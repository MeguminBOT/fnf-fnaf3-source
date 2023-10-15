function onEvent(name, value1, value2)
    if name == 'fearforever3' then
        removeLuaSprite('foxy', true);
        setProperty('bfPhantom.alpha', 0)
        setProperty('dadPhantom.alpha', 0)
        setProperty('gfPhantom.alpha', 0)
        makeLuaSprite('foxy2', 'BGs/foxy2', -1700, -400);
        setLuaSpriteScrollFactor('foxy2', 1, 1);
        scaleObject('foxy2', 1, 1);
        setObjectOrder('foxy2', 1)
    
        makeLuaSprite('box', 'Props/box', 800, 1000);
        setLuaSpriteScrollFactor('box', 1.3, 1.2);
        scaleObject('box', 1.5, 1.5);
    
        makeLuaSprite('present', 'Props/present', -1300, 1000);
        setLuaSpriteScrollFactor('present', 1.3, 1.2);
        scaleObject('present', 1.5, 1.5);
    
        setProperty('dad.x', -500);
        setProperty('dad.y', 600);
        setProperty('boyfriend.x', 700);
        setProperty('boyfriend.y', 950);
    
        addLuaSprite('foxy2', false);
        addLuaSprite('box', true);
        addLuaSprite('present', true);
        addLuaSprite('black', true)
     end
 end