express = require "express"
music = require "./lib/music"
lastfm = require "./lib/lastfm"
io = require "socket.io"
ejs = require "ejs"
app = express.createServer()

ejs.open = '{{'
ejs.close = '}}'

lastFMAPIKey = "b65df1403e2b6b46ff46fb1c5cb5f578"
app.configure () ->
  app.use express.methodOverride()
  app.use express.bodyParser()
  app.use app.router

  app.register ".html", require "ejs"
  app.set "views", "#{ __dirname }/templates"
  app.set "view engine", "ejs"
  app.set "view options", layout: false

  coffeeDir = "#{ __dirname }/coffee"
  publicDir = "#{ __dirname }/public"
  app.use express.compiler src: coffeeDir, dest: publicDir, enable: ['coffeescript']
  app.use express.static publicDir
  app.use express.errorHandler { dumpExceptions: true, showStack: true }
 

app.get "/", (req, res) ->
  res.render "index.html"

socket = io.listen(app)

socket.on "connection", (client) ->
  console.log "connect"

  client.on "message", (data) ->
    console.log data
    res =
      action: data.action

    switch data.action
      when "get.artists" then do ->
        a = music.getArtistsAndGenres (artists) ->
          res.artists = artists
          client.send res

      when "get.lastfm.tags" then do ->
        artist = data.artist
        l = new lastfm.LastFm lastFMAPIKey
        l.getTags artist, (tags) ->
          res.tags = tags
          client.send res

      when "get.lastfm.similar" then do ->
        artist = data.artist
        l = new lastfm.LastFm lastFMAPIKey
        l.getSimilar artist, (similar) ->
          res.similar = similar
          client.send res

      when "set.genre" then do ->
        artist = data.artist
        genre = data.genre
        music.setGenre artist, genre

  client.on "disconnect", (data) ->
    console.log "disconnect"



app.listen 3000, "0.0.0.0"
