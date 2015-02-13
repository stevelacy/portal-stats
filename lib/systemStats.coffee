os = require 'os'
usage = require 'usage'

pid = process.pid

module.exports = (cb) ->
  usage.lookup pid, (err, result) ->
    result =
      process:
        mem: (result.memory / os.totalmem())*1000
        cpu: result.cpu
    cb err, result
