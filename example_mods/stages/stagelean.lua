-- Using Lulu's optimizations to avoid game lagging.

function onCreate()
	-- Custom functions for stage.
	createStage() -- Create stages.
	createJumpscares() -- Create jumpscares.
	createMiscSprites() -- Create misc sprites.
end

function onCreatePost()
	createSubtitles() -- Create subtitles. (Had to put them on createPost for some reason)
end

function createStage()
	local stages = {
		{ name = 'leanstage', image = 'BGs/leantrap', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 1.4, scaleY = 1.4, add = false },
		{ name = 'drugs', image = 'BGs/drugs', posX = -300, posY = -150, scrollX = 0, scrollY = 0, scaleX = 1.5, scaleY = 1.5, add = false },
	}
	
	for _, stage in ipairs(stages) do
		precacheImage(stage.image)

		if stage.name == 'drugs' then
			if not epilepsy or lowQuality then
				makeAnimatedLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
				addAnimationByPrefix(stage.name, 'anim', 'idle', 24, true)
			else
				makeLuaSprite(stage.name, 'BGs/drugsLQ', stage.posX, stage.posY)
			end
		else
			makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		end

		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('leanstage.visible', true)
end

function createJumpscares()
	local jumpscares = {
		{ name = 'leanjump', image = 'jumpscares/leanjump', posX = 0, posY = 0, add = true },
		{ name = 'leanjump2', image = 'jumpscares/leanjump2', posX = 0, posY = 0, add = true },
	}
	
	for _, jumpscare in ipairs(jumpscares) do
		precacheImage(jumpscare.image)
		makeLuaSprite(jumpscare.name, jumpscare.image, jumpscare.posX, jumpscare.posY)

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
	local miscSprites = {
		{ name = 'white', image = 'white', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'black', image = 'black', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 1 },
		{ name = 'purpleglow', image = 'purpleglow', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'dontdodrugs', image = 'dontdodrugs', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
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

	makeLuaText('Text', '', 1000, 135, 545)
	addLuaText('Text')
	setTextSize('Text', 45)
	setTextFont('Text', 'stalker2.ttf')
	setObjectCamera('Text', 'camOther')
end

function onStepHit()
	if curStep == 832 then
		-- Remove previous stage sprites.
		removeLuaSprite('leantrap', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of the next stage sprites.
		setProperty('drugs.visible', true)
	end
end
