function onEvent(name, value1, value2)
    if name == 'fearforever9' then
        removeLuaSprite('puppet', true);
        removeLuaSprite('puppet2', true);
        removeLuaSprite('starstring', true); 
        removeLuaSprite('starstring2', true); 

        makeAnimatedLuaSprite('phantoms', 'BGs/phantoms', -168, -100)
        setObjectOrder('phantoms', 0)
        scaleObject('phantoms', 1.4, 1.4)
        setScrollFactor('phantoms', 0, 0)
        addAnimationByPrefix('phantoms', 'anim', 'idle0', 24, true)
        playAnim('phantoms', 'anim', true)
        addLuaSprite('phantoms', true)
        setObjectOrder('phantoms', 1)
     end
 end