local error = false;
local buttonpressed = false;
local phantomAlpha = 0;

function onCreate()
    makeLuaSprite('flashlight','Mechanics/flashlight', 0, 0);
    setObjectCamera('flashlight', 'hud')
    addLuaSprite('flashlight', true);
    makeLuaSprite('freddyjump','Mechanics/freddyjump', 0, 0);
    setObjectCamera('freddyjump', 'hud')
    addLuaSprite('freddyjump', true);
    makeLuaSprite('mechanicfreddy', 'Mechanics/freddy', -1000, 500);
	setLuaSpriteScrollFactor('mechanicfreddy', 1, 1);
	scaleObject('mechanicfreddy', 0.75, 0.75);
    makeLuaSprite('errorblack', "", 0, 0);
    makeGraphic('errorblack', 1280, 720, '000000');
    setObjectCamera('errorblack', 'other');
    makeAnimatedLuaSprite('tablet','Mechanics/tablet', -180, 300);
    makeLuaSprite('errorred', "", 0, 0);
    makeGraphic('errorred', 1280, 720, 'ff0000');
    setObjectCamera('errorred', 'other');
    setProperty('errorred.alpha', 0);
    setObjectCamera('tablet', 'other')
    addLuaSprite('tablet', true);
    addAnimationByPrefix('tablet','idle','idle',24,true);
    addAnimationByPrefix('tablet','pressed','pressed',24,true);
    addAnimationByPrefix('tablet','in','in',24,false);
    addAnimationByPrefix('tablet','out','out',24,false);
    addAnimationByPrefix('tablet','notpressed','notpressed',24,true);
    scaleObject('tablet', 0.6, 0.6);
    makeAnimatedLuaSprite('button','Mechanics/button', 0, 650);
    setObjectCamera('button', 'other')
    addAnimationByPrefix('button','idle','idle',24,true);
    scaleObject('button', 0.69, 0.7);
    addLuaSprite('errorred', true);
    setProperty('button.alpha', 0);
    setProperty('tablet.alpha', 0);
    setProperty('errorblack.alpha', 0);
    addLuaSprite('errorblack', true);
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', true);
    addLuaSprite('button', true);
    addLuaSprite('mechanicfreddy', true);
    setProperty('freddyjump.alpha', 0)
end

function onUpdate()

    buttonStartX = getProperty('button.x');
    buttonEndX = getProperty('button.x') + 426;
    buttonStartY = getProperty('button.y');
    buttonEndY = getProperty('button.y') + 46;

    if not buttonpressed and error and mouseClicked('left') and getMouseX('other') >= buttonStartX and getMouseX('other') <= buttonEndX and getMouseY('other') >= buttonStartY and getMouseY('other') <= buttonEndY then 
        buttonpressed = true;
        setProperty('tablet.alpha', 1);
        setProperty('button.alpha', 0);
        playSound('tabletin', 1);
        objectPlayAnimation('tablet', 'in', true);
    end

tabletStartX = getProperty('tablet.x');
tabletEndX = getProperty('tablet.x') + 512;
tabletStartY = getProperty('tablet.y');
tabletEndY = getProperty('tablet.y') + 288;

if buttonpressed and error and mouseClicked('left') and getMouseX('other') >= tabletStartX and getMouseX('other') <= tabletEndX and getMouseY('other') >= tabletStartY and getMouseY('other') <= tabletEndY then 
    runTimer('errorend', 5, 1);
    objectPlayAnimation('tablet', 'pressed', true);


end

phantomAlpha = phantomAlpha + 0.001;

setProperty('mechanicfreddy.alpha', phantomAlpha);

if getPropertyFromClass("flixel.FlxG", "keys.pressed.Z") then

    phantomAlpha = phantomAlpha - 0.01;
    setProperty('flashlight.alpha', 1);

else

    setProperty('flashlight.alpha', 0);

end
if phantomAlpha <= 0 then

    phantomAlpha = 0;

elseif phantomAlpha >= 1 then
    setProperty('freddyjump.alpha', 1);
    doTweenAlpha('jumpscarefade', 'freddyjump', 0, 2, 'sineInOut');
    playSound('jumpscare', 1);
    phantomAlpha = 0; 
    triggerEvent('error', ' ', ' ');
end
end
function onEvent(name, value1, value2)
    if name == 'error' then
        doTweenAlpha('blackIn', 'errorblack', 1, 2, 'sineInOut');
        error = true;
        buttonpressed = false;
        setProperty('button.alpha', 1);
        setProperty('tablet.alpha', 1);
     end
 end

 function onTweenCompleted(tag)
    if tag == 'blackIn' then
        doTweenAlpha('blackOut', 'errorblack', 0, 2, 'sineInOut');
    elseif tag == 'blackOut' then
        doTweenAlpha('blackIn', 'errorblack', 0.9, 2, 'sineInOut');
    end
end
function onBeatHit()
    if error then
    if curBeat % 2 == 0 then
        setProperty('errorred.alpha', 0.1);
        playSound('alarm', 1);
    else
        setProperty('errorred.alpha', 0);
    end
end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'errorend' then
        cancelTween('blackIn');
        cancelTween('blackOut');
        doTweenAlpha('blackdone', 'errorblack', 0, 2, 'sineInOut');
        error = false;
        buttonpressed = false;
        objectPlayAnimation('tablet', 'out', true);
        setProperty('errorred.alpha', 0);
end
end

function onStepHit()
        if curStep < 0 or curStep > 1552 then

            phantomAlpha = 0;
            
            end

            if curStep < 1888 or curStep > 2592 then

                phantomAlpha = 0;
                
                end

                if curStep < 2848 or curStep > 4288 then

                    phantomAlpha = 0;
                    
                    end
end