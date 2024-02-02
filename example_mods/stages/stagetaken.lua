-- Using some of Lulu's optimizations to avoid game lagging.
-- Not optimized: Flashing effects, see "script_unoptimizedStuff.lua" inside "data/taken-apart"

function onCreate()
	createStage() -- Create stages.
	createJumpscares() -- Create jumpscares.
	createMiscSprites() -- Create misc sprites.

	-- Load Video
	video.Load("takenapart.webm")
end

function onCreatePost()
	createSubtitles() -- Create subtitles. (Had to put them on createPost for some reason)
end

function createStage()
	local stages = {
		{ name = 'minigamestart', image = 'BGs/minigamestart', posX = -1450, posY = -400, scrollX = 1, scrollY = 1, scaleX = 1.8, scaleY = 1.8, add = true },
		{ name = 'takenstage', image = 'BGs/takenstage', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, add = false },
		{ name = 'takenstage2', image = 'BGs/takenstage2', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, add = false },
		{ name = 'takenstage3', image = 'BGs/takenstage3', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, add = false },
		{ name = 'takenstage4', image = 'BGs/takenstage4', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, add = false },
		{ name = 'blueglow', image = 'BGs/blueglow', posX = -2000, posY = -900, scrollX = 1.5, scrollY = 1.5, scaleX = 1.7, scaleY = 1, add = true },
		{ name = 'fnaf1wall', image = 'BGs/fnaf1wall', posX = -1200, posY = -700, scrollX = 1, scrollY = 1, scaleX = 2.6, scaleY = 2.6, add = false },
	}

	for _, stage in ipairs(stages) do
		precacheImage(stage.image)

		if stage.name == 'minigamestart' then
			makeAnimatedLuaSprite(stage.name, stage.image, -1450, -400)
			addAnimationByPrefix(stage.name, 'anim', 'idle0', 24, true)
			playAnim(stage.name, 'anim', true)
		elseif stage.name == 'fnaf1wall' then
			makeAnimatedLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
			addAnimationByPrefix(stage.name, 'anim', 'fnaf1wall idle', 12, true)
		else
			makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		end

		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('minigamestart.visible', true)
	setProperty('takenstage.visible', true)
	setProperty('blueglow.visible', true)
end

function createJumpscares()
	makeAnimatedLuaSprite('foxyjump', 'Jumpscares/foxyjump', 0, 0)
	addAnimationByPrefix('foxyjump', 'foxyjump', 'idle', 24, true)

	if immersionLevel == 'Partial' then
		setObjectCamera('foxyjump', 'camEasy')
	else
		setObjectCamera('foxyjump', 'camJump')
	end

	addLuaSprite('foxyjump', true)
	setProperty('foxyjump.visible', false)
end

function createMiscSprites()
    local miscSprites = {
		{ name = 'static', image = 'static', camera = 'camHUD', posX = 0, posY = 0, scrollX = 0, scrollY = 0, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'red', image = 'red', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'white', image = 'white', camera = 'camGame', posX = -3200, posY = -1800, scrollX = 0, scrollY = 0, scaleX = 5, scaleY = 5, alpha = 0 },
		{ name = 'black', image = 'black', camera = 'camGame', posX = -3200, posY = -1800, scrollX = 0, scrollY = 0, scaleX = 5, scaleY = 5, alpha = 1 },
    }

    for _, miscSprite in ipairs(miscSprites) do
        precacheImage(miscSprite.image)

		if miscSprite.name == 'static' then
			makeAnimatedLuaSprite(miscSprite.name, miscSprite.image, 0, 0);
			addAnimationByPrefix(miscSprite.name, 'anim', 'idle', 24, true)
		else
        	makeLuaSprite(miscSprite.name, miscSprite.image, miscSprite.posX, miscSprite.posY)
		end

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
	makeLuaSprite('TextBG', 'black', 0, 540)
	setObjectCamera('TextBG', 'camOther')
	scaleObject('TextBG', 1, 0.1)
	setProperty('TextBG.alpha', 0)
	addLuaSprite('TextBG', true)

	makeLuaText('Text', "", 1000, 135, 545)
	setTextSize('Text', 45)
	setTextFont('Text', 'stalker2.ttf')
	setObjectCamera('Text', 'camOther')
	addLuaText('Text')
end

function onStepHit()
	if curStep == 64 then
		setProperty('minigamestart.visible', false)

	elseif curStep == 816 then
		setProperty('takenstage.visible', false)
		setProperty('blueglow.visible', false)
		setProperty('fnaf1wall.visible', true)
		playAnim('fnaf1wall', 'anim', true)

	elseif curStep == 944 then
		setProperty('fnaf1wall.visible', false)
		setProperty('blueglow.visible', true)
		setProperty('takenstage2.visible', true)

	elseif curStep == 1632 then
		setProperty('takenstage2.visible', false)
		setProperty('blueglow.visible', false)
		setProperty('fnaf1wall.visible', true)
		playAnim('fnaf1wall', 'anim', true)

	elseif curStep == 1696 then
		setProperty('fnaf1wall.visible', false)
		setProperty('blueglow.visible', true)
		setProperty('takenstage3.visible', true)

	elseif curStep == 2465 then
		setProperty('takenstage3.visible', false)
		setProperty('blueglow.visible', false)
		setProperty('fnaf1wall.visible', true)
		playAnim('fnaf1wall', 'anim', true)

	elseif curStep == 2607 then
		setProperty('fnaf1wall.visible', false)
		setProperty('blueglow.visible', true)
		setProperty('takenstage4.visible', true)
	end
end
