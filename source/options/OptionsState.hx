package options;

import lime.utils.Assets;

import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.animation.FlxAnimationController;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.input.keyboard.FlxKeyList;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxSpriteButton;
import flixel.ui.FlxButton;
import flixel.util.FlxSave;

import Controls;
import Discord.DiscordClient;

using StringTools;

class OptionsState extends MusicBeatState
{
	private static var curSelected:Int = 0;

	// UI Button stuff
	var button:FlxButton;
	var btnGroup:FlxTypedGroup<FlxButton>;
	var btnGroups:Array<FlxTypedGroup<FlxButton>> = [];

	// Button properties 
	// DO NOT CHANGE THESE VARIABLES THEY'RE HANDLED IN A FUNCTION LATER ON.
	var btnWidth:Float = 0; // Width of each button.
	var btnHeight:Float = 0; // Height of each button.
	var btnX:Float = 0; // X position of the button row.
	var btnY:Float = 0; // Y position of the button row.
	var btnSpacing:Int = 0; // Space between each button.

	var menuList:Array<String> = ['Notecolors', 'Controls', 'Notedelay', 'Graphics', 'Visuals', 'Gameplay', 'Accessibility'];

	override function create()
	{
		FlxG.mouse.visible = true; // Make the mouse visible since the UI is made for mouse and touch input.

		persistentUpdate = true;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Options Menu", null);
		#end

        var bg = new FlxSprite().loadGraphic(Paths.image('menuBG'));
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg);
        bg.screenCenter();

		/* Call our separated function for creating song buttons */
		btnGroups.push(createGroup(menuList));

		super.create();
	}

	public function createGroup(menuList:Array<String>):FlxTypedGroup<FlxButton> 
	{
		// Initialize groups.
		btnGroup = new FlxTypedGroup<FlxButton>();
	
		for (i in 0...menuList.length) {
			// Sets a bigger or smaller size of the buttons depending on the index range. 
			btnWidth = 829;
			btnHeight = 55;
			btnSpacing = 4;
			btnX = 16;
			btnY = 16 + (btnHeight + btnSpacing) * i;
	
			// Automatically create the appropiate amount of buttons.
			var button = createButton(btnX, btnY, i, menuList);
			btnGroup.add(button);
		}
		add(btnGroup);
	
		return btnGroup;
	}

	function createButton(btnX:Float, btnY:Float, index:Int, menuList:Array<String>):FlxButton
	{
		// Button creation.
		button = new FlxButton(btnX, btnY, "", onButtonClicked.bind(index, menuList));

		// Load a sprite sharing the name of the menu.
		button.loadGraphic(Paths.image('options/option' + menuList[index]));
		button.frames = Paths.getSparrowAtlas('options/option' + menuList[index]);
		button.animation.addByPrefix('idle', menuList[index] + ' idle', 24, true);
		button.animation.addByPrefix('highlighted', menuList[index] + ' highlighted', 24, true);
		button.animation.addByPrefix('pressed', menuList[index] + ' pressed', 24, true);

		// Assign button events to functions.
		button.onOver.callback = onButtonHighlight.bind(index, menuList);
		button.onOut.callback = onButtonDeselect.bind(index, menuList); 

		button.animation.play('idle');
		
		return button;
	}

	function onButtonClicked(index:Int, menuList:Array<String>) 
	{
		// Set the current selection to the index of the clicked button
		curSelected = index;

		//Play pressed animation of button
		button.animation.play('pressed');

		// Play a sound when the button is clicked.
		FlxG.sound.play(Paths.sound('done'), 1);

		// Handle button actions based on index
		switch (index) {
			case 0: // 'Notecolors'
				openSubState(new options.NotesSubState());
			case 1: // 'Controls'
				openSubState(new options.ControlsSubState());
			case 2: // 'Notedelay'
				LoadingState.loadAndSwitchState(new options.NoteOffsetState());
			case 3: // 'Graphics'
				openSubState(new options.GraphicsSettingsSubState());
			case 4: // 'Visuals'
				openSubState(new options.VisualsUISubState());
			case 5: // 'Gameplay'
				openSubState(new options.GameplaySettingsSubState());
			case 6: // 'Accessibility'
				openSubState(new options.AccessibilitySubState());
		}
	}

	function onButtonHighlight(index:Int, menuList:Array<String>) 
	{
		// Set the current selection to the index of the highlighted button
		curSelected = index;

		//Play highlight animation of button
		button.animation.play('highlighted');

		// Play a sound when the button is highlighted.
		FlxG.sound.play(Paths.sound('done'), 1);
	}

	function onButtonDeselect(index:Int, menuList:Array<String>) 
	{
		curSelected = index;

		//Play idle animation of button
		button.animation.play('idle');

		index = -1;
		curSelected = index;
	}

	override function closeSubState() 
	{
		persistentUpdate = true;
		super.closeSubState();
	}

	override function update(elapsed:Float)
	{
		if (controls.BACK) {
			persistentUpdate = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}