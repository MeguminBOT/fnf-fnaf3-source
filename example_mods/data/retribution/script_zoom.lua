local customCamZoom = true
local zoomValue = 0.8 -- Default zoom value, should be the same as the stage.json.

function onCreate()
	if not customCamZoom then
        return
    end
end

function onUpdate()
    setProperty('defaultCamZoom', zoomValue)
end

function onStepHit()
	if curStep >= 0 and curStep <= 399 then
        zoomValue = 0.8

    elseif curStep >= 400 and curStep <= 1695 then
        zoomValue = mustHitSection and 0.6 or 1.0

    elseif curStep >= 1696 and curStep <= 1951 then
        zoomValue = 1.0

    elseif curStep >= 1952 then
        zoomValue = mustHitSection and 0.5 or 1
    end
end

-- function onSectionHit()
-- 	zoomDebug = getProperty('defaultCamZoom')
-- 	sectionDebug = tostring(mustHitSection)
-- 	debugPrint(" Camera zoom: " .. zoomDebug .. " | Must hit section: " .. sectionDebug)
-- end