exec = require('child_process').exec

self = module.exports =
  getStatuses: ->
    new Promise (resolve, reject) ->
      self.sispmctl('-g all').then (output) ->
        resolve(value == 'on' for value in output.match /\bon|off\b/g)
      , reject

  toggle: (id) ->
    new Promise (resolve, reject) ->
      self.sispmctl("-t #{id}").then (output) ->
        resolve output.includes 'on'
      , reject

  switch: (id, enable) ->
    option = if enable then '-o' else '-f'
    self.sispmctl "#{option} #{id}"

  sispmctl: (params) ->
    new Promise (resolve, reject) ->
      cmd = "sispmctl #{params}"
      exec cmd, (error, stdout, stderr) ->
        console.log 'ERROR' if error
        console.log cmd, stdout, stderr
        if error then reject(stderr) else resolve(stdout)
