window.SimilarArtistView = Backbone.View.extend
  el: $ "#Artist [role='similar']"
  template: _.template $("#SimilarAritstTemplate").html()
  initialize: ->
    @render()
  render: ->
    @el.html @template { similarArtists: @collection }


