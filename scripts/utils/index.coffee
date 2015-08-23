
module.exports = {
  expandServerUrl: (url) ->
    "#{url.replace /\/?$/, ''}/_status?format=xml"

  humanizeUptime: (uptime) ->
    if uptime? then moment.duration(uptime, 'second').humanize() else 'N/A'

  safeGet: (obj, keyPath, placeholder = 'N/A') ->
    R.getPath(keyPath.split('.'), obj) or placeholder

  storage: ->
    get: (key) ->
      try
        JSON.parse localStorage[key]
      catch
        @del key
        null

    set: (key, val) ->
      localStorage[key] = JSON.stringify val

    del: (key) ->
      localStorage[key]
}
