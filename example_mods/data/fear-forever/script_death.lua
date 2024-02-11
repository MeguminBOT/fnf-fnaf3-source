function onCreate()
	precacheSound('death/fearForever')
	video.Load("death/fearForever.webm")
end

function onGameOverStart()
	playSound('death/fearForever')
	startVideo('death/fearForever')
end