--[[ 
	Original author: beihu(b站一北狐丶逐梦) 
		bilbil: https://b23.tv/gxqO0GH
		youtube: https://www.youtube.com/@beihu235
	
	Fully refactored and optimized by: AutisticLulu
		- Reduced code size from 233 lines (9431 chars) to 76 lines (2829 chars). (Excluding comments and song specific stuff).
]]

function onCreatePost()
	if lowQuality then
		return
	end

	bfAlpha = 0.35
	dadAlpha = 0.35

	bfEnabled = true
	dadEnabled = true

	boyfriendFixY = 0
	dadFixY = 0

	createPhantom('boyfriend', 'bfPhantom', 'boyfriendGroup', bfAlpha, getProperty('boyfriend.flipX'), getProperty('boyfriend.offset.x'), getProperty('boyfriend.offset.y'), getProperty('boyfriend.scale.x'), getProperty('boyfriend.scale.y'), boyfriendFixY)
	createPhantom('dad', 'dadPhantom', 'dadGroup', dadAlpha, getProperty('dad.flipX'), getProperty('dad.offset.x'), getProperty('dad.offset.y'), getProperty('dad.scale.x'), getProperty('dad.scale.y'), dadFixY)
end

function onUpdate()
	if lowQuality then
		return
	end

	updateAnimation('boyfriend', 'bfPhantom', 'b')
	updateAnimation('dad', 'dadPhantom', 'd')
end

function onEvent(name, value1, value2)
	if lowQuality then
		return
	end

	if name == 'Change Character' then
		boyfriendFixY = 0
		dadFixY = 0

		if value1 == 'BF' or value1 == 'bf' then
			createPhantom('boyfriend', 'bfPhantom', 'boyfriendGroup', bfAlpha, getProperty('boyfriend.flipX'), getProperty('boyfriend.offset.x'), getProperty('boyfriend.offset.y'), getProperty('boyfriend.scale.x'), getProperty('boyfriend.scale.y'), boyfriendFixY)
		elseif value1 == 'Dad' or value1 == 'dad' then
			createPhantom('dad', 'dadPhantom', 'dadGroup', dadAlpha, getProperty('dad.flipX'), getProperty('dad.offset.x'), getProperty('dad.offset.y'), getProperty('dad.scale.x'), getProperty('dad.scale.y'), dadFixY)
		end

		if value2 == 'phmangle' then
			setProperty(dadPhantom .. '.visible', false)
		else
			setProperty(dadPhantom .. '.visible', true)
		end
	end
end

function createPhantom(objectName, phantomName, groupName, alpha, flipX, offsetX, offsetY, scaleX, scaleY, fixY)
	setObjectOrder(phantomName, getObjectOrder(groupName) - 1)
	makeAnimatedLuaSprite(phantomName, getProperty(objectName .. '.imageFile'), getProperty(objectName .. '.x'), 0)
	addLuaSprite(phantomName, false)
	setProperties(phantomName, {
		['offset.x'] = offsetX,
		['offset.y'] = offsetY,
		['scale.x'] = scaleX,
		['scale.y'] = scaleY,
		['alpha'] = alpha,
		['flipX'] = flipX,
		['flipY'] = true,
		['y'] = getProperty(objectName .. '.y') + getProperty(objectName .. '.frameHeight') * getProperty(objectName .. '.scale.y') * 2 - offsetY * 2 + fixY
	})
	setObjectOrder(phantomName, 1)
end

function updateAnimation(objectName, phantomName, prefix)
	local frame = getProperty(objectName .. '.animation.frameName')
	addAnimationByPrefix(phantomName, prefix, frame, 1, true)
	playAnim(phantomName, prefix, true)
	setProperty(phantomName .. '.offset.x', getProperty(objectName .. '.offset.x'))
	setProperty(phantomName .. '.offset.y', getProperty(objectName .. '.frameHeight') * getProperty(objectName .. '.scale.y') - getProperty(objectName .. '.offset.y'))
end

function setProperties(phantomName, properties)
	for key, value in pairs(properties) do
		setProperty(phantomName .. '.' .. key, value)
	end
end