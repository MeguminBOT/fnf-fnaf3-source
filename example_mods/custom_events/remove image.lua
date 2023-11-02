local songNames = {
	'taken-apart',
	'Taken Apart',
	'Retribution',
	'retribution',
	'fear-forever',
	'Fear Forever'
}

local songFound = false

function onEvent(name, value1, value2)
	if name == "remove image" then
		if songName == "fear-forever" or "Fear Forever" then
			setProperty(value1 .. '.alpha', 0)
		else
			for _, name in ipairs(songNames) do
				if songName == name then
					setProperty(value1 .. '.alpha', 0)
					setProperty(value1 .. '.visible', false)
					songFound = true
					break
				end
			end
		end

		if not songFound then
			removeLuaSprite(value1)
		end
	end
end