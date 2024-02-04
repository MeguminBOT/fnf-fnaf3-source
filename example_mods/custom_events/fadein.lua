function onEvent(name, value1, value2)
    if name == 'fadein' then
        doTweenAlpha(value1, value1, 1, value2, true)
    end
end