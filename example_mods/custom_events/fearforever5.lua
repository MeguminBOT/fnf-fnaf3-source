function onEvent(name, value1, value2)
    if name == 'fearforever5' then
        removeLuaSprite('foxychase', true);
        removeLuaSprite('foxysfeet', true);
        removeLuaSprite('bfeet', true); 
        removeLuaSprite('foxyjumping', true); 
        removeLuaSprite('bfeetblue', true); 
        makeAnimatedLuaSprite('static3', 'static', 200, 200)
        setObjectOrder('static3', 2)
        scaleObject('static3', 0.4, 0.4)
        setScrollFactor('static3', 1, 1)
        addAnimationByPrefix('static3', 'anim', 'idle0', 24, true)
        playAnim('static3', 'anim', true)
        addLuaSprite('static3', true)
        makeLuaSprite('chica', 'BGs/chica', -1400, -600)
        scaleObject('chica', 1, 1)
        addLuaSprite('chica', false)
        setObjectOrder('chica', 3)
        setProperty('bfPhantom.alpha', 0)
        setProperty('dadPhantom.alpha', 0)
        setProperty('gfPhantom.alpha', 0)
        setObjectOrder('dadGroup', 1);
        setObjectOrder('boyfriendGroup', 5);
        makeLuaSprite('coffee', 'Props/coffee', -900, 30)
        scaleObject('coffee', 2, 2)
        setScrollFactor('coffee', 1.3, 1.3)
        addLuaSprite('coffee', true)
        
        makeLuaSprite('star', 'Props/star', -600, -763)
        scaleObject('star', 1.6, 1.6)
        setScrollFactor('star', 1.6, 1.1)
        addLuaSprite('star', true)
        
        makeLuaSprite('present', 'Props/present', 1400, 371)
        scaleObject('present', 1.6, 1.6)
        setScrollFactor('present', 1.3, 1.3)
        addLuaSprite('present', true)
        
        setProperty('dad.x', -135);
        setProperty('dad.y', -50);
        setProperty('boyfriend.x', 1000);
        setProperty('boyfriend.y', 500);
        addLuaSprite('black', true)
    end
end
