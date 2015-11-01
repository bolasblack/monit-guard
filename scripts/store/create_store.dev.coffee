{createStore, applyMiddleware, compose} = require 'redux'
thunkMiddleware = require 'redux-thunk'
{persistState} = require 'redux-devtools'
DevTools = require 'scripts/DevTools'

module.exports = createStoreWithMiddleware = compose(
  applyMiddleware(thunkMiddleware)
  DevTools.instrument()
  persistState(window.location.href.match(/[?&]debug_session=([^&]+)\b/))
)(createStore)
