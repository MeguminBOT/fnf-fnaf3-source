function onEvent(name, value1, value2)
	if name == 'paper' then
		runTimer('gonepap', 1, 1)
		setProperty('paper.visible', true)
		setProperty('paper.alpha', 1)
		playAnim('paper', 'anim', true)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'gonepap' then
		setProperty('paper.alpha', 0)
		setProperty('paper.visible', false)
	end
end