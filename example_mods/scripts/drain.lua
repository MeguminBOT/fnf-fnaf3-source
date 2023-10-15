function opponentNoteHit()
	local curHealth = getProperty('health')
	local healthThreshold = 0.4
	local healthDecrease = 0.02

	if curHealth > healthThreshold then
		setProperty('health', curHealth - healthDecrease)
	end
end