tell application "iTunes"
	
	set pl to item 1 of (every user playlist whose name is "Greg's Library")
	
	repeat with t in (every track of pl)
		set genre of t to ""
	end repeat
end tell