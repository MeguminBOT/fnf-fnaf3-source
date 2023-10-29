local epilepsySafetyOne = {
	'static',
	'static2'
}

local epilepsySafetyTwo = {
	'static',
	'static2'
}

local epilepsySafetyThree = {
	'static',
	'static2',
	'chica',
	'foxyjump',
	'foxyjumpscare',
	'mangle',
	'phfreddyjump',
	'phfreddyjumpscare',
	'phfreddyjumpscare2'
}

local songNames = {
	'taken-apart',
	'Taken Apart',
	'fear-forever',
	'Fear Forever'
}

local songFound = false

function onEvent(name, value1, value2)
	if name == 'addanimimage' then
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
					if value1 ~= 'chicajump' then -- Ignores chicajump as it's a loop intended to continuously play.
						playAnim(value1, 'idle', true)
					end
					songFound = true
					break
				end
			end
			if not songFound then
				makeAnimatedLuaSprite(value1, value1, 0, 0)
				setObjectCamera(value1, 'camHUD')
				addLuaSprite(value1, true)
				addAnimationByPrefix(value1, value1, 'idle', 24, true)
			end
		end
	end
end