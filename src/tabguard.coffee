React = require 'react'
ReactDOM = require 'react-dom'
arrayFrom = require 'array-from'
partialRight = require 'lodash.partialright'

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
  componentDidMount: ->
    @_registerTabGuard()

  componentDidUpdate: ->
    @_registerTabGuard()

  componentWillReceiveProps: ->
    @_removeListeners()

  componentWillUnmount: ->
    @_removeListeners()

  _firstElementListener: null

  _lastElementListener: null

  _firstElement: null

  _lastElement: null

  _registerTabGuard: ->
    parentNode = ReactDOM.findDOMNode(this)

    nodeList = parentNode.querySelectorAll(focusableElementsSelector)
    focusableElements = arrayFrom(nodeList)
    @_firstElement = focusableElements[0]
    @_lastElement = focusableElements[focusableElements.length - 1]

    @_firstElementListener = partialRight @_handleKeyDown,
      element: @_lastElement
      isShiftKeyRequired: true

    @_lastElementListener = partialRight @_handleKeyDown,
      element: @_firstElement
      isShiftKeyRequired: false

    @_firstElement.addEventListener 'keydown', @_firstElementListener
    @_lastElement.addEventListener 'keydown', @_lastElementListener

  _handleKeyDown: (event, options = {}) ->
    tabCharCode = 9
    { isShiftKeyRequired, element } = options

    if event.keyCode is tabCharCode and event.shiftKey is isShiftKeyRequired
      event.preventDefault()
      element.focus()

  _removeListeners: ->
    @_firstElement.removeEventListener 'keydown', @_firstElementListener
    @_lastElement.removeEventListener 'keydown', @_lastElementListener

  render: ->
    @props.children


module.exports = TabGuard
