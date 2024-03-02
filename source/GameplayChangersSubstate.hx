package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import Controls;

using StringTools;

class GameplayChangersSubstate extends MusicBeatSubstate
{
	private var curOption:GameplayOption = null;
	private var curSelected:Int = 0;
	private var optionsArray:Array<Dynamic> = [];

	private var grpOptions:FlxTypedGroup<FlxText>;
	private var boolTextGroup:FlxTypedGroup<FlxText>;
	private var grpTexts:FlxTypedGroup<FlxText>;

	private var modifierTablet:FlxSprite;
	private var optionText:FlxText;
	private var boolText:FlxText;
	private var valueText:FlxText;

	// Filepath shortcuts
	private var spritePath:String = 'menus/freeplayMenu/';

	function getOptions()
	{
		var goption:GameplayOption = new GameplayOption('Scroll Type', 'scrolltype', 'string', 'X-MOD', ["X-MOD", "C-MOD"]);
		optionsArray.push(goption);

		var option:GameplayOption = new GameplayOption('Scroll Speed', 'scrollspeed', 'float', 1);
		option.scrollSpeed = 2.0;
		option.minValue = 0.35;
		option.changeValue = 0.05;
		option.decimals = 2;
		if (goption.getValue() != "C-MOD") {
			option.displayFormat = '%vX';
			option.maxValue = 3;
		} else {
			option.displayFormat = "%v";
			option.maxValue = 6;
		}
		optionsArray.push(option);

		#if !html5
		var option:GameplayOption = new GameplayOption('Song Speed', 'songspeed', 'float', 1);
		option.scrollSpeed = 1;
		option.minValue = 0.5;
		option.maxValue = 3.0;
		option.changeValue = 0.05;
		option.displayFormat = '%vX';
		option.decimals = 2;
		optionsArray.push(option);
		#end

		var option:GameplayOption = new GameplayOption('Health Gain', 'healthgain', 'float', 1);
		option.scrollSpeed = 2.5;
		option.minValue = 0;
		option.maxValue = 5;
		option.changeValue = 0.1;
		option.displayFormat = '%vX';
		optionsArray.push(option);

		var option:GameplayOption = new GameplayOption('Health Loss', 'healthloss', 'float', 1);
		option.scrollSpeed = 2.5;
		option.minValue = 0.5;
		option.maxValue = 5;
		option.changeValue = 0.1;
		option.displayFormat = '%vX';
		optionsArray.push(option);

		var option:GameplayOption = new GameplayOption('Mirror Mode', 'mirrormode', 'bool', false);
		optionsArray.push(option);

		var option:GameplayOption = new GameplayOption('Sudden Death', 'instakill', 'bool', false);
		optionsArray.push(option);

		var option:GameplayOption = new GameplayOption('No Fail', 'practice', 'bool', false);
		optionsArray.push(option);

		var option:GameplayOption = new GameplayOption('Botplay', 'botplay', 'bool', false);
		optionsArray.push(option);
	}

	public function getOptionByName(name:String)
	{
		for(i in optionsArray)
		{
			var opt:GameplayOption = i;
			if (opt.name == name)
				return opt;
		}
		return null;
	}

