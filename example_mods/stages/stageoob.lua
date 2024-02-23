-- Using Lulu's optimizations to avoid game lagging.

function onCreate()
	-- Custom functions for stage.
	createStage() -- Create stages.
	createStageAnimated() -- Create animated stages.
	createMiscSprites() -- Create misc sprites.
end

function onCreatePost()
	createSubtitles() -- Create subtitles. (Had to put them on createPost for some reason)
end

function createStage()
	local stages = {
		{ name = 'oob', image = 'BGs/oob', posX = 0, posY = 0, scrollX = 0, scrollY = 0, scaleX = 1, scaleY = 1, add = true, antialiasing = false },
		{ name = 'oobbb', image = 'BGs/oobbb', posX = -720, posY = -50, scrollX = 1, scrollY = 1, scaleX = 0.8, scaleY = 0.8, add = true, antialiasing = false },
		{ name = 'oobbb2', image = 'BGs/oobbb2', posX = -900, posY = -550, scrollX = 0.8, scrollY = 0.5, scaleX = 0.8, scaleY = 0.8, add = false, antialiasing = true },
		{ name = 'oobmangle', image = 'BGs/oobmangle', posX = -900, posY = -30, scrollX = 1, scrollY = 1, scaleX = 0.8, scaleY = 0.8, add = true, antialiasing = false },
		{ name = 'oobmangle2', image = 'BGs/oobmangle2', posX = -800, posY = -550, scrollX = 0.8, scrollY = 0.5, scaleX = 0.8, scaleY = 0.8, add = false, antialiasing = true },
		{ name = 'oobchica', image = 'BGs/oobchica', posX = -700, posY = -20, scrollX = 1, scrollY = 1, scaleX = 0.8, scaleY = 0.8, add = true, antialiasing = false },
		{ name = 'oobchica2', image = 'BGs/oobchica2', posX = -1050, posY = -300, scrollX = 0.8, scrollY = 0.5, scaleX = 0.8, scaleY = 0.8, add = false, antialiasing = true },
		{ name = 'oobpuppet', image = 'BGs/oobpuppet', posX = -200, posY = 25, scrollX = 1, scrollY = 1, scaleX = 1.35, scaleY = 1.35, add = false, antialiasing = false },
		{ name = 'oobpuppet2', image = 'BGs/oobpuppet2', posX = -200, posY = 25, scrollX = 1, scrollY = 1, scaleX = 1.35, scaleY = 1.35, add = true, antialiasing = false },
		{ name = 'oobpuppetchild', image = 'BGs/oobpuppetchild', posX = -200, posY = 25, scrollX = 1, scrollY = 1, scaleX = 1.35, scaleY = 1.35, add = true, antialiasing = false },
		{ name = 'oobpuppet5', image = 'BGs/oobpuppet5', posX = -200, posY = 25, scrollX = 1, scrollY = 1, scaleX = 1.35, scaleY = 1.35, add = false, antialiasing = false },
		{ name = 'oobpuppet6', image = 'BGs/oobpuppet6', posX = -200, posY = 25, scrollX = 1, scrollY = 1, scaleX = 1.35, scaleY = 1.35, add = true, antialiasing = false },
		{ name = 'oobpuppet7', image = 'BGs/oobpuppet7', posX = -200, posY = 25, scrollX = 1, scrollY = 1, scaleX = 1.35, scaleY = 1.35, add = true, antialiasing = false },
		{ name = 'oobpuppet8', image = 'BGs/oobpuppet8', posX = -200, posY = 25, scrollX = 1, scrollY = 1, scaleX = 1.35, scaleY = 1.35, add = true, antialiasing = false },
		{ name = 'oobpuppet3', image = 'BGs/oobpuppet3', posX = -200, posY = 25, scrollX = 1, scrollY = 1, scaleX = 1.35, scaleY = 1.35, add = false, antialiasing = false },
		{ name = 'oobpuppet4', image = 'BGs/oobpuppet4', posX = -200, posY = 25, scrollX = 1, scrollY = 1, scaleX = 1.35, scaleY = 1.35, add = true, antialiasing = false },
		{ name = 'oobpuppetchild2', image = 'BGs/oobpuppetchild2', posX = -200, posY = 25, scrollX = 1, scrollY = 1, scaleX = 1.35, scaleY = 1.35, add = true, antialiasing = false }
	}
	
	for _, stage in ipairs(stages) do
		precacheImage(stage.image)
		makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.antialiasing', stage.antialiasing)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('oob.visible', true)
	setProperty('oobbb.visible', true)

	setObjectOrder('oobbb', 0)
end

function createStageAnimated()
	local stagesAnimated = {
		{ name = 'oobfredbear', image = 'BGs/oobfredbear', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, posX = -700, posY = -40, scrollX = 1, scrollY = 1, scaleX = 0.8, scaleY = 0.8, add = true, antialiasing = false },
		{ name = 'springbonnie', image = 'Chars/springbonnie', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, posX = -200, posY = 210, scrollX = 1, scrollY = 1, scaleX = 1.9, scaleY = 1.9, add = true, antialiasing = false },
		{ name = 'oobfredbear2', image = 'BGs/oobfredbear2', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, posX = 0, posY = 0, scrollX = 0, scrollY = 0, scaleX = 1, scaleY = 1, add = false, antialiasing = true },
	}

	for _, stage in ipairs(stagesAnimated) do
		precacheImage(stage.image)

		if stage.name == 'oobfredbear2' then
			if lowQuality then
				makeLuaSprite(stage.name, 'BGs/oobfredbear2LQ', stage.posX, stage.posY)
			elseif epilepsy then
				makeLuaSprite(stage.name, 'BGs/oobfredbear2epilepsy', stage.posX, stage.posY)
			else
				makeAnimatedLuaSprite(stage.name, 'BGs/oobfredbear2', stage.posX, stage.posY)
				addAnimationByPrefix(stage.name, 'anim', 'idle', 24, true)
			end
		else
			makeAnimatedLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
			addAnimationByPrefix(stage.name, 'anim', 'idle', 24, true)
		end

		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.antialiasing', stage.antialiasing)
		setProperty(stage.name .. '.visible', false)
	end
