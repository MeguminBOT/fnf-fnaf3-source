function onCreate()
	video.Load("Death/retribution.webm")
end

function onGameOverStart()
	setProperty('boyfriend.visible', false)
	startVideo('Death/Retribution')
end

function onGameOver()
	video.load("Death/BF.webm")
	startVideo('Death/BF')
end