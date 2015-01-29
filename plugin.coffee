{spawn} = require 'child_process'

systemStats = require './systemStats'



module.exports = (socket, db) ->

  socket.emit 'test', test: 'widget'
  console.log db
  db.set widget: script: 'null'
  db.save()

  systemStats (err, stats) ->
    socket.emit 'graphs',
      stats
    console.log stats
  setInterval ->
    systemStats (err, stats) ->
      socket.emit 'graphs',
        stats
      console.log stats
  , 3000
