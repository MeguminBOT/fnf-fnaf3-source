local epilepsySafetyOne = {

}

local epilepsySafetyTwo = {
	'white',
	'red',
	'purple',
	'bb',
	'mangleinvert',
	'phfreddyjumpinverted',
}

local epilepsySafetyThree = {
	'white',
	'red',
	'purple',
	'bb',
	'chica',
	'leanjump',
	'leanjump2',
	'mangleinvert',
	'phfreddyjumpinverted',
}

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
	if name == 'addimage' then
		if epilepsy and epilepsyLevel == 'One' and table.contains(epilepsySafetyOne, value1) then
			return;
		elseif epilepsy and epilepsyLevel == 'Two' and table.contains(epilepsySafetyTwo, value1) then
			return;
		elseif epilepsy and epilepsyLevel == 'Three' and table.contains(epilepsySafetyThree, value1) then
			return;
		else
			for _, name in ipairs(songNames) do
				if songName == name then
					setProperty(value1 .. '.alpha', 1)
					setProperty(value1 .. '.visible', true)
					songFound = true
					break
				end
			end
			if not songFound then
				makeLuaSprite(value1, value1, 0, 0)
				setObjectCamera(value1, 'camHUD')
				addLuaSprite(value1, true)
			end
		end
	end
end