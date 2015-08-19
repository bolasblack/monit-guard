{createStore, applyMiddleware, compose} = require 'redux'
thunkMiddleware = require 'redux-thunk'
utils = require 'app/utils'
reducer = require 'app/reducer'

defaultInitialState = do ->
  try
    urls = JSON.parse(localStorage.getItem 'urls') or []
  catch
    localStorage.removeItem 'urls'
    urls = []

  servers: urls.map (url) ->
    url: url
    fetching: true

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
