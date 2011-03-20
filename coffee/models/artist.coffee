window.Artist = Backbone.Model.extend
	initialize: () ->


window.ArtistList = Backbone.Collection.extend
	model: Artist
	url: "/artists"
	comparator: (item) ->
		return item.get('name').toLowerCase()

window.Artists = new ArtistList

	
