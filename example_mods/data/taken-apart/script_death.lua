local freddy = 1;
local bonnie = 0;
local chica = 0;
local foxy = 0;

function onCreate()
	video.Load("death/takenApart1.webm")
	video.Load("death/takenApart2.webm")
	video.Load("death/takenApart3.webm")
	video.Load("death/takenApart4.webm")
end

function onStepHit()
	if curStep < 817 then
		freddy = 1;
		bonnie = 0;
		chica = 0;
		foxy = 0;
	elseif curStep >= 818 and curStep <= 1632 then
		freddy = 0;
		bonnie = 1;
		chica = 0;
		foxy = 0;
	elseif curStep >= 1633 and curStep <= 2465 then
		freddy = 0;
		bonnie = 0;
		chica = 1;
		foxy = 0;
	elseif curStep >= 2466 and curStep <= 10000 then
		freddy = 0;
		bonnie = 0;
		chica = 0;
		foxy = 1;
	end
end

function onGameOverStart()
	if freddy == 1 then
		startVideo('death/takenApart1')
	elseif bonnie == 1 then
		startVideo('death/takenApart2')
	elseif chica == 1 then
		startVideo('death/takenApart3')
	else
		startVideo('death/takenApart4')
	end
end