{createStore, applyMiddleware, compose} = require 'redux'
thunkMiddleware = require 'redux-thunk'
utils = require 'src/utils'
reducer = require 'src/reducer'

defaultInitialState = do ->
  urls = utils.storage().get('urls') ? []
  servers: urls.map (url) ->
    url: url
    fetching: true
    failed: false

# @if DEBUG
{devTools, persistState} = require 'redux-devtools'
createStoreWithMiddleware = compose(
  applyMiddleware(thunkMiddleware)
  devTools()
  persistState(window.location.href.match(/[?&]debug_session=([^&]+)\b/))
  createStore
)
# @endif

# @if !DEBUG
createStoreWithMiddleware = compose(
  applyMiddleware(thunkMiddleware)
  createStore
)
# @endif

module.exports = (initialState = defaultInitialState) ->
  createStoreWithMiddleware reducer, initialState
