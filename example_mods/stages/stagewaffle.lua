function onCreate()
	precacheImage('characters/wafflebear2');
	precacheImage('characters/wafflebonnie2');
	precacheImage('characters/waffletrap2');
	precacheImage('characters/waffletrap3');
	precacheImage('BGs/wafflestage1');
	precacheImage('BGs/wafflestage2');
	precacheImage('BGs/wafflestage3');
	precacheImage('BGs/wafflestage4');
	precacheImage('Props/waffle1');
	precacheImage('Props/waffle2');
	precacheImage('Props/waffle3');
	precacheImage('Props/waffle4');
	precacheImage('Props/waffle5');
	makeLuaSprite('wafflestage1', 'BGs/wafflestage1', 0, 300);
	setLuaSpriteScrollFactor('wafflestage1', 1, 1);
	scaleObject('wafflestage1', 0.4, 0.4);
	addLuaSprite('wafflestage1', false);
	makeLuaSprite('waffle1', 'Props/waffle1', 750, 790);
	setLuaSpriteScrollFactor('waffle1', 1, 1);
	scaleObject('waffle1', 0.11, 0.11);
	addLuaSprite('waffle1', true);
	setProperty('wafflestage1.alpha', 0);
	setProperty('waffle1.alpha', 0);

	makeLuaSprite('wafflestage2', 'BGs/wafflestage2', -300, 0);
	setLuaSpriteScrollFactor('wafflestage2', 1, 1);
	scaleObject('wafflestage2', 0.6, 0.6);
	addLuaSprite('wafflestage2', false);
	makeLuaSprite('waffle2', 'Props/waffle2', 500, 600);
	setLuaSpriteScrollFactor('waffle2', 1, 1);
	scaleObject('waffle2', 0.5, 0.5);
	addLuaSprite('waffle2', true);

	makeLuaSprite('black','black', 0, 0);
    setObjectCamera('black', 'other')
    addLuaSprite('black', true);
	makeLuaSprite('white','white', 0, 0);
    setObjectCamera('white', 'other')
    addLuaSprite('white', true);
	doTweenAlpha('white','white', 0, 0.01, true);

end

function onCreatePost()
	setProperty('boyfriend.visible', false);
end


