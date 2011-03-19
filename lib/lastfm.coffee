sys = require 'sys'
http = require 'http'
xml2js = require 'xml2js'

class LastFm
	constructor: (api, secret) ->
		@host = "ws.audioscrobbler.com"
		@api = api

	makeRequest: (url, cb) ->
		options =
			host: @host
			path: "/2.0/#{ url }&api_key=#{ @api }"

		http.get options, (res) ->
			data = ""
			parser = new xml2js.Parser()
			parser.addListener 'end', (result) ->
				cb result.similarartists.artist
			res.on 'data', (chunk) ->
				data += chunk.toString "utf8"
			res.on "end", ->
				parser.parseString data
				


	getSimilar: (artist, cb) ->
		url = "?method=artist.getsimilar&artist=#{ artist }"
		@makeRequest url, cb

exports.LastFm = LastFm

#api = "b65df1403e2b6b46ff46fb1c5cb5f578"
#l = new LastFm api, secret
#l.getSimilar "incubus", (data) ->
	#console.log sys.inspect data.similarartists.artist
