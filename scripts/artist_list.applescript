tell application "iTunes"
	set pl to item 1 of (every playlist whose name is "Library")
	set artistNames to artist of every track of pl
	--set artistNames to artist of every track of library playlist 1
end tell
