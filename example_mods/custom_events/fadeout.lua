function onEvent(name, value1, value2)
    if name == 'fadeout' then
        doTweenAlpha( value1, value1, 0, value2, true);
     
     end
 end