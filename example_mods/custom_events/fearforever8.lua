function onEvent(name, value1, value2)
    if name == 'fearforever8' then
        removeLuaSprite('mangle', true); 

        makeLuaSprite('puppet', 'BGs/puppet', -471, -319)
        setObjectOrder('puppet', 1)
        scaleObject('puppet', 1.2, 1.2)
        setScrollFactor('puppet', 0, 0)
        addLuaSprite('puppet', true)
        setProperty('puppet.alpha', 0);
        setObjectOrder('puppet', 1)
        --200
        
        makeLuaSprite('puppet2', 'BGs/puppet2', -380, 1200)
        setObjectOrder('puppet2', 2)
        scaleObject('puppet2', 0.7, 0.7)
        setScrollFactor('puppet2', 0.8, 0.8)
        addLuaSprite('puppet2', true)
        --150
        makeAnimatedLuaSprite('starstring', 'BGs/starstring', 206, -550)
        setObjectCamera('starstring', 'camOther')
        setObjectOrder('starstring', 2)
        scaleObject('starstring', 0.8, 0.8)
        setScrollFactor('starstring', 0.8, 0.8)
        addAnimationByPrefix('starstring', 'anim', 'idle0', 12, true)
        playAnim('starstring', 'anim', true)
        addLuaSprite('starstring', true)
        --150
        makeAnimatedLuaSprite('starstring2', 'BGs/starstring', 873, -550)
        setObjectCamera('starstring2', 'camOther')
        setObjectOrder('starstring2', 2)
        scaleObject('starstring2', 0.8, 0.8)
        setScrollFactor('starstring2', 1.2, 0.8)
        addAnimationByPrefix('starstring2', 'anim', 'idle0', 12, true)
        playAnim('starstring2', 'anim', true)
        addLuaSprite('starstring2', true)
        addLuaSprite('black', true)
     end
 end