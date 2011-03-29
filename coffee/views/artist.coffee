window.ArtistView = Backbone.View.extend
  el: $ "#Artist"
  template: _.template $("#ArtistTemplate").html()
  initialize: ->
    @render()

  setModel: (model) ->
    @model = model
    @render()

  render: ->
    #@clear()
    @el.html @template { artist: @model }
    name = @model.get "name"

  setSimilar: (similar) ->
      lastFMSimilar = similar.map (item) ->
        return item.name
      similar = Artists.filter (item) ->
        lastFMSimilar.indexOf(item.get("name")) != -1

      new SimilarArtistView collection: similar, el: $("#Artist [role='similar']")

  setTags: (tags) ->
      tv = new TagsView collection: tags, el: $("#Artist [role='tags']")
      tv.bind "tagSet", (tag) =>
        @trigger "tagSet", @model.get("name"), tag
