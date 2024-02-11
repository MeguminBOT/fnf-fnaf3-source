function onCreate()
	precacheSound("death/untilNextTime")
	video.Load("death/untilNextTime.webm")
end

function onGameOverStart()
	playSound('death/untilNextTime')
	startVideo('death/untilNextTime')
end