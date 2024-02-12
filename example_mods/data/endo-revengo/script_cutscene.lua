local allowCountdown = false

function onStartCountdown()
	if not allowCountdown then
		playSound('cutscenes/endo', 1, 'cutsceneAudio')
		startVideo('endo')
		allowCountdown = true
		return Function_Stop
	end
	stopSound('cutsceneAudio')
	return Function_Continue
end