function onCreate()

	precacheImage('jumpscares/foxyjumpscare');
	precacheImage('jumpscares/phfreddyjumpscare');
	precacheImage('jumpscares/phfreddyjumpinverted');
	precacheImage('jumpscares/phfreddyjump');
	precacheImage('jumpscares/chica');
	makeLuaSprite('freddy', 'BGs/freddy', -2050, -170);
	setLuaSpriteScrollFactor('freddy', 1, 1);
	scaleObject('freddy', 0.75, 0.75);
	makeLuaSprite('freddy2', 'BGs/freddy2', -2050, -170);
	setLuaSpriteScrollFactor('freddy2', 1, 1);
	scaleObject('freddy2', 0.75, 0.75);
	addLuaSprite('freddy', true);
	addLuaSprite('freddy2', false);
	doTweenY('dadTweenY', 'dad', 1000, 1, 'cubeIn');
	makeLuaSprite('black2','black', 0, 0);
    setObjectCamera('black2', 'hud')
    addLuaSprite('black2', true);
	makeLuaSprite('black','black', -5000, -5000);
	setLuaSpriteScrollFactor('black', 0, 0);
	scaleObject('black', 20, 20);
	addLuaSprite('black', true);
end

function onStepHit()
--100 10
	if curStep == 100 then
		doTweenX('Walk', 'dad', -400, 10, 'quadIn');
   end
   --192 5
   if curStep == 192 then
	doTweenX('Walk', 'dad', -550, 5, 'quadIn');
end
--320 5
if curStep == 320 then
	doTweenX('Walk', 'dad', -700, 5, 'quadIn');
end
--448 5 
if curStep == 448 then
	doTweenX('Walk', 'dad', -850, 5, 'quadIn');
end

--576 5 
if curStep == 576 then
	doTweenX('Walk', 'dad', -1000, 5, 'quadIn');
end

if curStep == 630 then
	makeAnimatedLuaSprite('phfreddyjump','Jumpscares/phfreddyjump', -1700, 200);
	scaleObject('phfreddyjump', 1.3, 1.3);
	addLuaSprite('phfreddyjump', true);

	addAnimationByPrefix('phfreddyjump','phfreddyjump','idle',24,true);
end
--2336
	if curStep == 2336 then
		setObjectOrder('static3', 0)
		setObjectOrder('chica', 1)
		setProperty('dad.x', -300);
		setProperty('dad.y', 250);
   end
   
   	if curStep == 4544 then
        doTweenAlpha('bgappear', 'puppet', 1, 10, 'sineInOut');
   end

   	if curStep == 4672 then
		doTweenY('presents', 'puppet2', 600, 5, 'cubeOut');
   end

   	if curStep == 4800 then
        doTweenY('stardown2', 'starstring2', -100, 5, 'cubeOut');
   end

      	if curStep == 4832 then
			doTweenY('stardown1', 'starstring', -100, 5, 'cubeOut');
   end

end