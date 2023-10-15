function onEvent(name, value1, value2)
    if name == 'addimagebehindui' then
        if songName == "fear-forever" or "Fear Forever" then
            setProperty(value1 .. '.alpha', 1)
            setProperty(value1 .. '.visible', true)
        else
            makeLuaSprite(value1, value1, -500, -500)
            setLuaSpriteScrollFactor(value1, 0, 0)
            scaleObject(value1, 10, 10)
            addLuaSprite(value1, true)
        end
    end
end