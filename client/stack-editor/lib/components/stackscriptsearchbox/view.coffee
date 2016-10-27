kd = require 'kd'
React = require 'app/react'
ScrollableContent = require 'app/components/scroller'


module.exports = class StackScriptSeachBoxView extends React.Component

  renderResultList: ->

    i = 0
    @props.scripts.map (script) =>
      <List item={script} key={i++} callback={@props.onClick.bind this, script} />


  renderResults: ->

    return  unless @props.scripts.length
    return  if @props.close

    <ScrollableContent className='stack-script-search-scroll'>
      {@renderResultList()}
    </ScrollableContent>


  renderIcon: ->

    icon = if @props.loading then 'loading-icon' else 'close-icon'

    return  unless @props.query or @props.scripts.length
    return  if @props.close and icon is 'close-icon'

    <span className={icon} onClick={@props.onIconClick}></span>


  render: ->

    <div>
      <SearchInputBox
        value={@props.query}
        onChangeCallback={@props.onChange}
        onFocusCallback={@props.onFocus} />
      {@renderIcon()}
      {@renderResults()}
    </div>


SearchInputBox = ({ value, onChangeCallback, onFocusCallback }) ->

  <input
    type='text'
    className='kdinput text searchStackInput'
    placeholder='Search Anything, AWS, S3, Azure, GCP...'
    value={value}
    onChange={onChangeCallback}
    onFocus={onFocusCallback} />


List = ({ item, callback }) ->

  <div className='item-wrapper' onClick={callback}>
    <div className='item'>
      <div className='title'> {item.title} </div>
      <div className='description'> {item.description} </div>
    </div>
  </div>
