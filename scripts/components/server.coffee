{PropTypes} = React
utils = require 'src/utils'

module.exports = Server = React.createClass(
  _status: (item, keyPath) ->
    if R.assocPath keyPath.split('.'), item then 'running' else 'failure'

  _removeServer: (url) ->
    (event) =>
      @props.onRemoveServer event, url

  _renderSummary: (server) ->
    if server.fetching
      <small>Loading...</small>
    else
      <small>
        <span className="info"><span className="label">load:   </span>{utils.safeGet server, 'system.system.load.avg01'}</span>
        <span className="info"><span className="label">cpu:    </span>{utils.safeGet server, 'system.system.cpu.system'}</span>
        <span className="info"><span className="label">memory: </span>{utils.safeGet server, 'system.system.memory.percent'}</span>
        <span className="info"><span className="label">swap:   </span>{utils.safeGet server, 'system.system.swap.percent'}</span>
        <span className="info"><span className="label">uptime: </span>{utils.humanizeUptime server.info?.uptime}</span>
      </small>

  render: ->
    server = @props.server

    <h2 className="server-summary">
      <div className="run-info">
        <div className="object">
          <span title="status" className="dot status #{@_status server, 'system.status'}">&middot;</span>
          <span title="monitored" className="dot monitored #{@_status server, 'system.monitor'}">&middot;</span>
        </div>
      </div>

      <div className="more-info">
        <strong>
          <a href={server.url}>{server.url}</a>
          <a href="javascript:;" onClick={@_removeServer server.url}>&times;</a>
        </strong>

        {@_renderSummary server}
      </div>
    </h2>
)

Server.propTypes =
  server: PropTypes.object.isRequired
  onRemoveServer: PropTypes.func.isRequired
