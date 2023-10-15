function onCreate()
    precacheImage('wfstage2');
	precacheImage('static');
	precacheImage('static2');
	precacheImage('wire');
	precacheImage('wfstage3');
	precacheImage('wfstage5');
end

function onStepHit()

	if curStep == 58 then

	makeLuaText('Text',"Don't see me as a big Teddy Bear now ...",1000,140,550)
    setTextSize('Text',25)
	addLuaText("Text")

	end

	if curStep == 93 then

		removeLuaText("Text")
		makeLuaText('Text2',"Do ya ?",1000,140,550)
		setTextSize('Text2',25)
		addLuaText("Text2")
	
		end

		if curStep == 106 then

			removeLuaText("Text2")
		
			end

			if curStep == 528 then

				makeLuaText('Text',"Don't you worry ...",1000,140,550)
				setTextSize('Text',25)
				addLuaText("Text")
			
				end
			
				if curStep == 542 then
			
					removeLuaText("Text")
					makeLuaText('Text2',"We can find a suit that's just PERFECT for you!",1000,140,550)
					setTextSize('Text2',25)
					addLuaText("Text2")
				
					end
			
					if curStep == 576 then
			
						removeLuaText("Text2")
					
						end
						if curStep == 1059 then

							makeLuaText('Text',"You can RUN ...",1000,140,550)
							setTextSize('Text',25)
							addLuaText("Text")
						
							end
						
							if curStep == 1072 then
						
								removeLuaText("Text")
								makeLuaText('Text2',"But you can't HIDE",1000,140,550)
								setTextSize('Text2',25)
								addLuaText("Text2")
							
								end
						
								if curStep == 1088 then
						
									removeLuaText("Text2")
								
									end

	if curStep == 576 then
      removeLuaSprite('wfstage', false);
      
      makeLuaSprite('wfstage2', 'wfstage2', -2100, -1100);
	  setLuaSpriteScrollFactor('wfstage', 1, 1);
      scaleObject('wfstage2', 0.7, 0.7);

	  makeLuaSprite('wire', 'wire', -1800, -800);
	  scaleObject('wire', 1.7, 1.7);
	  setLuaSpriteScrollFactor('wire', 1.2, 1.2);

      addLuaSprite('wfstage2', false);
	  addLuaSprite('wire', true);

   end

   if curStep == 1088 then
    removeLuaSprite('wfstage2', false);
	removeLuaSprite('wire', false);

    makeLuaSprite('wfstage3', 'wfstage3', -2000, -950);
	setLuaSpriteScrollFactor('wfstage3', 0.8, 0.8);
	scaleObject('wfstage3', 0.6, 0.6);

	makeAnimatedLuaSprite('wfstage5', 'wfstage5', -100, 300);
	setLuaSpriteScrollFactor('wfstage5', 1.2, 1.2);
	scaleObject('wfstage5', 0.7, 0.7);

	addAnimationByPrefix('wfstage5','wfstage5','idle',24,true);

	addLuaSprite('wfstage3', false);
	addLuaSprite('wfstage5', true);

	close(true);

	end
end