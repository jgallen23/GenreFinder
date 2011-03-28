window.ArtistView = Backbone.View.extend
  el: $ "#Artist [role='details']"
  template: _.template $("#ArtistTemplate").html()
  initialize: ->
    @render()
  render: ->
    @el.html @template { artist: @model }
