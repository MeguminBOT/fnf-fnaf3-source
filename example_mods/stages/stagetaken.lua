function onCreate()
	precacheImage('BGs/fnaf1wall');
	precacheImage('characters/bonnie');
	precacheImage('characters/chica');
	precacheImage('characters/foxy');
	precacheImage('bonniewalk');
	precacheImage('chicawalk');
	precacheImage('foxywalk');
	precacheImage('sfreddywalk');
	makeLuaSprite('white','white', 0, 0);
        setObjectCamera('white', 'hud')
        addLuaSprite('white', true);
	makeLuaSprite('blueglow', 'BGs/blueglow', -2000, -900);
	setLuaSpriteScrollFactor('blueglow', 1.5, 1.5);
	scaleObject('blueglow', 1.7, 1);
	addLuaSprite('blueglow', true);
	doTweenAlpha('white','white', 0, 0.01, true);
	makeLuaSprite('takenstage', 'BGs/takenstage', -2000, -550);
	setLuaSpriteScrollFactor('takenstage', 1, 1);
	scaleObject('takenstage', 0.85, 0.85);
	addLuaSprite('takenstage', false);
	video.Load("takenapart.mp4");
end

function onStepHit()

	if curStep == 386 then

	makeLuaText('Text',"Follow me...",1000,140,550)
    setTextSize('Text',25)
	addLuaText("Text")

	end

		if curStep == 400 then

			removeLuaText("Text")
		
			end

			if curStep == 1311 then

				makeLuaText('Text',"Follow me...",1000,140,550)
				setTextSize('Text',25)
				addLuaText("Text")
			
				end
			
					if curStep == 1324 then
			
						removeLuaText("Text")
					
						end

						if curStep == 2160 then

							makeLuaText('Text',"Follow me...",1000,140,550)
							setTextSize('Text',25)
							addLuaText("Text")
						
							end
						
								if curStep == 2176 then
						
									removeLuaText("Text")
								
									end
						
									if curStep == 2606 then
						
										makeLuaText('Text',"I'VE GOT YA NOW!",1000,140,550)
										setTextSize('Text',25)
										addLuaText("Text")
									
										end
									
											if curStep == 2630 then
									
												removeLuaText("Text")
											
												end

												if curStep == 3031 then

													makeLuaText('Text',"Follow me...",1000,140,550)
													setTextSize('Text',25)
													addLuaText("Text")
												
													end
												
														if curStep == 3046 then
												
															removeLuaText("Text")
														
															end

	if curStep == 816 then
      removeLuaSprite('takenstage', true);
      
	  makeAnimatedLuaSprite('fnaf1wall','BGs/fnaf1wall', -1200, -700);
	  scaleObject('fnaf1wall', 2.6, 2.6);
        addLuaSprite('fnaf1wall', false);
        addAnimationByPrefix('fnaf1wall','fnaf1wall','fnaf1wall idle',12,true);

   end

   if curStep == 944 then
    removeLuaSprite('fnaf1wall', true);
	makeLuaSprite('blueglow', 'BGs/blueglow', -2000, -900);
	setLuaSpriteScrollFactor('blueglow', 1.5, 1.5);
	scaleObject('blueglow', 1.7, 1);
	addLuaSprite('blueglow', true);

	makeLuaSprite('takenstage2', 'BGs/takenstage2', -2000, -550);
	setLuaSpriteScrollFactor('takenstage2', 1, 1);
	scaleObject('takenstage2', 0.85, 0.85);
	addLuaSprite('takenstage2', false);

	end

	if curStep == 1632 then
		removeLuaSprite('takenstage', true);
		
		makeAnimatedLuaSprite('fnaf1wall','BGs/fnaf1wall', -1200, -700);
		scaleObject('fnaf1wall', 2.6, 2.6);
		  addLuaSprite('fnaf1wall', false);
		  addAnimationByPrefix('fnaf1wall','fnaf1wall','fnaf1wall idle',12,true);
  
	 end
  
	 if curStep == 1696 then
	  removeLuaSprite('fnaf1wall', true);
	  makeLuaSprite('blueglow', 'BGs/blueglow', -2000, -900);
	  setLuaSpriteScrollFactor('blueglow', 1.5, 1.5);
	  scaleObject('blueglow', 1.7, 1);
	  addLuaSprite('blueglow', true);
  
	  makeLuaSprite('takenstage3', 'BGs/takenstage3', -2000, -550);
	  setLuaSpriteScrollFactor('takenstage3', 1, 1);
	  scaleObject('takenstage3', 0.85, 0.85);
	  addLuaSprite('takenstage3', false);
  
	  end

	  if curStep == 2465 then
		removeLuaSprite('takenstage', true);
		
		makeAnimatedLuaSprite('fnaf1wall','BGs/fnaf1wall', -1200, -700);
		scaleObject('fnaf1wall', 2.6, 2.6);
		  addLuaSprite('fnaf1wall', false);
		  addAnimationByPrefix('fnaf1wall','fnaf1wall','fnaf1wall idle',12,true);
  
	 end
  
	 if curStep == 2646 then
	  removeLuaSprite('fnaf1wall', true);
	  makeLuaSprite('blueglow', 'BGs/blueglow', -2000, -900);
	  setLuaSpriteScrollFactor('blueglow', 1.5, 1.5);
	  scaleObject('blueglow', 1.7, 1);
	  addLuaSprite('blueglow', true);
  
	  makeLuaSprite('takenstage4', 'BGs/takenstage4', -2000, -550);
	  setLuaSpriteScrollFactor('takenstage4', 1, 1);
	  scaleObject('takenstage4', 0.85, 0.85);
	  addLuaSprite('takenstage4', false);
  
	  end
end