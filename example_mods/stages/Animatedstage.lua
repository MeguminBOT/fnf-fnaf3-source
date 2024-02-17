function onCreate()
	makeAnimatedLuaSprite('foreground','foreground', 0, 0);
    setObjectCamera('foreground', 'hud')
    addAnimationByPrefix('foreground','foreground','idle',24,true);
	
	makeAnimatedLuaSprite('blobstage','blobstage', 0, 0);
    addAnimationByPrefix('blobstage','blobstage','idle',24,true);
	scaleObject('blobstage', 1, 1);
	doTweenAlpha('blobstage','blobstage', 0, 0.01, true);

	makeLuaSprite('blobstage2', 'blobstage2', 0, 0);
	setScrollFactor('blobstage2', 1, 1);
	scaleObject('blobstage2', 1, 1);
	makeLuaSprite('black','black', 0, 0);
    setObjectCamera('black', 'hud')

	addLuaSprite('blobstage', false);
	addLuaSprite('blobstage2', true);
	addLuaSprite('black', true);
	addLuaSprite('foreground', true);

end