local allowCountdown = false
local allowEnd = false

function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		playSound('cutscenes/cutscene4')
		startVideo('cutscene4')
		allowCountdown = true
		return Function_Stop
	end
	return Function_Continue
end

function onEndSong()
	if not allowEnd and isStoryMode then
		playSound('cutscenes/cutscene5')
		startVideo('cutscene5')
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end