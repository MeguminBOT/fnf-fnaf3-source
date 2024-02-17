--credits
--I Used toggle trail from Psychic mod but fixed it.

trailEnabledDad = false;
trailEnabledBF = false;
timerStartedDad = false;
timerStartedBF = false;

trailLength = 6;
trailDelay = 0.05;
number = 0.4

function onEvent(name, value1, value2)
	if name == "Toggle Trail" then
		function onTimerCompleted(tag, loops, loopsLeft)
			if tag == 'timerTrailBF' then
				createTrailFrameBF('BF');
			end
			if tag == 'timerTrailDad' then
				createTrailFrameDad('Dad');
			end
		end
		
		if not (value1 == '0' or value1 == '') then
			trailEnabledDad = true
			curTrailDad = 0;
			
			function createTrailFrameDad(tag)
				num = 0;
				color = -1;
				image = '';
				frame = 'BF idle dance';
				x = 0;
				y = 0;
				offsetX = 0;
				offsetY = 0;
				
				if tag == 'Dad' then
					num = curTrailDad;
					curTrailDad = curTrailDad + 1;
					if trailEnabledDad then
						flip = getProperty('dad.flipX')
						color = getColorFromHex(''..dadColor);
						image = getProperty('dad.imageFile')
						frame = getProperty('dad.animation.frameName');
						x = getProperty('dad.x');
						y = getProperty('dad.y');
						offsetX = getProperty('dad.offset.x');
						offsetY = getProperty('dad.offset.y');
					end
				end
				
				if num - trailLength + 1 >= 0 then
					for i = (num - trailLength + 1), (num - 1) do
						setProperty('psychicTrail'..tag..i..'.alpha', getProperty('psychicTrail'..tag..i..'.alpha') - (0.6 / (trailLength - 1)));
					end
				end
				removeLuaSprite('psychicTrail'..tag..(num - trailLength));
				
				if not (image == '') then
					trailTag = 'psychicTrail'..tag..num;
					makeAnimatedLuaSprite(trailTag, image, x, y);
					setProperty(trailTag..'.offset.x', offsetX);
					setProperty(trailTag..'.offset.y', offsetY);
					setProperty(trailTag..'.flipX', flip)
					setProperty(trailTag..'.alpha', number);
					setProperty(trailTag..'.color', color);
					--setBlendMode(trailTag, 'add');
					addAnimationByPrefix(trailTag, 'stuff', frame, 0, false);
					addLuaSprite(trailTag, false);
				end
			end
			
			--number = 0.4
			if not timerStartedDad then
				runTimer('timerTrailDad', trailDelay, 0);
				timerStartedDad = true;
				trailEnabledDad = true
				dadColor = value1
			end
		else
			trailEnabledDad = false
			--number = 0
		end

		if not (value2 == '0' or value2 == '') then
			trailEnabledBF = true
			curTrailBF = 0;
			
			function createTrailFrameBF(tag)
				num = 0;
				color = -1;
				image = '';
				frame = 'BF idle dance';
				x = 0;
				y = 0;
				offsetX = 0;
				offsetY = 0;
				
				if tag == 'BF' then
					num = curTrailBF;
					curTrailBF = curTrailBF + 1;
					if trailEnabledBF then
						flip = getProperty('boyfriend.flipX')
						color = getColorFromHex(''..bfColor);
						image = getProperty('boyfriend.imageFile')
						frame = getProperty('boyfriend.animation.frameName');
						x = getProperty('boyfriend.x');
						y = getProperty('boyfriend.y');
						offsetX = getProperty('boyfriend.offset.x');
						offsetY = getProperty('boyfriend.offset.y');
					end
				end
				
				if num - trailLength + 1 >= 0 then
					for i = (num - trailLength + 1), (num - 1) do
						setProperty('psychicTrail'..tag..i..'.alpha', getProperty('psychicTrail'..tag..i..'.alpha') - (0.6 / (trailLength - 1)));
					end
				end
				removeLuaSprite('psychicTrail'..tag..(num - trailLength));
				
				if not (image == '') then
					trailTag = 'psychicTrail'..tag..num;
					makeAnimatedLuaSprite(trailTag, image, x, y);
					setProperty(trailTag..'.offset.x', offsetX);
					setProperty(trailTag..'.offset.y', offsetY);
					setProperty(trailTag..'.flipX', flip)
					setProperty(trailTag..'.alpha', number);
					setProperty(trailTag..'.color', color);
					--setBlendMode(trailTag, 'add');
					addAnimationByPrefix(trailTag, 'stuff', frame, 0, false);
					addLuaSprite(trailTag, false);
				end
			end
			
			--number = 0.4
			if not timerStartedBF then
				runTimer('timerTrailBF', trailDelay, 0);
				timerStartedBF = true;
				trailEnabledBF = true
				bfColor = value2
			end
		else
			trailEnabledBF = false
			--number = 0
		end
	end
end