local Enabled
local Speed
local Ease = 'CubeOut'
local Height = 80 -- 80 or 120


function onCreate()
        makeLuaSprite('topBar', nil, 0, -Height)
	makeGraphic('topBar', 1280, Height, '000000')
	setObjectCamera('topBar', 'hud')
	addLuaSprite('topBar', true)

        makeLuaSprite('bottomBar', nil, 0, 650 +Height)
	makeGraphic('bottomBar', 1280, Height, '000000')
	setObjectCamera('bottomBar', 'hud')
	addLuaSprite('bottomBar', true)
end
function onEvent(n,v1,v2)
 if n == 'Cinematics Bars' then
  Enabled = tonumber(v1)
  Speed = tonumber(v2)
  if Enabled ~= 0 then
        doTweenY('Bars1', 'topBar', 0, Speed, Ease)
        doTweenY('Bars2', 'bottomBar', screenHeight  - Height, Speed, Ease)
      if downscroll then
       for i = 0,7 do
        noteTweenY('DownscrollMove' .. i, i, -Height +590, Speed + 0.1, Ease)
     end
     elseif not downscroll then
      for i = 0,7 do
       noteTweenY('UpscrollMove' .. i, i, Height +10, Speed + 0.1, Ease)
      end
     end	
       doTweenAlpha('Tween1', 'healthBarBG', 0, 0.1, Ease)
       doTweenAlpha('Tween2', 'healthBar', 0, 0.1, Ease)
       doTweenAlpha('Tween3', 'scoreTxt', 0, 0.1, Ease)
       doTweenAlpha('Tween4', 'iconP1', 0, 0.1, Ease)
       doTweenAlpha('Tween5', 'iconP2', 0, 0.1, Ease)
       doTweenAlpha('Tween6', 'timeBar', 0, 0.1, Ease)
       doTweenAlpha('Tween7', 'timeBarBG', 0, 0.1, Ease)
       doTweenAlpha('Tween8', 'timeTxt', 0, 0.1, Ease)

end
if Enabled == 0 then
     doTweenY('Barsse1', 'topBar', -Height, Speed, Ease)
     doTweenY('Barsse2', 'bottomBar', 700 +Height, Speed, Ease)
    if downscroll then
     for i = 0,7 do
      noteTweenY('DownscollMoveBack' .. i, i, 570, Speed, Ease)
     end
    elseif not downscroll then
     for i = 0,7 do
      noteTweenY('UpscrollMoveBack' .. i, i, 50, Speed, Ease)
     end	
    end
     doTweenAlpha('Tween01', 'healthBarBG', 1, Speed, Ease)
     doTweenAlpha('Tween02', 'healthBar', 1, Speed, Ease)
     doTweenAlpha('Tween03', 'scoreTxt', 1, Speed, Ease)
     doTweenAlpha('Tween04', 'iconP1', 1, Speed, Ease)
     doTweenAlpha('Tween05', 'iconP2', 1, Speed, Ease)
     doTweenAlpha('Tween06', 'timeBar', 1, Speed, Ease)
     doTweenAlpha('Tween07', 'timeBarBG', 1, Speed, Ease)
     doTweenAlpha('Tween08e', 'timeTxt', 1, Speed, Ease)
end 
end
end
   -- Made by Skry#4271 --
--nice
     -- Feel Free to Credit me ig --
 













-- hi --
 --Skry