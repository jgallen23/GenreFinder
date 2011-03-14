tell application "iTunes"
	set genre of every track in library playlist 1 whose artist is "MGMT" to "Indie"
end tell