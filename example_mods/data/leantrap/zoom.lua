local camzoom = true
function onUpdate()
if camzoom then
	if mustHitSection then
		setProperty('defaultCamZoom', 0.9)
	else
		setProperty('defaultCamZoom', 0.7)
	end
end
end
