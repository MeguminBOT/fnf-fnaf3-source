function onCreate()
	precacheImage('BGs/jjstage2');
	precacheImage('characters/bb');
	precacheImage('characters/jj2');
	precacheImage('characters/jj3');
	makeLuaSprite('black','black', 0, 0);
    setObjectCamera('black', 'hud')
    addLuaSprite('black', true);
	doTweenAlpha('black','black', 0, 0.01, true);
	makeLuaSprite('jjstage1', 'BGs/jjstage1', -2050, -170);
	setLuaSpriteScrollFactor('jjstage1', 1, 1);
	scaleObject('jjstage1', 0.75, 0.75);

	makeLuaSprite('jjtable', 'BGs/jjtable', -2050, -170);
	setLuaSpriteScrollFactor('jjtable', 1, 1);
	scaleObject('jjtable', 0.75, 0.75);

	addLuaSprite('jjstage1', false);
	addLuaSprite('jjtable', true);

end

function onStepHit()
	if curStep == 256 then
    removeLuaSprite('jjstage1', true);
	removeLuaSprite('jjtable', true);
      
    makeLuaSprite('jjstage2', 'BGs/jjstage2', -1700, -400);
	setLuaSpriteScrollFactor('jjstage2', 1, 1);
	scaleObject('jjstage2', 1, 1);
	setObjectOrder('jjstage2', 0)
    addLuaSprite('jjstage2', false);

   end

	if curStep == 300 then
		setObjectOrder('gfGroup', getObjectOrder('dadGroup')+1)
   end
end