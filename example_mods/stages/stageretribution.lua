function onCreate()
	precacheImage('characters/afton3');
	precacheImage('characters/springbonnie');
	precacheImage('characters/cassidy2');
	precacheImage('Chars/children');
	precacheImage('characters/afton2');
	precacheImage('characters/cassidy');
	precacheImage('BGs/retribution');
	precacheImage('BGs/retribution2');
	precacheImage('BGs/retribution3');

    makeLuaSprite('arcadeffect','arcadeffect', 0, 0);
    setObjectCamera('arcadeffect', 'hud')
    addLuaSprite('arcadeffect', true);
    makeLuaSprite('blackui','blackui', 0, 0);
    setObjectCamera('blackui', 'hud')
    addLuaSprite('blackui', true);
    setProperty('blackui.alpha', 0.5);
    makeLuaSprite('black2','black', -500, -500);
    setLuaSpriteScrollFactor('black2', 0, 0);
    scaleObject('black2', 10, 10);
    addLuaSprite('black2', true);
    setProperty('black2.alpha', 0);
    makeLuaSprite('white2','white', -500, -500);
    setLuaSpriteScrollFactor('white2', 0, 0);
    scaleObject('white2', 10, 10);
    addLuaSprite('white2', true);
    setProperty('white2.alpha', 0);
    makeLuaSprite('white','white', 0, 0);
    setObjectCamera('white', 'other')
    makeLuaSprite('black','black', 0, 0);
    setObjectCamera('black', 'other')
    addLuaSprite('black', true);
    addLuaSprite('white', true);
    setProperty('white.alpha', 0);
    makeLuaSprite('minigameafton', 'BGs/minigameafton', -1600, 0);
    setLuaSpriteScrollFactor('minigameafton', 1, 1);
    scaleObject('minigameafton', 1, 1);
    addLuaSprite('minigameafton', false);
    setLuaSpriteScrollFactor('minigameafton', 1, 1);
    makeAnimatedLuaSprite('retribution2','BGs/retribution2', -2400, -530);
    addAnimationByPrefix('retribution2','idle','idle',24,true);
    addAnimationByPrefix('retribution2','bop','bop',24,false);
    scaleObject('retribution2', 1.1, 1.1);
    addLuaSprite('retribution2', false);
    setProperty('retribution2.alpha', 0);

    makeAnimatedLuaSprite('aftonwear','aftonwear', 0, 0);
    addAnimationByPrefix('aftonwear','idle','idle',24,false);
    setLuaSpriteScrollFactor('aftonwear', 0, 0);
    scaleObject('aftonwear', 1, 1);
    
end


function onStepHit()
    if curStep == 400 then
		removeLuaSprite('minigameafton', true);
        makeLuaSprite('retribution', 'BGs/retribution', -2400, -530);
        setLuaSpriteScrollFactor('retribution', 1, 1);
        scaleObject('retribution', 1.1, 1.1);
        addLuaSprite('retribution', false);
        setLuaSpriteScrollFactor('retribution', 1, 1);
        setProperty('blackui.alpha', 0);
        setScrollFactor('boyfriendGroup', 1, 1.5);
        end

        if curStep == 1696 then

    removeLuaSprite('retribution', true);
    makeLuaSprite('retribution3', 'BGs/retribution3', -1300, 0);
    setLuaSpriteScrollFactor('retribution3', 0.9, 0.9);
    scaleObject('retribution3', 0.6, 0.6);
    addLuaSprite('retribution3', false);
    setScrollFactor('boyfriendGroup', 1, 1);
            end
            if curStep == 1952 then

        removeLuaSprite('retribution3', true);
        makeLuaSprite('retribution', 'BGs/retribution', -2400, -530);
        setLuaSpriteScrollFactor('retribution', 1, 1);
        scaleObject('retribution', 1.1, 1.1);
        addLuaSprite('retribution', false);
        setScrollFactor('boyfriendGroup', 1, 1.5);
        makeAnimatedLuaSprite('children','Chars/cryingchildren', -1600, 500);
        addAnimationByPrefix('children','children','idle',24,true);
        scaleObject('children', 2, 2);
        addLuaSprite('children', false);
                end


            if curStep == 2208 then
                addLuaSprite('aftonwear', true);
                removeLuaSprite('retribution', true);
                setProperty('aftonwear.alpha', 1);
                setProperty('retribution2.alpha', 1);
                        end

                        if curStep == 2240 then
                            setProperty('aftonwear.alpha', 0);
                                    end
        end

function onBeatHit()
                        if curBeat >= 552 and curBeat % 3 == 0 then

                            objectPlayAnimation('retribution2', 'bop',true)

                    end
                end