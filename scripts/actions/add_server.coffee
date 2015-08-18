utils = require 'app/utils'
fetchServer = require 'app/actions/fetch_server'
type = 'ADD_SERVER'

module.exports = addServer = (url) ->
  (dispatch) ->
    setTimeout (-> fetchServer(url)(dispatch)), 0
    dispatch {type, url}

addServer.type = type
addServer.reducer = (store, action) ->
  return store if action.type isnt type
  R.assocAppend 'servers', [url: utils.expandServerUrl action.url], store
