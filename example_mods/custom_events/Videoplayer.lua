function onEvent(name, value1, value2)
    if name == 'Videoplayer' then
        setProperty('inCutscene', false)
        startVideo(value1)
        setProperty('inCutscene', false) -- Setting a second time JUST TO MAKE SURE
    end
    return Function_Continue;
end
