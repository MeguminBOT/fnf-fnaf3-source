local allowCountdown = false
local allowEnd = false

function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		playSound('cutscenes/cutscene4', 1, 'cutsceneAudio')
		startVideo('cutscene4')
		allowCountdown = true
		return Function_Stop
	end
	stopSound('cutsceneAudio')
	return Function_Continue
end

function onEndSong()
	if not allowEnd and isStoryMode and not seenCutscene then
		playSound('cutscenes/cutscene5', 1, 'cutsceneAudioEnd')
		startVideo('cutscene5')
		allowEnd = true;
		return Function_Stop;
	end
	stopSound('cutsceneAudioEnd')
	return Function_Continue;
end