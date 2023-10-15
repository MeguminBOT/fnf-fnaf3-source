--[[ CAMERA SYSTEM MADE BY NOOBMAN, DO NOT REMOVE MY CREDITS! ]]

--[[ Optimized by AutisticLulu from 313 lines down to 149 lines ]]

-- SETTINGS --
local enabled = true -- Turns script functionality on or off.
local debugmode = false -- Turns debug mode on or off.

-- CAMERA SETTINGS --
local dadstrength = 50
local bfstrength = 50
local camerarotation = false

-- NOT SETTINGS --
local dadx = 0
local dady = 0
local bfx = 0
local bfy = 0
local debugcam = false
local songpos = 0
local vers = 1.2

function onCreatePost()
	if debugmode and enabled then
        makeLuaText('thefuckindebugtext', 'V' .. vers .. '\nNOOBMANS CAMERA SYSTEM DEBUG MODE IS ACTIVE!\nPRESS 6 TO SEE ALL THE CAMERA POSITIONS', 1300, 0, 0)
        setObjectCamera('thefuckindebugtext', 'other')
        setTextSize('thefuckindebugtext', 20)
        screenCenter('thefuckindebugtext', 'x')
        addLuaText('thefuckindebugtext')

        local sprites = {
            {name = 'dadi', color = 'FFFFFF', dx = dadx, dy = dady},
            {name = 'dadl', color = 'C24B99', dx = dadx - dadstrength, dy = dady},
            {name = 'dadd', color = '00FFFF', dx = dadx, dy = dady + dadstrength},
            {name = 'dadu', color = '12FA05', dx = dadx, dy = dady - dadstrength},
            {name = 'dadr', color = 'F9393F', dx = dadx + dadstrength, dy = dady},
            {name = 'bfi', color = 'FFFFFF', dx = bfx, dy = bfy},
            {name = 'bfl', color = 'C24B99', dx = bfx - bfstrength, dy = bfy},
            {name = 'bfd', color = '00FFFF', dx = bfx, dy = bfy + bfstrength},
            {name = 'bfu', color = '12FA05', dx = bfx, dy = bfy - bfstrength},
            {name = 'bfr', color = 'F9393F', dx = bfx + bfstrength, dy = bfy}
        }

        for _, sprite in ipairs(sprites) do
            makeLuaSprite(sprite.name, '', sprite.dx, sprite.dy)
            makeGraphic(sprite.name, 25, 25, sprite.color)
            addLuaSprite(sprite.name, true)
        end
    end
end

function onUpdate()
	if enabled then
		if debugmode and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SIX') then
			setTextString('thefuckindebugtext', 'V' .. vers .. '\nNOOBMANS CAMERA SYSTEM DEBUG MODE IS ACTIVE!\nPRESS SPACE TO CHANGE THE SELECTED CHARACTER\nHOLD DOWN A KEY TO MAKE THE SELECTED CHARACTER SING\nUSE THIS TO SEE IF THERE ARE ANY CAMERA POSITIONS THAT MAY GO OUTSIDE THE STAGE!\nPRESS 6 TO GO BACK TO NORMAL GAMEPLAY')
			debugcam = true
			songpos = getPropertyFromClass('Conductor', 'songPosition')
			setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
			setProperty('vocals.volume', 0)
			doTweenAlpha('camHUD', 'camHUD', 0, 0.5, 'linear')
			
			if not debugcam then
				setTextString('thefuckindebugtext', 'V' .. vers .. '\nNOOBMANS CAMERA SYSTEM DEBUG MODE IS ACTIVE!\nPRESS 6 TO SEE ALL THE CAMERA POSITIONS')
				setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 1)
				setProperty('vocals.volume', 1)
				setProperty('boyfriend.stunned', false)
				doTweenAlpha('camHUD', 'camHUD', 1, 0.5, 'linear')
			end
		end

		if debugcam then
			setPropertyFromClass('Conductor', 'songPosition', songpos)
			setPropertyFromClass('flixel.FlxG', 'sound.music.time', songpos)
			setProperty('vocals.time', songpos)

			if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') then
				mustHitSection = not mustHitSection
			end

			local character = mustHitSection and 'boyfriend' or 'dad'
			local animPrefix = 'sing'
			local animSuffix = ''

			if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT') then
				playAnim(character, animPrefix .. 'LEFT' .. animSuffix, true)
			elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') then
				playAnim(character, animPrefix .. 'DOWN' .. animSuffix, true)
			elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') then
				playAnim(character, animPrefix .. 'UP' .. animSuffix, true)
			elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT') then
				playAnim(character, animPrefix .. 'RIGHT' .. animSuffix, true)
			end
		end

		dadx = getMidpointX('dad') + 100 + (getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]'))
		dady = getMidpointY('dad') - 100 + (getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]'))
		bfx = getMidpointX('boyfriend') - 100 - (getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]'))
		bfy = getMidpointY('boyfriend') - 100 + (getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]'))

		local function setCharacterProperties(character, x, y, strength)
			setProperty(character .. 'i.alpha', 0.5)
			setProperty(character .. 'l.alpha', 0.5)
			setProperty(character .. 'd.alpha', 0.5)
			setProperty(character .. 'u.alpha', 0.5)
			setProperty(character .. 'r.alpha', 0.5)

			local animName = getProperty(character .. '.animation.curAnim.name')
			local animOffsetX = 0
			local animOffsetY = 0
			local angle = cameraRotation and 0 or nil

			if animName == 'singLEFT' or animName == 'singLEFT-alt' then
				animOffsetX = -strength
				angle = -1
			elseif animName == 'singDOWN' or animName == 'singDOWN-alt' then
				animOffsetY = strength
				angle = 2
			elseif animName == 'singUP' or animName == 'singUP-alt' then
				animOffsetY = -strength
				angle = -2
			elseif animName == 'singRIGHT' or animName == 'singRIGHT-alt' then
				animOffsetX = strength
				angle = 1
			end

			triggerEvent('Camera Follow Pos', x + animOffsetX, y + animOffsetY)
			setProperty(character .. 'i.x', x)
			setProperty(character .. 'i.y', y)
			setProperty(character .. 'l.x', x - strength)
			setProperty(character .. 'l.y', y)
			setProperty(character .. 'd.x', x)
			setProperty(character .. 'd.y', y + strength)
			setProperty(character .. 'u.x', x)
			setProperty(character .. 'u.y', y - strength)
			setProperty(character .. 'r.x', x + strength)
			setProperty(character .. 'r.y', y)

			if cameraRotation then
				doTweenAngle('turn', 'camGame', angle, 1, 'circOut')
			end
		end

		if mustHitSection then
			setCharacterProperties('boyfriend', bfx, bfy, bfstrength)
		else 
			setCharacterProperties('dad', dadx, dady, dadstrength)
		end
	end
end