function onCreate()
	precacheSound('death/leantrap')
	video.Load("death/leantrap.webm")
end

function onGameOverStart()
	playSound('death/leantrap')
	startVideo('death/leantrap')
end