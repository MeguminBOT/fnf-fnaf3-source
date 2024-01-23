function onEvent(name, value1, value2)
    if name == 'paper' then
        makeAnimatedLuaSprite('paper','paper', 0, 0);
        setObjectCamera('paper', 'hud')
        addLuaSprite('paper', true);
        addAnimationByPrefix('paper','paper','idle',24,true);
        runTimer('gonepap', 1, 1);
        setProperty('paper.alpha', 1);
    end
end
     function onTimerCompleted(tag, loops, loopsLeft)
        if tag == 'gonepap' then
            setProperty('paper.alpha', 0);
    end
end