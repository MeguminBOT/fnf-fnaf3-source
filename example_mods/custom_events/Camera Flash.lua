--[[

>>> Camera Flash Event for Psych Engine with configurable camera and flash properties written by AutisticLulu.
>>> With additional stuff specifically for Vs FNAF 3. (If you gonna use this on regular Psych Engine, remove the following lines: 35, 36, 37 and 44.

* Supports all parameters for the cameraFlash function.
* Supports RGB input
* Only triggers if Flashing Lights are enabled.

Value 1:
	Camera [camGame/camHUD/camOther], forced? [true/false] 
	(Example: camGame, true)

Value 2:
	Colour [HEX], Duration [Seconds] 
	(Example: 9DCFED, 4) 

	Colour [RGB], Duration [Seconds] 
	(Example: 157, 207, 237, 4)

	If no duration value is specified, it defaults to 1 second.

]]

-- Define valid camera options.
local validCameras = {
	camGame = true,
	camHUD = true,
	camOther = true
}

-- This function is called when an event occurs.
function onEvent(name, value1, value2)
	if name == 'Camera Flash' or name == 'Camera_Flash' and flashingLights then
		if epilepsy then
			return
		else
			-- Parse the input fields for value1 and value2.
			local camera, isForced = parseCameraValue(value1)
			local colour, duration = parseFlashValue(value2)

			-- Call the cameraFlash function with the parsed values.
			cameraFlash(camera, colour, duration or 1, isForced)
		end
	end
end

-- Helper function: Parses the camera and forced value from the input string.
function parseCameraValue(value)
	-- Extract the camera and forced values from the input string.
	local camera, isForced = string.match(value:gsub(' ', ''), '(.*),(%a+)')

	-- If the camera value is valid, return the camera and forced values.
	if validCameras[camera] and isForced == 'true' then
		return camera, true

	elseif validCameras[camera] then
		return camera, false
	end
end

-- Helper function: Parses the colour and duration from the input string.
function parseFlashValue(value)
	-- Extract the colour and duration values from the input string.
	local colour, duration = string.match(value:gsub(' ', ''), '(.*),(.*)')
	local r, g, b = string.match(colour:gsub(' ', ''), '(%d+),(%d+),(%d+)')
	
	-- Check if the input colour is in RGB format.
	if r ~= nil and g ~= nil and b ~= nil then
		-- Convert RGB values to hexadecimal format.
		colour = rgbToHex(tonumber(r), tonumber(g), tonumber(b))
		return colour, tonumber(duration)
	else
		return colour, tonumber(duration)
	end
end

-- Helper function: Converts RGB color codes to hexadecimal.
function rgbToHex(r, g, b)
    -- Convert each RGB value to hexadecimal and concatenate them.
    local hexR = string.format('%02X', r)
    local hexG = string.format('%02X', g)
    local hexB = string.format('%02X', b)
    return hexR .. hexG .. hexB
end


--[[ Debug code for parseFlashValue

	local charIndex = string.find(colour, '[^0-9A-Fa-f]')
	-- If the colour value contains invalid characters, show a debug message.
	if colour:len() == 6 and charIndex ~= nil then
		debugPrint('Hex Colour value contains invalid character(s) at index: ' .. charIndex)
		debugPrint('Invalid HEX colour: ' .. colour)
		debugPrint("'Camera Flash' event error")

	-- If the colour value is too short or long, show a debug message.
	elseif colour:len() < 6 or colour:len() > 6 then
		debugPrint('Hex Colour value too short or long! Has: ' .. colour:len() .. ' | Want: 6')
		debugPrint('Invalid HEX colour: ' .. colour)
		debugPrint("'Camera Flash' event error") 
	end
]]
	