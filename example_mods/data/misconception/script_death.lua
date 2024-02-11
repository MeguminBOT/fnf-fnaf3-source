function onCreate()
	precacheSound("death/misconception")
	video.Load("death/misconception.webm")
end

function onGameOverStart()
	playSound('death/misconception')
	startVideo('death/misconception')
end