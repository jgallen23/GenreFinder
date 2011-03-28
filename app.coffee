express = require "express"
music = require "./lib/music"
lastfm = require "./lib/lastfm"
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

app.get "/artists", (req, res) ->
  a = music.getArtistsAndGenres (artists) ->
    res.send JSON.stringify artists, "Content-Type": "application/json"


app.post "/artists", (req, res) ->
  data = req.body
  console.log data
  artist = data.name
  genre = data.genres[0]
  music.setGenre artist, genre
  res.send '{ "status": "ok" }', "Content-Type": "application/json"

app.get "/lastfm/similar/:artist", (req, res) ->
  artist = req.params.artist
  l = new lastfm.LastFm lastFMAPIKey
  l.getSimilar artist, (similar) ->
    res.send JSON.stringify(similar), "Content-Type": 'application/json'

app.get "/lastfm/tags/:artist", (req, res) ->
  artist = req.params.artist
  l = new lastfm.LastFm lastFMAPIKey
  l.getTags artist, (tags) ->
    res.send JSON.stringify(tags), "Content-Type": 'application/json'


app.listen 3000, "0.0.0.0"
