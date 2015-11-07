express = require 'express'
sispm = require './sispm'

app = express()
app.set 'view engine', 'jade'

showError = (res, status) ->
  (error) ->
    console.log "app error: ", error if status == 500
    res
      .type 'text/plain'
      .status(status || 500)
      .send error

app.param 'id', (req, res, next, id) ->
  req.id = parseInt id
  if id >= 1 && id <= 4
    next()
  else
    showError(res, 400) 'id must be between 1 and 4'

app.get '/', (req, res) ->
  res.redirect '/index.html'

app.get '/index.html', (req, res) ->
  sispm.getStatuses()
    .then (statuses) ->
      res.render 'index', statuses: statuses
    , showError(res)

app.get '/status', (req, res) ->
  sispm.getStatuses()
    .then (statuses) ->
      res.type 'application/json'
      res.send statuses
    , showError(res)

app.put '/toggle/:id', (req, res) ->
  sispm.toggle(req.id).then (status) ->
    res.type 'application/json'
    res.send status
  , showError res

# legacy routes

app.get '/toggle.html/:id', (req, res) ->
  sispm.toggle(req.id).then (status) ->
    res.redirect '/'
  , showError res

app.get '/on:id.html', (req, res) ->
  sispm.switch(req.id, true).then (status) ->
    res.redirect '/'
  , showError res

app.get '/off:id.html', (req, res) ->
  sispm.switch(req.id, false).then (status) ->
    res.redirect '/'
  , showError res

app.listen(process.env.PORT || 2638)
