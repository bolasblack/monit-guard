type = 'REMOVE_SERVER'

module.exports = removeServer = (url) ->
  {type, url}

removeServer.type = type
removeServer.reducer = (store, action) ->
  R.assocDrop 'servers', ((server) -> server.url is action.url), store
