window.ArtistListView = Backbone.View.extend
  el: $ "#ArtistList"
  template: _.template $("#ArtistListTemplate").html()
  initialize: ->
    @render()
  render: ->
    @el.html @template Artists
