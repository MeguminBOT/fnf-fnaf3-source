function onEvent(name, value1, value2)
	if name == 'sub' then
		if value1 == nil or value1 == '' then
			setTextString('text', '')
			setProperty('text.alpha', 0)
			setProperty('textBG.alpha', 0)
		else
			setProperty('textBG.alpha', 0.5)
			setProperty('text.alpha', 1)
			setTextString('text', value1)
			setTextColor('text', value2)
		end
	end
end