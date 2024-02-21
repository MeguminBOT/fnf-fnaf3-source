-- Using Lulu's optimizations to avoid game lagging.

-- TODO: Add in sprites that events add to the stage. (If there are any)

function onCreate()
	-- Custom functions for stage.
	createStage() -- Create stages.
	createWaffles() -- Create waffles.
	createMiscSprites() -- Create misc sprites.
end

function onCreatePost()
	createSubtitles() -- Create subtitles. (Had to put them on createPost for some reason)
	setProperty('boyfriend.visible', false)
end

function createStage()
	local stages = {
		{ name = 'wafflestage1', image = 'BGs/wafflestage1', posX = 0, posY = 300, scrollX = 1, scrollY = 1, scaleX = 0.4, scaleY = 0.4, add = false },
		{ name = 'wafflestage2', image = 'BGs/wafflestage2', posX = -300, posY = 0, scrollX = 1, scrollY = 1, scaleX = 0.6, scaleY = 0.6, add = false },
		{ name = 'wafflestage3', image = 'BGs/wafflestage3', posX = -200, posY = 200, scrollX = 1, scrollY = 1, scaleX = 0.5, scaleY = 0.5, add = false },
		{ name = 'wafflestage4', image = 'BGs/wafflestage4', posX = -200, posY = 400, scrollX = 1, scrollY = 1, scaleX = 0.4, scaleY = 0.4, add = false },
	}

	for _, stage in ipairs(stages) do
		precacheImage(stage.image)
		makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('wafflestage2.visible', true)
	setProperty('waffle2.visible', true)
end

function createWaffles()
	local waffles = {
		{ name = 'waffle1', image = 'Props/waffle1', posX = 750, posY = 790, scrollX = 1, scrollY = 1, scaleX = 0.11, scaleY = 0.11, add = true},
		{ name = 'waffle2', image = 'Props/waffle2', posX = 500, posY = 600, scrollX = 1, scrollY = 1, scaleX = 0.5, scaleY = 0.5, add = true},
		{ name = 'waffle3', image = 'Props/waffle3', posX = 850, posY = 720, scrollX = 1, scrollY = 1, scaleX = 0.08, scaleY = 0.08, add = true},
		{ name = 'waffle4', image = 'Props/waffle4', posX = 440, posY = 685, scrollX = 1, scrollY = 1, scaleX = 0.35, scaleY = 0.35, add = false},
		{ name = 'waffle5', image = 'Props/waffle5', posX = 0, posY = 820, scrollX = 1, scrollY = 1, scaleX = 0.35, scaleY = 0.35, add = true}
	}

	for _, waffle in ipairs(waffles) do
		precacheImage(waffle.image)
		makeLuaSprite(waffle.name, waffle.image, waffle.posX, waffle.posY)
		setScrollFactor(waffle.name, waffle.scrollX, waffle.scrollY)
		scaleObject(waffle.name, waffle.scaleX, waffle.scaleY)
		addLuaSprite(waffle.name, waffle.add)
		setProperty(waffle.name .. '.visible', false)
	end
end

