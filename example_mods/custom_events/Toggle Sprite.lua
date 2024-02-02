-- Simple event to toggle sprites on and off. //Lulu

local epilepsySafetyOne = {
	'whiteui',
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

function onEvent(name, value1, value2)
	if name == 'Toggle Sprite' then
		if epilepsy and epilepsyLevel == 'One' and table.contains(epilepsySafetyOne, value1) then
			return;

		elseif epilepsy and epilepsyLevel == 'Two' and table.contains(epilepsySafetyTwo, value1) then
			return;

		elseif epilepsy and epilepsyLevel == 'Three' and table.contains(epilepsySafetyThree, value1) then
			return;

		elseif not epilepsy and value2 == 'on' then
			setProperty(value1 .. '.alpha', 1)
			setProperty(value1 .. '.visible', true)

		elseif not epilepsy and value2 == 'off' then
			setProperty(value1 .. '.alpha', 0)
			if not songName == "fear-forever" or "Fear Forever" then
				setProperty(value1 .. '.visible', false)
			end
		end
	end
end