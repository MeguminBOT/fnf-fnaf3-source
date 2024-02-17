local allowCountdown = false
local allowEnd = false

function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		playSound('cutscenes/cutscene4', 1, 'cutsceneAudio4')
		setSoundPitch('cutsceneAudio4', playbackRate)
		startVideo('cutscene4')
		allowCountdown = true
		return Function_Stop
	end
	return Function_Continue
end

function onEndSong()
	if not allowEnd and isStoryMode then
		playSound('cutscenes/cutscene5', 1, 'cutsceneAudio5')
		setSoundPitch('cutsceneAudio5', playbackRate)
		startVideo('cutscene5')
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end