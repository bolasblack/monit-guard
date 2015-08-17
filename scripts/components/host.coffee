
module.exports = Host = React.createClass(
  _status: (item, propertyName, expectValue = 1) ->
    if Number(item[propertyName]()) is expectValue then 'running' else 'failure'

  _alertNotMonitored: (host) ->
    if host.monitored() isnt 1
      <span className="label warning">NOT MONITORED</span>

  render: ->
    <div className="segment hosts">
      <h3>Hosts</h3>
      <ul>
        {@props.hosts.map (host, index) ->
          <li key={index}>
            <strong>
              <span class="dot status #{@_status host, 'status', 0}">&middot;</span>
              <span class="dot monitored #{@_status host, 'monitored'}">&middot;</span>
              <a href={host.url()} target="_blank">{host.name()}</a>
              {@_alertNotMonitored host}
            </strong>
            <small>
              <span class="info"><span class="label">response time: </span>{host.responseTime()}</span>
            </small>
          </li>
        }
      </ul>
      <div className="clear"></div>
    </div>
)
