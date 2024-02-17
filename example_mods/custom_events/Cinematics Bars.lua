-- Made by Skry
-- Refactored / Optimized by AutisticLulu

local enabled
local speed
local ease = 'CubeOut'
local height = 80
local width = 1280

local function createBar(name)
	makeLuaSprite(name, nil, 0, y)
	makeGraphic(name, width, height, '000000')
	setObjectCamera(name, 'camHUD')
	addLuaSprite(name, false)
end

local function cinematicTween(name, element, targetY, targetAlpha, speed, ease)
	doTweenY(name, element, targetY, speed, ease)
	doTweenAlpha(name, element, targetAlpha, speed, ease)
end

function onCreate()
	createBar('upperBarHUD', -height)
	createBar('lowerBarHUD', height)
end

function onEvent(name, value1, value2)
	if name == 'Cinematics Bars' then
		enabled = tonumber(value1)
		speed = tonumber(value2)
		
		if enabled ~= 0 then
			cinematicTween('topBarTweenIn', 'topBar', 0, 0, speed, ease)
			cinematicTween('bottomBarTweenIn', 'bottomBar', screenHeight - height, 0, speed, ease)
			
			local startY = downscroll and -height + 590 or height + 10
			local targetY = downscroll and 570 or 50
			
			for i = 0, 7 do
				local noteTweenName = (downscroll and 'Downscroll' or 'Upscroll') .. 'move' .. i
				cinematicTween(noteTweenName, i, startY, targetY, speed + 0.1, ease)
			end
			
			cinematicTween('cinemaTweenIn1', 'healthBarBG', 0, 0, 0.1, ease)
			cinematicTween('cinemaTweenIn2', 'healthBar', 0, 0, 0.1, ease)
			cinematicTween('cinemaTweenIn3', 'scoreTxt', 0, 0, 0.1, ease)
			cinematicTween('cinemaTweenIn4', 'iconP1', 0, 0, 0.1, ease)
			cinematicTween('cinemaTweenIn5', 'iconP2', 0, 0, 0.1, ease)
			cinematicTween('cinemaTweenIn6', 'timeBar', 0, 0, 0.1, ease)
			cinematicTween('cinemaTweenIn7', 'timeBarBG', 0, 0, 0.1, ease)
			cinematicTween('cinemaTweenIn8', 'timeTxt', 0, 0, 0.1, ease)
		end
		
		if enabled == 0 then
			cinematicTween('topBarTweenOut', 'topBar', -height, 1, speed, ease)
			cinematicTween('bottomBarTweenOut', 'bottomBar', 700 + height, 1, speed, ease)
			
			local startY = downscroll and 570 or 50
			local targetY = downscroll and -height + 590 or height + 10
			
			for i = 0, 7 do
				local noteTweenName = (downscroll and 'DownscollMoveBack' or 'UpscrollMoveBack') .. i
				cinematicTween(noteTweenName, i, startY, targetY, speed, ease)
			end
			
			cinematicTween('cinemaTweenOut1', 'healthBarBG', 1, 1, speed, ease)
			cinematicTween('cinemaTweenOut2', 'healthBar', 1, 1, speed, ease)
			cinematicTween('cinemaTweenOut3', 'scoreTxt', 1, 1, speed, ease)
			cinematicTween('cinemaTweenOut4', 'iconP1', 1, 1, speed, ease)
			cinematicTween('cinemaTweenOut5', 'iconP2', 1, 1, speed, ease)
			cinematicTween('cinemaTweenOut6', 'timeBar', 1, 1, speed, ease)
			cinematicTween('cinemaTweenOut7', 'timeBarBG', 1, 1, speed, ease)
			cinematicTween('cinemaTweenOut8', 'timeTxt', 1, 1, speed, ease)
		end
	end
end