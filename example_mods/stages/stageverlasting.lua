function onCreate()
	makeLuaSprite('office', 'BGs/Freddy', -1771, -468)
	setObjectOrder('office', 5)
	scaleObject('office', 0.9, 0.9)
	addLuaSprite('office', true)
	
	makeLuaSprite('bg', 'BGs/Freddy2', -1687, -480)
	setObjectOrder('bg', 0)
	scaleObject('bg', 0.9, 0.9)
	setScrollFactor('bg', 0.8, 0.8)
	addLuaSprite('bg', true)
	
	makeAnimatedLuaSprite('fan', 'BGs/Fan', -1771, -468)
	setObjectOrder('fan', 7)
	scaleObject('fan', 0.9, 0.9)
	addAnimationByPrefix('fan', 'anim', 'idle0', 24, true)
	playAnim('fan', 'anim', true)
	addLuaSprite('fan', true)
	
	makeAnimatedLuaSprite('cam05', 'cam05', 443, 480)
	setObjectOrder('cam05', 15)
	scaleObject('cam05', 0.253, 0.2)
	addAnimationByPrefix('cam05', 'anim', 'idle0', 24, true)
	playAnim('cam05', 'anim', true)
	addLuaSprite('cam05', true)

	makeAnimatedLuaSprite('cam02', 'cam02', 443, 480)
	setObjectOrder('cam02', 15)
	scaleObject('cam02', 0.253, 0.2)
	addAnimationByPrefix('cam02', 'anim', 'idle0', 24, true)
	playAnim('cam02', 'anim', true)
	addLuaSprite('cam02', true)
	
	makeAnimatedLuaSprite('camstatic', 'camstatic', 443, 480)
	setObjectOrder('camstatic', 16)
	scaleObject('camstatic', 0.253, 0.2)
	addAnimationByPrefix('camstatic', 'anim', 'idle0', 24, true)
	playAnim('camstatic', 'anim', true)
	addLuaSprite('camstatic', true)

	setProperty('camstatic.alpha', 0);
	setProperty('cam02.alpha', 0);
	setProperty('cam05.alpha', 0);

	makeLuaSprite('white','white', -5000, -5000);
	setLuaSpriteScrollFactor('white', 0, 0);
	scaleObject('white', 20, 20);
	addLuaSprite('white', true);
	makeLuaSprite('black','black', -5000, -5000);
	setLuaSpriteScrollFactor('black', 0, 0);
	scaleObject('black', 20, 20);
	addLuaSprite('black', true);
	makeLuaSprite('whiteui','whiteui', 0, 0);
	setObjectCamera('whiteui', 'hud')
	addLuaSprite('whiteui', true);
	setProperty('whiteui.alpha', 0);
	setProperty('white.alpha', 0);
	setObjectOrder('whiteui', 98)
	setObjectOrder('white', 99)
	setObjectOrder('black', 100)


end

function onStepHit()
	if curStep == 832 then
		setObjectOrder('bg', 0)
		setObjectOrder('office', 1)
		setObjectOrder('fan', 2)
		scaleObject('dad', 0.285, 0.23)
		setProperty('boyfriend.x', 630)
		setProperty('boyfriend.y', 600)
	end
	if curStep == 1088 then
		scaleObject('dad', 0.285, 0.23)
		setProperty('cam02.alpha', 1);
	end
	if curStep == 1376 then
		removeLuaSprite('camstatic', true);
		removeLuaSprite('cam05', true);
		removeLuaSprite('cam02', true);
		removeLuaSprite('fan', true);
		removeLuaSprite('office', true);
		removeLuaSprite('bg', true);

		makeLuaSprite('door', 'BGs/springtrap2', -795, -448)
		setObjectOrder('door', 5)
		scaleObject('door', 0.7, 0.7)
		addLuaSprite('door', true)
		
		makeLuaSprite('hallway', 'BGs/springtrap1', -794, -440)
		setObjectOrder('hallway', 0)
		scaleObject('hallway', 0.7, 0.7)
		setScrollFactor('hallway', 0.9, 0.9)
		addLuaSprite('hallway', true)

		setProperty('boyfriend.x', 630)
		setProperty('boyfriend.y', 400)
	end
	if curStep == 1680 then
		removeLuaSprite('door', true);
		removeLuaSprite('hallway', true);
	end
	if curStep == 2736 then

		makeAnimatedLuaSprite('longasshallway', 'BGs/foxychase', -327, -365)
		setObjectOrder('longasshallway', 0)
		scaleObject('longasshallway', 1.3, 1.3)
		addAnimationByPrefix('longasshallway', 'anim', 'idle0', 24, true)
		playAnim('longasshallway', 'anim', true)
		addLuaSprite('longasshallway', true)
		
		makeAnimatedLuaSprite('bfeet', 'Chars/bfeet', 1265, 553)
		setObjectOrder('bfeet', 1)
		scaleObject('bfeet', 0.7, 0.7)
		addAnimationByPrefix('bfeet', 'anim', 'idle0', 24, true)
		playAnim('bfeet', 'anim', true)
		addLuaSprite('bfeet', true)
		
		makeAnimatedLuaSprite('aftonfeet', 'Chars/springtrapfeet', -19, 221)
		setObjectOrder('aftonfeet', 1)
		addAnimationByPrefix('aftonfeet', 'anim', 'idle0', 40, true)
		playAnim('aftonfeet', 'anim', true)
		addLuaSprite('aftonfeet', true)

		setProperty('boyfriend.x', 1429)
		setProperty('boyfriend.y', 330)
		setProperty('dad.x', 301)
		setProperty('dad.y', -75)
	end
	if curStep == 3280 then
		removeLuaSprite('aftonfeet', true);
		removeLuaSprite('bfeet', true);
		removeLuaSprite('longasshallway', true);
		setProperty('boyfriend.x', 700)
	end
	if curStep == 3792 then
		makeAnimatedLuaSprite('prefire', 'BGs/prefirestage', -2592, -1066)
		setObjectOrder('prefire', 1)
		scaleObject('prefire', 1.5, 1.5)
		addAnimationByPrefix('prefire', 'anim', 'idle0', 24, true)
		playAnim('prefire', 'anim', true)
		addLuaSprite('prefire', true)
	end
	if curStep == 4304 then
		removeLuaSprite('prefire', true);
	end
end