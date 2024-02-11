function onCreate()
	precacheSound("death/retribution")
	video.Load("death/retribution.webm")
end

function onGameOverStart()
	playSound('death/retribution')
	startVideo('death/retribution')
end