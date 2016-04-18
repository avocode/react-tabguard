React = require 'react'
ReactDOM = require 'react-dom'
arrayFrom = require 'array-from'

tabGuard = React.createFactory 'tabguard'

focusableElementsList = [
  'a[href]'
  'button:not([disabled])'
  'area[href]'
  'input:not([disabled])'
  'select:not([disabled])'
  'textarea:not([disabled])'
  'iframe'
  'object'
  'embed'
  '*[tabindex]'
  '*[contenteditable]'
]

focusableElementsSelector = focusableElementsList.join()

TabGuard = React.createClass
  propTypes:
    className: React.PropTypes.string

  componentDidMount: ->
    @_registerTabGuard()

  componentDidUpdate: ->
    @_registerTabGuard()

  componentWillUpdate: ->
    @_removeListeners()

  componentWillUnmount: ->
    @_removeListeners()

  _firstElement: null

  _lastElement: null

  _registerTabGuard: ->
    parentNode = ReactDOM.findDOMNode(this)

    elements = arrayFrom(parentNode.querySelectorAll(focusableElementsSelector))
    focusableElements = elements.filter(@_filterFocusableElements)

    @_firstElement = focusableElements[0]
    @_lastElement = focusableElements[focusableElements.length - 1]

    @_firstElement.addEventListener 'keydown', @_handleFirstElement
    @_lastElement.addEventListener 'keydown', @_handleLastElement

  _isTabKeyEvent: (event) ->
    tabCharCode = 9
    result = if event.keyCode is tabCharCode then true else false
    return result

  _filterFocusableElements: (element) ->
    isVisible = element.style.display isnt 'none' and
      element.style.visibility isnt 'hidden'
    isNonNegativeTabIndex = element.getAttribute('tabindex') isnt '-1'

    return isVisible and isNonNegativeTabIndex

  _handleFirstElement: (event) ->
    if event.shiftKey and @_isTabKeyEvent(event)
      event.preventDefault()
      @_lastElement.focus()

  _handleLastElement: (event) ->
    if not event.shiftKey and @_isTabKeyEvent(event)
      event.preventDefault()
      @_firstElement.focus()

  _removeListeners: ->
    @_firstElement.removeEventListener 'keydown', @_handleFirstElement
    @_lastElement.removeEventListener 'keydown', @_handleLastElement

  render: ->
    tabGuard
      className: @props.className
      children: @props.children


module.exports = TabGuard
