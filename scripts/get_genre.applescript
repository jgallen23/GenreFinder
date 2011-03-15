tell application "iTunes"
	set artistGenres to {}
	set tks to every track in library playlist 1 whose artist is "Thrice"
	repeat with tk in tks
		set tkGenre to genre of tk
		if tkGenre is not "" and artistGenres does not contain tkGenre then
			copy genre of tk to end of artistGenres
		end if
	end repeat
	set asdf to artistGenres
end tell