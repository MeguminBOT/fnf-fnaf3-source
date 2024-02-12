local tagT = {}
local pixel = false
local notePositions = {}  -- Table to store note positions

function onCreatePost()
	luaDebugMode = true
	pixel = getProperty('isPixelStage')
end

function goodNoteHit(id, dir, type, sus)
	if not sus then
		if getPropertyFromGroup('notes', id, 'rating') == 'sick' then
			if notePositions[dir] then  -- Check if position exists for the note direction
				tag = makeStrumAsset(dir, function(t, d, x, y, s)
					if notePositions[dir] then
						setProperty(t..'.x', notePositions[dir].x)
						setProperty(t..'.y', notePositions[dir].y)
					end
					tagT[d] = t
					scaleObject(t, 0.5, 0.5)
					updateHitbox(t)
					setProperty(t..'.offset.x', 25)
					setProperty(t..'.offset.y', 25)
					setBlendMode(t, 'ADD')
					setObjectCamera(t, 'hud')
					playAnim(t, 'confirm')
					doTweenX(t..'aaa', t..'.scale', 0.9, 0.5, 'quadOut')
					doTweenY(t..'bbb', t..'.scale', 0.9, 0.5, 'quadOut')
					runTimer(t..'b', 0.15)
				end)
			end
		end
	end
end

function onTimerCompleted(t)
	for i, v in pairs(tagT) do
		if t == v..'b' then
			doTweenAlpha('strum'..v..'a', v, 0, 0.5, 'quadOut')
			removeLuaSprite(v, false)
			addLuaSprite(v, true)
		end
	end
end

function makeStrumAsset(dir, custom, x, y, tag)
	local animTable = { [0] = 'Left', [1] = 'Down', [2] = 'Up', [3] = 'Right' }
	local colorTable = { [0] = 'Purple', [1] = 'Blue', [2] = 'Green', [3] = 'Red' }
	local tag = tag or 'strum'..animTable[dir]
	local skin = getPropertyFromGroup('playerStrums', dir, 'texture') or 'NOTE_assets'
	local x = x or getPropertyFromGroup('playerStrums', dir, 'x')
	local y = y or getPropertyFromGroup('playerStrums', dir, 'y')
	local anims = {
		{ name = 'static', prefix = 'arrow'..animTable[dir]:upper() },
		{ name = 'pressed', prefix = animTable[dir]:lower()..' press' },
		{ name = 'confirm', prefix = animTable[dir]:lower()..' confirm' },
		{ name = 'note', prefix = colorTable[dir]:lower() },
	}
	makeAnimatedLuaSprite(tag, skin, x, y)
	for i = 1, #anims do
		addAnimationByPrefix(tag, anims[i].name, anims[i].prefix, 24, false)
	end
	setObjectOrder(tag, getObjectOrder(tag) or getObjectOrder('boyfriendGroup'))
	addLuaSprite(tag, false)
	if custom then
		custom(tag, dir, x, y, skin)
	end
	return tag
end

function onUpdate()
	if not middlescroll and not downscroll then
		notePositions[0] = { x = 703, y = 22 }
		notePositions[1] = { x = 828, y = 32 }
		notePositions[2] = { x = 944, y = 37 }
		notePositions[3] = { x = 1055, y = 38 }
	elseif not middlescroll and not upscroll then
		notePositions[0] = { x = 703, y = 542 }
		notePositions[1] = { x = 828, y = 552 }
		notePositions[2] = { x = 944, y = 557 }
		notePositions[3] = { x = 1055, y = 558 }
	elseif not downscroll and middlescroll then
		notePositions[0] = { x = 380, y = 22 }
		notePositions[1] = { x = 508, y = 32 }
		notePositions[2] = { x = 624, y = 37 }
		notePositions[3] = { x = 735, y = 38 }
	elseif downscroll and middlescroll then
		notePositions[0] = { x = 380, y = 542 }
		notePositions[1] = { x = 508, y = 552 }
		notePositions[2] = { x = 624, y = 557 }
		notePositions[3] = { x = 735, y = 558 }
	end
end