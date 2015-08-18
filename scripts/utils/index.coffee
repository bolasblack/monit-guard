
module.exports = {
  expandServerUrl: (url) ->
    "#{url.replace /\/?$/, ''}/_status?format=xml"

  humanizeUptime: (uptime) ->
    if uptime? then moment.duration(uptime, 'second').humanize() else 'N/A'
}
