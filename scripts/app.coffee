require 'app/vendor'
{servers} = require 'app/models/server'
HostViewer = require 'app/components/host'
ServerViewer = require 'app/components/server'
ProcessViewer = require 'app/components/process'
FilesystemViewer = require 'app/components/filesystem'

App = React.createClass(
  getInitialState: ->
    serverFetchState: Promise.resolve()

  componentWillMount: ->
    @_update()
    servers.on 'update', => @forceUpdate()

  componentWillUnmount: ->
    clearTimeout @_timer
    @_stopTimer = true

  _update: ->
    @setState serverFetching: true
    servers.fetch().then =>
      return if @_stopTimer
      @setState serverFetching: false
      @_timer = setTimeout @_update, 1000 * 60 * 1

  _renderContent: ->
    if servers.length and @state.serverFetching
      <div>Loading...</div>
    else
      @_renderServer()

  _renderServer: ->
    servers.map (server, index) ->
      <div key={index} className="server rounded expanded">
        <ServerViewer server={server} />

        <div className="content" style={{display: 'block'}}>
          <FilesystemViewer filesystems={server.filesystems()} />
          <ProcessViewer processes={server.processes()} />
          <HostViewer hosts={server.hosts()} />
        </div>

        <div className="clear"></div>
      </div>

  _addNewServer: ->
    url = prompt 'Input monit url'
    servers.add {url}
    @_update()

  render: ->
    <div id="monittr">
      {@_renderContent()}
      <p className="server-new"><button onClick={@_addNewServer}> + </button></p>
    </div>
)

React.render(
  <App />
  document.getElementById('app')
)
