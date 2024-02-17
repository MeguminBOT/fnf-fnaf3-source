function onEvent(name, value1, value2)
	local time = tonumber(value1)
	local alpha = tonumber(value2)

	if name == 'OpponentNotesFade' then
		for i = 0, 3 do
			noteTweenAlpha(i + 16, i, time, alpha, 'QuadOut')
		end
	end
end
