localStorage = do ->
  return @localStorage if @localStorage

  memoryStore = {}

  getItem: (key) ->
    memoryStore[key]

  setItem: (key, val) ->
    memoryStore[key] = val

  removeItem: (key) ->
    delete memoryStore[key]

  clear: ->
    memoryStore = {}

module.exports = {
  prod: process.env.NODE_ENV is 'production'
  test: process.env.NODE_ENV is 'test'
  dev: process.env.NODE_ENV not in 'production test'.split(' ')

  expandServerUrl: (url) ->
    "#{url.replace /\/?$/, ''}/_status?format=xml"

  humanizeUptime: (uptime) ->
    if uptime? then moment.duration(uptime, 'second').humanize() else 'N/A'

  safeGet: (obj, keyPath, placeholder = 'N/A') ->
    R.getPath(keyPath.split('.'), obj) or placeholder

  storage: ->
    get: (key) ->
      try
        JSON.parse localStorage.getItem key
      catch
        @del key
        null

    set: (key, val) ->
      localStorage.setItem key, JSON.stringify(val)

    del: (key) ->
      localStorage.removeItem key
}
