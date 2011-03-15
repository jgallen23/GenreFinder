express = require "express"
app = express.createServer()

artists = []

app.configure () ->
	app.use express.methodOverride()
	app.use express.bodyParser()
	app.use app.router

	app.register ".html", require "ejs"
	app.set "views", "#{ __dirname }/templates"
	app.set "view engine", "ejs"
	app.set "view options", layout: false

	coffeeDir = "#{ __dirname }"
	publicDir = "#{ __dirname }/public"
	app.use express.compiler src: coffeeDir, dest: publicDir, enable: ['coffeescript']
	app.use express.static publicDir
	app.use express.errorHandler { dumpExceptions: true, showStack: true }
 

app.get "/", (req, res) ->
	res.render "index.html"

app.get "/artists", (req, res) ->
	res.send JSON.stringify artists

app.post "/artists", (req, res) ->
	data = req.body
	artists.push data
	res.send "created"

app.listen 3000
