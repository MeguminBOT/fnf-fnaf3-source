function onCreate()

	--makeAnimatedLuaSprite('prefire', 'BGs/prefirestage', -2592, -1066)
	--setObjectOrder('prefire', 1)
	--scaleObject('prefire', 1.5, 1.5)
	--addAnimationByPrefix('prefire', 'anim', 'idle0', 24, true)
	--playAnim('prefire', 'anim', true)
	--addLuaSprite('prefire', true)

	makeVideoSprite('firebg', 'firebg', -700, 100)
	scaleVideo('firebg', 2.2, 2.2)
	setVideoCamera('firebg', 'camGame')

	setProperty('boyfriend.x', 700)
	setProperty('boyfriend.y', 270)
	setProperty('dad.x', 301)
	setProperty('dad.y', -75)
end

function onStepHit()
	if curStep == 10 then

		addVideoSprite('firebg', 'true')
	end
end