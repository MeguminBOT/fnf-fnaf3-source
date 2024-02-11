local allowCountdown = false

function onStartCountdown()
	if not allowCountdown then
		playSound('cutscenes/endo')
		startVideo('endo')
		allowCountdown = true
		return Function_Stop
	end
	return Function_Continue
end