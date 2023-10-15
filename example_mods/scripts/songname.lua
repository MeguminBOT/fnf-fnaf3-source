function onCreate()
	makeAnimatedLuaSprite('songnametablet', 'tablets/'..songName, -150, 290)
	setObjectCamera('songnametablet', 'camOther')
	addLuaSprite('songnametablet', true)
	addAnimationByPrefix('songnametablet', 'anim', 'idle', 24, true)
	scaleObject('songnametablet', 0.6, 0.6)
	setProperty('songnametablet.visible', false)
end

function onStepHit()
	if curStep == 10 then
		playAnim('songnametablet', 'anim', true)
		setProperty('songnametablet.visible', true)
		runTimer('songnametimerdone', 6.6)
	end
end

function onTimerCompleted(tag)
	if tag == "songnametimerdone" then
		removeLuaSprite('songnametablet', true)
	end
end