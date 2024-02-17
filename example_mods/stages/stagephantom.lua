function onCreate()
	createStage() -- Create stages.
	createStageProps() -- Create stage props.
	createStageAnimated() -- Create animated stages.
	createJumpscares() -- Create jumpscares.
	createMiscSprites() -- Create misc sprites.

	doTweenY('dadTweenY', 'dad', 1000, 1, 'cubeIn')

	makeAnimatedLuaSprite('fan', 'BGs/Fan', -2050, -170)
	setObjectOrder('dadGroup', 2);
	setObjectOrder('fan', 8)
	scaleObject('fan', 0.75, 0.75)
	addAnimationByPrefix('fan', 'anim', 'idle0', 24, true)
	playAnim('fan', 'anim', true)
	addLuaSprite('fan', true)
end

function onCreatePost()
	createSubtitles() -- Create subtitles. (Had to put them on createPost for some reason)
end

function createStage()
	local stages = {
		{ name = 'freddy', image = 'BGs/freddy', posX = -2050, posY = -170, scrollX = 1, scrollY = 1, scaleX = 0.75, scaleY = 0.75, add = true },
		{ name = 'freddy2', image = 'BGs/freddy2', posX = -2050, posY = -170, scrollX = 1, scrollY = 1, scaleX = 0.75, scaleY = 0.75, add = false },
		{ name = 'freddy3', image = 'BGs/freddy3', posX = -1700, posY = -400, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = false },
		{ name = 'foxy', image = 'BGs/foxy', posX = -1700, posY = -400, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = false },
		{ name = 'foxy2', image = 'BGs/foxy2', posX = -1700, posY = -400, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = false },
		{ name = 'chica', image = 'BGs/chica', posX = -1400, posY = -600, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = false },
		{ name = 'bb', image = 'BGs/bb', posX = -1253, posY = -502, scrollX = 1, scrollY = 1, scaleX = 0.8, scaleY = 0.8, add = true },
		{ name = 'mangle', image = 'BGs/mangle', posX = -1200, posY = -602, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = true },
		{ name = 'puppet', image = 'BGs/puppet', posX = -471, posY = -319, scrollX = 0, scrollY = 0, scaleX = 1.2, scaleY = 1.2, add = true },
		{ name = 'puppet2', image = 'BGs/puppet2', posX = -380, posY = 1200, scrollX = 0.8, scrollY = 0.8, scaleX = 0.7, scaleY = 0.7, add = true },
	}
	
	for _, stage in ipairs(stages) do
		precacheImage(stage.image)
		makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('freddy.visible', true)
	setProperty('freddy2.visible', true)
end

function createStageProps()
	if lowQuality then
		return
	end

	local props = {
		{ name = 'arcade', image = 'Props/arcade', posX = 800, posY = 0, scrollX = 1.3, scrollY = 1.2, scaleX = 2.5, scaleY = 2.5, add = true },
		{ name = 'wire', image = 'Props/wire', posX = -1700, posY = 0, scrollX = 1.3, scrollY = 1.2, scaleX = 2.5, scaleY = 2.5, add = true },
		{ name = 'greenglow', image = 'BGs/greenglow', posX = -2000, posY = -3000, scrollX = 1.3, scrollY = 1.2, scaleX = 2.5, scaleY = 2.5, add = true },
		{ name = 'box', image = 'Props/box', posX = 800, posY = 1000, scrollX = 1.3, scrollY = 1.2, scaleX = 1.5, scaleY = 1.5, add = true },
		{ name = 'present', image = 'Props/present', posX = -1300, posY = 1000, scrollX = 1.3, scrollY = 1.2, scaleX = 1.5, scaleY = 1.5, add = true },
		{ name = 'coffee', image = 'Props/coffee', posX = -900, posY = 30, scrollX = 1.3, scrollY = 1.3, scaleX = 2, scaleY = 2, add = true },
		{ name = 'star', image = 'Props/star', posX = -600, posY = -763, scrollX = 1.6, scrollY = 1.1, scaleX = 1.6, scaleY = 1.6, add = true },
		{ name = 'present2', image = 'Props/present', posX = 1400, posY = 371, scrollX = 1.3, scrollY = 1.3, scaleX = 1.6, scaleY = 1.6, add = true },
		{ name = 'gate', image = 'Props/gate', posX = 1272, posY = 475, scrollX = 1.3, scrollY = 1.3, scaleX = 0.8, scaleY = 0.8, add = true },
		{ name = 'table', image = 'Props/table', posX = -1500, posY = 500, scrollX = 1.3, scrollY = 1.3, scaleX = 1.5, scaleY = 1.5, add = true },
	}

	for _, prop in ipairs(props) do
		precacheImage(prop.image)
		makeLuaSprite(prop.name, prop.image, prop.posX, prop.posY)
		setScrollFactor(prop.name, prop.scrollX, prop.scrollY)
		scaleObject(prop.name, prop.scaleX, prop.scaleY)
		addLuaSprite(prop.name, prop.add)
		setProperty(prop.name .. '.visible', false)
	end
