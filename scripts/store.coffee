{createStore, applyMiddleware, compose} = require 'redux'
thunkMiddleware = require 'redux-thunk'
utils = require 'scripts/utils'

defaultInitialState = do ->
  urls = utils.storage().get('urls') ? []
  servers: urls.map (url) ->
    url: url
    fetching: true
    failed: false

# @if DEV
{persistState} = require 'redux-devtools'
DevTools = require 'scripts/DevTools'
createStoreWithMiddleware = compose(
  applyMiddleware(thunkMiddleware)
  DevTools.instrument()
  persistState(window.location.href.match(/[?&]debug_session=([^&]+)\b/))
)(createStore)
# @endif

# @if PROD
createStoreWithMiddleware = compose(
  applyMiddleware(thunkMiddleware)
)(createStore)
# @endif

module.exports = (initialState = defaultInitialState) ->
  store = createStoreWithMiddleware require('scripts/reducer'), initialState

# @if DEV
  if module.hot
    module.hot.accept './reducer', ->
      store.replaceReducer require('scripts/reducer')
# @endif

  store
