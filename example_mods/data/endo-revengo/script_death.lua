function onCreate()
	precacheSound("death/bf")
	video.Load("death/bf.webm")
end

function onGameOverStart()
	playSound('death/bf')
	startVideo('death/bf')
end