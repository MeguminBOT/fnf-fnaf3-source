local customCamZoom = true
local zoomValue = 0.8

function onCreate()
	if not customCamZoom then
        return
    end
end

function onUpdate()
    setProperty('defaultCamZoom', zoomValue)
end

function onStepHit()
	if curStep >= 0 and curStep <= 9999 then
        zoomValue = mustHitSection and 0.8 or 1
    end
end