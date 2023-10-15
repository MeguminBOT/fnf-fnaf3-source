function onCreate()
	-- Precache images
    local images = {
        'BGs/takenstage',
        'BGs/takenstage2',
        'BGs/takenstage3',
        'BGs/takenstage4',
        'BGs/fnaf1wall',
        'BGs/blueglow',
        'white'
    }

    for _, image in ipairs(images) do
        precacheImage(image)
    end

	-- Base stages
	local stages = {
		{ name = 'takenstage', image = 'BGs/takenstage', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, add = false },
		{ name = 'takenstage2', image = 'BGs/takenstage2', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, add = false },
		{ name = 'takenstage3', image = 'BGs/takenstage3', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, add = false },
		{ name = 'takenstage4', image = 'BGs/takenstage4', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 0.85, scaleY = 0.85, add = false },
		{ name = 'blueglow', image = 'BGs/blueglow', posX = -2000, posY = -900, scrollX = 1.5, scrollY = 1.5, scaleX = 1.7, scaleY = 1, add = true },
	}

	for _, stage in ipairs(stages) do
		makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('takenstage.visible', true)
	setProperty('blueglow.visible', true)

	-- Next phase animation
	makeAnimatedLuaSprite('fnaf1wall', 'BGs/fnaf1wall', -1200, -700)
	scaleObject('fnaf1wall', 2.6, 2.6)
	addAnimationByPrefix('fnaf1wall', 'anim', 'fnaf1wall idle', 12, true)
	addLuaSprite('fnaf1wall', false)
	setProperty('fnaf1wall.visible', false)

	-- Text
	makeLuaText('Text', "", 1000, 140, 550)
	setTextSize('Text', 25)
	setObjectCamera('Text', 'camHUD')
	addLuaText("Text")

	-- White
	makeLuaSprite('white', 'white', 0, 0)
	setObjectCamera('white', 'camHUD')
	addLuaSprite('white', true)
	doTweenAlpha('white', 'white', 0, 0.01, true)

	-- Load Video
	video.Load("takenapart.mp4")
end

function onStepHit()
	if curStep == 386 then
		setTextString('Text', "Follow me...")

	elseif curStep == 400 then
		setTextString('Text', "")

	elseif curStep == 816 then
		setProperty('takenstage.visible', false)
		setProperty('blueglow.visible', false)
		setProperty('fnaf1wall.visible', true)
		playAnim('fnaf1wall', 'anim', true)

	elseif curStep == 944 then
		setProperty('fnaf1wall.visible', false)
		setProperty('blueglow.visible', true)
		setProperty('takenstage2.visible', true)

	elseif curStep == 1311 then
		setTextString('Text', "Follow me...")

	elseif curStep == 1324 then
		setTextString('Text', "")

	elseif curStep == 1632 then
		setProperty('takenstage2.visible', false)
		setProperty('blueglow.visible', false)
		setProperty('fnaf1wall.visible', true)
		playAnim('fnaf1wall', 'anim', true)

	elseif curStep == 1696 then
		setProperty('fnaf1wall.visible', false)
		setProperty('blueglow.visible', true)
		setProperty('takenstage3.visible', true)

	elseif curStep == 2160 then
		setTextString('Text', "Follow me...")

	elseif curStep == 2176 then
		setTextString('Text', "")

	elseif curStep == 2465 then
		setProperty('takenstage3.visible', false)
		setProperty('blueglow.visible', false)
		setProperty('fnaf1wall.visible', true)
		playAnim('fnaf1wall', 'anim', true)

	elseif curStep == 2606 then
		setObjectCamera('Text', 'camOther')
		setTextString('Text', "I'VE GOT YA NOW!")

	elseif curStep == 2630 then
		setObjectCamera('Text', 'camHUD')
		setTextString('Text', "")

	elseif curStep == 2646 then
		setProperty('fnaf1wall.visible', false)
		setProperty('blueglow.visible', true)
		setProperty('takenstage4.visible', true)

	elseif curStep == 3031 then
		setTextString('Text', "Follow me...")

	elseif curStep == 3046 then
		setTextString('Text', "")
	end
end
