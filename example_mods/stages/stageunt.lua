function onCreate()
	precacheImage('cameras');
	precacheImage('characters/shadowbonnie');
	precacheImage('characters/shadowbonnie2');
	precacheImage('characters/pshadowfreddy');
	precacheImage('characters/pshadowfreddy2');

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

	if curStep == 458 then
		makeLuaText('Text',"Tonight ...",1000,140,550)
		setTextSize('Text',25)
		addLuaText("Text")			
	end				
	if curStep == 467 then		
		removeLuaText("Text")
		makeLuaText('Text2',"I won't hold BACK!",1000,140,550)
		setTextSize('Text2',25)
		addLuaText("Text2")				
	end				
	if curStep == 488 then
		removeLuaText("Text2")				
	end

	if curStep == 1976 then

    removeLuaSprite('untstage', true);

	makeAnimatedLuaSprite('cameras', 'BGs/cameras', -500, -200);
	setLuaSpriteScrollFactor('cameras', 0, 0);
	scaleObject('cameras', 1.7, 1.7);

	addAnimationByPrefix('cameras','cameras','idle',12,true);

	addLuaSprite('cameras', false);

	end
end