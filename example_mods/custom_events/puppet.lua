function onCreate()
    if middlescroll then
        makeAnimatedLuaSprite('phpuppet', 'mechanics/phpuppet', 85, 1000)
    else
        makeAnimatedLuaSprite('phpuppet', 'mechanics/phpuppet', 430, 1000)
    end
    setObjectCamera('phpuppet', 'camHUD');
    scaleObject('phpuppet', 0.8, 0.8)
    addLuaSprite('phpuppet', true)
    addAnimationByPrefix('phpuppet', 'phpuppet', 'idle', 24, true)
end

function onEvent(name, value1, value2)
    if name == 'puppet' then
        doTweenY('comingup', 'phpuppet', 400, 5, 'cubeOut')
        runTimer('puppetgoaway', 10, 1)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'puppetgoaway' then
        doTweenY('goingdown', 'phpuppet', 1000, 5, 'cubeIn')
    end
end