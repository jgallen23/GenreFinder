window.TagsView = Backbone.View.extend
  el: $ "#Artist [role='tags']"
  template: _.template $("#TagsTemplate").html()
  initialize: ->
    @render()
  events: {
    "click button[data-action='setGenre']": "setTag"
  }
  render: ->
    @el.html @template { tags: @collection }
  setTag: (el) ->
    console.log el
    tag = el.target.innerText
    @trigger "tagSet", tag
    
