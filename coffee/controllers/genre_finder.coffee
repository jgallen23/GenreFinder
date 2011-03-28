window.GenreFinderController = Backbone.Controller.extend
  initialize: ->
    @artistsLoaded = false
    @artistView = null
    Artists.fetch { success: =>
      @artistNames = Artists.map (item) ->
        item.get "name"
      Backbone.history.start()
    }
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

    $("#ArtistList").hide()
    $("#Artist").show()

    artist = Artists.models[@artistNames.indexOf name]
    name = name.replace(/\s/g, "+")

    if @artistView
      @artistView.setModel artist
    else
      @artistView = new ArtistView model: artist, el: $("#Artist")
  
  next: (name) ->
    index = @artistNames.indexOf name
    nextArtist = Artists.models[index+1]
    window.location = "#artist/#{ nextArtist.get("name") }"
  
  prev: (name) ->
    index = @artistNames.indexOf name
    prevArtist = Artists.models[index-1]
    window.location = "#artist/#{ prevArtist.get("name") }"

