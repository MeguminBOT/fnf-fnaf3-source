local allowCountdown = false

function onStartCountdown()
	if not allowCountdown then
		playSound('cutscenes/endo', 1, 'cutsceneAudio6')
		setSoundPitch('cutsceneAudio6', playbackRate)
		startVideo('endo')
		allowCountdown = true
		return Function_Stop
	end
	return Function_Continue
end