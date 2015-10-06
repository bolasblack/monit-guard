sysPath = require 'path'
ipc = require('ipc')
BrowserWindow = require('browser-window')

publicDir = sysPath.resolve(process.cwd(), 'public')
isolateWindow = null
menubar = require('menubar')(
  dir: publicDir
  width: 460
)

fnRunInWebContents = ->
  ipc = require('ipc')
  remote = require('remote')
  Menu = remote.require('menu')
  MenuItem = remote.require('menu-item')

  menu = new Menu
  menu.append(new MenuItem(
    label: 'Open Developer Tools'
    click: ->
      remote.getCurrentWindow().toggleDevTools();
  ))
  menu.append(new MenuItem(
    label: 'Detach From Tray'
    click: ->
      ipc.send 'app:isolate'
  ))

  window.addEventListener('contextmenu', (event) ->
    event.preventDefault()
    menu.popup(remote.getCurrentWindow())
  , false)

menubar.on 'after-create-window', ->
  menubar.window.webContents.executeJavaScript ";(#{fnRunInWebContents.toString()})();"

ipc.on 'app:isolate', ->
  if isolateWindow
    isolateWindow.focus()
  else
    isolateWindow = new BrowserWindow(width: 950, height: 400, show: true)
    isolateWindow.loadUrl "file://#{publicDir}/index.html"
    isolateWindow.webContents.executeJavaScript ";(#{fnRunInWebContents.toString()})();"
