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
	if curStep >= 0 and curStep <= 639 then
        zoomValue = mustHitSection and 0.6 or 0.9
    elseif curStep >= 640 and curStep <= 1023 then
        zoomValue = 0.7
    elseif curStep >= 1024 and curStep <= 1279 then
        zoomValue = mustHitSection and 0.7 or 0.9
    elseif curStep >= 1280 and curStep <= 1539 then
        zoomValue = 0.7
    elseif curStep >= 1540 and curStep <= 1823 then
        zoomValue = 1
    elseif curStep >= 1824 and curStep <= 1951 then
        zoomValue = mustHitSection and 0.7 or 0.9
	elseif curStep >= 1952 and curStep <= 2335 then
        zoomValue = mustHitSection and 1.2 or 0.8
	elseif curStep >= 2336 and curStep <= 3359 then
        zoomValue = 0.8
	elseif curStep >= 3360 and curStep <= 3759 then
        zoomValue = mustHitSection and 0.7 or 0.9 -- May be be 0.6 and 1.3? Had duplicated steps with different values
	elseif curStep >= 3760 and curStep <= 4159 then
        zoomValue = mustHitSection and 0.7 or 0.8 -- Looks weird when only set to 0.7, added .1 zoom on opponent as suggestion //Remove if desired.
	elseif curStep >= 4160 and curStep <= 4287 then
        zoomValue = mustHitSection and 1 or 1.5 -- Zoom seems to be a bit excessive? Removed .2 zoom on both sides as suggestion //Remove if desired.
	elseif curStep >= 4288 then
        zoomValue = mustHitSection and 0.8 or 1.2 -- Zoom seems to be a very excessive? Puppet's face not visible on BF parts, Removed .3 zoom on opponent and removed .4 on player as suggestion //Remove if desired.
    end
end

-- function onSectionHit()
-- 	zoomDebug = getProperty('defaultCamZoom')
-- 	sectionDebug = tostring(mustHitSection)
-- 	debugPrint(" Camera zoom: " .. zoomDebug .. " | Must hit section: " .. sectionDebug)
-- end