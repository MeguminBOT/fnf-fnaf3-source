local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
		startVideo('cutscene1');
		allowCountdown = true;
		noteTweenX("NoteMove1", 0, -1500, 0.1, cubeOut)
		noteTweenX("NoteMove2", 1, -1500, 0.1, cubeOut)
		noteTweenX("NoteMove3", 2, -1500, 0.1, cubeOut)
		noteTweenX("NoteMove4", 3, -1500, 0.1, cubeOut)
		return Function_Stop;
	end
	return Function_Continue;
end