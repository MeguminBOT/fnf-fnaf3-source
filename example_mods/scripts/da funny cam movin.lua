--CAMERA SYSTEM MADE BY NOOBMAN, DO NOT REMOVE MY CREDITS!

--ALSO THIS AUTOMATICALLY GRABS THE CHARACTERS CAMERA POSITION

--SETTINGS--

local debugmode = false --Requires enabled to be set to true
local enabled = true
local dadstrength = 50
local bfstrength = 50
local camerarotation = false

--NOT SETTINGS--

local dadx = 0
local dady = 0

local bfx = 0
local bfy = 0

local debugcam = false
local songpos = 0
local musthit = false
local vers = 1.2

function onCreatePost()
	if mustHitSection then
		musthit = true
	else
		musthit = false
	end
	if debugmode == true and enabled == true then
		makeLuaText('thefuckindebugtext', 'V' ..vers  ..'\nNOOBMANS CAMERA SYSTEM DEBUG MODE IS ACTIVE!\nPRESS 6 TO SEE ALL THE CAMERA POSITIONS', 1300, 0, 0)
		setObjectCamera('thefuckindebugtext', 'other')
		setTextSize('thefuckindebugtext', 20);
		screenCenter('thefuckindebugtext', 'x')
		addLuaText('thefuckindebugtext')

		makeLuaSprite('dadi', '', dadx, dady);
		makeGraphic('dadi', 25, 25, 'FFFFFF')
		addLuaSprite('dadi', true);

		makeLuaSprite('dadl', '', dadx -dadstrength, dady);
		makeGraphic('dadl', 25, 25, 'C24B99')
		addLuaSprite('dadl', true);

		makeLuaSprite('dadd', '', dadx, dady +dadstrength);
		makeGraphic('dadd', 25, 25, '00FFFF')
		addLuaSprite('dadd', true);

		makeLuaSprite('dadu', '', dadx, dady -dadstrength);
		makeGraphic('dadu', 25, 25, '12FA05')
		addLuaSprite('dadu', true);

		makeLuaSprite('dadr', '', dadx +dadstrength, dady);
		makeGraphic('dadr', 25, 25, 'F9393F')
		addLuaSprite('dadr', true);


		makeLuaSprite('bfi', '', bfx, bfy);
		makeGraphic('bfi', 25, 25, 'FFFFFF')
		addLuaSprite('bfi', true);

		makeLuaSprite('bfl', '', bfx -bfstrength, bfy);
		makeGraphic('bfl', 25, 25, 'C24B99')
		addLuaSprite('bfl', true);

		makeLuaSprite('bfd', '', bfx, bfy +bfstrength);
		makeGraphic('bfd', 25, 25, '00FFFF')
		addLuaSprite('bfd', true);

		makeLuaSprite('bfu', '', bfx, bfy -bfstrength);
		makeGraphic('bfu', 25, 25, '12FA05')
		addLuaSprite('bfu', true);

		makeLuaSprite('bfr', '', bfx +bfstrength, bfy);
		makeGraphic('bfr', 25, 25, 'F9393F')
		addLuaSprite('bfr', true);
	end
end

