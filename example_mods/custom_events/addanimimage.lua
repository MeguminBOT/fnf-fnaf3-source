function onEvent(name, value1, value2)
    if name == 'addanimimage' then
        makeAnimatedLuaSprite( value1, value1, 0, 0);
        setObjectCamera( value1, 'hud')
        addLuaSprite( value1, true);

        addAnimationByPrefix( value1, value1,'idle',24,true);
     
     end
 end