function onCreate()
	precacheImage('Chars/shadowbb');
	makeAnimatedLuaSprite('background','BGs/hoaxing', 450, -300);
    addAnimationByPrefix('background','idle','idle',24,true);
	scaleObject('background', 1.2, 1.2);
	setObjectOrder('background', 0)
	setLuaSpriteScrollFactor('background', 1.2, 1.2);
	addLuaSprite('background', false);

	makeLuaSprite('table', 'BGs/hoaxtable', 0, 600);
	setLuaSpriteScrollFactor('table', 1, 1);
	scaleObject('table', 0.7, 0.7);
	setObjectOrder('table', 2)
	addLuaSprite('table', false);

	makeAnimatedLuaSprite('phtfreddy','Chars/phtfreddy', 2500, 0);
    addAnimationByPrefix('phtfreddy','idle','idle',24,true);
	scaleObject('phtfreddy', 1.1, 1.1);
	setObjectOrder('phtfreddy', 1)
	addLuaSprite('phtfreddy', false);

	makeAnimatedLuaSprite('phtchica','Chars/phtchica', 2500, 0);
    addAnimationByPrefix('phtchica','idle','idle',24,true);
	scaleObject('phtchica', 1.1, 1.1);
	setObjectOrder('phtchica', 1)
	addLuaSprite('phtchica', false);

	makeAnimatedLuaSprite('phtbonnie','Chars/phtbonnie', 2500, 0);
    addAnimationByPrefix('phtbonnie','idle','idle',24,true);
	scaleObject('phtbonnie', 1.1, 1.1);
	setObjectOrder('phtbonnie', 1)
	addLuaSprite('phtbonnie', false);

	makeAnimatedLuaSprite('chromefreddy','Chars/chromefreddy', -200, 0);
    addAnimationByPrefix('chromefreddy','idle','idle',24,true);
	scaleObject('chromefreddy', 1, 1);
	setObjectOrder('chromefreddy', 1)
	addLuaSprite('chromefreddy', false);
	setProperty('chromefreddy.alpha', 0);
end

function onStepHit()
		if curStep == 1 then
			objectPlayAnimation('background', 'idle',true)
	   end

	   if curStep == 250 then
		doTweenX('phantom1', 'phtfreddy', -400, 15, 'linear');
   	end
  	 if curStep == 290 then
		doTweenX('phantom2', 'phtchica', -400, 12, 'linear');
	end
	if curStep == 330 then
		doTweenX('phantom3', 'phtbonnie', -400, 14, 'linear');
	end
	if curStep == 848 then
		doTweenX('chrome', 'chromefreddy', 3500, 20, 'linear');
		setProperty('chromefreddy.alpha', 1);
	end
	if curStep == 512 then
		makeAnimatedLuaSprite('shadowbb','Chars/shadowbb', 0, 0);
        setObjectCamera('shadowbb', 'hud')
        addLuaSprite('shadowbb', true);

        addAnimationByPrefix('shadowbb','shadowbb','idle',24,false);
	end
	end