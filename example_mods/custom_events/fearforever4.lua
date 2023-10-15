function onEvent(name, value1, value2)
    if name == 'fearforever4' then
        removeLuaSprite('foxy2', true);
        removeLuaSprite('present', true);
        removeLuaSprite('box', true);
        
        makeAnimatedLuaSprite('foxychase','BGs/foxychase', 0, 0);
        addAnimationByPrefix('foxychase','foxychase','idle',24,true);
        scaleObject('foxychase', 1.3, 1.3);
        setObjectOrder('foxychase', 1)
    
        makeAnimatedLuaSprite('foxysfeet','Chars/foxysfeet', 270, 650);
        addAnimationByPrefix('foxysfeet','foxysfeet','idle',36,true);
        scaleObject('foxysfeet', 0.7, 0.7);
        setObjectOrder('foxysfeet', 2)

        makeAnimatedLuaSprite('bfeet','Chars/bfeet', 1430, 810);
        addAnimationByPrefix('bfeet','bfeet','idle',24,true);
        scaleObject('bfeet', 0.7, 0.7);
        setObjectOrder('bfeet', 3)
    


        setProperty('dad.x', 495);
        setProperty('dad.y', 155);
        setProperty('boyfriend.x', 1600);
        setProperty('boyfriend.y', 600);
    
        addLuaSprite('foxychase', false);
        addLuaSprite('foxysfeet', false);
        addLuaSprite('bfeet', false);
        makeAnimatedLuaSprite('foxyjumping', 'Chars/foxyjumping', 0, 150)
        setObjectOrder('foxyjumping', 5)
        scaleObject('foxyjumping', 1.4, 1.4)
        addAnimationByPrefix('foxyjumping', 'anim', 'idle0', 24, false)
        playAnim('foxyjumping', 'anim', true)
        addLuaSprite('foxyjumping', true)
        setProperty('foxyjumping.alpha', 0)
        addLuaSprite('black', true)
     end
 end