local mangle = false;

function onUpdate()

    mangleStartX = getProperty('mangleMech.x');
    mangleEndX = getProperty('mangleMech.x') + 691;
    mangleStartY = getProperty('mangleMech.y');
    mangleEndY = getProperty('mangleMech.y') + 742;

    if mangle and mouseClicked('left') and getMouseX('other') >= mangleStartX and getMouseX('other') <= mangleEndX and getMouseY('other') >= mangleStartY and getMouseY('other') <= mangleEndY then 
        mangle = false;
        stopSound('garble');
        objectPlayAnimation('mangleMech', 'out', true);
    end
end
function onCreate()
    makeAnimatedLuaSprite('mangleMech', 'Mechanics/mangle', 400, -200);
    setObjectCamera('mangleMech', 'hud')
    scaleObject('mangleMech', 1, 1);
    addLuaSprite('mangleMech', true);

    addAnimationByPrefix('mangleMech','idle','idle',24,true);
    addAnimationByPrefix('mangleMech','none','none',24,true);
    addAnimationByPrefix('mangleMech','in','in',24,false);
    addAnimationByPrefix('mangleMech','out','out',24,false);
    objectPlayAnimation('mangleMech', 'none', true);
end
function onEvent(name, value1, value2)
    if name == 'mangle' then
        mangle = true;
        runTimer('mangleidle', 1, 1);
        objectPlayAnimation('mangleMech', 'in', true);
        playSound('garble', 0.7, 'garble', true);
     end
 end

 function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'mangleidle' then
        objectPlayAnimation('mangleMech', 'idle', true);
end
end