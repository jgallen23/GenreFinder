express = require "express"
app = express.createServer()

app.configure () ->
	app.use express.methodOverride()
	app.use express.bodyParser()
	app.use app.router
	app.set "views", "#{ __dirname }/templates"
	app.set "view engine", "ejs"
	app.register ".html", require "ejs"
	app.set "view options", layout: false

	app.use express.static "#{ __dirname }/public"
	app.use express.errorHandler { dumpExceptions: true, showStack: true }
 

app.get "/", (req, res) ->
	res.render "index.html"

app.listen 3000
