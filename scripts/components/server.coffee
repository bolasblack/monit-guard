{servers} = require 'app/models/server'

module.exports = Server = React.createClass(
  _status: (item, categoryName, propertyName, expectValue = 1) ->
    if Number(item[categoryName]()[propertyName]()) is expectValue then 'running' else 'failure'

  _removeServer: ->
    servers.remove @props.server

  render: ->
    server = @props.server

    <h2 className="rounded">
      <strong>
        <span title="status" className="dot status #{@_status server, 'system', 'status', 0}">&middot;</span>
        <span title="monitored" className="dot monitored #{@_status server, 'system', 'monitored'}">&middot;</span>
        <a href={server.get 'url'}>{server.info().localhostname}</a>
        <a href="javascript:;" onClick={@_removeServer}>&times;</a>
      </strong>

      <small>
        <span className="info"><span className="label">load:   </span>{server.system().load()}</span>
        <span className="info"><span className="label">cpu:    </span>{server.system().cpu()}</span>
        <span className="info"><span className="label">memory: </span>{server.system().memory()}</span>
        <span className="info"><span className="label">swap:   </span>{server.system().swap()}</span>
        <span className="info"><span className="label">uptime: </span>{server.system().humanizeUptime()}</span>
      </small>
    </h2>

)
