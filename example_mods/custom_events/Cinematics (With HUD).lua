-- Created by RamenDominoes (Please credit if using this, thanks! <3)
-- Refactored / Optimized by AutisticLulu

local upperBar
local lowerBar

local function createBar(name, y)
	makeLuaSprite(name, nil, -110, y)
	makeGraphic(name, 1500, 350, '000000')
	setObjectCamera(name, 'camHUD')
	addLuaSprite(name, false)
end

function onCreatePost()
	createBar('upperBarHUD', -350)
	createBar('lowerBarHUD', 720)

	upperBar = getProperty('upperBarHUD.y')
	lowerBar = getProperty('lowerBarHUD.y')
end

function onEvent(name, value1, value2)
	if name == 'Cinematics (With HUD)' then
		local speed = tonumber(value1)
		local distance = tonumber(value2)

		if speed and distance > 0 then
			doTweenY('barHudTween1', 'upperBarHUD', upperBar + distance, speed, 'QuadOut')
			doTweenY('barHudTween2', 'lowerBarHUD', lowerBar - distance, speed, 'QuadOut')
		end

		if downscroll and speed and distance > 0 then
			doTweenY('barHudTween1', 'upperBarHUD', upperBar + distance, speed, 'QuadOut')
			doTweenY('barHudTween2', 'lowerBarHUD', lowerBar - distance, speed, 'QuadOut')
		end

		if distance <= 0 then
			doTweenY('barHudTween1', 'upperBarHUD', upperBar, speed, 'QuadIn')
			doTweenY('barHudTween2', 'lowerBarHUD', lowerBar, speed, 'QuadIn')
		end
	end
end