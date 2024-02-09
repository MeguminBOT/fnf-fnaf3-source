local allowEnd = false

function onEndSong()
	if not allowEnd then
		startVideo('until')
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end