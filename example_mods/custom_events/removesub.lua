
function onEvent(name, value1, value2)
	if name == 'removesub' then
		if value1 == 'fade' then
			doTweenAlpha('text', 'text', 0, value2, true)
			doTweenAlpha('textBG', 'textBG', 0, value2, true)
		else
			setTextString('text', '')
			setProperty('textBG.alpha', 0)
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'text' or tag == 'textBG' then
		setTextString('text', '')
		setProperty('textBG.alpha', 0)
	end
end
