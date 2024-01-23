function onCreate()
	precacheImage('characters/oobbb2');
	precacheImage('characters/oobchica2');
	precacheImage('characters/oobmangle6');
	precacheImage('characters/oobfredbear2');
	precacheImage('BGs/oobfredbear2');
	makeLuaSprite('oob', 'BGs/oob', 0, 0);
	setLuaSpriteScrollFactor('oob', 0, 0);
	scaleObject('oob', 1, 1);
	addLuaSprite('oob', true);
	makeLuaSprite('outofbounds', 'outofbounds', 0, 0);
	setLuaSpriteScrollFactor('outofbounds', 0, 0);
	scaleObject('outofbounds', 1, 1);
	addLuaSprite('outofbounds', true);
	makeLuaSprite('oobbb', 'BGs/oobbb', -720, -50)
	setObjectOrder('oobbb', 0)
	scaleObject('oobbb', 0.8, 0.8)
	addLuaSprite('oobbb', true)
	makeAnimatedLuaSprite('static','static', 0, 0);
	setObjectCamera('static', 'hud')
	addLuaSprite('static', true);
	addAnimationByPrefix('static','static','idle',24,true);
	setProperty('static.alpha', 0);
	makeLuaSprite('white','white', -5000, -5000);
	setLuaSpriteScrollFactor('white', 0, 0);
	scaleObject('white', 20, 20);
	addLuaSprite('white', true);
	makeLuaSprite('black','black', -5000, -5000);
	setLuaSpriteScrollFactor('black', 0, 0);
	scaleObject('black', 20, 20);
	addLuaSprite('black', true);
	makeLuaSprite('arcadeffect','arcadeffect', 0, 0);
	setLuaSpriteScrollFactor('arcadeffect', 0, 0);
	scaleObject('arcadeffect', 1, 1);
	setObjectCamera('arcadeffect', 'hud')
	addLuaSprite('arcadeffect', true);
	makeLuaSprite('whiteui','whiteui', 0, 0);
	setObjectCamera('whiteui', 'hud')
	addLuaSprite('whiteui', true);
	setProperty('whiteui.alpha', 0);
	setProperty('outofbounds.alpha', 0);
end
--50 2 2:45 3:30 4:10 5:05 6:25 7:50
function onStepHit()
if curStep == 512 then
	removeLuaSprite('oob', true);
	removeLuaSprite('oobbb', true);

	makeLuaSprite('oobbb2', 'BGs/oobbb2', -900, -550)
	setObjectOrder('oobbb2', 0)
	scaleObject('oobbb2', 0.8, 0.8)
	setLuaSpriteScrollFactor('oobbb2', 0.8, 0.5);
	addLuaSprite('oobbb2', false)
end
if curStep == 1216 then
	removeLuaSprite('oobbb2', true);
	makeLuaSprite('oobmangle', 'BGs/oobmangle', -900, -30)
	setObjectOrder('oobmangle', 0)
	scaleObject('oobmangle', 0.8, 0.8)
	addLuaSprite('oobmangle', true)
end
if curStep == 1696 then
	removeLuaSprite('oobmangle', true);
	makeLuaSprite('oobmangle2', 'BGs/oobmangle2', -800, -550)
	setObjectOrder('oobmangle2', 0)
	scaleObject('oobmangle2', 0.8, 0.8)
	setLuaSpriteScrollFactor('oobmangle2', 0.8, 0.5);
	addLuaSprite('oobmangle2', false)
end
if curStep == 2224 then
	removeLuaSprite('oobmangle2', true);
	makeLuaSprite('oobchica', 'BGs/oobchica', -700, -20)
	setObjectOrder('oobchica', 0)
	scaleObject('oobchica', 0.8, 0.8)
	addLuaSprite('oobchica', true)
end
if curStep == 2752 then
	removeLuaSprite('oobchica', true);
	makeLuaSprite('oobchica2', 'BGs/oobchica2', -1050, -300)
	setObjectOrder('oobchica2', 0)
	scaleObject('oobchica2', 0.8, 0.8)
	setLuaSpriteScrollFactor('oobchica2', 0.8, 0.5);
	addLuaSprite('oobchica2', false)
end
if curStep == 3424 then
	removeLuaSprite('oobchica2', true);
	makeAnimatedLuaSprite('oobfredbear', 'BGs/oobfredbear', -700, -40)
	setObjectOrder('oobfredbear', 0)
	scaleObject('oobfredbear', 0.8, 0.8)
	addLuaSprite('oobfredbear', true)
	makeAnimatedLuaSprite('springbonnie','Chars/springbonnie', -200, 210);
	scaleObject('springbonnie', 1.9, 1.9);
	addLuaSprite('springbonnie', true);
	addAnimationByPrefix('oobfredbear','oobfredbear','idle',24,true);
	addAnimationByPrefix('springbonnie','springbonnie','idle',24,true);
