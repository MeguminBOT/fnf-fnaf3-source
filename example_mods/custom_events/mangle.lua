local mangle = false;

function onUpdate()

    mangleStartX = getProperty('mangle.x');
    mangleEndX = getProperty('mangle.x') + 691;
    mangleStartY = getProperty('mangle.y');
    mangleEndY = getProperty('mangle.y') + 742;

    if mangle and mouseClicked('left') and getMouseX('other') >= mangleStartX and getMouseX('other') <= mangleEndX and getMouseY('other') >= mangleStartY and getMouseY('other') <= mangleEndY then 
        mangle = false;
        stopSound('garble');
        objectPlayAnimation('mangle', 'out', true);
    end
end
function onCreate()
    makeAnimatedLuaSprite('mangle','Mechanics/mangle', 400, -200);
    setObjectCamera('mangle', 'hud')
    scaleObject('mangle', 1, 1);
    addLuaSprite('mangle', true);

    addAnimationByPrefix('mangle','idle','idle',24,true);
    addAnimationByPrefix('mangle','none','none',24,true);
    addAnimationByPrefix('mangle','in','in',24,false);
    addAnimationByPrefix('mangle','out','out',24,false);
    objectPlayAnimation('mangle', 'none', true);
end
function onEvent(name, value1, value2)
    if name == 'mangle' then
        mangle = true;
        runTimer('mangleidle', 1, 1);
        objectPlayAnimation('mangle', 'in', true);
        playSound('garble', 0.7, 'garble', true);
     end
 end

 function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'mangleidle' then
        objectPlayAnimation('mangle', 'idle', true);
end
end