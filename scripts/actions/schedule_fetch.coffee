
module.exports = (dispatch, url) ->
  console.log 'schedule fetch', url
  fetchServer = require 'src/actions/fetch_server'
  setTimeout (-> dispatch fetchServer url), 1000 * 30