end

function createStageAnimated()
	local stagesAnimated = {
		{ name = 'foxychase', image = 'BGs/foxychase', animation = 'foxychase', xmlPrefix = 'idle', fps = 24, loop = true, posX = 0, posY = 0, scrollX = 0.9, scrollY = 0.9, scaleX = 1.3, scaleY = 1.3, add = false },
		{ name = 'foxysfeet', image = 'Chars/foxysfeet', animation = 'foxysfeet', xmlPrefix = 'idle', fps = 36, loop = true, posX = 270, posY = 650, scrollX = 0.9, scrollY = 0.9, scaleX = 0.7, scaleY = 0.7, add = true },
		{ name = 'bfeet', image = 'Chars/bfeet', animation = 'bfeet', xmlPrefix = 'idle', fps = 24, loop = true, posX = 1430, posY = 810, scrollX = 0.9, scrollY = 0.9, scaleX = 0.7, scaleY = 0.7, add = true },
		{ name = 'foxyjumping', image = 'Chars/foxyjumping', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = false, posX = 0, posY = 150, scrollX = 0.9, scrollY = 0.9, scaleX = 1.4, scaleY = 1.4, add = true },
		{ name = 'static3', image = 'static', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, posX = 200, posY = 200, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = true },
		{ name = 'greenstatic', image = 'BGs/greenstatic', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, posX = -168, posY = -100, scrollX = 0, scrollY = 0, scaleX = 1.4, scaleY = 1.4, add = false },
		{ name = 'starstring', image = 'BGs/starstring', animation = 'anim', xmlPrefix = 'idle', fps = 12, loop = true, posX = 206, posY = -550, scrollX = 0.8, scrollY = 0.8, scaleX = 0.8, scaleY = 0.8, add = true },
		{ name = 'starstring2', image = 'BGs/starstring', animation = 'anim', xmlPrefix = 'idle', fps = 12, loop = true, posX = 873, posY = -550, scrollX = 1.2, scrollY = 0.8, scaleX = 0.8, scaleY = 0.8, add = true },
		{ name = 'phantoms', image = 'BGs/phantoms', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, posX = -168, posY = -100, scrollX = 0, scrollY = 0, scaleX = 1.4, scaleY = 1.4, add = true },
	}

	for _, stage in ipairs(stagesAnimated) do
		precacheImage(stage.image)
		makeAnimatedLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		addAnimationByPrefix(stage.name, stage.animation, stage.xmlPrefix, stage.fps, stage.loop)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end
end

function createJumpscares()
	local jumpscares = {
		{ name = 'phfreddyjump', image = 'jumpscares/phfreddyjump', posX = 0, posY = 0, add = true },
		{ name = 'phfreddyjumpinverted', image = 'jumpscares/phfreddyjumpinverted', posX = 0, posY = 0, add = true },
		{ name = 'foxyjump', image = 'jumpscares/foxyjumpscare', posX = 0, posY = 0, add = true },
		{ name = 'chicajump', image = 'jumpscares/chica', posX = 0, posY = 0, add = true },
		{ name = 'manglejump', image = 'jumpscares/mangle', posX = 0, posY = 0, add = true },
		{ name = 'mangleinvert', image = 'jumpscares/mangleinvert', posX = 0, posY = 0, add = true },
		{ name = 'bbjump', image = 'jumpscares/bb', posX = 0, posY = 0, add = true },
	}
	
	for _, jumpscare in ipairs(jumpscares) do
		precacheImage(jumpscare.image)
		if (jumpscare.name == 'phfreddyjump' or jumpscare.name == 'foxyjump' or jumpscare.name == 'chicajump' or jumpscare.name == 'manglejump' and not epilepsy) then
			makeAnimatedLuaSprite(jumpscare.name, jumpscare.image, jumpscare.posX, jumpscare.posY)
			addAnimationByPrefix(jumpscare.name, 'anim', 'idle', 24, true)
		else
			makeLuaSprite(jumpscare.name, jumpscare.image, jumpscare.posX, jumpscare.posY)
		end

		if immersionLevel == 'Partial' then
			setObjectCamera(jumpscare.name, 'camEasy')
		else
			setObjectCamera(jumpscare.name, 'camJump')
		end

		addLuaSprite(jumpscare.name, jumpscare.add)
		setProperty(jumpscare.name .. '.visible', false)
	end
