tell application "iTunes"
	set pl to every playlist whose name is "Greg's Library"
	set artistNames to artist of every track of item 1 of pl
	--set artistNames to artist of every track of library playlist 1
end tell
