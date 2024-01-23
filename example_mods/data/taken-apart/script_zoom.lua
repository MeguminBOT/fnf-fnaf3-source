local customCamZoom = true
local zoomValue = 0.9 -- Default zoom value

function onCreate()
	if not customCamZoom then
        return
    end
end

function onUpdate()
    setProperty('defaultCamZoom', zoomValue)
end

function onStepHit()
	if curStep >= 0 and curStep <= 815 then
        zoomValue = mustHitSection and 0.6 or 0.9
    elseif curStep >= 816 and curStep <= 943 then
        zoomValue = 0.5
    elseif curStep >= 944 and curStep <= 1599 then
        zoomValue = mustHitSection and 0.6 or 0.9
    elseif curStep >= 1600 and curStep <= 1695 then
        zoomValue = 0.5
    elseif curStep >= 1696 and curStep <= 2431 then
        zoomValue = mustHitSection and 0.6 or 0.9
    elseif curStep >= 2432 and curStep <= 2608 then
        zoomValue = 0.5
    elseif curStep >= 2608 and curStep <= 3680 then
        zoomValue = mustHitSection and 0.6 or 0.9
    end
end

-- function onSectionHit()
-- 	zoomDebug = getProperty('defaultCamZoom')
-- 	sectionDebug = tostring(mustHitSection)
-- 	debugPrint(" Camera zoom: " .. zoomDebug .. " | Must hit section: " .. sectionDebug)
-- end