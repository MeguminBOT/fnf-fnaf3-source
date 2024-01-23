function onCreate()

	makeAnimatedLuaSprite('minigamestart', 'BGs/minigamestart', -1450, -400)
	scaleObject('minigamestart', 1.8, 1.8)
	addAnimationByPrefix('minigamestart', 'anim', 'idle0', 24, true)
	playAnim('minigamestart', 'anim', true)
    makeLuaSprite('red','red', 0, 0);
	setObjectCamera('red', 'hud')
	makeLuaSprite('white','white', -5000, -5000);
	setLuaSpriteScrollFactor('white', 0, 0);
	scaleObject('white', 20, 20);
	makeLuaSprite('black','black', -5000, -5000);
	setLuaSpriteScrollFactor('black', 0, 0);
	scaleObject('black', 20, 20);
    makeAnimatedLuaSprite('static','static', 0, 0);
    setObjectCamera('static', 'hud')
    addAnimationByPrefix('static','static','idle',24,true);

	addLuaSprite('minigamestart', true)
    addLuaSprite('static', true);
    addLuaSprite('red', true);
	addLuaSprite('white', true);
    addLuaSprite('black', true);
	setProperty('red.alpha', 0);
	setProperty('white.alpha', 0);
    setProperty('black.alpha', 0);
    setProperty('static.alpha', 0);
    end

    function onStepHit()

        if curStep == 64 then
            removeLuaSprite('minigamestart', true)
end
end