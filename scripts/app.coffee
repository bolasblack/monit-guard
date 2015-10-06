{connect} = require 'react-redux'
actions = require 'src/actions'
Host = require 'src/components/host'
Server = require 'src/components/server'
Process = require 'src/components/process'
Filesystem = require 'src/components/filesystem'

App = React.createClass(
  componentWillMount: ->
    @props.servers.forEach (server) =>
      @props.dispatch actions.fetchServer server.url

  _addServer: ->
    return unless url = prompt 'Input monit url'
    @props.dispatch actions.addServer R.trim url

  _removeServer: (event, url) ->
    @props.dispatch actions.removeServer url

  render: ->
    <div className="servers">
      {@props.servers.map (server, index) =>
        <div key={index} className="server expanded">
          <Server server={server} onRemoveServer={@_removeServer} />

          <div className="content" style={{display: 'block'}}>
            <Filesystem server={server} />
            <Process server={server} />
            <Host server={server} />
          </div>

          <div className="clear"></div>
        </div>
      }
      <p className="server-new"><button onClick={@_addServer}> + </button></p>
    </div>
)

mapStateToProps = (state) ->
  servers: state.servers

module.exports = connect(mapStateToProps)(App)
