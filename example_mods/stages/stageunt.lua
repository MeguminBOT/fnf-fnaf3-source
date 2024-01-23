function onCreate()
	precacheImage('cameras');
	precacheImage('characters/shadowbonnie');
	precacheImage('characters/shadowbonnie2');
	precacheImage('characters/pshadowfreddy');
	precacheImage('characters/pshadowfreddy2');

	makeLuaSprite('eyes', 'BGs/eyes', -2000, -550);
	setLuaSpriteScrollFactor('eyes', 1, 1);
	scaleObject('eyes', 0.9, 0.9);
	addLuaSprite('eyes', false);
	setLuaSpriteScrollFactor('eyes', 0.4, 0.4);

	makeLuaSprite('helloagain', 'helloagain', -400, 540);
		setLuaSpriteScrollFactor('helloagain', 1, 1);
		scaleObject('helloagain', 1, 1);

		addLuaSprite('helloagain', true);
		doTweenAlpha('helloagain','helloagain', 0, 0.01, true);

	makeAnimatedLuaSprite('static','static', 0, 0);
	setObjectCamera('static', 'other')
	addLuaSprite('static', true);

	addAnimationByPrefix('static','static','idle',24,true);
	doTweenAlpha('static','static', 0, 0.01, true);
	
	makeLuaSprite('sfedstage', 'BGs/sfedstage', -2000, -550);
	setLuaSpriteScrollFactor('sfedstage', 1, 1);
	scaleObject('sfedstage', 0.9, 0.9);

	addLuaSprite('sfedstage', false);

	makeLuaSprite('untsfed', 'Chars/untsfed', -1500, 500);
	setLuaSpriteScrollFactor('untsfed', 1, 1);
	scaleObject('untsfed', 1.1, 1.1);

	addLuaSprite('untsfed', false);

	makeLuaSprite('black','black', 0, 0);
        setObjectCamera('black', 'other')
        addLuaSprite('black', true);

		makeLuaSprite('white','white', 0, 0);
        setObjectCamera('white', 'other')
        addLuaSprite('white', true);
		doTweenAlpha('white','white', 0, 0.01, true);

end

function onStepHit()

	if curStep == 245 then

		removeLuaSprite('untsfed', true);
	
		end

		if curStep == 1080 then

			removeLuaSprite('sfedstage', true);
		
			makeLuaSprite('sfedstage2', 'BGs/sfedstage2', -2000, -550);
			setLuaSpriteScrollFactor('sfedstage2', 1, 1);
			scaleObject('sfedstage2', 0.9, 0.9);
			addLuaSprite('sfedstage2', false);
		
			end

	if curStep == 1976 then

    removeLuaSprite('sfedstage2', true);

	makeAnimatedLuaSprite('cameras', 'BGs/cameras', -500, -250);
	setLuaSpriteScrollFactor('cameras', 0, 0);
	scaleObject('cameras', 1.9, 1.9);

	addAnimationByPrefix('cameras','cameras','idle',12,true);

	addLuaSprite('cameras', false);

	makeLuaSprite('thegraphic','thegraphic', 0, 0);
	setObjectCamera('thegraphic', 'hud')
	addLuaSprite('thegraphic', true);
	setProperty('thegraphic.alpha', 0)
	setObjectOrder('thegraphic', 5)

	end
end