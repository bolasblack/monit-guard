fs = require 'fs'
sysPath = require 'path'
fetchServer = require 'scripts/actions/fetch_server'

describe 'actions/fetch_server', ->
  pit 'can transform server data correctly', ->
    serverData = fs.readFileSync sysPath.join __dirname, '/fetch_server.in.xml'
    expectData = JSON.parse fs.readFileSync sysPath.join __dirname, './fetch_server.out.json'
    fetchServer.transformXML(serverData).then (transformedData) ->
      expect(transformedData).toEqual expectData