	public function new()
	{
		super();
	
		modifierTablet = new FlxSprite();
		modifierTablet.loadGraphic(Paths.image(spritePath + 'tablet_options'));
		modifierTablet.frames = Paths.getSparrowAtlas(spritePath + 'tablet_options');
		modifierTablet.antialiasing = ClientPrefs.globalAntialiasing;
		modifierTablet.x = 0;
		modifierTablet.y = 340;
		modifierTablet.scale.x = 0.7;
		modifierTablet.scale.y = 0.7;
		modifierTablet.updateHitbox();
		modifierTablet.animation.addByPrefix('Anim In', 'Anim In', 48, false);
		modifierTablet.animation.addByPrefix('Anim Out', 'Anim Out', 48, false);
		modifierTablet.animation.addByPrefix('Anim Opened', 'Anim Opened', 48, true);
		modifierTablet.animation.play('Anim In');
		modifierTablet.alpha = 1;
		add(modifierTablet);
	
		// avoids lagspikes while scrolling through me	nus!
		grpOptions = new FlxTypedGroup<FlxText>();
		add(grpOptions);
	
		grpTexts = new FlxTypedGroup<FlxText>();
		add(grpTexts);
	
		boolTextGroup = new FlxTypedGroup<FlxText>();
		add(boolTextGroup);

		getOptions();
	
		var yOffset:Float = 0; // Initialize the Y offset

		for (i in 0...optionsArray.length)
		{
			optionText = new FlxText(32, modifierTablet.y + 36 + yOffset, 0, optionsArray[i].name, 16, true);
			optionText.setFormat(Paths.font('stalker1.ttf'), 32, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.GREEN, true);
			optionText.borderSize = 2;
			optionText.visible = false; // Hide the optionText initially
			grpOptions.add(optionText);

			if(optionsArray[i].type == 'bool') {
				boolText = new FlxText(optionText.x + 220, optionText.y, 0, '', 16, true);
				boolText.text = optionsArray[i].getValue(true) ? "On" : "Off";
				boolText.setFormat(Paths.font('stalker1.ttf'), 32, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.RED, true);
				boolText.borderSize = 2;
				boolText.ID = i;
				boolText.visible = false; // Hide the boolText initially
				boolTextGroup.add(boolText);
	
			} else {
				valueText = new FlxText(optionText.x + 220, optionText.y, optionText.width, '', 16, true);
				valueText.text = Std.string(optionsArray[i].getValue());
				valueText.setFormat(Paths.font('stalker1.ttf'), 32, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.RED, true);
				valueText.borderSize = 2;
				valueText.ID = i;
				valueText.visible = false; // Hide the valueText on creation
				grpTexts.add(valueText);
				optionsArray[i].setChild(valueText);
			}
			updateTextFrom(optionsArray[i]);
			yOffset += 32; // Increment the Y offset by 32 pixels
		}
		changeSelection();
		reloadBoolValues();

		modifierTablet.animation.finishCallback = function(name:String) {
			switch (name) {
				case 'Anim In':
					modifierTablet.animation.play('Anim Opened');
					for (optionText in grpOptions.members) {
						optionText.visible = true;
					}
					for (boolText in boolTextGroup.members) {
						boolText.visible = true;
					}
					for (valueText in grpTexts.members) {
						valueText.visible = true;
					}
				case 'Anim Out':
					close();
			}
		};
	}
	
