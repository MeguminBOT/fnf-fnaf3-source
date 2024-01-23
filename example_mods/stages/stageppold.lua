function onCreate()
	precacheImage('characters/paperbb');
	precacheImage('characters/paperbonnie');
	makeLuaSprite('ppstage', 'BGs/ppstage', -2000, -550);
	setLuaSpriteScrollFactor('ppstage', 1, 1);
	scaleObject('ppstage', 1.07, 1.07);
	addLuaSprite('ppstage', false);

	makeLuaSprite('ppstage2', 'BGs/ppstage2', -750, 550);
	setLuaSpriteScrollFactor('ppstage2', 1, 1);
	scaleObject('ppstage2', 0.9, 0.9);
	addLuaSprite('ppstage2', true);

end

function onStepHit()
	if curStep == 695 then
		makeAnimatedLuaSprite('bonnieanim', 'characters/paperbonnie', -515, 240);
		setLuaSpriteScrollFactor('bonnieanim', 1, 1);
		scaleObject('bonnieanim', 1, 1);
		addAnimationByPrefix('bonnieanim','bonnieanim','enter',24,true);
		addLuaSprite('bonnieanim', false);

   end 

   if curStep == 720 then
	removeLuaSprite('bonnieanim', true);

end 

   if curStep == 1473 then
	removeLuaSprite('ppstage2', true);
	makeLuaSprite('ppstage3', 'BGs/ppstage3', -750, 550);
	setLuaSpriteScrollFactor('ppstage3', 1, 1);
	scaleObject('ppstage3', 0.9, 0.9);
	addLuaSprite('ppstage3', true);
makeAnimatedLuaSprite('bbanim', 'characters/paperbb', -700, 200);
setLuaSpriteScrollFactor('bbanim', 1, 1);
scaleObject('bbanim', 1, 1);
addAnimationByPrefix('bbanim','bbanim','enter',24,true);
addLuaSprite('bbanim', false);


end 

if curStep == 1504 then
	removeLuaSprite('bbanim', true);

end 

end