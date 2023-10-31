local customCamZoom = true
local zoomValue = 0.9 -- Default zoom value, should be the same as the stage.json.

function onCreate()
	if not customCamZoom then
        return
    end
end

function onUpdate()
    setProperty('defaultCamZoom', zoomValue)
end

function onStepHit()

    -- Within what range to apply camera zoom values
	if curStep >= 0 and curStep <= 1 then -- First curstep is the starting point, the second is the ending point.
        zoomValue = mustHitSection and 0.6 or 0.9 -- First zoom value is BF zoom, second value is Dad zoom.

    elseif curStep >= 2 and curStep <= 3 then
        zoomValue = 0.5 -- Both sides sharing the same value.

    elseif curStep >= 4 and curStep <= 5 then
        zoomValue = mustHitSection and 0.6 or 0.9

    -- Set as many curstep ranges as needed.
    end
end

-- function onSectionHit()
-- 	zoomDebug = getProperty('defaultCamZoom')
-- 	sectionDebug = tostring(mustHitSection)
-- 	debugPrint(" Camera zoom: " .. zoomDebug .. " | Must hit section: " .. sectionDebug)
-- end