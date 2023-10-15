function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'none' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'none');
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
                setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
			end
		end
	end
end