type = 'REMOVE_SERVER'

module.exports = removeServer = (url) ->
  {type, url}

removeServer.type = type
removeServer.reducer = (state, action) ->
  R.assocDrop 'servers', R.pipe(R.tap((server) -> console.log 'server', server), R.propEq('url', action.url), R.tap((result) -> console.log 'result', result)), state
