local customCamZoom = true
local zoomValue = 0.8 -- Default zoom value

function onCreate()
	if not customCamZoom then
        return
    end
end

function onUpdate()
    if not customCamZoom then
        return
    end

    setProperty('defaultCamZoom', zoomValue)
end

function onStepHit()
    if not customCamZoom then
        return
    end

	if curStep >= 0 and curStep <= 832 then
        zoomValue = mustHitSection and 0.8 or 1.2
    elseif curStep >= 832 and curStep <= 1344 then
        zoomValue = mustHitSection and 2 or 2.4
    elseif curStep >= 1376 and curStep <= 2768 then
        zoomValue = mustHitSection and 0.6 or 0.8
    elseif curStep >= 2768 and curStep <= 3280 then
        zoomValue = mustHitSection and 1.2 or 0.9
    elseif curStep >= 3280 and curStep <= 3792 then
        zoomValue = 1
    elseif curStep >= 3792 and curStep <= 4576 then
        zoomValue = mustHitSection and 0.4 or 0.8
    end
end

-- function onSectionHit()
-- 	zoomDebug = getProperty('defaultCamZoom')
-- 	sectionDebug = tostring(mustHitSection)
-- 	debugPrint(" Camera zoom: " .. zoomDebug .. " | Must hit section: " .. sectionDebug)
-- end