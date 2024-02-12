function opponentNoteHit()
	local curHealth = getProperty('health')
	local healthThreshold = 0.75
	local healthDecrease = 0.017

	if curHealth > healthThreshold then
		setProperty('health', curHealth - healthDecrease)
	end
end