function createMiscSprites()
	local miscSprites = {
		{ name = 'white', image = 'white', camera = 'camGame', posX = -3200, posY = -1800, scrollX = 0, scrollY = 0, scaleX = 5, scaleY = 5, alpha = 0 },
		{ name = 'black', image = 'black', camera = 'camGame', posX = -3000, posY = -1800, scrollX = 0, scrollY = 0, scaleX = 5, scaleY = 5, alpha = 1 },
		{ name = 'waffleglow', image = 'waffleglow', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
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
	if curStep == 72 then
		-- Hide stage sprites that will be re-used.
		setProperty('wafflestage2.visible', false)
		setProperty('waffle2.visible', false)

		-- Toggle visibility of the next stage sprites.
		setProperty('wafflestage1.visible', true)
		setProperty('waffle1.visible', true)

		-- Toggle character visibility.
		setProperty('dad.visible', false)
		setProperty('gf.visible', false)
		setProperty('boyfriend.visible', true)

	elseif curStep == 84 then
		-- Hide stage sprites that will be re-used.
		setProperty('wafflestage1.visible', false)
		setProperty('waffle1.visible', false)

		-- Toggle visibility of the next stage sprites.
		setProperty('wafflestage2.visible', true)
		setProperty('waffle2.visible', true)

		-- Toggle character visibility.
		setProperty('dad.visible', true)
		setProperty('gf.visible', true)
		setProperty('boyfriend.visible', false)

	elseif curStep == 94 then
		-- Hide stage sprites that will be re-used.
		setProperty('wafflestage2.visible', false)
		setProperty('waffle2.visible', false)

		-- Toggle visibility of the next stage sprites.
		setProperty('wafflestage1.visible', true)
		setProperty('waffle1.visible', true)

		-- Toggle character visibility.
		setProperty('dad.visible', false)
		setProperty('gf.visible', false)
		setProperty('boyfriend.visible', true)

	elseif curStep == 126 then
		-- Hide stage sprites that will be re-used.
		setProperty('wafflestage1.visible', false)
		setProperty('waffle1.visible', false)

		-- Toggle visibility of the next stage sprites.
		setProperty('wafflestage2.visible', true)
		setProperty('waffle2.visible', true)

		-- Toggle character visibility.
		setProperty('dad.visible', true)
		setProperty('gf.visible', true)
		setProperty('boyfriend.visible', false)

	elseif curStep == 160 then
		-- Hide stage sprites that will be re-used.
		setProperty('wafflestage2.visible', false)
		setProperty('waffle2.visible', false)

		-- Toggle visibility of the next stage sprites.
		setProperty('wafflestage1.visible', true)
		setProperty('waffle1.visible', true)

		-- Toggle character visibility.
		setProperty('dad.visible', false)
		setProperty('gf.visible', false)
		setProperty('boyfriend.visible', true)

	elseif curStep == 178 then
		-- Hide stage sprites that will be re-used.
		setProperty('wafflestage1.visible', false)
		setProperty('waffle1.visible', false)

		-- Toggle visibility of the next stage sprites.
		setProperty('wafflestage2.visible', true)
		setProperty('waffle2.visible', true)

		-- Toggle character visibility.
		setProperty('dad.visible', true)
		setProperty('gf.visible', true)
		setProperty('boyfriend.visible', false)

	elseif curStep == 254 then
		-- Hide stage sprites that will be re-used.
		setProperty('wafflestage2.visible', false)
		setProperty('waffle2.visible', false)

		-- Toggle visibility of the next stage sprites.
		setProperty('wafflestage1.visible', true)
		setProperty('waffle1.visible', true)

		-- Toggle character visibility.
		setProperty('dad.visible', false)
		setProperty('gf.visible', false)
		setProperty('boyfriend.visible', true)

	elseif curStep == 321 then
		-- Remove previous stage sprites.
		removeLuaSprite('wafflestage1', true)
		removeLuaSprite('wafflestage2', true)
		removeLuaSprite('waffle1', true)
		removeLuaSprite('waffle2', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of the next stage sprites.
		setProperty('wafflestage3.visible', true)
		setProperty('waffle3.visible', true)
		setProperty('waffle4.visible', true)

		-- Toggle character visibility.
		setProperty('dad.visible', true)
		setProperty('gf.visible', true)
		setProperty('boyfriend.visible', true)

		-- Modify object order.
		setObjectOrder('waffle4', getObjectOrder('dadGroup') + -1)

	elseif curStep == 705 then
		-- Hide stage sprites that will be re-used.
		setProperty('wafflestage3.visible', false)
		setProperty('waffle3.visible', false)
		setProperty('waffle4.visible', false)

		-- Toggle visibility of the next stage sprites.
		setProperty('wafflestage4.visible', true)

		-- Toggle character visibility.
		setProperty('dad.visible', false)
		setProperty('gf.visible', false)
		setProperty('boyfriend.visible', true)

	elseif curStep == 833 then
		-- Remove previous stage sprites.
		removeLuaSprite('wafflestage4', true)
		removeLuaSprite('waffle5', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of the next stage sprites.
		setProperty('wafflestage3.visible', true)
		setProperty('waffle3.visible', true)
		setProperty('waffle4.visible', true)

		-- Toggle character visibility.
		setProperty('dad.visible', true)
		setProperty('gf.visible', true)
		setProperty('boyfriend.visible', true)

		-- Modify object order.
		setObjectOrder('waffle4', getObjectOrder('dadGroup') + -1)
	end
end
