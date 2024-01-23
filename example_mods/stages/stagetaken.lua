function onCreate()
	createStage() -- Create stages.
	createJumpscares() -- Create jumpscares.
	createMiscSprites() -- Create misc sprites.

	-- Subtitles
	makeLuaText('Text', "", 1000, 140, 550)
	setTextSize('Text', 25)
	setObjectCamera('Text', 'camOther')
	addLuaText("Text")

	-- Load Video
	video.Load("takenapart.mp4")
end

function createStage()
	local stages = {
		{ name = 'takenstage', image = 'BGs/takenstage', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, add = false },
		{ name = 'takenstage2', image = 'BGs/takenstage2', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, add = false },
		{ name = 'takenstage3', image = 'BGs/takenstage3', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, add = false },
		{ name = 'takenstage4', image = 'BGs/takenstage4', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, add = false },
		{ name = 'blueglow', image = 'BGs/blueglow', posX = -2000, posY = -900, scrollX = 1.5, scrollY = 1.5, scaleX = 1.7, scaleY = 1, add = true },
		{ name = 'fnaf1wall', image = 'BGs/fnaf1wall', posX = -1200, posY = -700, scrollX = 1, scrollY = 1, scaleX = 2.6, scaleY = 2.6, add = false },
	}

	for _, stage in ipairs(stages) do
		precacheImage(stage.image)
		if stage.name == 'fnaf1wall' then
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

	setProperty('takenstage.visible', true)
	setProperty('blueglow.visible', true)
end

function createJumpscares()
	makeAnimatedLuaSprite('foxyjump', 'Jumpscares/foxyjump', 0, 0)
	addAnimationByPrefix('foxyjump', 'foxyjump', 'idle', 24, true)
	setObjectCamera('foxyjump', 'camJump')
	addLuaSprite('foxyjump', true)
	setProperty('foxyjump.visible', false)
end

function onStepHit()

	if curStep == 816 then
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
