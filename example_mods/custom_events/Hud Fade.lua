function onCreate()
	setProperty('camHUD.alpha',0)
end

function onEvent(name, value1, value2)
	if name == 'Hud Fade' then
		doTweenAlpha('hudFade', 'camHUD', tonumber(value1), tonumber(value2) * (stepCrochet / 1000), 'linear')
	end
end