end

function createMiscSprites()
	local miscSprites = {
		{ name = 'outofbounds', image = 'outofbounds', camera = 'camOther', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'arcadeffect', image = 'arcadeffect', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'static', image = 'static', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'whiteui', image = 'whiteui', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'whiteHUD', image = 'white', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'white', image = 'white', camera = 'camGame', posX = -3200, posY = -1800, scrollX = 0, scrollY = 0, scaleX = 5, scaleY = 5, alpha = 1 },
		{ name = 'black', image = 'black', camera = 'camGame', posX = -3000, posY = -1800, scrollX = 0, scrollY = 0, scaleX = 5, scaleY = 5, alpha = 1 },
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

	setProperty('arcadeffect.antialiasing', false)
	setProperty('outofbounds.antialiasing', false)

	setObjectOrder('white', 50)
	setObjectOrder('black', 51)
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
	if curStep == 512 then
		-- Remove previous stage sprites.
		removeLuaSprite('oob', true)
		removeLuaSprite('oobbb', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of stage sprites.
		setProperty('oobbb2.visible', true)

		-- Modify object order.
		setObjectOrder('oobbb2', 0)

	elseif curStep == 1216 then
		-- Remove previous stage sprites.
		removeLuaSprite('oobbb2', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of stage sprites.
		setProperty('oobmangle.visible', true)

		-- Modify object order.
		setObjectOrder('oobmangle', 0)

	elseif curStep == 1696 then
		-- Remove previous stage sprites.
		removeLuaSprite('oobmangle', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of stage sprites.
		setProperty('oobmangle2.visible', true)

		-- Modify object order.
		setObjectOrder('oobmangle2', 0)

	elseif curStep == 2224 then
		-- Remove previous stage sprites.
		removeLuaSprite('oobmangle2', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of stage sprites.
		setProperty('oobchica.visible', true)

		-- Modify object order.
		setObjectOrder('oobchica', 0)

	elseif curStep == 2752 then
		-- Remove previous stage sprites.
		removeLuaSprite('oobchica', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of stage sprites.
		setProperty('oobchica2.visible', true)

		-- Modify object order.
		setObjectOrder('oobchica2', 0)

	elseif curStep == 3424 then
		-- Remove previous stage sprites.
		removeLuaSprite('oobchica2', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of stage sprites.
		setProperty('oobfredbear.visible', true)
		setProperty('springbonnie.visible', true)

		-- Modify object order.
		setObjectOrder('oobfredbear', 0)

		-- Force play animations so they start from the beginning.
		playAnim('oobfredbear', 'anim', true)
		playAnim('springbonnie', 'anim', true)

	elseif curStep == 4320 then
		-- Remove previous stage sprites.
		removeLuaSprite('oobfredbear', true)
		removeLuaSprite('springbonnie', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of stage sprites.
		setProperty('oobfredbear2.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('oobfredbear2', 'anim', true)

	elseif curStep == 5760 then
		-- Remove previous stage sprites.
		removeLuaSprite('oobfredbear2', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of stage sprites.
		setProperty('oobpuppet.visible', true)
		setProperty('oobpuppet2.visible', true)
		setProperty('oobpuppetchild.visible', true)

		-- Modify object order.
		setObjectOrder('oobpuppet', 0)
		setObjectOrder('oobpuppet2', 1)
		setObjectOrder('oobpuppetchild', 1)

	elseif curStep == 5968 then
		-- Toggle visibility of stage sprites.
		setProperty('oobpuppet5.visible', true)

		-- Modify object order.
		setObjectOrder('oobpuppet5', 2)

	elseif curStep == 6096 then
		-- Toggle visibility of stage sprites.
		setProperty('oobpuppet6.visible', true)

		-- Modify object order.
		setObjectOrder('oobpuppet6', 2)

	elseif curStep == 6224 then
		-- Toggle visibility of stage sprites.
		setProperty('oobpuppet7.visible', true)

		-- Modify object order.
		setObjectOrder('oobpuppet7', 2)

	elseif curStep == 6352 then
		-- Toggle visibility of stage sprites.
		setProperty('oobpuppet8.visible', true)

		-- Modify object order.
		setObjectOrder('oobpuppet8', 2)

	elseif curStep == 6480 then
		-- Toggle visibility of stage sprites.
		setProperty('oobpuppet3.visible', true)
		setProperty('oobpuppet4.visible', true)

		-- Modify object order.
		setObjectOrder('oobpuppet3', 2)
		setObjectOrder('oobpuppet4', 2)

	elseif curStep == 6608 then
		-- Remove previous stage sprites.
		removeLuaSprite('oobpuppet4', true)
		removeLuaSprite('oobpuppetchild', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of stage sprites.
		setProperty('oobpuppetchild2.visible', true)

		-- Modify object order.
		setObjectOrder('oobpuppetchild2', 2)
	end
end