function onEvent(name, value1, value2)
	if name == 'removesub' then
		setTextString('text', '')
		setProperty('textbackground.alpha', 0);
	end
end