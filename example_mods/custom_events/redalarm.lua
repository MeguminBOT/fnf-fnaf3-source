function onCreate()
    makeLuaSprite('errorred', "", 0, 0);
    makeGraphic('errorred', 1280, 720, 'ff0000');
    setObjectCamera('errorred', 'other');
    setProperty('errorred.alpha', 0);
    addLuaSprite('errorred', true);
end

function onEvent(name, value1, value2)
    if name == 'redalarm' then
        function onBeatHit()
            if curBeat % 2 == 0 then
                setProperty('errorred.alpha', value1);
            else
                setProperty('errorred.alpha', 0);
            end
        end
        end
     
     end