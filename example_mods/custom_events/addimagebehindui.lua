function onEvent(name, value1, value2)
    if name ==  'addimagebehindui' then
        makeLuaSprite( value1, value1, -500, -500);
        setLuaSpriteScrollFactor( value1, 0, 0);
        scaleObject( value1, 10, 10);
        addLuaSprite( value1, true);
     
     end
 end