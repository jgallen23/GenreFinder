sys = require 'sys'
http = require 'http'
xml2js = require 'xml2js'

_lastfmcache = {}
class LastFm
  constructor: (api, secret) ->
    @host = "ws.audioscrobbler.com"
    @api = api

  makeRequest: (url, cb) ->
    options =
      host: @host
      path: "/2.0/#{ url }&api_key=#{ @api }"

    self = @
    if _lastfmcache[options.path]
      console.log "cache hit"
      cb _lastfmcache[options.path]
    http.get options, (res) ->
      data = ""
      parser = new xml2js.Parser()
      parser.addListener 'end', (result) ->
        _lastfmcache[options.path] = result
        cb result
      res.on 'data', (chunk) ->
        data += chunk.toString "utf8"
      res.on "end", ->
        parser.parseString data
        


  getSimilar: (artist, cb) ->
    url = "?method=artist.getsimilar&artist=#{ artist }&limit=10&autocorrect=1"
    @makeRequest url, (data) ->
      cb data.similarartists.artist

  getTags: (artist, cb) ->
    url = "?method=artist.gettoptags&artist=#{ artist }"
    @makeRequest url, (data) ->
      cb data.toptags.tag[0...10]

exports.LastFm = LastFm

api = "b65df1403e2b6b46ff46fb1c5cb5f578"
#l = new LastFm api
#l.getSimilar "incubus", (data) ->
  #console.log sys.inspect data.similarartists.artist
#l.getTags "incubus", (data) ->
  #console.log data
