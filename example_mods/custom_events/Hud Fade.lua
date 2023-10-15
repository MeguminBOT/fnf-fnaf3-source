function onCreate()
setProperty('camHUD.alpha',0)
end
function onEvent(eventName, value1, value2)
if eventName=='Hud Fade' then
doTweenAlpha('HudFADE','camHUD',tonumber(value1),tonumber(value2)*(stepCrochet/1000),'linear')
end
end