local allowCountdown = false

function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		playSound('cutscenes/cutscene2', 1, 'cutsceneAudio2')
		setSoundPitch('cutsceneAudio2', playbackRate)
		startVideo('cutscene2')
		allowCountdown = true
		return Function_Stop
	end
	return Function_Continue
end