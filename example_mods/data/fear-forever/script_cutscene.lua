local allowCountdown = false

function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		playSound('cutscenes/cutscene3', 1, 'cutsceneAudio3')
		setSoundPitch('cutsceneAudio3', playbackRate)
		startVideo('cutscene3')
		allowCountdown = true
		return Function_Stop
	end
	return Function_Continue
end