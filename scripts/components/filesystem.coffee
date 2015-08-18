
module.exports = Filesystem = React.createClass(
  _status: (item, propertyName) ->
    if item[propertyName] then 'running' else 'failure'

  render: ->
    <div className="segment filesystems">
      <h3>Filesystem</h3>
      <ul className="clearfix">
        {@props.filesystems.map (fs, index) =>
          <li key={index}>
            <strong title="(#{fs.block.usage} of #{fs.block.total})">
              <span className="dot status #{@_status fs, 'status'}">&middot;</span>
              <span className="dot monitored #{@_status fs, 'monitor'}">&middot;</span>
              <a href={fs.url}>{fs.name}</a>
            </strong>
            {fs.block.percent}%
          </li>
        }
      </ul>
      <div className="clear"></div>
    </div>
)
