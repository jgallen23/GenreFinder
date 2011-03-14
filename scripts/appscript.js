var fs = require('fs');
var path = require('path');
var applescript = require('applescript');

applescript.execFile('artist_list.applescript', function(err, rtn) {
	if (err) {
		console.log(err);
	} else {
		var artists = [];
		rtn.forEach(function(item, i) {
			if (artists.indexOf(item.toLowerCase()) == -1)
				artists.push(item.toLowerCase());
		});
		artists.sort();
		console.log(artists.length);
		console.log(artists);
	}
});
