
module.exports = Filesystem = React.createClass(
  _status: (item, propertyName, expectValue = 1) ->
    if Number(item[propertyName]()) is expectValue then 'running' else 'failure'

  render: ->
    <div className="segment filesystems">
      <h3>Filesystem</h3>
      <ul className="clearfix">
        {@props.filesystems.map (fs, index) =>
          <li key={index}>
            <strong title="(#{fs.usage()} of #{fs.total()})">
              <span className="dot status #{@_status fs, 'status', 0}">&middot;</span>
              <span className="dot monitored #{@_status fs, 'monitored'}">&middot;</span>
              <a href={fs.url()}>{fs.name()}</a>
            </strong>
            {fs.percent()}%
          </li>
        }
      </ul>
      <div className="clear"></div>
    </div>
)
