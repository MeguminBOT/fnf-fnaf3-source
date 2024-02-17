-- Made by kludge_
-- Refactored/Optimized by AutisticLulu

local on = false
local camin = 0.025
local hudin = 0.025

function onEvent(name, value1, value2)
    if name == 'bop' then
        camin = tonumber(value1) or 0.025
        hudin = tonumber(value2) or 0.025
        on = not on
    end
end

function onBeatHit()
    if on then
        triggerEvent('Add Camera Zoom', camin, hudin)
    end
end
