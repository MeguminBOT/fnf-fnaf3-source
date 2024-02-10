-- Using Lulu's optimizations to avoid game lagging.

function onCreate()
	createStage() -- Create stages.
	createSpringtrap() -- Create Springtrap.
	createMiscSprites() -- Create misc sprites.
	createJumpscares() -- Create jumpscare like sprites.
	setObjectOrder('boyfriendGroup', 7)
end

function createStage()
	local stages = {
		{ name = 'minigameafton', image = 'BGs/minigameafton', posX = -1600, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = false },
		{ name = 'retribution', image = 'BGs/retribution', posX = -2400, posY = -530, scrollX = 1, scrollY = 1, scaleX = 1.1, scaleY = 1.1, add = false },
		{ name = 'retribution2', image = 'BGs/retribution2', posX = -2400, posY = -530, scrollX = 1, scrollY = 1, scaleX = 1.1, scaleY = 1.1, add = false },
		{ name = 'retribution3', image = 'BGs/retribution3', posX = -1300, posY = 0, scrollX = 0.9, scrollY = 0.9, scaleX = 0.6, scaleY = 0.6, add = false },
		{ name = 'children', image = 'Chars/cryingchildren', posX = -1600, posY = 500, scrollX = 1, scrollY = 1, scaleX = 2, scaleY = 2, add = false },
	}

	for _, stage in ipairs(stages) do
		precacheImage(stage.image)
		if stage.name == 'retribution2' then
			makeAnimatedLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
			addAnimationByPrefix('retribution2', 'idle', 'idle', 24, true)
			addAnimationByPrefix('retribution2', 'bop', 'bop', 24, false)
		elseif stage.name == 'children' then
			makeAnimatedLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
			addAnimationByPrefix('children', 'anim', 'idle', 24, true)
		else
			makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		end
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('minigameafton.visible', true)
end

function createSpringtrap()
	makeAnimatedLuaSprite('aftonwear', 'Chars/aftonwear', 0, 0)
	addAnimationByPrefix('aftonwear', 'anim', 'idle', 24, false)
	setScrollFactor('aftonwear', 0, 0)
	scaleObject('aftonwear', 1, 1)
	addLuaSprite('aftonwear', true)
	setProperty('aftonwear.visible', false)
	setObjectOrder('aftonwear', 8)
end

function createMiscSprites()
	local miscSprites = {
		{ name = 'arcadeffect', image = 'arcadeffect', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 1 },
		{ name = 'blackui', image = 'blackui', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0.5 },
		{ name = 'black2', image = 'black', camera = 'camGame', posX = -500, posY = -500, scrollX = 0, scrollY = 0, scaleX = 10, scaleY = 10, alpha = 0 },
		{ name = 'white2', image = 'white', camera = 'camGame', posX = -500, posY = -500, scrollX = 0, scrollY = 0, scaleX = 10, scaleY = 10, alpha = 0 },
		{ name = 'black', image = 'black', camera = 'camOther', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 1 },
		{ name = 'white', image = 'white', camera = 'camOther', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		{ name = 'whiteui', image = 'whiteui', camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, alpha = 0 },
		
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

function createJumpscares()
	local jumpscares = {
		{ name = 'gfed', image = 'gfed', posX = 0, posY = 0, add = true },
		{ name = 'itsme', image = 'itsme', posX = 0, posY = 0, add = true },
		{ name = 'fred', image = 'fred', posX = 0, posY = 0, add = true },
		{ name = 'bon', image = 'bon', posX = 0, posY = 0, add = true },
		{ name = 'chic', image = 'chic', posX = 0, posY = 0, add = true },
		{ name = 'fox', image = 'fox', posX = 0, posY = 0, add = true },
		{ name = 'gfed2', image = 'gfed2', posX = 0, posY = 0, add = true },
		{ name = 'spring', image = 'spring', posX = 0, posY = 0, add = true },
		{ name = 'cassid', image = 'cassid', posX = 0, posY = 0, add = true },
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

function onStepHit()
	if curStep == 400 then
		-- Remove previous stage sprites.
		removeLuaSprite('minigameafton', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of the next stage sprites.
		setProperty('retribution.visible', true)
		setProperty('blackui.alpha', 0)

		-- Miscellaneous.
		setScrollFactor('boyfriendGroup', 1, 1.5)

	elseif curStep == 1696 then
		-- Toggle visibility of previous stage sprites.
		setProperty('retribution.visible', false)

		-- Toggle visibility of the next stage sprites.
		setProperty('retribution3.visible', true)
		setProperty('blackui.alpha', 0.5)

		-- Miscellaneous.
		setScrollFactor('boyfriendGroup', 1, 1)

	elseif curStep == 1952 then
		setObjectOrder('boyfriendGroup', 7)

		-- Remove previous stage sprites.
		removeLuaSprite('retribution3', true)
		removeLuaSprite('blackui', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])
		
		-- Toggle visibility of the next stage sprites.
		setProperty('retribution.visible', true)
		setProperty('children.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('children', 'anim', true)

		-- Miscellaneous.
		setScrollFactor('boyfriendGroup', 1, 1.5)
		setObjectOrder('dadGroup', 2)
		setObjectOrder('children', 4)

	elseif curStep == 2208 then
		-- Remove previous stage sprites.
		removeLuaSprite('retribution', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Modify object order.
		setObjectOrder('boyfriendGroup', 0)

		-- Toggle visibility of the next stage sprites.
		setProperty('retribution2.visible', true)

		-- Anim of Afton putting on Springtrap suit.
		setProperty('aftonwear.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('aftonwear', 'anim', true)
		playAnim('retribution2', 'idle', true)

		-- Object Order fixes.
		setObjectOrder('children', 4)

	elseif curStep == 2240 then
		-- Remove anim of Afton putting on Springtrap suit.
		removeLuaSprite('aftonwear', true)
		setObjectOrder('boyfriendGroup', 7)
	end
end

function onBeatHit()
	if curBeat >= 552 and curBeat % 3 == 0 then
		playAnim('retribution2', 'bop', true)
	end
end