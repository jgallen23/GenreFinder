applescript = require "applescript"
library = "Library"

exports.getArtistsAndGenres = (cb) ->
	ar = {}
	@getArtists (artists) =>
		@getGenres (genres) =>
			artists.forEach (item, i) ->
				if not ar[item]
					ar[item] = []
				if ar[item].indexOf(genres[i]) == -1
					ar[item].push(genres[i])
			json = for name, tags of ar
				{ name: name, tags: tags }
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


