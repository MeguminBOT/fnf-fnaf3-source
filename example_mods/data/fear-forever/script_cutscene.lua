local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		playSound('cutscenes/cutscene3', 1, 'cutsceneAudio')
		startVideo('cutscene3')
		allowCountdown = true
		return Function_Stop
	end
	stopSound('cutsceneAudio')
	return Function_Continue
end