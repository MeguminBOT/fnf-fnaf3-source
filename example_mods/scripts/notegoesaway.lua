function onCreatePost()
	for i = 1, 4 do
		noteTweenX("NoteMove" .. i, i-1, -1500, 0.1, cubeOut)
	end
end