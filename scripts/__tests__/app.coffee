React = require 'react'
TestUtils = require 'react-addons-test-utils'

jest.dontMock 'scripts/vendor'
jest.dontMock 'scripts/app'

require 'scripts/vendor'

describe 'App', ->
  it 'works', ->
    App = require 'scripts/app'
    app = TestUtils.renderIntoDocument(<App />)
    pageContainer = TestUtils.findRenderedDOMComponentWithClass(app, 'app-page')
    expect(pageContainer.getDOMNode().textContent).toEqual 'It works'
