function onCreate()
	createStage() -- Create stages.
	createStageAnimated() -- Create animated stages.
end

function onCreatePost()
	setProperty('paperbonnie.visible', false)
	setProperty('paperbb.visible', false)
end

function createStage()
	local stages = {
		{ name = 'ppstage', image = 'BGs/ppstage', posX = -2000, posY = -550, scrollX = 1, scrollY = 1, scaleX = 1.07, scaleY = 1.07, add = false },
		{ name = 'ppstage2', image = 'BGs/ppstage2', posX = -750, posY = 550, scrollX = 1, scrollY = 1, scaleX = 0.9, scaleY = 0.9, add = true },
		{ name = 'ppstage3', image = 'BGs/ppstage3', posX = -750, posY = 550, scrollX = 1, scrollY = 1, scaleX = 0.9, scaleY = 0.9, add = true },
	}
	
	for _, stage in ipairs(stages) do
		precacheImage(stage.image)
		makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end

	setProperty('ppstage.visible', true)
	setProperty('ppstage2.visible', true)
end


function createStageAnimated()
	local stagesAnimated = {
		{ name = 'bonnieanim', image = 'characters/paperbonnie', animation = 'anim', xmlPrefix = 'enter', fps = 24, loop = true, camera = 'camGame', posX = -515, posY = 240, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = false },
		{ name = 'bbanim', image = 'characters/paperbb', animation = 'anim', xmlPrefix = 'enter', fps = 24, loop = true, camera = 'camGame', posX = -700, posY = 200, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = false },
		{ name = 'paper', image = 'paper', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, camera = 'camHUD', posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = true },
		{ name = 'paperpeople', image = 'paperpeople', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, camera = 'camHUD', posX = -200, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = true },
		{ name = 'paperpeople2', image = 'paperpeople2', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, camera = 'camHUD', posX = -200, posY = 600, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = true },
	}

	for _, stage in ipairs(stagesAnimated) do
		precacheImage(stage.image)
		makeAnimatedLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		addAnimationByPrefix(stage.name, stage.animation, stage.xmlPrefix, stage.fps, stage.loop)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)

		if (stage.camera ~= 'camGame' and immersionLevel == 'Partial') then
			setObjectCamera(stage.name, 'camEasy')
		else
			setObjectCamera(stage.name, stage.camera)
		end

		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end
end

function onStepHit()
	if curStep == 699 then
		setProperty('bonnieanim.visible', true)
		playAnim('bonnieanim', 'anim', true)

	elseif curStep == 720 then
		removeLuaSprite('bonnieanim', true)
		setProperty('paperbonnie.visible', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])
	
	elseif curStep == 1392 then
		removeLuaSprite('ppstage2', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])

		setProperty('ppstage3.visible', true)
		setProperty('bbanim.visible', true)
		playAnim('bbanim', 'anim', true)

	elseif curStep == 1424 then
		removeLuaSprite('bbanim', true)
		setProperty('paperbb.visible', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
            Paths.clearUnusedMemory();
        ]])

	elseif curStep == 1936 then
		setProperty('paperpeople.visible', true)
		playAnim('paperpeople', 'anim', true)
		
		setProperty('paperpeople2.visible', true)
		playAnim('paperpeople2', 'anim', true)
	end
end