function onStepHit()
		if curStep == 72 then
			setProperty('wafflestage1.alpha', 1);
			setProperty('wafflestage2.alpha', 0);
			setProperty('waffle1.alpha', 1);
			setProperty('waffle2.alpha', 0);
			setProperty('dad.visible', false);
			setProperty('gf.visible', false);
			setProperty('boyfriend.visible', true);
		end
		if curStep == 84 then
			setProperty('wafflestage1.alpha', 0);
			setProperty('wafflestage2.alpha', 1);
			setProperty('waffle1.alpha', 0);
			setProperty('waffle2.alpha', 1);
			setProperty('dad.visible', true);
			setProperty('gf.visible', true);
			setProperty('boyfriend.visible', false);
		end
		if curStep == 94 then
			setProperty('wafflestage1.alpha', 1);
			setProperty('wafflestage2.alpha', 0);
			setProperty('waffle1.alpha', 1);
			setProperty('waffle2.alpha', 0);
			setProperty('dad.visible', false);
			setProperty('gf.visible', false);
			setProperty('boyfriend.visible', true);
		end
		if curStep == 126 then
			setProperty('wafflestage1.alpha', 0);
			setProperty('wafflestage2.alpha', 1);
			setProperty('waffle1.alpha', 0);
			setProperty('waffle2.alpha', 1);
			setProperty('dad.visible', true);
			setProperty('gf.visible', true);
			setProperty('boyfriend.visible', false);
		end
		if curStep == 160 then
			setProperty('wafflestage1.alpha', 1);
			setProperty('wafflestage2.alpha', 0);
			setProperty('waffle1.alpha', 1);
			setProperty('waffle2.alpha', 0);
			setProperty('dad.visible', false);
			setProperty('gf.visible', false);
			setProperty('boyfriend.visible', true);
		end
		if curStep == 178 then
			setProperty('wafflestage1.alpha', 0);
			setProperty('wafflestage2.alpha', 1);
			setProperty('waffle1.alpha', 0);
			setProperty('waffle2.alpha', 1);
			setProperty('dad.visible', true);
			setProperty('gf.visible', true);
			setProperty('boyfriend.visible', false);
		end
		if curStep == 254 then
			setProperty('wafflestage1.alpha', 1);
			setProperty('wafflestage2.alpha', 0);
			setProperty('waffle1.alpha', 1);
			setProperty('waffle2.alpha', 0);
			setProperty('dad.visible', false);
			setProperty('gf.visible', false);
			setProperty('boyfriend.visible', true);
		end
	if curStep == 321 then
		setProperty('dad.visible', true);
		setProperty('gf.visible', true);
		setProperty('boyfriend.visible', true);
    removeLuaSprite('wafflestage1', true);
	removeLuaSprite('waffle1', true);
    removeLuaSprite('wafflestage2', true);
	removeLuaSprite('waffle2', true);
      
	makeLuaSprite('wafflestage3', 'BGs/wafflestage3', -200, 200);
	setLuaSpriteScrollFactor('wafflestage3', 1, 1);
	scaleObject('wafflestage3', 0.5, 0.5);
	addLuaSprite('wafflestage3', false);

	makeLuaSprite('waffle3', 'Props/waffle3', 850, 720);
	setLuaSpriteScrollFactor('waffle3', 1, 1);
	scaleObject('waffle3', 0.08, 0.08);
	addLuaSprite('waffle3', true);

	makeLuaSprite('waffle4', 'Props/waffle4', 440, 685);
	setLuaSpriteScrollFactor('waffle4', 1, 1);
	scaleObject('waffle4', 0.35, 0.35);
	addLuaSprite('waffle4', false);
	setObjectOrder('waffle4', getObjectOrder('dadGroup')+ -1)
   end
	if curStep == 705 then

		removeLuaSprite('wafflestage1', true);
		removeLuaSprite('waffle1', true);
		removeLuaSprite('wafflestage2', true);
		removeLuaSprite('waffle2', true);


		removeLuaSprite('wafflestage3', true);
		removeLuaSprite('waffle4', true);
		removeLuaSprite('waffle3', true);

		makeLuaSprite('wafflestage4', 'BGs/wafflestage4', -200, 400);
		setLuaSpriteScrollFactor('wafflestage4', 1, 1);
		scaleObject('wafflestage4', 0.4, 0.4);
		addLuaSprite('wafflestage4', false);

		makeLuaSprite('waffle5', 'Props/waffle5', 0, 820);
		setLuaSpriteScrollFactor('waffle5', 1, 1);
		scaleObject('waffle5', 0.35, 0.35);
		addLuaSprite('waffle5', true);


   end

   if curStep == 833 then
		
    removeLuaSprite('wafflestage4', true);
	removeLuaSprite('waffle5', true);
      
	makeLuaSprite('wafflestage3', 'BGs/wafflestage3', -200, 200);
	setLuaSpriteScrollFactor('wafflestage3', 1, 1);
	scaleObject('wafflestage3', 0.5, 0.5);
	addLuaSprite('wafflestage3', false);

	makeLuaSprite('waffle3', 'Props/waffle3', 850, 720);
	setLuaSpriteScrollFactor('waffle3', 1, 1);
	scaleObject('waffle3', 0.08, 0.08);
	addLuaSprite('waffle3', true);

	makeLuaSprite('waffle4', 'Props/waffle4', 440, 685);
	setLuaSpriteScrollFactor('waffle4', 1, 1);
	scaleObject('waffle4', 0.35, 0.35);
	addLuaSprite('waffle4', false);
	setObjectOrder('waffle4', getObjectOrder('dadGroup')+ -1)
   end
end