ReactDOM = require 'react-dom'
App = require './app'

element = React.createElement(App, null)
ReactDOM.render(element, document.getElementById('app'))
