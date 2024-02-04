local shaderName = "BloomFX"
function onStepHit()
	if curStep == 1080 then	
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
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("glitch").shader)]);
        return;
    ]])
end
if curStep == 40 then	
    onDestroy()
end
end
function onUpdate(elapsed)
    setShaderFloat("glitch", "iTime", os.clock())
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