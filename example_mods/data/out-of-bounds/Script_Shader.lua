local shaderName = "tvcrt"

function onCreate()
	if immersionLevel == 'Partial' then
		return
	end

	shaderCoordFix() -- initialize a fix for textureCoord when resizing game window

	makeLuaSprite("crt")
	makeGraphic("crtImage", screenWidth, screenHeight)
	setSpriteShader("crtImage", "crt")

	runHaxeCode([[
		var shaderName = "]] .. shaderName .. [[";
		
		game.initLuaShader(shaderName);
		
		var shader0 = game.createRuntimeShader(shaderName);
		game.camHUD.setFilters([new ShaderFilter(shader0)]);
		game.getLuaObject("crt").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
		game.camGame.setFilters([new ShaderFilter(game.getLuaObject("crt").shader)]);
		return;
	]])
end

function onUpdate(elapsed)
	if immersionLevel == 'Partial' then
		return
	end

	setShaderFloat("shader", "iTime", os.clock())
end

function shaderCoordFix()
	runHaxeCode([[
		resetCamCache = function(?spr) {
			if (spr == null || spr.filters == null) return;
			spr.__cacheBitmap = null;
			spr.__cacheBitmapData = null;
		}
		
		fixShaderCoordFix = function(?_) {
			resetCamCache(game.camGame.flashSprite);
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