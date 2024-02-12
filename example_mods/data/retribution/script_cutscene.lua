local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		playSound('cutscenes/cutscene2', 1, 'cutsceneAudio')
		startVideo('cutscene2')
		allowCountdown = true
		return Function_Stop
	end
	stopSound('cutsceneAudio')
	return Function_Continue
end