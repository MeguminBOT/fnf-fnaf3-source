function onEvent(name, value1, value2)
    if name == "remove image" then 
        if songName == "fear-forever" or "Fear Forever" then
            setProperty(value1 .. '.alpha', 0)
        else
            removeLuaSprite(value1)
        end
    end
end