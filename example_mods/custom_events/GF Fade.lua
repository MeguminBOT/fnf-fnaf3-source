-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'GF Fade' then
		duration = tonumber(value1);
		if duration < 0 then
			duration = 0;
		end

		targetAlpha = tonumber(value2);
		if duration == 0 then
			setProperty('gf.alpha', targetAlpha);
		else
			doTweenAlpha('gfFadeEventTween', 'gf', targetAlpha, duration, 'linear');
		end
		--debugPrint('Event triggered: ', name, duration, targetAlpha);
	end
end