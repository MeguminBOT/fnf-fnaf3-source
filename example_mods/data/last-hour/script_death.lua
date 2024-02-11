function onCreate()
	precacheSound("death/lastHour")
	video.Load("death/lastHour.webm")
end

function onGameOverStart()
	playSound('death/lastHour')
	startVideo('death/lastHour')
end