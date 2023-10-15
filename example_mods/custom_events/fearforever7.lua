function onEvent(name, value1, value2)
    if name == 'fearforever7' then
        removeLuaSprite('bb', true);
        removeLuaSprite('gate', true);
        removeLuaSprite('table', true); 
        removeLuaSprite('greenstatic', true); 
        setObjectOrder('dadGroup', 3);
        setObjectOrder('gfGroup', 4);
        setObjectOrder('boyfriendGroup', 5);
        makeLuaSprite('mangle', 'BGs/mangle', -1200, -602)
        setObjectOrder('mangle', 2)
        scaleObject('mangle', 1, 1)
        addLuaSprite('mangle', true)
        addLuaSprite('black', true)
        setProperty('bfPhantom.alpha', 0)
        setProperty('dadPhantom.alpha', 0)
        setProperty('gfPhantom.alpha', 0)
        setObjectOrder('dadPhantom', 0)
     end
 end