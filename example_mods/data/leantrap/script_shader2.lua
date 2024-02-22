local shaderName = "lean"

function onStepHit()
	if curStep == 40 and not epilepsy then
		onDestroy()
	end

	if curStep == 640 and not epilepsy then
		if immersionLevel == 'Partial' then
			return
		end

		shaderCoordFix() -- initialize a fix for textureCoord when resizing game window

		makeLuaSprite("glitch")
		makeGraphic("shaderImage", screenWidth, screenHeight)
		setSpriteShader("shaderImage", "glitch")

		runHaxeCode([[
			var shaderName = "]] .. shaderName .. [[";
			
			game.initLuaShader(shaderName);
			
			var shader0 = game.createRuntimeShader(shaderName);
			game.camGame.setFilters([new ShaderFilter(shader0)]);
			game.getLuaObject("glitch").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
			game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("glitch").shader)]);
			return;
		]])
	end
end

function onUpdate(elapsed)
	if not epilepsy and immersionLevel == 'Full' then
		setShaderFloat("glitch", "iTime", os.clock())
	end
end

function shaderCoordFix()
	if not epilepsy and immersionLevel == 'Full' then
		runHaxeCode([[
			resetCamCache = function(?spr) {
				if (spr == null || spr.filters == null) return;
				spr.__cacheBitmap = null;
				spr.__cacheBitmapData = null;
			}

			fixShaderCoordFix = function(?_) {
				resetCamCache(game.camGame.flashSprite);
				resetCamCache(game.camHUD.flashSprite);
				resetCamCache(game.camOther.flashSprite);
			}

			FlxG.signals.gameResized.add(fixShaderCoordFix);
			fixShaderCoordFix();
			return;
		]])

		local temp = onDestroy
		function onDestroy()
			runHaxeCode([[
				FlxG.signals.gameResized.remove(fixShaderCoordFix);
				return;
			]])
			if (temp) then temp() end
		end
	end
end