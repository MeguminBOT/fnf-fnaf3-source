function onEvent(name, value1, value2)
	if name == 'sub' then
		setProperty('textbackground.alpha', 0.5);
		setTextString('text', value1)
		setTextColor('text', value2)
	end
end

function onCreate()
	makeLuaSprite('textbackground', 'black', 0, 540);
	setObjectCamera('textbackground', 'other')
	scaleObject('textbackground', 1,0.1);
	setProperty('textbackground.alpha', 0);
	addLuaSprite('textbackground', true);
	makeLuaText('text', '', 1000, 135, 545);
	addLuaText('text');
	setTextSize('text',45);
	setTextFont('text', 'Stalker2.ttf');
	setObjectCamera('text', 'other')
end

function onUpdate()
	if value1 == 'empty' then
		setTextString('text', '')
		setProperty('textbackground.alpha', 0);
	end
end