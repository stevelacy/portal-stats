systemStats = require './systemStats'

module.exports =
  plugin: (socket, db) ->
    socket.on 'plugin:stats:connect', ->

      sendStats = ->
        systemStats (err, stats) ->
          if err?
            return socket.emit 'system:notification',
              title: 'portal-stats'
              message: String err
              type: 'error'

          socket.emit 'plugin:stats:graphs',
            stats

      setInterval ->
        sendStats()
      , 5000

      sendStats()
