function onCreate()
	precacheImage('characters/bflean2');
	precacheImage('characters/leantrap2');
	precacheImage('BGs/drugs');
	makeLuaSprite('leanstage', 'BGs/leantrap', -2000, -550);
	setLuaSpriteScrollFactor('leanstage', 1, 1);
	scaleObject('leanstage', 1.4, 1.4);
	addLuaSprite('leanstage', false);
	makeLuaSprite('black','black', 0, 0);
        setObjectCamera('black', 'hud')
        addLuaSprite('black', true);
		makeLuaSprite('white','white', 0, 0);
        setObjectCamera('white', 'hud')
        addLuaSprite('white', true);
		setProperty('white.alpha', 0);
end

function onStepHit()
	if curStep == 832 then
		removeLuaSprite('leantrap',true);
		makeAnimatedLuaSprite('drugs','BGs/drugs', -300, -150);
		scaleObject('drugs', 1.5, 1.5);
		addLuaSprite('drugs', false);
		setLuaSpriteScrollFactor('drugs', 0, 0);
		addAnimationByPrefix('drugs','drugs','idle',24,true);
	end
	end