	var nextAccept:Int = 5;
	var holdTime:Float = 0;
	var holdValue:Float = 0;
	override function update(elapsed:Float)
	{
		if (controls.UI_UP_P)
		{
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P)
		{
			changeSelection(1);
		}

		if (controls.BACK) {
			
			for (optionText in grpOptions.members) {
				optionText.visible = false;
			}
			for (boolText in boolTextGroup.members) {
				boolText.visible = false;
			}
			for (valueText in grpTexts.members) {
				valueText.visible = false;
			}
			modifierTablet.animation.play('Anim Out');

			#if android
			flixel.addons.transition.FlxTransitionableState.skipNextTransOut = true;
			FlxG.resetState();
			#else
			close();
			#end

			ClientPrefs.saveSettings();
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}

		if(nextAccept <= 0)
		{
			var usesboolValue = true;
			if(curOption.type != 'bool')
			{
				usesboolValue = false;
			}

			if(usesboolValue)
			{
				if(controls.ACCEPT || controls.UI_LEFT_P || controls.UI_RIGHT_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					curOption.setValue((curOption.getValue() == true) ? false : true);
					curOption.change();
					reloadBoolValues();
				} 
			} else {
				if(controls.UI_LEFT || controls.UI_RIGHT) {
					var pressed = (controls.UI_LEFT_P || controls.UI_RIGHT_P);
					if(holdTime > 0.5 || pressed) {
						if(pressed) {
							var add:Dynamic = null;
							if(curOption.type != 'string') {
								add = controls.UI_LEFT ? -curOption.changeValue : curOption.changeValue;
							}

							switch(curOption.type)
							{
								case 'int' | 'float' | 'percent':
									holdValue = curOption.getValue() + add;
									if(holdValue < curOption.minValue) holdValue = curOption.minValue;
									else if (holdValue > curOption.maxValue) holdValue = curOption.maxValue;

									switch(curOption.type)
									{
										case 'int':
											holdValue = Math.round(holdValue);
											curOption.setValue(holdValue);

										case 'float' | 'percent':
											holdValue = FlxMath.roundDecimal(holdValue, curOption.decimals);
											curOption.setValue(holdValue);
									}

								case 'string':
									var num:Int = curOption.curOption; //lol
									if(controls.UI_LEFT_P) --num;
									else num++;

									if(num < 0) {
										num = curOption.options.length - 1;
									} else if(num >= curOption.options.length) {
										num = 0;
									}

									curOption.curOption = num;
									curOption.setValue(curOption.options[num]); //lol
									
									if (curOption.name == "Scroll Type")
									{
										var oOption:GameplayOption = getOptionByName("Scroll Speed");
										if (oOption != null)
										{
											if (curOption.getValue() == "C-MOD")
											{
												oOption.displayFormat = "%v";
												oOption.maxValue = 6;
											}
											else
											{
												oOption.displayFormat = "%vX";
												oOption.maxValue = 3;
												if(oOption.getValue() > 3) oOption.setValue(3);
											}
											updateTextFrom(oOption);
										}
									}
									//trace(curOption.options[num]);
							}
							updateTextFrom(curOption);
							curOption.change();
							FlxG.sound.play(Paths.sound('scrollMenu'));
						} else if(curOption.type != 'string') {
							holdValue = Math.max(curOption.minValue, Math.min(curOption.maxValue, holdValue + curOption.scrollSpeed * elapsed * (controls.UI_LEFT ? -1 : 1)));

							switch(curOption.type)
							{
								case 'int':
									curOption.setValue(Math.round(holdValue));
								
								case 'float' | 'percent':
									var blah:Float = Math.max(curOption.minValue, Math.min(curOption.maxValue, holdValue + curOption.changeValue - (holdValue % curOption.changeValue)));
									curOption.setValue(FlxMath.roundDecimal(blah, curOption.decimals));
							}
							updateTextFrom(curOption);
							curOption.change();
						}
					}

					if(curOption.type != 'string') {
						holdTime += elapsed;
					}
				} else if(controls.UI_LEFT_R || controls.UI_RIGHT_R) {
					clearHold();
				}
			}

			if(controls.RESET #if android || virtualPad.buttonC.justPressed #end)
			{
				for (i in 0...optionsArray.length)
				{
					var leOption:GameplayOption = optionsArray[i];
					leOption.setValue(leOption.defaultValue);
					if(leOption.type != 'bool')
					{
						if(leOption.type == 'string')
						{
							leOption.curOption = leOption.options.indexOf(leOption.getValue());
						}
						updateTextFrom(leOption);
					}

					if(leOption.name == 'Scroll Speed')
					{
						leOption.displayFormat = "%vX";
						leOption.maxValue = 3;
						if(leOption.getValue() > 3)
						{
							leOption.setValue(3);
						}
						updateTextFrom(leOption);
					}
					leOption.change();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				reloadBoolValues();
			}
		}

		if(nextAccept > 0) {
			nextAccept -= 1;
		}
		super.update(elapsed);
	}

	// PLEASE DONT LOOK AT ME IM SO UGLYYYY //Lulu
	function updateTextFrom(option:GameplayOption) {
		if(option == optionsArray[curSelected]) {
			var text:String = option.displayFormat;
			var val:Dynamic = option.getValue();
			if(option.type == 'percent') val *= 100;
			var def:Dynamic = option.defaultValue;
			option.text = "< " + (text.replace('%v', val).replace('%d', def)) + " >";
		} else {
			var text:String = option.displayFormat;
			var val:Dynamic = option.getValue();
			if(option.type == 'percent') val *= 100;
			var def:Dynamic = option.defaultValue;
			option.text = text.replace('%v', val).replace('%d', def);
		}
	}

	function clearHold()
	{
		if(holdTime > 0.5) {
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		holdTime = 0;
	}

	// PLEASE DONT LOOK AT ME IM SO UGLYYYY //Lulu
	function changeSelection(change:Int = 0)
	{
		curSelected += change;
		if (curSelected < 0)
			curSelected = optionsArray.length - 1;
		if (curSelected >= optionsArray.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			bullShit++;
			item.alpha = 1;
		}
		for (bools in boolTextGroup) {
			if(bools.ID == curSelected) {
				bools.alpha = 1;
				bools.text = "< " + (optionsArray[curSelected].getValue(true) ? "On" : "Off") + " >";
			} else {
				bools.alpha = 0.6;
				bools.text = optionsArray[bools.ID].getValue(true) ? "On" : "Off";
			}
		}
		for (text in grpTexts) {
			if(text.ID == curSelected) {
				text.alpha = 1;
				text.text = "< " + (Std.string(optionsArray[curSelected].getValue()) + " >");
			} else {
				text.alpha = 0.6;
				text.text = Std.string(optionsArray[text.ID].getValue());
			}
		}
		curOption = optionsArray[curSelected]; //shorter lol
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	function reloadBoolValues() {
		for (boolText in boolTextGroup) {
			if(boolText.ID == curSelected) {
				var newValue = optionsArray[curSelected].getValue(true);
				boolText.text = "< " + (newValue ? "On" : "Off") + " >";
			} else {
				var newValue = optionsArray[boolText.ID].getValue(true);
				boolText.text = newValue ? "On" : "Off";
			}
		}
	}	
}

class GameplayOption
{
	private var child:FlxText;
	public var text(get, set):String;
	public var onChange:Void->Void = null; //Pressed enter (on Bool type options) or pressed/held left/right (on other types)

	public var type(get, default):String = 'bool'; //bool, int (or integer), float (or fl), percent, string (or str)
	// Bool will use boolValuees
	// Everything else will use a text

	public var showBoyfriend:Bool = false;
	public var scrollSpeed:Float = 50; //Only works on int/float, defines how fast it scrolls per second while holding left/right

	private var variable:String = null; //Variable from ClientPrefs.hx's gameplaySettings
	public var defaultValue:Dynamic = null;

	public var curOption:Int = 0; //Don't change this
	public var options:Array<String> = null; //Only used in string type
	public var changeValue:Dynamic = 1; //Only used in int/float/percent type, how much is changed when you PRESS
	public var minValue:Dynamic = null; //Only used in int/float/percent type
	public var maxValue:Dynamic = null; //Only used in int/float/percent type
	public var decimals:Int = 1; //Only used in float/percent type

	public var displayFormat:String = '%v'; //How String/Float/Percent/Int values are shown, %v = Current value, %d = Default value
	public var name:String = 'Unknown';

	public function new(name:String, variable:String, type:String = 'bool', defaultValue:Dynamic = 'null variable value', ?options:Array<String> = null)
	{
		this.name = name;
		this.variable = variable;
		this.type = type;
		this.defaultValue = defaultValue;
		this.options = options;

		if(defaultValue == 'null variable value')
		{
			switch(type)
			{
				case 'bool':
					defaultValue = false;
				case 'int' | 'float':
					defaultValue = 0;
				case 'percent':
					defaultValue = 1;
				case 'string':
					defaultValue = '';
					if(options.length > 0) {
						defaultValue = options[0];
					}
			}
		}

		if(getValue() == null) {
			setValue(defaultValue);
		}

		switch(type)
		{
			case 'string':
				var num:Int = options.indexOf(getValue());
				if(num > -1) {
					curOption = num;
				}
	
			case 'percent':
				displayFormat = '%v%';
				changeValue = 0.01;
				minValue = 0;
				maxValue = 1;
				scrollSpeed = 0.5;
				decimals = 2;
		}
	}

	public function change()
	{
		//nothing lol
		if(onChange != null) {
			onChange();
		}
	}

	public function getValue():Dynamic
	{
		return ClientPrefs.gameplaySettings.get(variable);
	}
	public function setValue(value:Dynamic)
	{
		ClientPrefs.gameplaySettings.set(variable, value);
	}

	public function setChild(child:FlxText)
	{
		this.child = child;
	}

	private function get_text()
	{
		if(child != null) {
			return child.text;
		}
		return null;
	}
	private function set_text(newValue:String = '')
	{
		if(child != null) {
			child.text = newValue;
		}
		return null;
	}

	private function get_type()
	{
		var newValue:String = 'bool';
		switch(type.toLowerCase().trim())
		{
			case 'int' | 'float' | 'percent' | 'string': newValue = type;
			case 'integer': newValue = 'int';
			case 'str': newValue = 'string';
			case 'fl': newValue = 'float';
		}
		type = newValue;
		return type;
	}
}
