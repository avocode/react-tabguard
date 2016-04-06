chai = require 'chai'
chaiEnzyme = require 'chai-enzyme'

chai.use(chaiEnzyme())

global.expect = chai.expect
global.jsdom = require 'jsdom'
global.React = require 'react'
global.ReactDOM = require 'react-dom'
global.enzyme = require 'enzyme'
global._ = require 'lodash'

before (done) ->
  jsdom.env '', [], (errs, window) ->
    global.window = window
    global.document = window.document
    global.Image = window.Image
    global.navigator = window.navigator
    global.CustomEvent = window.CustomEvent

    done()
