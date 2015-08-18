utils = require 'app/utils'

module.exports = Process = React.createClass(
  _status: (item, propertyName) ->
    if item[propertyName] then 'running' else 'failure'

  _alertNotMonitored: (process) ->
    unless process.monitor
      <span className="label warning">NOT MONITORED</span>

  render: ->
    <div className="segment processes">
      <h3>Processes</h3>
      <ul>
        {@props.processes.map (process, index) =>
          <li key={index}>
            <strong>
              <span className="dot status #{@_status process, 'status'}">&middot;</span>
              <span className="dot monitored #{@_status process, 'monitor'}">&middot;</span>
              <a href={process.url}>{process.name}</a>
              {@_alertNotMonitored process}
            </strong>

            <small>
              <span className="info"><span className="label">cpu:    </span>{process.cpu.percent}</span>
              <span className="info"><span className="label">memory: </span>{process.memory.percent}</span>
              <span className="info"><span className="label">uptime: </span>{utils.humanizeUptime process.uptime}</span>
            </small>
          </li>
        }
      </ul>
      <div className="clear"></div>
    </div>
)
