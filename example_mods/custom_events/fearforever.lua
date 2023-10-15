function onEvent(name, value1, value2)
    if name == 'fearforever' then
        removeLuaSprite('freddy', true);
        removeLuaSprite('freddy2', true);
        removeLuaSprite('phfreddyjump', true); 
    
        makeLuaSprite('phfreddyjumpinverted','Jumpscares/phfreddyjumpinverted', 0, 0);
        setObjectCamera('phfreddyjumpinverted', 'hud')
        addLuaSprite('phfreddyjumpinverted', true);
        doTweenAlpha('phfreddyjumpinverted','phfreddyjumpinverted', 0, 1, true);
        
        makeLuaSprite('freddy3', 'BGs/freddy3', -1700, -400);
        setLuaSpriteScrollFactor('freddy3', 1, 1);
        scaleObject('freddy3', 1, 1);
        setObjectOrder('freddy3', 0)
    
        addLuaSprite('freddy3', false);
    
        makeLuaSprite('arcade', 'Props/arcade', 800, 0);
        setLuaSpriteScrollFactor('arcade', 1.3, 1.2);
        scaleObject('arcade', 2.5, 2.5);
    
        makeLuaSprite('wire', 'Props/wire', -1700, 0);
        setLuaSpriteScrollFactor('wire', 1.3, 1.2);
        scaleObject('wire', 2.5, 2.5);
    
        makeLuaSprite('greenglow', 'BGs/greenglow', -2000, -3000);
        setLuaSpriteScrollFactor('greenglow', 1.3, 1.2);
        scaleObject('greenglow', 2.5, 2.5);
    
        addLuaSprite('freddy3', false);
        addLuaSprite('arcade', true);
        addLuaSprite('wire', true);
        addLuaSprite('greenglow', true);    
        addLuaSprite('black', true)
     end
 end