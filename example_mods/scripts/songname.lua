function onStepHit()
	if curStep == 10 then
	makeAnimatedLuaSprite('songnametablet','tablets/'..songName, -150, 290);
	setObjectCamera('songnametablet', 'camOther');
	addLuaSprite('songnametablet', true);
	addAnimationByPrefix('songnametablet','songnametablet','idle',24,true);
	scaleObject('songnametablet', 0.6, 0.6);
	runTimer('songnametimerdone' , 6.6);
end
end
function onTimerCompleted(tag)
	if tag == "songnametimerdone" then
	removeLuaSprite('songnametablet', true);
end
end