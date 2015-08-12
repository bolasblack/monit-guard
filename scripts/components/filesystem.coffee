
module.exports = Filesystem = React.createClass(
  _status: (item, propertyName, expectValue = 1) ->
    if Number(item[propertyName]()) is expectValue then 'running' else 'failure'

  render: ->
    <div className="segment filesystems">
      <h3>Filesystem</h3>
      <ul className="clearfix">
        {@props.filesystems.map (fs, index) ->
          <li key={index}>
            <strong title="(#{fs.usage()} of #{fs.total()})">
              <span class="dot status #{@_status fs, 'status', 0}">&middot;</span>
              <span class="dot monitored #{@_status fs, 'monitored'}">&middot;</span>
              {fs.name()}
            </strong>
            {fs.percent()}%
          </li>
        }
      </ul>
      <div className="clear"></div>
    </div>
)
