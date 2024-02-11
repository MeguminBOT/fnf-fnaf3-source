local death1 = 1;
local death2 = 0;
local death3 = 0;
local death4 = 0;

function onCreate()
	precacheSound("death/everlasting1")
	precacheSound("death/everlasting2")
	precacheSound("death/everlasting3")
	precacheSound("death/everlasting4")

	video.Load("death/everlasting1.webm")
	video.Load("death/everlasting2.webm")
	video.Load("death/everlasting3.webm")
	video.Load("death/everlasting4.webm")
end

function onStepHit()
	if curStep < 1407 then
		death1 = 1;
		death2 = 0;
		death3 = 0;
		death4 = 0;
	elseif curStep >= 1408 and curStep <= 1679 then
		death1 = 0;
		death2 = 1;
		death3 = 0;
		death4 = 0;
	elseif curStep >= 2752 and curStep <= 2465 then
		death1 = 0;
		death2 = 0;
		death3 = 1;
		death4 = 0;
	elseif curStep >= 4320 and curStep <= 10000 then
		death1 = 0;
		death2 = 0;
		death3 = 0;
		death4 = 1;
	end
end

function onGameOverStart()
	if death1 == 1 then
		playSound('death/everlasting1')
		startVideo('death/everlasting1')
	elseif death2 == 1 then
		playSound('death/everlasting2')
		startVideo('death/everlasting2')
	elseif death3 == 1 then
		playSound('death/everlasting3')
		startVideo('death/everlasting3')
	else
		playSound('death/everlasting4')
		startVideo('death/everlasting4')
	end
end