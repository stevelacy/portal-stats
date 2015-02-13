io = require 'socket.io-client'
{view, DOM} = require 'fission'

easypiechart = require '../vendor/easypiechart'

token = parent.token
client = io parent.config.socketUrl,
  reconnect: true
  query: "token=#{token}"

module.exports = view
  init: ->
    o =
      cpu: null
      mem: null

  mounted: ->

    console.log @refs

    cpu = new easypiechart @refs.cpu.getDOMNode(),
      animate: 2000
      easing: 'easeOutBounce'
      barColor: 'green'
      lineWidth: 10
      lineCap: 'butt'
      trackColor: '#efefef'
      rotate: 180
    cpu.update 100

    mem = new easypiechart @refs.mem.getDOMNode(),
      animate: 2000
      easing: 'easeOutBounce'
      barColor: 'green'
      lineWidth: 10
      lineCap: 'butt'
      trackColor: '#efefef'
      rotate: 180
    mem.update 100



    client.on 'connect', ->

      client.emit 'plugin:stats:connect'
    client.on 'plugin:stats:graphs', (data) =>
      cpu.update data.process.cpu
      mem.update data.process.mem

  render: ->
    DOM.h1 null, 'test'
    DOM.div
      ref: 'cpu'
      className: 'cpu'

    DOM.div
      ref: 'mem'
      className: 'mem'
