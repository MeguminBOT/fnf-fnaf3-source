function onCreate()
	precacheSound("death/waffles")
	video.Load("death/waffles.webm")
end

function onGameOverStart()
	playSound('death/waffles')
	startVideo('death/waffles')
end