end

function createMiscSprites()
	-- Black fade above UI.
	makeLuaSprite('black2', 'black', 0, 0)
	setObjectCamera('black2', 'camHUD')
	addLuaSprite('black2', true)
	setProperty('black2.alpha', 1)

	-- Black fade behind UI.
	makeLuaSprite('black', 'black', -5000, -5000)
	setScrollFactor('black', 0, 0)
	scaleObject('black', 10, 10)
	addLuaSprite('black', true)
	setProperty('black.alpha', 1)

	makeAnimatedLuaSprite('static2', 'static2', 0, 0)
	setObjectCamera('static2', 'camHUD')
	addLuaSprite('static2', true)
	addAnimationByPrefix('static2', 'static2', 'idle', 24, true)
	setProperty('static2.visible', false)
end

function createSubtitles()
	makeLuaSprite('TextBG', 'black', 0, 540)
	setObjectCamera('TextBG', 'camOther')
	scaleObject('TextBG', 1, 0.1)
	addLuaSprite('TextBG', true)
	setProperty('TextBG.alpha', 0)

	makeLuaText('Text', '', 1000, 135, 545)
	addLuaText('Text')
	setTextSize('Text', 45)
	setTextFont('Text', 'stalker2.ttf')
	setObjectCamera('Text', 'camOther')
end

function onBeatHit()
	-- Fade the strumline in and out.
	if curBeat == 228 then
		doTweenAlpha('strumFadeOut', 'camHUD', 0, 1, 'linear')
	elseif curBeat == 256 then
		doTweenAlpha('strumFadeIn', 'camHUD', 1, 1, 'linear')
	elseif curBeat == 456 then
		doTweenAlpha('strumFadeOut', 'camHUD', 0, 0.25, 'linear')
	elseif curBeat == 480 then
		doTweenAlpha('strumFadeIn', 'camHUD', 1, 0.25, 'linear')
	elseif curBeat == 648 then
		doTweenAlpha('strumFadeOut', 'camHUD', 0, 0.25, 'linear')
	elseif curBeat == 709 then
		doTweenAlpha('strumFadeIn', 'camHUD', 1, 1, 'linear')
	elseif curBeat == 839 then
		doTweenAlpha('strumFadeOut', 'camHUD', 0, 0.25, 'linear')
	elseif curBeat == 868 then
		doTweenAlpha('strumFadeIn', 'camHUD', 1, 1, 'linear')
	elseif curBeat == 1072 then
		doTweenAlpha('strumFadeOut', 'camHUD', 0, 0.25, 'linear')
	elseif curBeat == 1100 then
		doTweenAlpha('strumFadeIn', 'camHUD', 1, 1, 'linear')
	elseif curBeat == 1236 then
		doTweenAlpha('strumFadeOut', 'camHUD', 0, 0.25, 'linear')
	elseif curBeat == 1264 then
		doTweenAlpha('strumFadeIn', 'camHUD', 1, 3, 'linear')
	end
end

