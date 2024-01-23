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

function onEvent(name, value1, value2)
    if name == 'Toggle Anim Sprite' then
		if epilepsy and epilepsyLevel == 'One' and table.contains(epilepsySafetyOne, value1) then 
			return; 
		elseif epilepsy and epilepsyLevel == 'Two' and table.contains(epilepsySafetyTwo, value1) then 
			return; 
		elseif epilepsy and epilepsyLevel == 'Three' and table.contains(epilepsySafetyThree, value1) then 
			return;
        else
            if value2 == nil then
                setProperty(value1 .. '.alpha', 1)
                setProperty(value1 .. '.visible', true)
                if value1 ~= 'chicajump' then -- Ignores chicajump as it's a loop intended to continuously play.
                    playAnim(value1, value1, true)
                end
            else
                setProperty(value1 .. '.alpha', 1)
                setProperty(value1 .. '.visible', true)
                playAnim(value1, value2, true) 
            end
        end
    end
end