-- Using Lulu's optimizations to avoid game lagging.

-- TODO: Add in sprites that events add to the stage. (If there are any)

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
		{ name = 'desk', image = 'BGs/5amdesk', posX = -370, posY = -38, scrollX = 1, scrollY = 1, scaleX = 0.8, scaleY = 0.8, add = true },
		{ name = 'wall', image = 'BGs/5amwall', posX = -605, posY = -70, scrollX = 0.7, scrollY = 0.7, scaleX = 1.2, scaleY = 1.2, add = true },
		{ name = 'office', image = 'BGs/5amoffice', posX = -732, posY = 171, scrollX = 1, scrollY = 1, scaleX = 0.6, scaleY = 0.6, add = true },
	}
	
	for _, stage in ipairs(stages) do
		precacheImage(stage.image)
		makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('desk.visible', true)
	setProperty('wall.visible', true)

	setObjectOrder('desk', 2)
	setObjectOrder('wall', 0)
end

function createMiscSprites()
	local miscSprites = {
		{ name = 'whiteui', image = 'whiteui', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'white', image = 'white', camera = 'camGame', posX = -3200, posY = -1800, scrollX = 0, scrollY = 0, scaleX = 5, scaleY = 5, alpha = 1 },
		{ name = 'black', image = 'black', camera = 'camGame', posX = -3000, posY = -1800, scrollX = 0, scrollY = 0, scaleX = 5, scaleY = 5, alpha = 1 },
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
	
-- Table storing tweens
local tweenData = {
	[608] = {'findthatchild', 'dad', 2000, 5, 'cubeIn'},
	[688] = {'findthatchild', 'dad', -136, 0.1, 'cubeOut'},
	[700] = {'freddyhello', 'gf', 170, 10, 'cubeOut'},
	[1484] = {'freddyno', 'gf', 1000, 2, 'cubeIn'},
	[1500] = {'fucker', 'dad', -1500, 2, 'cubeIn'}
}

function onStepHit()
	-- Tween Stuff
	local tweenData = tweenData[curStep]
	if tweenData then
		if tweenData[1] == 'freddyhello' then
			doTweenY(tweenData[1], tweenData[2], tweenData[3], tweenData[4], tweenData[5])
		else
			doTweenX(tweenData[1], tweenData[2], tweenData[3], tweenData[4], tweenData[5])
		end
	end

	if curStep == 1546 then
		-- Remove previous stage sprites.
		removeLuaSprite('wall', true)
		removeLuaSprite('desk', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Modify object order.
		setObjectOrder('office', 0)

		-- Toggle visibility of the next stage sprites.
		setProperty('office.visible', true)
	end
end