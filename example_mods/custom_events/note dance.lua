-- Refactored / Optimized by AutisticLulu

songPos = getSongPosition()

function onUpdate(elapsed)
	local currentBeat = (songPos / 5000) * (curBpm / 60)
	local currentBeat2 = (songPos / 200) * (curBpm / 200)
	local camFollowPosX = getProperty('camFollowPos.x')
	local camFollowPosY = getProperty('camFollowPos.y')

	setProperty('camFollowPos.x', camFollowPosX + (math.sin(currentBeat2) * 0.2))
	setProperty('camFollowPos.y', camFollowPosY + (math.cos(currentBeat2) * 0.2))

	for i = 4, 7 do
		noteTweenX(defaultPlayerStrumX[i], i, defaultPlayerStrumX[i] - 100 * math.cos((currentBeat2 * 0.25) * math.pi), 0.5)
	end
end