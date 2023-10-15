function opponentNoteHit()
	if getProperty('dad.curCharacter') == 'ycr' or getProperty('dad.curCharacter') == 'phantoms' then
		cameraShake('camGame', 0.005, 0.1)
		cameraShake('camHUD', 0.003, 0.1)
	end
end