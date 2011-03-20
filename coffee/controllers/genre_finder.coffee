window.GenreFinderController = Backbone.Controller.extend
	initialize: ->
		@artistsLoaded = false
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
		#Clear existing
		$("#Artist [role='details'], #Artist [role='tags'], #Artist [role='similar']").html('')

		$("#ArtistList").hide()
		$("#Artist").show()
		artist = Artists.models[@artistNames.indexOf name]
		name = name.replace(/\s/g, "+")
		new ArtistView { model: artist }
		#Similar
		$.getJSON "/lastfm/similar/#{ name }", (data) ->
			lastFMSimilar = data.map (item) ->
				return item.name
			similar = Artists.filter (item) ->
				lastFMSimilar.indexOf(item.get("name")) != -1

			new SimilarArtistView { collection: similar }
		#Tags
		$.getJSON "/lastfm/tags/#{ name }", (tags) ->
			tv = new TagsView { collection: tags }
			tv.bind "tagSet", (tag) ->
				artist.set { genres: [tag] }
				artist.save()

	
	next: (name) ->
		index = @artistNames.indexOf name
		nextArtist = Artists.models[index+1]
		window.location = "#artist/#{ nextArtist.get("name") }"
	
	prev: (name) ->
		index = @artistNames.indexOf name
		prevArtist = Artists.models[index-1]
		window.location = "#artist/#{ prevArtist.get("name") }"

