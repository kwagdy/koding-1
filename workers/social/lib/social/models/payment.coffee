{argv}   = require 'optimist'
KONFIG   = require('koding-config-manager').load("main.#{argv.c}")

Bongo = require "bongo"
{secure, signature, Base} = Bongo

module.exports = class Payment extends Base
  @share()

  @set
    sharedMethods     :
      static          :
        subscribe         :
          (signature Object, Function)
        subscriptions     :
          (signature Object, Function)
        invoices          :
          (signature Object, Function)
        creditCard        :
          (signature Object, Function)
        updateCreditCard  :
          (signature Object, Function)
        canChangePlan     :
          (signature Object, Function)
        logOrder          :
          (signature Object, Function)


  { get, post } = require "./socialapi/requests"


  @subscribe = secure (client, data, callback)->
    requiredParams = [
      "token", "email", "planTitle", "planInterval", "provider"
    ]

    validateParams requiredParams, data, (err)->
      return callback err  if err

      canChangePlan client, data.planTitle, (err)->
        return callback err  if err

        data.accountId = getAccountId client
        url = "/payments/subscribe"

        post url, data, (err, response)->
          callback err, response

          data.status = if err then "$failed" else "$success"
          logTransaction client, data, (err)->
            log "logging to SiftScience failed", err  if err


  @subscriptions$ = secure (client, data, callback)->
    Payment.subscriptions client, data, callback

  @subscriptions = (client, data, callback)->
    data.accountId = getAccountId client
    url = "/payments/subscriptions?account_id=#{data.accountId}"

    get url, data, callback

  @invoices = secure (client, data, callback)->
    data.accountId = getAccountId client
    url = "/payments/invoices/#{data.accountId}"

    get url, data, callback

  @creditCard = secure (client, data, callback)->
    data.accountId = getAccountId client
    url = "/payments/creditcard/#{data.accountId}"

    get url, data, callback

  @updateCreditCard = secure (client, data, callback)->
    requiredParams = [ "token" , "provider"]

    validateParams requiredParams, data, (err)->
      return callback err  if err

      data.accountId = getAccountId client
      url = "/payments/creditcard/update"

      post url, data, callback

  @canChangePlan = secure (client, data, callback)->
    requiredParams = [ "planTitle" ]

    validateParams requiredParams, data, (err)->
      canChangePlan client, data.planTitle, callback


  @logOrder = secure (client, raw, callback)->
    requiredParams = [
      "planTitle", "planAmount", "binNumber", "lastFour", "cardName"
    ]

    validateParams requiredParams, raw, (err)->
      return callback err  if err

      {planTitle, planAmount, binNumber, lastFour, cardName} = raw

      data = {
        "$type"               : "$create_order"
        "$currency_code"      : "USD"
        "$amount"             : planAmount*1000000
        "$payment_methods"    : [
          "$payment_type"     : "$credit_card"
          "$payment_gateway"  : "$stripe"
          "$card_bin"         : binNumber
          "$card_last4"       : lastFour
        ]
        "$billing_address"    :
          "$name"             : cardName
        "$items"              : [
          "$item_id"          : planTitle
          "$price"            : planAmount*1000000
        ]
      }

      logToSiftScience client, "create_order", data, callback


  validateParams = (requiredParams, data, callback)->
    for param in requiredParams
      if not data[param]
        return callback {message: "#{param} is required"}

    callback null

  getAccountId = (client)->
    return client.connection.delegate.getId()

  getUserName = (client)->
    return client.connection.delegate.profile.nickname

  prettifyFeature = (name)->
    switch name
      when "alwaysOn"
        "alwaysOn vms"
      when "storage"
        "GB storage"
      when "total"
        "total vms"

  canChangePlan = (client, planTitle, callback)->
    fetchPlan client, planTitle, (err, plan)->
      return callback err  if err

      fetchUsage client, (err, usage)->
        return callback err  if err

        for name in ["alwaysOn", "storage", "total"]
          if usage[name] > plan[name]
            return callback {
              "message"   : "Sorry, your request to downgrade can't be processed because you are currently using more resources than the plan you are trying to downgrade to allows."
              "allowed"   : plan[name]
              "usage"     : usage[name]
              "planTitle" : planTitle
              "name"      : prettifyFeature name
            }

        callback null

  fetchUsage = (client, callback)->
    ComputeProvider = require "./computeproviders/computeprovider"
    ComputeProvider.fetchUsage client, {
      provider   : "koding"
      credential : client.connection.delegate.profile.nickname
    }, callback

  fetchPlan = (client, planTitle, callback)->
    ComputeProvider = require "./computeproviders/computeprovider"
    ComputeProvider.fetchPlans client,
      provider   : "koding"
    , (err, plans)->
      return err  if err

      plan = plans[planTitle]
      return callback {"message" : "plan not found"}  unless plan

      fetchReferrerSpace client, (err, space)->
        return callback err  if err

        plan.storage += space

        callback null, plan

  fetchReferrerSpace = (client, callback)->
    JReferral = require "./referral/index"
    JReferral.fetchEarnedSpace client, callback


  fetchUserInfo = (client, callback)->
    {sessionToken, connection : {delegate}} = client
    delegate.fetchUser (err, user)->
      return callback err  if err

      {username, email} = user

      callback null, {username, email, sessionToken}

  logTransaction = (client, raw, callback)->
    {planTitle, planAmount, binNumber, lastFour, cardName, status} = raw

    return callback null  if planTitle is "free"

    data = {
      "$type"               : "$transaction"
      "$transaction_status" : "$success"
      "$currency_code"      : "USD"
      "$amount"             : planAmount*1000000
      "$payment_method"     :
        "$payment_type"     : "$credit_card"
        "$payment_gateway"  : "$stripe"
        "$card_bin"         : binNumber
        "$card_last4"       : lastFour
      "$billing_address"    :
        "$name"             : cardName
    }

    logToSiftScience client, "transaction", data, callback

  logToSiftScience = (client, event, data, callback)->
    siftScience = require('yield-siftscience') KONFIG.siftScience

    fetchUserInfo client, (err, {username, email, sessionToken})->
      return callback err   if err

      data["$user_id"]    = username
      data["$user_email"] = email
      data["$session_id"] = sessionToken

      siftScience.event[event] data, callback
