-- Using Lulu's optimizations to avoid game lagging.

function onCreate()
	-- Custom functions for stage.
	createStage() -- Create stages.
	createMiscSprites() -- Create misc sprites.
end

function onCreatePost()
	createSubtitles() -- Create subtitles. (Had to put them on createPost for some reason)
end

function createStage()
	local stages = {
		{ name = 'eyes', image = 'BGs/eyes', posX = -2000, posY = -550, scrollX = 0.4, scrollY = 0.4, scaleX = 0.9, scaleY = 0.9, add = false },
		{ name = 'helloagain', image = 'BGs/helloagain', posX = -400, posY = 540, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = true },
		{ name = 'sfedstage', image = 'BGs/sfedstage', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.9, scaleY = 0.9, add = false },
		{ name = 'untsfed', image = 'Chars/untsfed', posX = -1500, posY = 500, scrollX = 1, scrollY = 1, scaleX = 1.1, scaleY = 1.1, add = false },
		{ name = 'sfedstage2', image = 'BGs/sfedstage2', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.9, scaleY = 0.9, add = false },
		{ name = 'cameras', image = 'BGs/cameras', posX = -500, posY = -250, scrollX = 0, scrollY = 0, scaleX = 1.9, scaleY = 1.9, add = false }
	}
	
	for _, stage in ipairs(stages) do
		precacheImage(stage.image)

		if stage.name == 'cameras' then
			makeAnimatedLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
			addAnimationByPrefix(stage.name, 'anim', 'idle', 12, true)
		else
			makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		end

		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('eyes.visible', true)
	setProperty('sfedstage.visible', true)
	setProperty('untsfed.visible', true)
	setProperty('helloagain.visible', true)
	setProperty('helloagain.alpha', 0)
end

function createMiscSprites()
	local miscSprites = {
		{ name = 'static', image = 'static', camera = 'camOther', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'black', image = 'black', camera = 'camOther', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 1 },
		{ name = 'white', image = 'white', camera = 'camOther', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'purple', image = 'purple', camera = 'camOther', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'thegraphic', image = 'thegraphic', camera = 'camOther', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 }
	}

	for _, miscSprite in ipairs(miscSprites) do
		precacheImage(miscSprite.image)

		if miscSprite.name == 'static' then
			makeAnimatedLuaSprite(miscSprite.name, miscSprite.image, miscSprite.posX, miscSprite.posY)
			addAnimationByPrefix(miscSprite.name, 'anim', 'idle', 24, true)
		else
			makeLuaSprite(miscSprite.name, miscSprite.image, miscSprite.posX, miscSprite.posY)
		end

		if (miscSprite.camera ~= 'camGame' and immersionLevel == 'Partial') then
			setObjectCamera(miscSprite.name, 'camEasy')
		else
			setObjectCamera(miscSprite.name, miscSprite.camera)
		end

		setScrollFactor(miscSprite.name, miscSprite.scrollX, miscSprite.scrollY)
		scaleObject(miscSprite.name, miscSprite.scaleX, miscSprite.scaleX)
		addLuaSprite(miscSprite.name, true)
		setProperty(miscSprite.name .. '.alpha', miscSprite.alpha)
	end
end

function createSubtitles()
	makeLuaSprite('TextBG', 'black', 0, 535)
	setObjectCamera('TextBG', 'camOther')
	scaleObject('TextBG', 1, 0.1)
	addLuaSprite('TextBG', true)
	setProperty('TextBG.alpha', 0)

	makeLuaText('Text', '', 1200, 50, 545)
	addLuaText('Text')
	setTextSize('Text', 45)
	setTextFont('Text', 'stalker2.ttf')
	setObjectCamera('Text', 'camOther')
end

function onStepHit()
	if curStep == 245 then
		-- Remove previous stage sprites.
		removeLuaSprite('untsfed', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

	elseif curStep == 1080 then
		-- Remove previous stage sprites.
		removeLuaSprite('sfedstage', true)
	
		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of stage sprites.
		setProperty('sfedstage2.visible', true)

	elseif curStep == 1976 then
		-- Remove previous stage sprites.
		removeLuaSprite('sfedstage2', true)
	
		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of stage sprites.
		setProperty('cameras.visible', true)
		setProperty('thegraphic.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('cameras', 'anim', true)

		-- Modify object order.
		setObjectOrder('thegraphic', 5)
	end
end
