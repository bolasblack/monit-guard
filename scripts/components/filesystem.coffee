utils = require 'app/utils'

module.exports = Filesystem = React.createClass(
  _status: (item, propertyName) ->
    if item[propertyName] then 'running' else 'failure'

  _renderFilesystems: (filesystems) ->
    <div className="segment filesystems">
      <h3>Filesystem</h3>
      <ul className="clearfix">
        {filesystems.map (fs, index) =>
          <li key={index}>
            <strong title="(#{fs.block.usage} of #{fs.block.total})">
              <span className="dot status #{@_status fs, 'status'}">&middot;</span>
              <span className="dot monitored #{@_status fs, 'monitor'}">&middot;</span>
              <a href={"#{@props.server.url}/#{fs.name}"}>{fs.name}</a>
            </strong>
            {utils.safeGet fs, 'block.percent'}%
          </li>
        }
      </ul>
      <div className="clear"></div>
    </div>

  render: ->
    {filesystems} = @props.server
    if filesystems and not R.isEmpty(filesystems)
      @_renderFilesystems filesystems
    else
      <div></div>
)
