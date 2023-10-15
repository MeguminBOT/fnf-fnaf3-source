function onEvent(name, value1, value2)
    if name == 'addimage' then
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