end
if curStep == 4320 then
	removeLuaSprite('oobfredbear', true);
	removeLuaSprite('springbonnie', true);
	removeLuaSprite('oobbb', true);
	makeAnimatedLuaSprite('oobfredbear2','BGs/oobfredbear2', 0, 0);
	scaleObject('oobfredbear2', 1, 1);
	addLuaSprite('oobfredbear2', false);
	setLuaSpriteScrollFactor('oobfredbear2', 0, 0);
	addAnimationByPrefix('oobfredbear2','oobfredbear2','idle',24,true);
end
if curStep == 5760 then
	removeLuaSprite('oobfredbear2', true);
	removeLuaSprite('oobbb', true);
	makeLuaSprite('oobpuppet', 'BGs/oobpuppet', -200, 25)
	setObjectOrder('oobpuppet', 0)
	scaleObject('oobpuppet', 1.35, 1.35)
	setLuaSpriteScrollFactor('oobpuppet', 1, 1);
	addLuaSprite('oobpuppet', false)
	makeLuaSprite('oobpuppet2', 'BGs/oobpuppet2', -200, 25)
	setObjectOrder('oobpuppet2', 1)
	scaleObject('oobpuppet2', 1.35, 1.35)
	setLuaSpriteScrollFactor('oobpuppet2', 1, 1);
	addLuaSprite('oobpuppet2', true)
	makeLuaSprite('oobpuppetchild', 'BGs/oobpuppetchild', -200, 25)
	setObjectOrder('oobpuppetchild', 1)
	scaleObject('oobpuppetchild', 1.35, 1.35)
	setLuaSpriteScrollFactor('oobpuppetchild', 1, 1);
	addLuaSprite('oobpuppetchild', true)
end
if curStep == 5968 then
	makeLuaSprite('oobpuppet5', 'BGs/oobpuppet5', -200, 25)
	setObjectOrder('oobpuppet5', 2)
	scaleObject('oobpuppet5', 1.35, 1.35)
	setLuaSpriteScrollFactor('oobpuppet5', 1, 1);
	addLuaSprite('oobpuppet5', false)
end
	if curStep == 6096 then
	makeLuaSprite('oobpuppet6', 'BGs/oobpuppet6', -200, 25)
	setObjectOrder('oobpuppet6', 2)
	scaleObject('oobpuppet6', 1.35, 1.35)
	setLuaSpriteScrollFactor('oobpuppet6', 1, 1);
	addLuaSprite('oobpuppet6', true)
	end
	if curStep == 6224 then
	makeLuaSprite('oobpuppet7', 'BGs/oobpuppet7', -200, 25)
	setObjectOrder('oobpuppet7', 2)
	scaleObject('oobpuppet7', 1.35, 1.35)
	setLuaSpriteScrollFactor('oobpuppet7', 1, 1);
	addLuaSprite('oobpuppet7', true)
	end
	if curStep == 6352 then
	makeLuaSprite('oobpuppet8', 'BGs/oobpuppet8', -200, 25)
	setObjectOrder('oobpuppet8', 21)
	scaleObject('oobpuppet8', 1.35, 1.35)
	setLuaSpriteScrollFactor('oobpuppet8', 1, 1);
	addLuaSprite('oobpuppet8', true)
	end
if curStep == 6480 then
	makeLuaSprite('oobpuppet3', 'BGs/oobpuppet3', -200, 25)
	setObjectOrder('oobpuppet3', 2)
	scaleObject('oobpuppet3', 1.35, 1.35)
	setLuaSpriteScrollFactor('oobpuppet3', 1, 1);
	addLuaSprite('oobpuppet3', false)
	makeLuaSprite('oobpuppet4', 'BGs/oobpuppet4', -200, 25)
	setObjectOrder('oobpuppet4', 2)
	scaleObject('oobpuppet4', 1.35, 1.35)
	setLuaSpriteScrollFactor('oobpuppet4', 1, 1);
	addLuaSprite('oobpuppet4', true)
end
if curStep == 6608 then
	removeLuaSprite('oobpuppet4', true);
	removeLuaSprite('oobpuppetchild', true);
	makeLuaSprite('oobpuppetchild2', 'BGs/oobpuppetchild2', -200, 25)
	setObjectOrder('oobpuppetchild2', 2)
	scaleObject('oobpuppetchild2', 1.35, 1.35)
	setLuaSpriteScrollFactor('oobpuppetchild2', 1, 1);
	addLuaSprite('oobpuppetchild2', true)
end
end