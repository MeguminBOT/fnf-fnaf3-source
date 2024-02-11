function onCreate()
	precacheSound("death/bonnieRizz")
	video.Load("death/bonnieRizz.webm")
end

function onGameOverStart()
	playSound('death/bonnieRizz')
	startVideo('death/bonnieRizz')
end