-- Script by AquaStrikr (https://twitter.com/AquaStrikr_)
function onCreatePost()
	makeLuaSprite('Health', 'health bar')
	setObjectCamera('Health', 'hud')
	addLuaSprite('Health', true)
	setObjectOrder('Health', getObjectOrder('healthBar') + 1)
	setProperty('healthBar.visible', true)
end

function onUpdatePost(elapsed)
    local healthBarX = getProperty('healthBar.x')
    local healthBarY = getProperty('healthBar.y')
    
    setProperty('Health.x', healthBarX - 55)
    setProperty('Health.y', healthBarY - 11)
end