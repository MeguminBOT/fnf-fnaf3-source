function onCreate()
	precacheSound("death/outOfBounds")
	video.Load("death/outOfBounds.webm")
end

function onGameOverStart()
	playSound('death/outOfBounds')
	startVideo('death/outOfBounds')
end