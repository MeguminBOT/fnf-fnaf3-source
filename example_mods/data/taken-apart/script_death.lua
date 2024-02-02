local freddy = 1;
local bonnie = 0;
local chica = 0;
local foxy = 0;

function onCreate()
	video.Load("Death/takenapartfreddy.webm")
	video.Load("Death/takenapartbonnie.webm")
	video.Load("Death/takenapartchica.webm")
	video.Load("Death/takenapartfoxy.webm")
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'fnf_loss_sfx')
	makeLuaSprite('gameover', 'gameover', 0, 0);
	setObjectCamera('gameover', 'hud')
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
	setProperty('boyfriend.visible', false);
	addLuaSprite('gameover');
	if freddy == 1 then
		startVideo('Death/takenapartfreddy');
	elseif bonnie == 1 then
		startVideo('Death/takenapartbonnie');
	elseif chica == 1 then
		startVideo('Death/takenapartchica');
	else
		startVideo('Death/takenapartfoxy');
	end
end