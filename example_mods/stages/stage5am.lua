function onCreate()

	makeLuaSprite('desk', 'BGs/5amdesk', -370, -38)
	setObjectOrder('desk', 2)
	scaleObject('desk', 0.8, 0.8)
	addLuaSprite('desk', true)
	
	makeLuaSprite('wall', 'BGs/5amwall', -605, -70)
	setObjectOrder('wall', 0)
	scaleObject('wall', 1.2, 1.2)
	setScrollFactor('wall', 0.7, 0.7)
	addLuaSprite('wall', true)
	makeLuaSprite('white','white', -5000, -5000);
	setLuaSpriteScrollFactor('white', 0, 0);
	scaleObject('white', 20, 20);
	addLuaSprite('white', true);
	makeLuaSprite('black','black', -5000, -5000);
	setLuaSpriteScrollFactor('black', 0, 0);
	scaleObject('black', 20, 20);
	addLuaSprite('black', true);
	makeLuaSprite('whiteui','whiteui', 0, 0);
	setObjectCamera('whiteui', 'hud')
	addLuaSprite('whiteui', true);
	setProperty('whiteui.alpha', 0);
end

function onStepHit()
	--624 2
	if curStep == 608 then	
		doTweenX('findthatchild', 'dad', 2000, 5, 'cubeIn');
		end
--688 0.2
	
		if curStep == 688 then	
			doTweenX('findthatchild', 'dad', -136, 0.1, 'cubeOut');
			end
	--736 10
	if curStep == 700 then	
		doTweenY('freddyhello', 'gf', 135, 10, 'cubeOut');
		end
		--1484 2
		if curStep == 1484 then	
			doTweenX('freddyno', 'gf', 1000, 2, 'cubeIn');
			end
			--1500 2 
			if curStep == 1500 then	
				doTweenX('fucker', 'dad', -1500, 2, 'cubeIn');
				end
				--10
	if curStep == 1546 then	
		removeLuaSprite('wall', true);
		removeLuaSprite('desk', true);
		makeLuaSprite('office', 'BGs/5amoffice', -732, 171)
		setObjectOrder('office', 0)
		scaleObject('office', 0.6, 0.6)
		addLuaSprite('office', true)
	end
end


