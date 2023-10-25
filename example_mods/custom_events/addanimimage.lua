local epilepsySafetyOne = {
    'static',
    'static2'
}

local epilepsySafetyTwo = {
    'static',
    'static2'
}

local epilepsySafetyThree = {
    'static',
    'static2',
    'chica',
    'foxyjump',
    'foxyjumpscare',
    'mangle',
    'phfreddyjump',
    'phfreddyjumpscare',
    'phfreddyjumpscare2'
}

function onEvent(name, value1, value2)
    if name == 'addanimimage' then
        if epilepsy and epilepsyLevel == 'One' and table.contains(epilepsySafetyOne, value1) then
            return;
        elseif epilepsy and epilepsyLevel == 'Two' and table.contains(epilepsySafetyTwo, value1) then
            return;
        elseif epilepsy and epilepsyLevel == 'Three' and table.contains(epilepsySafetyThree, value1) then
            return;
        else
            if songName == "fear-forever" or "Fear Forever" then
                setProperty(value1 .. '.alpha', 1)
                setProperty(value1 .. '.visible', true)
                if value1 ~= 'chicajump' then -- Ignores chicajump as it's a loop intended to continuously play.
                    playAnim(value1, 'idle', true)
                end
            else
                makeAnimatedLuaSprite(value1, value1, 0, 0)
                setObjectCamera(value1, 'camHUD')
                addLuaSprite(value1, true);
                addAnimationByPrefix(value1, value1, 'idle', 24, true)
            end
        end
    end
end