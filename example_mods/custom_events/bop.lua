-- made by kludge_

local on = 0
local camin = 0.025
local hudin = 0.025

function onEvent(name, value1, value2)
    if name == 'bop' then
        if value1 == '' then
            camin = 0.025
        else
            camin = tonumber(value1); -- idk if 'tonumber' is necessary :|
        end
        if value2 == '' then
            hudin = 0.025
        else
            hudin = tonumber(value2);
        end
        if on == 0 then
            on = 1;
        else
            on = 0;
        end
    end
end

function onBeatHit()
    if on == 1 then
        triggerEvent('Add Camera Zoom',camin,hudin);
    end
end