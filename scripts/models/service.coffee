{Model, Collection} = Backbone

# https://github.com/karmi/monittr/blob/master/lib/monittr.rb
class Service extends Model
  @TYPES = ['Filesystem', 'Directory', 'File', 'Process', 'Host', 'System']

  _safeGet: (path, options = {}) ->
    result = _.get(@attributes, path)
    return 'N/A' unless result?
    if options.isNumber
      Number result
    else
      result

  name:      -> @_safeGet 'name'
  status:    -> @_safeGet 'status', isNumber: true
  monitored: -> @_safeGet 'monitor', isNumber: true

class Services extends Collection
  @fromServer: (server) ->
    services = new this server.getCategory(this::categoryName)
    services.server = server
    services

class System extends Service
  @TYPE = 5

  @fromServer: (server) ->
    system = new System server.getCategory('system')
    system.server = server
    system

  load:           -> @_safeGet 'system.load.avg01', isNumber: true
  cpu:            -> @_safeGet 'system.cpu.user', isNumber: true
  memory:         -> @_safeGet 'system.memory.percent', isNumber: true
  swap:           -> @_safeGet 'system.swap.percent', isNumber: true
  uptime:         -> if (uptime = @server.getCategory('info').uptime)? then Number(uptime) else 'N/A'
  humanizeUptime: -> if (uptime = @uptime()) then moment.duration(uptime, 'second').humanize() else 'N/A'

class Host extends Service
  @TYPE = 4

  responseTime: -> @get('port').responsetime

class Process extends Service
  @TYPE = 3

  pid:            -> @_safeGet 'pid', isNumber: true
  cpu:            -> @_safeGet 'cpu.percent', isNumber: true
  memory:         -> @_safeGet 'memory.percent', isNumber: true
  uptime:         -> @_safeGet 'uptime', isNumber: true
  humanizeUptime: -> if (uptime = @uptime()) then moment.duration(uptime, 'second').humanize() else 'N/A'

class Filesystem extends Service
  @TYPE = 0

  percent: -> @_safeGet 'block.percent', isNumber: true
  usage:   -> @_safeGet 'block.usage', isNumber: true
  total:   -> @_safeGet 'block.total', isNumber: true

class Processes extends Services
  model: Process
  categoryName: 'processes'

class Filesystems extends Services
  model: Filesystem
  categoryName: 'filesystems'

class Hosts extends Services
  model: Host
  categoryName: 'hosts'

module.exports = {Service, Services, System, Host, Hosts, Process, Processes, Filesystem, Filesystems}
