window.ArtistListView = Backbone.View.extend
	el: $ "#ArtistList"
	template: _.template $("#ArtistListTemplate").html()
	initialize: ->
		_.bindAll this, 'render'
		Artists.bind "refresh", @render
		Artists.fetch()
	render: ->
		console.log Artists
		@el.html @template Artists
