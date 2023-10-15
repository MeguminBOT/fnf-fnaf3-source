local camzoom = true
function onUpdate()
if camzoom then
	if mustHitSection then
		setProperty('defaultCamZoom', 0.6)
	else
		setProperty('defaultCamZoom', 0.8)
	end
end
if curStep == 256 then
	function onUpdate()
	if camzoom then
		if mustHitSection then
			setProperty('defaultCamZoom', 0.6)
		else
			setProperty('defaultCamZoom', 0.6)
		end
end
end
end
end