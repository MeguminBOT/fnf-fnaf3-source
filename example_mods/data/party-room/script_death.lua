function onCreate()
	precacheSound("death/tryAgain")
	video.Load("death/tryAgain.webm")
end

function onGameOverStart()
	playSound('death/tryAgain')
	startVideo('death/tryAgain')
end