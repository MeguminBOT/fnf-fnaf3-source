function onCreate()
	makeLuaSprite('black','black', 0, 0);
	setObjectCamera('black', 'hud')
	addLuaSprite('black', true);
	makeLuaSprite('white','white', -500, -500);
	setLuaSpriteScrollFactor('white', 0, 0);
	scaleObject('white', 10, 10);
	addLuaSprite('white', true);
	setProperty('white.alpha', 0)
	makeLuaSprite('endobg', 'BGs/endobg', -2200, -900)
	setObjectOrder('endobg', 0)
	addLuaSprite('endobg', true)
	scaleObject('endobg', 1.3, 1.3);
	makeLuaSprite('mimic', 'mimic', -300, -100)
	setObjectOrder('mimic', 2)
	addLuaSprite('mimic', true)
	scaleObject('mimic', 1.1, 1.1);
	setProperty('mimic.alpha', 0)
end