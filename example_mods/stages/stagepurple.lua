-- Using Lulu's optimizations to avoid game lagging.

function onCreate()
	-- Custom functions for stage.
	createStage() -- Create stages.
	createMiscSprites() -- Create misc sprites.
	createJumpscares() -- Create jumpscares.
end

function createStage()
	local stages = {
		{ name = 'purplestage', image = 'BGs/purplestage', posX = -1500, posY = 0, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, flipX = false },
		{ name = 'stageback', image = 'stageback', posX = -600, posY = -300, scrollX = 0.9, scrollY = 0.9, scaleX = 1, scaleY = 1, flipX = false },
		{ name = 'stagefront', image = 'stagefront', posX = -650, posY = 600, scrollX = 0.9, scrollY = 0.9, scaleX = 1.1, scaleY = 1.1, flipX = false },
		{ name = 'stagelight_left', image = 'stage_light', posX = -125, posY = -100, scrollX = 0.9, scrollY = 0.9, scaleX = 1.1, scaleY = 1.1, flipX = false },
		{ name = 'stagelight_right', image = 'stage_light', posX = 1225, posY = -100, scrollX = 0.9, scrollY = 0.9, scaleX = 1.1, scaleY = 1.1, flipX = true },
		{ name = 'stagecurtains', image = 'stagecurtains', posX = -500, posY = -300, scrollX = 1.3, scrollY = 1.3, scaleX = 0.9, scaleY = 0.9, flipX = false }
	}

	for _, stage in ipairs(stages) do
		precacheImage(stage.image)
		makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		setProperty(stage.name .. '.flipX', stage.flipX)
		addLuaSprite(stage.name, false)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('purplestage.visible', true)
end

function createJumpscares()
	local jumpscares = {
		{ name = 'purpleguy', image = 'Chars/PURPLEGUY', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = true },
	}

	for _, jumpscare in ipairs(jumpscares) do
		precacheImage(jumpscare.image)
		makeAnimatedLuaSprite(jumpscare.name, jumpscare.image, jumpscare.posX, jumpscare.posY)
		setScrollFactor(jumpscare.name, jumpscare.scrollX, jumpscare.scrollY)
		addAnimationByPrefix(jumpscare.name, jumpscare.animation, jumpscare.xmlPrefix, jumpscare.fps, jumpscare.loop)
		scaleObject(jumpscare.name, jumpscare.scaleX, jumpscare.scaleY)
		addLuaSprite(jumpscare.name, jumpscare.add)
		setProperty(jumpscare.name .. '.visible', false)

		if immersionLevel == 'Partial' then
			setObjectCamera(jumpscare.name, 'camEasy')
		else
			setObjectCamera(jumpscare.name, 'camJump')
		end
	end
end

function createMiscSprites()
	local miscSprites = {
		{ name = 'black', image = 'black', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'white', image = 'white', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
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

function onStepHit()
	if curStep == 1824 then
		-- Hide stage sprites that will be reused.
		setProperty('purplestage.visible', false)

		-- Toggle visibility of the next stage sprites.
		setProperty('stageback.visible', true)
		setProperty('stagefront.visible', true)
		setProperty('stagelight_left.visible', true)
		setProperty('stagelight_right.visible', true)
		setProperty('stagecurtains.visible', true)

	elseif curStep == 2080 then
		-- Add: PURPLE GUY, PURPLE GUY, PURPLE GUY!!
		setProperty('purpleguy.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('purpleguy', 'anim', true)

	elseif curStep == 2088 then
		-- Remove previous stage sprites.
		removeLuaSprite('stageback', true)
		removeLuaSprite('stagefront', true)
		removeLuaSprite('stagelight_left', true)
		removeLuaSprite('stagelight_right', true)
		removeLuaSprite('stagecurtains', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Hide stage sprites that will be reused.
		setProperty('purplestage.visible', false)

	elseif curStep == 2096 then
		-- Remove: PURPLE GUY, PURPLE GUY, PURPLE GUY!!
		removeLuaSprite('purpleguy', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of the next stage sprites.
		setProperty('purplestage.visible', true)
	end
end