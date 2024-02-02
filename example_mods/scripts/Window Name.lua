function onCreatePost(name, value1, value2)
    getProperty(songName)
	setPropertyFromClass('openfl.Lib', 'application.window.title', 'Friday Night Funkin: VS FNaF 3 | ' .. songName)
end

function onDestroy()
	setPropertyFromClass('openfl.Lib', 'application.window.title', 'Friday Night Funkin: VS FNaF 3')
end