function onStepHit()
	if curStep == 100 then
		-- Funny Freddy walk.
		doTweenX('Walk', 'dad', -400, 10, 'quadIn')

	elseif curStep == 192 then
		-- Funny Freddy walk.
		doTweenX('Walk', 'dad', -550, 5, 'quadIn')

	elseif curStep == 320 then
		-- Funny Freddy walk.
		doTweenX('Walk', 'dad', -700, 5, 'quadIn')

	elseif curStep == 448 then
		-- Funny Freddy walk.
		doTweenX('Walk', 'dad', -850, 5, 'quadIn')

	elseif curStep == 576 then
		-- Funny Freddy walk.
		doTweenX('Walk', 'dad', -1000, 5, 'quadIn')

	elseif curStep == 640 then
		-- Phase Transition.
		setProperty('phfreddyjumpinverted.visible', true)
		setProperty('phfreddyjumpinverted.alpha', 1)
		doTweenAlpha('phfreddyjumpinverted', 'phfreddyjumpinverted', 0, 1, true)

		-- Remove previous stage sprites.
		removeLuaSprite('freddy', true)
		removeLuaSprite('freddy2', true)
		removeLuaSprite('phfreddyjump', true) 
		removeLuaSprite('fan', true)

		-- Modify object order.
		setObjectOrder('freddy3', 0)

		-- Toggle visibility of the next stage sprites.
		setProperty('freddy3.visible', true)
		setProperty('arcade.visible', true)
		setProperty('wire.visible', true)
		setProperty('greenglow.visible', true)

	elseif curStep == 928 then
		-- Remove previous stage sprites.
		removeLuaSprite('greenglow', true)
		removeLuaSprite('wire', true)
		removeLuaSprite('arcade', true) 
		removeLuaSprite('freddy3', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])

		-- Modify object order.
		setObjectOrder('foxy', 1)

		-- Re-position characters.
		setProperty('dad.x', -500)
		setProperty('dad.y', 600)
		setProperty('boyfriend.x', 700)
		setProperty('boyfriend.y', 950)

		-- Hide phantoms.
		setProperty('bfPhantom.alpha', 0)
		setProperty('dadPhantom.alpha', 0)
		setProperty('gfPhantom.alpha', 0)

		-- Toggle visibility of the next stage sprites.
		setProperty('foxy.visible', true)

	elseif curStep == 1280 then
		-- Remove previous stage sprites.
		removeLuaSprite('foxy', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])

		-- Modify object order.
		setObjectOrder('foxy2', 1)

		-- Re-position characters.
		setProperty('dad.x', -500)
		setProperty('dad.y', 600)
		setProperty('boyfriend.x', 700)
		setProperty('boyfriend.y', 950)

		-- Hide phantoms.
		setProperty('bfPhantom.alpha', 0)
		setProperty('dadPhantom.alpha', 0)
		setProperty('gfPhantom.alpha', 0)

		-- Toggle visibility of the next stage sprites.
		setProperty('foxy2.visible', true)
		setProperty('box.visible', true)
		setProperty('present.visible', true)

	elseif curStep == 1856 then
		-- Remove previous stage sprites.
		removeLuaSprite('foxychase', true)
		removeLuaSprite('foxysfeet', true)
		removeLuaSprite('bfeet', true) 
		removeLuaSprite('foxyjumping', true) 
		removeLuaSprite('bfeetblue', true) 

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])

		-- Modify object order.
		setObjectOrder('static3', 2)
		setObjectOrder('chica', 3)
		setObjectOrder('dadGroup', 1)
		setObjectOrder('boyfriendGroup', 5)

		-- Re-position characters.
		setProperty('dad.x', -135)
		setProperty('dad.y', -50)
		setProperty('boyfriend.x', 1000)
		setProperty('boyfriend.y', 500)

		-- Hide phantoms.
		setProperty('bfPhantom.alpha', 0)
		setProperty('dadPhantom.alpha', 0)
		setProperty('gfPhantom.alpha', 0)

		-- Toggle visibility of the next stage sprites.
		setProperty('static3.visible', true)
		setProperty('chica.visible', true)
		setProperty('coffee.visible', true)
		setProperty('star.visible', true)
		setProperty('present.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('static3', 'anim', true)

	elseif curStep == 2336 then
		-- Modify object order.
		setObjectOrder('static3', 0)
		setObjectOrder('chica', 1)

		-- Re-position characters.
		setProperty('dad.x', -300)
		setProperty('dad.y', 250)

	elseif curStep == 1568 then
		-- Remove previous stage sprites.
		removeLuaSprite('foxy2', true)
		removeLuaSprite('present', true)
		removeLuaSprite('box', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])
		
		-- Modify object order.
		setObjectOrder('foxychase', 1)
		setObjectOrder('foxysfeet', 2)
		setObjectOrder('bfeet', 3)
		setObjectOrder('foxyjumping', 5)

		-- Re-position characters.
		setProperty('dad.x', 520)
		setProperty('dad.y', 175)
		setProperty('boyfriend.x', 1700)
		setProperty('boyfriend.y', 630)

		-- Miscellaneous.
		setProperty('foxyjumping.alpha', 0)

		-- Toggle visibility of the next stage sprites.
		setProperty('foxychase.visible', true)
		setProperty('foxysfeet.visible', true)
		setProperty('bfeet.visible', true)
		setProperty('foxyjumping.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('foxyChase', 'foxyChase', true)
		playAnim('foxysfeet', 'foxysfeet', true)
		playAnim('bfeet', 'bfeet', true)
		playAnim('foxyjumping', 'anim', true)

	elseif curStep == 2698 then
		-- Remove previous stage sprites.
		removeLuaSprite('chica', true)
		removeLuaSprite('coffee', true)
		removeLuaSprite('star', true) 
		removeLuaSprite('present', true)
		removeLuaSprite('static3', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])

		-- Re-position characters.
		setProperty('dad.x', 600)
		setProperty('dad.y', 300)
		setProperty('boyfriend.x', 2000)
		setProperty('boyfriend.y', 350)

		-- Modfy object order.
        setObjectOrder('bb', 1)
		setObjectOrder('greenstatic', 2)
		setObjectOrder('dadGroup', 3);

		-- Toggle visibility of the next stage sprites.
		setProperty('bb.visible', true)
		setProperty('gate.visible', true)
		setProperty('table.visible', true)
		setProperty('greenstatic.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('greenstatic', 'anim', true)

	elseif curStep == 3360 then
		-- Set alpha values.
		setProperty('black.alpha', 1)

	elseif curStep == 3376 then
		-- Phase Transition.
		setProperty('black.alpha', 1)
		doTweenAlpha('blackTransition', 'black', 0, 1, 'linear', true)

		-- Remove previous stage sprites.
		removeLuaSprite('bb', true)
		removeLuaSprite('gate', true)
		removeLuaSprite('table', true) 
		removeLuaSprite('greenstatic', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])

		-- Modify object order.
        setObjectOrder('dadGroup', 3)
        setObjectOrder('gfGroup', 4)
        setObjectOrder('boyfriendGroup', 5)
		setObjectOrder('mangle', 2)
		setObjectOrder('dadPhantom', 0)
		setProperty('mangleMech.alpha', 0)

		-- Toggle visibility of the next stage sprites.
		setProperty('mangle.visible', true)

	elseif curStep == 3388 then
		-- Phase Transition.
		doTweenAlpha('blackTransition', 'black', 0, 6, 'linear', true)

	elseif curStep == 4404 then
		-- Phase Transition.
		doTweenAlpha('blackTransition', 'black', 0, 1, 'linear', true)

		-- Remove previous stage sprites.
		removeLuaSprite('mangle', true) 

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])

		-- Modify object order.
		setObjectOrder('puppet', 1)
		setObjectOrder('puppet2', 2)
		setObjectOrder('starstring', 2)
		setObjectOrder('starstring2', 2)

		-- Modify object cameras.
		setObjectCamera('starstring', 'camOther')
		setObjectCamera('starstring2', 'camOther')

		-- Modify camera movement strength.
		dadstrength = 25
		bfstrength = 25

		-- Miscellaneous.
		setProperty('puppet.alpha', 0)

		-- Toggle visibility of the next stage sprites.
		setProperty('puppet.visible', true)
		setProperty('puppet2.visible', true)
		setProperty('starstring.visible', true)
		setProperty('starstring2.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('starstring', 'anim', true)
		playAnim('starstring2', 'anim', true)

	elseif curStep == 4288 then
		-- Set alpha values.
		setProperty('black.alpha', 1)

	elseif curStep == 4544 then
		-- Slowly tween in the background sprite.
		doTweenAlpha('bgappear', 'puppet', 1, 10, 'sineInOut')

	elseif curStep == 4672 then
		-- Tween in the presents sprite.
		doTweenY('presents', 'puppet2', 600, 5, 'cubeOut')

	elseif curStep == 4800 then
		-- Tween in the first stars.
		doTweenY('stardown2', 'starstring2', -100, 5, 'cubeOut')

	elseif curStep == 4832 then
		-- Tween in the second stars.
		doTweenY('stardown1', 'starstring', -100, 5, 'cubeOut')

	elseif curStep == 4944 then
		-- Remove previous stage sprites.
		removeLuaSprite('starstring', true)
		removeLuaSprite('starstring2', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])

	elseif curStep == 5056 then
		-- Remove previous stage sprites.
		removeLuaSprite('puppet', true)
		removeLuaSprite('puppet2', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])

		-- Modify object order.
		setObjectOrder('phantoms', 0)
		setObjectOrder('phantoms', 1)

		-- Modify camera movement strength.
		dadstrength = 50
		bfstrength = 50

		-- Toggle Phantoms.
		setProperty('phantoms.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('phantoms', 'anim', true)
	end
end