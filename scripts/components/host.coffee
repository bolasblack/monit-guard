utils = require 'app/utils'

module.exports = Host = React.createClass(
  _status: (item, propertyName) ->
    if item[propertyName] then 'running' else 'failure'

  _alertNotMonitored: (host) ->
    unless host.monitor
      <span className="label warning">NOT MONITORED</span>

  _renderHosts: (hosts) ->
    <div className="segment hosts">
      <h3>Hosts</h3>
      <ul>
        {hosts.map (host, index) =>
          <li key={index}>
            <strong>
              <span className="dot status #{@_status host, 'status'}">&middot;</span>
              <span className="dot monitored #{@_status host, 'monitor'}">&middot;</span>
              <a href={"#{@props.server.url}/#{host.name}"} target="_blank">{host.name}</a>
              {@_alertNotMonitored host}
            </strong>
            <small>
              <span className="info">
                <span className="label">response time: </span>
                {utils.safeGet host, 'icmp.responsetime'}
              </span>
            </small>
          </li>
        }
      </ul>
      <div className="clear"></div>
    </div>

  render: ->
    hosts = @props.server.hosts
    if hosts and not R.isEmpty hosts
      @_renderHosts hosts
    else
      <div></div>
)
