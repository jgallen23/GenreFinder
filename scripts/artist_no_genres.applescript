tell application "iTunes"
	set pl to item 1 of (every playlist whose name is "Greg's Library")
	--set genres to genre of every track of pl whose artist is "Bayside"
	set ars to artist of every track of pl whose artist starts with "a" and genre is ""
	set artistGenres to {}
	repeat with ar in ars
		if artistGenres does not contain ar then
			set end of artistGenres to ar
		end if
	end repeat
	set asd to artistGenres
end tell