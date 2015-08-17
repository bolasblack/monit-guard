{Model, Collection} = Backbone
{System, Filesystem, Filesystems, Process, Processes, Host, Hosts} = require './service'
url = require 'url'
jsonml = require 'app/vendors/jsonml-xml'

class Server extends Model
  idAttribute: 'url'

  initialize: (attrs) ->
    @_caches = {}
    super

  url: ->
    @get('url') + '/_status?format=xml'

  fetch: (options = {}) ->
    options.dataType = 'xml'
    super options

  parse: (resp, options) ->
    @_transformXML resp

  info:        -> @getCategory 'info'
  platform:    -> @getCategory 'platform'
  system:      -> System.fromServer this
  hosts:       -> Hosts.fromServer this
  processes:   -> Processes.fromServer this
  filesystems: -> Filesystems.fromServer this

  getCategory: (categoryName) ->
    switch categoryName
      when 'info'        then @_getCategory 'server'
      when 'platform'    then @_getCategory 'platform'
      when 'system'      then @_getCategory 'service', System.TYPE
      when 'hosts'       then @_getCategory 'service', Host.TYPE
      when 'processes'   then @_getCategory 'service', Process.TYPE, true
      when 'filesystems' then @_getCategory 'service', Filesystem.TYPE, true

  _parseChild: (child) ->
    if _(child.properties).isString() or _(child.children).isEmpty()
      child.properties
    else
      _.reduce child.children, (memo, child) =>
        memo[child.name] = @_parseChild child
        memo
      , child.properties or {}

  _getCategory: (typeName, type, isArray = false) ->
    id = typeName + type
    return @_caches[id] if @_caches[id]
    children = _.where @get('children'), name: typeName
    if type?
      children = _.filter children, (child) ->
        Number(child.properties.type) is type
    if isArray
      @_caches[id] = _.map children, @_parseChild, this
    else if _(children).isEmpty()
      return []
    else
      @_caches[id] = @_parseChild _(children).first()
    @_caches[id]

  _transformXML: (xml) =>
    if xml instanceof XMLDocument
      xml = jsonml.fromXML(xml)[1]

    name = xml[0]
    properties = xml[1]

    if _.isArray properties
      properties = {}
      children = xml.slice(1).map @_transformXML
    else
      children = xml.slice(2).map @_transformXML

    {name, properties, children}

class Servers extends Collection
  model: Server

  initialize: (models = [], options) ->
    try
      urls = JSON.parse(localStorage.getItem 'urls') or []
    catch
      localStorage.removeItem 'urls'
      urls = []
    urls.forEach (url) => @add {url}
    @on 'update', (servers, options) =>
      urls = servers.pluck 'url'
      localStorage.setItem 'urls', JSON.stringify urls

  fetch: (options) ->
    Promise.all @map (server) -> server.fetch options

module.exports = {Server, Servers, servers: new Servers}
