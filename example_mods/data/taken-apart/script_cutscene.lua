local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		playSound('cutscenes/cutscene1', 1, 'cutsceneAudio')
		startVideo('cutscene1')
		allowCountdown = true
		return Function_Stop
	end
	stopSound('cutsceneAudio')
	return Function_Continue
end