local allowCountdown = false
local allowEnd = false

function onStartCountdown()
	if not allowCountdown then
		startVideo('unt')
		allowCountdown = true
		return Function_Stop
	end
	return Function_Continue
end

function onEndSong()
	if not allowEnd then
		startVideo('until')
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end