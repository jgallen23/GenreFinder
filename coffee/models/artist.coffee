window.Artist = Backbone.Model.extend
	initialize: () ->


window.ArtistList = Backbone.Collection.extend
	model: Artist
	url: "/artists"

window.Artists = new ArtistList

	
