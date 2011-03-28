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
    getSimilar = ->
      #Similar
      $.getJSON "/lastfm/similar/#{ name }", (data) =>
        lastFMSimilar = data.map (item) ->
          return item.name
        similar = Artists.filter (item) ->
          lastFMSimilar.indexOf(item.get("name")) != -1

        new SimilarArtistView { collection: similar }
    getTags = ->
      #Tags
      $.getJSON "/lastfm/tags/#{ name }", (tags) ->
        tv = new TagsView collection: tags, el: $("#Artist [role='tags']")
        tv.bind "tagSet", (tag) ->
          console.log "trigger"
          #artist.set { genres: [tag] }
          #artist.save()
    getTags()
    getSimilar()