function onUpdate()
	if enabled == true then
		if debugmode == true and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SIX') then
			if debugcam == false then
				setTextString('thefuckindebugtext', 'V' ..vers ..'\nNOOBMANS CAMERA SYSTEM DEBUG MODE IS ACTIVE!\nPRESS SPACE TO CHANGE THE SELECTED CHARACTER\nHOLD DOWN A KEY TO MAKE THE SELECTED CHARACTER SING\nUSE THIS TO SEE IF THERE ARE ANY CAMERA POSITIONS THAT MAY GO OUTSIDE THE STAGE!\nPRESS 6 TO GO BACK TO NORMAL GAMEPLAY')
				debugcam = true
				songpos = getPropertyFromClass('Conductor', 'songPosition')
				setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
				setProperty('vocals.volume', 0)
				setProperty('boyfriend.stunned', true)
				doTweenAlpha('camHUD', 'camHUD', 0, 0.5, 'linear');
			else
				setTextString('thefuckindebugtext', 'V' ..vers  ..'\nNOOBMANS CAMERA SYSTEM DEBUG MODE IS ACTIVE!\nPRESS 6 TO SEE ALL THE CAMERA POSITIONS')
				debugcam = false
				setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 1)
				setProperty('vocals.volume', 1)
				setProperty('boyfriend.stunned', false)
				doTweenAlpha('camHUD', 'camHUD', 1, 0.5, 'linear');
			end
		end

		if debugcam == true then
			setPropertyFromClass('Conductor', 'songPosition', songpos)
			setPropertyFromClass('flixel.FlxG', 'sound.music.time', songpos)
			setProperty('vocals.time', songpos)
			if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') then
				if musthit == true then
					musthit = false
				elseif musthit == false then
					musthit = true
				end
			end
			if musthit == false then
				if keyPressed('left') then
					characterPlayAnim('dad', 'singLEFT', true);
				end
				if keyPressed('down') then
					characterPlayAnim('dad', 'singDOWN', true);
				end
				if keyPressed('up') then
					characterPlayAnim('dad', 'singUP', true);
				end
				if keyPressed('right') then
					characterPlayAnim('dad', 'singRIGHT', true);
				end
			else
				if keyPressed('left') then
					characterPlayAnim('boyfriend', 'singLEFT', true);
				end
				if keyPressed('down') then
					characterPlayAnim('boyfriend', 'singDOWN', true);
				end
				if keyPressed('up') then
					characterPlayAnim('boyfriend', 'singUP', true);
				end
				if keyPressed('right') then
					characterPlayAnim('boyfriend', 'singRIGHT', true);
				end
			end
		end
		if musthit == false then
			setProperty('bfi.alpha', 0.3)
			setProperty('bfl.alpha', 0.3)
			setProperty('bfd.alpha', 0.3)
			setProperty('bfu.alpha', 0.3)
			setProperty('bfr.alpha', 0.3)
			if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
				triggerEvent('Camera Follow Pos',dadx -dadstrength,dady)

				setProperty('dadi.alpha', 0.5)
				setProperty('dadl.alpha', 1)
				setProperty('dadd.alpha', 0.5)
				setProperty('dadu.alpha', 0.5)
				setProperty('dadr.alpha', 0.5)
				if camerarotation == true then
					doTweenAngle('turn', 'camGame', -1, 1, 'circOut')
				end
			elseif getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
				triggerEvent('Camera Follow Pos',dadx,dady +dadstrength)

				setProperty('dadi.alpha', 0.5)
				setProperty('dadl.alpha', 0.5)
				setProperty('dadd.alpha', 1)
				setProperty('dadu.alpha', 0.5)
				setProperty('dadr.alpha', 0.5)
				if camerarotation == true then
					doTweenAngle('turn', 'camGame', 2, 1, 'circOut')
				end
			elseif getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
				triggerEvent('Camera Follow Pos',dadx,dady -dadstrength)

				setProperty('dadi.alpha', 0.5)
				setProperty('dadl.alpha', 0.5)
				setProperty('dadd.alpha', 0.5)
				setProperty('dadu.alpha', 1)
				setProperty('dadr.alpha', 0.5)
				if camerarotation == true then
					doTweenAngle('turn', 'camGame', -2, 1, 'circOut')
				end
			elseif getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
				triggerEvent('Camera Follow Pos',dadx +dadstrength,dady)

				setProperty('dadi.alpha', 0.5)
				setProperty('dadl.alpha', 0.5)
				setProperty('dadd.alpha', 0.5)
				setProperty('dadu.alpha', 0.5)
				setProperty('dadr.alpha', 1)
				if camerarotation == true then
					doTweenAngle('turn', 'camGame', 1, 1, 'circOut')
				end
			else
				triggerEvent('Camera Follow Pos',dadx,dady)

				setProperty('dadi.alpha', 1)
				setProperty('dadl.alpha', 0.5)
				setProperty('dadd.alpha', 0.5)
				setProperty('dadu.alpha', 0.5)
				setProperty('dadr.alpha', 0.5)
				if camerarotation == true then
					doTweenAngle('turn', 'camGame', 0, 1, 'circOut')
				end
			end
		elseif musthit == true then
				setProperty('dadi.alpha', 0.3)
				setProperty('dadl.alpha', 0.3)
				setProperty('dadd.alpha', 0.3)
				setProperty('dadu.alpha', 0.3)
				setProperty('dadr.alpha', 0.3)
			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-alt' then
				triggerEvent('Camera Follow Pos',bfx -bfstrength,bfy)

				setProperty('bfi.alpha', 0.5)
				setProperty('bfl.alpha', 1)
				setProperty('bfd.alpha', 0.5)
				setProperty('bfu.alpha', 0.5)
				setProperty('bfr.alpha', 0.5)
				if camerarotation == true then
					doTweenAngle('turn', 'camGame', -1, 1, 'circOut')
				end
			elseif getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-alt' then
				triggerEvent('Camera Follow Pos',bfx,bfy +bfstrength)

				setProperty('bfi.alpha', 0.5)
				setProperty('bfl.alpha', 0.5)
				setProperty('bfd.alpha', 1)
				setProperty('bfu.alpha', 0.5)
				setProperty('bfr.alpha', 0.5)
				if camerarotation == true then
					doTweenAngle('turn', 'camGame', 2, 1, 'circOut')
				end
			elseif getProperty('boyfriend.animation.curAnim.name') == 'singUP' or getProperty('boyfriend.animation.curAnim.name') == 'singUP-alt' then
				triggerEvent('Camera Follow Pos',bfx,bfy -bfstrength)

				setProperty('bfi.alpha', 0.5)
				setProperty('bfl.alpha', 0.5)
				setProperty('bfd.alpha', 0.5)
				setProperty('bfu.alpha', 1)
				setProperty('bfr.alpha', 0.5)
				if camerarotation == true then
					doTweenAngle('turn', 'camGame', -2, 1, 'circOut')
				end
			elseif getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-alt' then
				triggerEvent('Camera Follow Pos',bfx +bfstrength,bfy)

				setProperty('bfi.alpha', 0.5)
				setProperty('bfl.alpha', 0.5)
				setProperty('bfd.alpha', 0.5)
				setProperty('bfu.alpha', 0.5)
				setProperty('bfr.alpha', 1)
				if camerarotation == true then
					doTweenAngle('turn', 'camGame', 1, 1, 'circOut')
				end
			else
				triggerEvent('Camera Follow Pos',bfx,bfy)

				setProperty('bfi.alpha', 1)
				setProperty('bfl.alpha', 0.5)
				setProperty('bfd.alpha', 0.5)
				setProperty('bfu.alpha', 0.5)
				setProperty('bfr.alpha', 0.5)
				if camerarotation == true then
					doTweenAngle('turn', 'camGame', 0, 1, 'circOut')
				end
			end
		end

			dadx = getMidpointX('dad') + 100 + (getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]'))
			dady = getMidpointY('dad') - 100 + (getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]'))
		
			bfx = getMidpointX('boyfriend') - 100 - (getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]'))
			bfy = getMidpointY('boyfriend') - 100 + (getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]'))

			setProperty('dadi.x', dadx)
			setProperty('dadi.y', dady)

			setProperty('dadl.x', dadx -dadstrength)
			setProperty('dadl.y', dady)

			setProperty('dadd.x', dadx)
			setProperty('dadd.y', dady +dadstrength)

			setProperty('dadu.x', dadx)
			setProperty('dadu.y', dady -dadstrength)

			setProperty('dadr.x', dadx +dadstrength)
			setProperty('dadr.y', dady)


			setProperty('bfi.x', bfx)
			setProperty('bfi.y', bfy)

			setProperty('bfl.x', bfx -bfstrength)
			setProperty('bfl.y', bfy)

			setProperty('bfd.x', bfx)
			setProperty('bfd.y', bfy +bfstrength)

			setProperty('bfu.x', bfx)
			setProperty('bfu.y', bfy -bfstrength)

			setProperty('bfr.x', bfx +bfstrength)
			setProperty('bfr.y', bfy)
	end
end

function onSectionHit()
	if mustHitSection then
		musthit = true
	else
		musthit = false
	end
end