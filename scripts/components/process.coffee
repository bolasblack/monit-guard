
module.exports = Process = React.createClass(
  _status: (item, propertyName, expectValue = 1) ->
    if Number(item[propertyName]()) is expectValue then 'running' else 'failure'

  _alertNotMonitored: (process) ->
    if process.monitored() isnt 1
      <span class="label warning">NOT MONITORED</span>

  render: ->
    <div className="segment processes">
      <h3>Processes</h3>
      <ul>
        {@props.processes.map (process, index) =>
          <li key={index}>
            <strong>
              <span className="dot status #{@_status process, 'status', 0}">&middot;</span>
              <span className="dot monitored #{@_status process, 'monitored'}">&middot;</span>
              <a href={process.url()}>{process.name()}</a>
              {@_alertNotMonitored process}
            </strong>

            <small>
              <span className="info"><span className="label">cpu:    </span>{process.cpu()}</span>
              <span className="info"><span className="label">memory: </span>{process.memory()}</span>
              <span className="info"><span className="label">uptime: </span>{process.humanizeUptime()}</span>
            </small>
          </li>
        }
      </ul>
      <div className="clear"></div>
    </div>
)
