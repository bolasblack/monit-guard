utils = require 'app/utils'
type = 'ADD_SERVER'

module.exports = addServer = (url) ->
  {type, url}

addServer.type = type
addServer.reducer = (store, action) ->
  return store if action.type isnt type
  R.assocAppend 'servers', url: action.url, fetching: true, store
