
module.exports = Host = React.createClass(
  _status: (item, propertyName) ->
    if item[propertyName] then 'running' else 'failure'

  _alertNotMonitored: (host) ->
    unless host.monitor
      <span className="label warning">NOT MONITORED</span>

  render: ->
    <div className="segment hosts">
      <h3>Hosts</h3>
      <ul>
        {@props.hosts.map (host, index) =>
          <li key={index}>
            <strong>
              <span className="dot status #{@_status host, 'status'}">&middot;</span>
              <span className="dot monitored #{@_status host, 'monitor'}">&middot;</span>
              <a href={host.url} target="_blank">{host.name}</a>
              {@_alertNotMonitored host}
            </strong>
            <small>
              <span className="info">
                <span className="label">response time: </span>
                {host.icmp.responsetime}
              </span>
            </small>
          </li>
        }
      </ul>
      <div className="clear"></div>
    </div>
)
