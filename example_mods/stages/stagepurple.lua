function onCreate()
	precacheImage('purpleguy');
	makeLuaSprite('purplestage', 'BGs/purplestage', -1500, 0);
	setLuaSpriteScrollFactor('purplestage', 1, 1);
	scaleObject('purplestage', 0.85, 0.85);
	addLuaSprite('purplestage', false);

	makeLuaSprite('black','black', 0, 0);
	setObjectCamera('black', 'hud')
	addLuaSprite('black', true);
	setProperty('black.alpha', 0);

end
function onStepHit()
	if curStep == 1824 then

	makeLuaSprite('stageback', 'stageback', -600, -300);
	setScrollFactor('stageback', 0.9, 0.9);
	makeLuaSprite('stagefront', 'stagefront', -650, 600);
	setScrollFactor('stagefront', 0.9, 0.9);
	scaleObject('stagefront', 1.1, 1.1);
	makeLuaSprite('stagelight_left', 'stage_light', -125, -100);
	setScrollFactor('stagelight_left', 0.9, 0.9);
	scaleObject('stagelight_left', 1.1, 1.1);
	makeLuaSprite('stagelight_right', 'stage_light', 1225, -100);
	setScrollFactor('stagelight_right', 0.9, 0.9);
	scaleObject('stagelight_right', 1.1, 1.1);
	setProperty('stagelight_right.flipX', true); 
	makeLuaSprite('stagecurtains', 'stagecurtains', -500, -300);
	setScrollFactor('stagecurtains', 1.3, 1.3);
	scaleObject('stagecurtains', 0.9, 0.9);
	addLuaSprite('stageback', false);
	addLuaSprite('stagefront', false);
	addLuaSprite('stagelight_left', false);
	addLuaSprite('stagelight_right', false);
	addLuaSprite('stagecurtains', false);
	end

	if curStep == 2088 then

		removeLuaSprite('stageback', true);
		removeLuaSprite('stagefront', true);
		removeLuaSprite('stagelight_left', true);
		removeLuaSprite('stagelight_right', true);
		removeLuaSprite('stagecurtains', true);
		end
end