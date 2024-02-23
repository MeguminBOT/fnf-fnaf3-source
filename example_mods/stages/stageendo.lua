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
		{ name = 'endobg', image = 'BGs/endobg', posX = -2200, posY = -900, scrollX = 1, scrollY = 1, scaleX = 1.3, scaleY = 1.3, add = true },
		{ name = 'mimic', image = 'Chars/mimic', posX = -300, posY = -100, scrollX = 0, scrollY = 0, scaleX = 1.1, scaleY = 1.1, add = true },
	}
	
	for _, stage in ipairs(stages) do
		precacheImage(stage.image)
		makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end

	setObjectOrder('endobg', 0)
	setObjectOrder('mimic', 2)
	setProperty('endobg.visible', true)
	setProperty('mimic.alpha', 0)
end

function createMiscSprites()
	local miscSprites = {
		{ name = 'black', image = 'black', camera = 'camOther', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 1 },
		{ name = 'white', image = 'white', camera = 'camGame', posX = -500, posY = -500, scrollX = 0, scrollY = 0, scaleX = 5, scaleY = 5, alpha = 0 },
	}

	for _, miscSprite in ipairs(miscSprites) do
		precacheImage(miscSprite.image)
		makeLuaSprite(miscSprite.name, miscSprite.image, miscSprite.posX, miscSprite.posY)
		setScrollFactor(miscSprite.name, miscSprite.scrollX, miscSprite.scrollY)
		scaleObject(miscSprite.name, miscSprite.scaleX, miscSprite.scaleX)

		if (miscSprite.camera ~= 'camGame' and immersionLevel == 'Partial') then
			setObjectCamera(miscSprite.name, 'camEasy')
		else
			setObjectCamera(miscSprite.name, miscSprite.camera)
		end

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
	if curStep == 148 then
		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])
	
	elseif curStep == 480 then
		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

	elseif curStep == 828 then
		scaleObject('TextBG', 1, 0.15)

	elseif curStep == 857 then
		scaleObject('TextBG', 1, 0.1)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

	elseif curStep == 1529 then
		scaleObject('TextBG', 1, 0.15)

	elseif curStep == 1566 then
		scaleObject('TextBG', 1, 0.1)

	elseif curStep == 1669 then
		scaleObject('TextBG', 1, 0.15)

	elseif curStep == 1699 then
		scaleObject('TextBG', 1, 0.1)

	elseif curStep == 1744 then
		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

	elseif curStep == 1840 then
		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

	elseif curStep == 2039 then
		scaleObject('TextBG', 1, 0.15)

	elseif curStep == 2068 then
		scaleObject('TextBG', 1, 0.1)

	elseif curStep == 2368 then
		-- Remove previous stage sprites.
		removeLuaSprite('mimic', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])
	end
end
