-- Using Lulu's optimizations to avoid game lagging.

function onCreate()
	-- Custom functions for stage.
	createStage() -- Create stages.
	createStageAnimated() -- Create animated stages.
	createMiscSprites() -- Create misc sprites.
end

function onCreatePost()
	createSubtitles() -- Create subtitles. (Had to put them on createPost for some reason)

	setProperty('paperbonnie.visible', false)
	setProperty('paperbb.visible', false)
	setProperty('camHUD.alpha', 0)
end

function createStage()
	local stages = {
		{ name = 'ppstage', image = 'BGs/ppstage', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 1.07, scaleY = 1.07, add = false },
		{ name = 'ppstage2', image = 'BGs/ppstage2', posX = -750, posY = 550, scrollX = 1, scrollY = 1, scaleX = 0.9, scaleY = 0.9, add = true },
		{ name = 'ppstage3', image = 'BGs/ppstage3', posX = -750, posY = 550, scrollX = 1, scrollY = 1, scaleX = 0.9, scaleY = 0.9, add = true },
	}
	
	for _, stage in ipairs(stages) do
		precacheImage(stage.image)
		makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('ppstage.visible', true)
	setProperty('ppstage2.visible', true)
end


function createStageAnimated()
	local stagesAnimated = {
		{ name = 'bonnieanim', image = 'characters/paperbonnie', animation = 'anim', xmlPrefix = 'enter', fps = 24, loop = true, camera = 'camGame', posX = -515, posY = 240, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = false },
		{ name = 'bbanim', image = 'characters/paperbb', animation = 'anim', xmlPrefix = 'enter', fps = 24, loop = true, camera = 'camGame', posX = -700, posY = 200, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = false },
		{ name = 'paper', image = 'paper', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, camera = 'camOther', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = true },
		{ name = 'paperpeople', image = 'paperpeople', animation = 'anim', xmlPrefix = 'idle', fps = 30, loop = true, camera = 'camOther', posX = -200, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = true },
		{ name = 'paperpeople2', image = 'paperpeople2', animation = 'anim', xmlPrefix = 'idle', fps = 30, loop = true, camera = 'camOther', posX = -200, posY = 600, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = true },
	}

	for _, stage in ipairs(stagesAnimated) do
		precacheImage(stage.image)
		makeAnimatedLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		addAnimationByPrefix(stage.name, stage.animation, stage.xmlPrefix, stage.fps, stage.loop)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)

		if (stage.camera ~= 'camGame' and immersionLevel == 'Partial') then
			setObjectCamera(stage.name, 'camEasy')
		else
			setObjectCamera(stage.name, stage.camera)
		end

		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end
end

function createMiscSprites()
	local miscSprites = {
		{ name = 'black', image = 'black', camera = 'camOther', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'white', image = 'white', camera = 'camOther', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
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
	if curStep == 699 then
		-- Toggle visibility of the Bonnie paperpal entrance.
		setProperty('bonnieanim.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('bonnieanim', 'anim', true)

	elseif curStep == 720 then
		-- Remove Bonnie paperpal entrance animation sprite.
		removeLuaSprite('bonnieanim', true)

		-- Toggle visibility of the actual Bonnie paperpal.
		setProperty('paperbonnie.visible', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])
	
	elseif curStep == 1392 then
		-- Remove previous stage sprites.
		removeLuaSprite('ppstage2', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])

		-- Toggle visibility of the stage sprite.
		setProperty('ppstage3.visible', true)

		-- Toggle visibility of the BB paperpal entrance.
		setProperty('bbanim.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('bbanim', 'anim', true)

	elseif curStep == 1424 then
		-- Remove BB Paperpal entrance animation sprite.
		removeLuaSprite('bbanim', true)

		-- Toggle visibility of the actual BB paperpal.
		setProperty('paperbb.visible', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])

	elseif curStep == 1936 then
		-- Toggle visibility of the annoying paper people distractions.
		setProperty('paperpeople.visible', true)
		setProperty('paperpeople2.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('paperpeople', 'anim', true)
		playAnim('paperpeople2', 'anim', true)
	end
end
