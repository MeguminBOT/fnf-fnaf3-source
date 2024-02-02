-- Simple event to toggle subtitles on and off. //Lulu

function onEvent(name, value1, value2)
	if name == 'Toggle Subtitles' then
		if value1 == nil or value1 == '' or value1 == ' ' then
			setTextString('Text', '')
			setProperty('TextBG.alpha', 0)
		else
			setProperty('TextBG.alpha', 0.5)
			setProperty('Text.alpha', 1)
			setTextString('Text', value1)
			setTextColor('Text', value2)
		end
	end
end