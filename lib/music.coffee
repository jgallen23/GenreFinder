applescript = require "applescript"
library = "Greg's Library"


_artistList = false

exports.getArtistsAndGenres = (cb) ->
  if _artistList
    cb _artistList
    return
  ar = {}
  @getArtists (artists) =>
    @getGenres (genres) =>
      artists.forEach (item, i) ->
        if not ar[item]
          ar[item] = []
        if genres[i] != "" and ar[item].indexOf(genres[i]) == -1
          ar[item].push(genres[i])
      json = for name, genres of ar
        { name: name, genres: genres }
      _artistList = json
      cb json

exports.getArtists = (cb) ->
  script = """ 
  tell application "iTunes"
    set pl to item 1 of (every playlist whose name is "#{ library }")
    set artistNames to artist of every track of pl
  end tell
  """
  applescript.execString script, (err, rtn) ->
    cb rtn

exports.getGenres = (cb) ->
  genres = []
  script = """
  tell application "iTunes"
    set pl to item 1 of (every playlist whose name is "#{ library }")
    set genreNames to genre of every track of pl
  end tell
  """
  applescript.execString script, (err, rtn) ->
    cb rtn

exports.setGenre = (artist, genre) ->
  script = """
  tell application "iTunes"
    set genre of every track in library playlist 1 whose artist is "#{ artist }" to "#{ genre }"
  end tell
  """
  applescript.execString script, (err, rtn) ->

