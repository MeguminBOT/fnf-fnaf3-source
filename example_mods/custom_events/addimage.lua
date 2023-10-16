local epilepsySafetyOne = {

}

local epilepsySafetyTwo = {
    'white',
    'red',
    'purple',
    'bb',
    'mangleinvert',
    'phfreddyjumpinverted',
}

local epilepsySafetyThree = {
    'white',
    'red',
    'purple',
    'bb',
    'chica',
    'leanjump',
    'leanjump2',
    'mangleinvert',
    'phfreddyjumpinverted',
}


function onEvent(name, value1, value2)
    if name == 'addimage' then
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
            else
                makeLuaSprite(value1, value1, 0, 0);
                setObjectCamera(value1, 'camHUD')
                addLuaSprite(value1, true);
            end
        end
    end
end