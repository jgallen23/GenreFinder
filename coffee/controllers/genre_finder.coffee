window.GenreFinderController = Backbone.Controller.extend
	initialize: ->
		@artistsLoaded = false
	routes:
		"": "artists"
		"artists": "artists"
		"artist/:name": "artist"
	
	artists: ->
		$("#ArtistList").show()
		$("#Artist").hide()
		new ArtistListView()
		@artistsLoaded = true

	artist: (name) ->
		show = ->
			$("#ArtistList").hide()
			$("#Artist").show()
			artist = Artists.filter (artist) ->
				return (artist.get("name") == name)
			new ArtistView { model: artist[0] }
			console.log "artist", name
		if !@artistsLoaded
			Artists.fetch { success: show }
		else
			show()
