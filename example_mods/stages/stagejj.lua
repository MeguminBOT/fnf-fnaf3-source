-- Using Lulu's optimizations to avoid game lagging.

-- TODO: Add in sprites that events add to the stage. (If there are any)

function onCreate()
	-- Custom functions for stage.
	createStage() -- Create stages.
	createMiscSprites() -- Create misc sprites.
end

function createStage()
	local stages = {
		{ name = 'jjstage1', image = 'BGs/jjstage1', posX = -2050, posY = -170, scrollX = 1, scrollY = 1, scaleX = 0.75, scaleY = 0.75, add = false },
		{ name = 'jjtable', image = 'BGs/jjtable', posX = -2050, posY = -170, scrollX = 1, scrollY = 1, scaleX = 0.75, scaleY = 0.75, add = true },
		{ name = 'jjstage2', image = 'BGs/jjstage2', posX = -1700, posY = -400, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = false },
	}
	
	for _, stage in ipairs(stages) do
		precacheImage(stage.image)
		makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('jjstage1.visible', true)
	setProperty('jjtable.visible', true)
end

function createMiscSprites()
	makeLuaSprite('black', 'black', 0, 0)
	setObjectCamera('black', 'camHUD')
	addLuaSprite('black', true)
	doTweenAlpha('black', 'black', 0, 0.01, true)
end

function onStepHit()
	if curStep == 256 then
		-- Remove previous stage sprites.
		removeLuaSprite('jjstage1', true)
		removeLuaSprite('jjtable', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of the next stage sprites.
		setProperty('jjstage2.visible', true)

		-- Modify object order.
		setObjectOrder('jjstage2', 0)

	elseif curStep == 300 then
		-- Modify object order.
		setObjectOrder('gfGroup', getObjectOrder('dadGroup') + 1)
	end
end