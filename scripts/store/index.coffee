utils = require 'scripts/utils'
createStoreWithMiddleware = require "scripts/store/create_store.#{if utils.dev then 'dev' else 'prod'}.coffee"

defaultInitialState = do ->
  urls = utils.storage().get('urls') ? []
  servers: urls.map (url) ->
    url: url
    fetching: true
    failed: false

module.exports = (initialState = defaultInitialState) ->
  store = createStoreWithMiddleware require('scripts/reducer'), initialState

# @if DEV
  if module.hot
    module.hot.accept 'scripts/reducer', ->
      store.replaceReducer require('scripts/reducer')
# @endif

  store
