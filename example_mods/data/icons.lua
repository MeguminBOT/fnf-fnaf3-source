local camzoom = true
function onCreatePost()
    mfw = getProperty('iconP2.y')
    setProperty('iconP2.y', mfw - 15)
	
	setProperty('scoreBar.alpha',0.6)
	setProperty('healthBar.alpha',0.6)
	setProperty('healthBarBG.alpha',0.6)
end
function onUpdatePost()
    P1Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)
    P2Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)
    setProperty('iconP1.x',P1Mult - 90)
    setProperty('iconP1.origin.x',240)
    setProperty('iconP1.flipX',true)
    setProperty('iconP2.x',P2Mult + 90)
    setProperty('iconP2.origin.x',-100)
    setProperty('iconP2.flipX',true)
    setProperty('healthBar.flipX',true)
end

function onUpdate()
if camzoom then
	if mustHitSection then
		setProperty('defaultCamZoom', 0.7)
	else
		setProperty('defaultCamZoom', 1)
	end
end
end
