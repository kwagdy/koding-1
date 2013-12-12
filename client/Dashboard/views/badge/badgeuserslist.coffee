class BadgeUsersList extends JView
  constructor:(options = {}, data) ->
    super options, data
    {@badge}                 = @getOptions()
    @filteredUsersController = new KDListViewController
      startWithLazyLoader    : no
      view                   : new KDListView
        type                 : "users"
        cssClass             : "user-list"
        itemClass            : BadgeUsersItem

    # TODO : after design we may need pagination
    @loadUserList()

    @userView = @filteredUsersController.getListView()

    @userView.on "RemoveBadgeUser", (account) =>
      @badge.removeBadgeFromUser account, (err, account)=>
        return err if err
        new KDNotificationView
          title     : "Badge removed"
          duration  : 2000

  loadUserList:->
    KD.remote.api.JBadge.fetchBadgeUsers @badge.getId(), limit:10 ,(err, accounts)=>
      @filteredUsersController.instantiateListItems accounts

  viewAppended:->
    @addSubView @userView