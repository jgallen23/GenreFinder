window.TagsView = Backbone.View.extend
  template: _.template $("#TagsTemplate").html()
  initialize: ->
    @render()
  events: {
    "click button[data-action='setGenre']": "setTag"
  }
  setCollection: (collection) ->
    @collection = collection
    @render()
  render: ->
    @el.html @template { tags: @collection }
  setTag: (el) ->
    tag = el.target.innerText
    @trigger "tagSet", tag
    
