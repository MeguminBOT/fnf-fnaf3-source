function onEvent(name, value1, value2)
    if name == 'fearforever6' then
        setProperty('dad.x', 600);
        setProperty('dad.y', 300);
        setProperty('boyfriend.x', 2000);
        setProperty('boyfriend.y', 350);
        removeLuaSprite('chica', true);
        removeLuaSprite('coffee', true);
        removeLuaSprite('star', true); 
        removeLuaSprite('present', true);
        removeLuaSprite('static3', true);

        makeLuaSprite('bb', 'BGs/bb', -1253, -502)
        setObjectOrder('bb', 0)
        scaleObject('bb', 0.8, 0.8)
        addLuaSprite('bb', true)
        setObjectOrder('bb', 1)
        
        makeLuaSprite('gate', 'Props/gate', 1272, 475)
        scaleObject('gate', 0.8, 0.8)
        setScrollFactor('gate', 1.3, 1.3)
        addLuaSprite('gate', true)
        
        makeLuaSprite('table', 'Props/table', -1500, 500)
        scaleObject('table', 1.5, 1.5)
        setScrollFactor('table', 1.3, 1.3)
        addLuaSprite('table', true)
        addLuaSprite('black', true)

        makeAnimatedLuaSprite('greenstatic', 'BGs/greenstatic', -168, -100)
        scaleObject('greenstatic', 1.4, 1.4)
        setScrollFactor('greenstatic', 0, 0)
        addAnimationByPrefix('greenstatic', 'anim', 'idle0', 24, true)
        playAnim('greenstatic', 'anim', true)
        addLuaSprite('greenstatic', false)
     end
 end