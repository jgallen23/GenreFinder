window.GenreFinderController = Backbone.Controller.extend
  initialize: ->
    @artistsLoaded = false
    @artistView = null

    socket = new io.Socket "gregamel.local"
    @socket = socket
    self = @

    socket.on "connect", ->
      console.log "connect"

      socket.send action: 'get.artists'

    socket.on "message", (data) ->
      console.log "message", data
      switch data.action
        when "get.artists" then do ->
          Artists.refresh data.artists
        when "get.lastfm.tags" then do ->
          self.artistView.setTags data.tags
        when "get.lastfm.similar" then do ->
          self.artistView.setSimilar data.similar
          

    socket.connect()

    #init app
    Artists.bind "refresh", =>
      @artistNames = Artists.map (item) ->
        item.get "name"
      Backbone.history.start()

  routes:
    "": "artists"
    "artists": "artists"
    "artist/:name": "artist"
    "artist/:name/next": "next"
    "artist/:name/prev": "prev"
  
  artists: ->
    $("#ArtistList").show()
    $("#Artist").hide()
    new ArtistListView()
    @artistsLoaded = true

  artist: (name) ->

    console.log "artist"
    $("#ArtistList").hide()
    $("#Artist").show()

    artist = Artists.models[@artistNames.indexOf name]
    name = name.replace(/\s/g, "+")

    @socket.send action: 'get.lastfm.tags', artist: name
    @socket.send action: 'get.lastfm.similar', artist: name

    if @artistView
      @artistView.setModel artist
    else
      @artistView = new ArtistView model: artist, el: $("#Artist")
      @artistView.bind "tagSet", (name, tag) =>
        console.log "set genre"
        @socket.send action: 'set.genre', artist: name, genre: tag
  
  next: (name) ->
    index = @artistNames.indexOf name
    nextArtist = Artists.models[index+1]
    window.location = "#artist/#{ nextArtist.get("name") }"
  
  prev: (name) ->
    index = @artistNames.indexOf name
    prevArtist = Artists.models[index-1]
    window.location = "#artist/#{ prevArtist.get("name") }"

