local customCamZoom = true
local zoomValue = 1 -- Default zoom value

function onCreate()
	if not customCamZoom then
        return
    end
end

function onUpdate()
    setProperty('defaultCamZoom', zoomValue)
end

function onStepHit()
	if curStep >= 0 and curStep <= 511 then
        zoomValue = 1
    elseif curStep >= 512 and curStep <= 1215 then
		zoomValue = mustHitSection and 1 or 1.2
    elseif curStep >= 1216 and curStep <= 1695 then
        zoomValue = 1
    elseif curStep >= 1696 and curStep <= 2223 then
        zoomValue = mustHitSection and 1 or 1.2
    elseif curStep >= 2224 and curStep <= 2751 then
        zoomValue = 1
    elseif curStep >= 2752 and curStep <= 3423 then
        zoomValue = mustHitSection and 1 or 1.2
	elseif curStep >= 3424 and curStep <= 4319 then
        zoomValue = 1
	elseif curStep >= 4320 and curStep <= 5759 then
        zoomValue = mustHitSection and 1 or 1.2
	elseif curStep >= 5760 then
        zoomValue = 1
	end
end

-- function onSectionHit()
-- 	zoomDebug = getProperty('defaultCamZoom')
-- 	sectionDebug = tostring(mustHitSection)
-- 	debugPrint(" Camera zoom: " .. zoomDebug .. " | Must hit section: " .. sectionDebug)
-- end