function onEvent(name, value1, value2)
    if name == 'fearforever2' then
        
        removeLuaSprite('greenglow', true);
        removeLuaSprite('wire', true);
        removeLuaSprite('arcade', true); 
        removeLuaSprite('freddy3', true); 
        
        makeLuaSprite('foxy', 'BGs/foxy', -1700, -400);
        setLuaSpriteScrollFactor('foxy', 1, 1);
        scaleObject('foxy', 1, 1);
        setObjectOrder('foxy', 1)
        setProperty('bfPhantom.alpha', 0)
        setProperty('dadPhantom.alpha', 0)
        setProperty('gfPhantom.alpha', 0)
    
        setProperty('dad.x', -500);
        setProperty('dad.y', 600);
        setProperty('boyfriend.x', 700);
        setProperty('boyfriend.y', 950);
    
        addLuaSprite('foxy', false);
        addLuaSprite('black', true)
     end
 end