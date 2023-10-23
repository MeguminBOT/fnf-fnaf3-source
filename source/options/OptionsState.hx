package options;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.animation.FlxAnimationController;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.ui.FlxButton;
import Controls;

using StringTools;

class OptionsState extends MusicBeatState
{
	private static var curSelected:Int = 0;

	// Options list
	var menuList:Array<String> = ['Notecolors', 'Controls', 'Notedelay', 'Graphics', 'Visuals', 'Gameplay', 'Accessibility'];

	// Filepath shortcut
	var spritePath:String = 'options/';

	// UI Button stuff
	var btnGroup:FlxTypedGroup<FlxButton>;
	var btnGroups:Array<FlxTypedGroup<FlxButton>> = [];

	// Button properties 
	// DO NOT CHANGE THESE VARIABLES THEY'RE HANDLED IN A FUNCTION LATER ON.
	var btnWidth:Int = 0; // Width of each button.
	var btnHeight:Int = 0; // Height of each button.
	var btnX:Int = 0; // X position of the button row.
	var btnY:Int = 0; // Y position of the button row.
	var btnSpacing:Int = 0; // Space between each button.

	// Bullshit position work around for frames.
	var highlightedFrames:Array<FlxSprite> = [];
	var pressedFrames:Array<FlxSprite> = [];

	override function create()
	{
		FlxG.mouse.visible = true; // Make the mouse visible since the UI is made for mouse and touch input.

		#if desktop
		// Updating Discord Rich Presence.
		DiscordClient.changePresence("Options Menu", null);
		#end

        var bg = new FlxSprite().loadGraphic(Paths.image('menuBG'));
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg);
        bg.screenCenter();

		/* Call our separated function for creating menu buttons */
		btnGroups.push(createGroup(menuList));

		ClientPrefs.saveSettings();

		super.create();
	}

	public function createGroup(menuList:Array<String>):FlxTypedGroup<FlxButton> 
	{
		// Initialize group.
		btnGroup = new FlxTypedGroup<FlxButton>();
	
		for (i in 0...menuList.length) {
			btnWidth = FlxG.width; // Set the button width to the game width, to prevent a really dumb bug I have no clue how to properly fix.
			btnHeight = 55;
			btnSpacing = 24;
			btnX = 69; // haha funny number.
			btnY = 100 + (btnHeight + btnSpacing) * i;
	
			// Automatically create the appropiate amount of buttons.
			var button = createButton(btnX, btnY, i, menuList);
			btnGroup.add(button);
		}
		add(btnGroup);
	
		return btnGroup;
	}

	function createButton(btnX:Int, btnY:Int, index:Int, menuList:Array<String>):FlxButton
	{
		// Button creation.
		var button = new FlxButton(btnX, btnY, "", onButtonClicked.bind(index, menuList));

		// Load a sprite sharing the name of the menu.
		button.loadGraphic(Paths.image(spritePath + menuList[index].toLowerCase()));
		button.frames = Paths.getSparrowAtlas(spritePath + menuList[index].toLowerCase());
		button.animation.addByPrefix('idle', menuList[index] + ' idle', 24, true);
		button.animation.addByPrefix('highlighted', menuList[index] + ' highlighted', 24, true);
		button.animation.addByPrefix('pressed', menuList[index] + ' pressed', 24, true);

		button.width = btnWidth;
		button.height = btnHeight;

		// Assign button events to functions.
		button.onOver.callback = onButtonHighlight.bind(index, menuList);
		button.onOut.callback = onButtonDeselect.bind(index, menuList); 

		button.animation.play('idle');

		/* 	
			The onDown and onUp event triggers even when you hold your mouse button down and hover over/hover out of the button. 
			Setting allowSwiping to false will prevent this.
		*/
		button.allowSwiping = false;
		
		return button;
	}

	function onButtonClicked(index:Int, menuList:Array<String>) 
	{
		// Set the current selection to the index of the clicked button.
		curSelected = index;

		var button = btnGroup.members[curSelected];
		button.animation.play('pressed');

		// Play a sound when the button is clicked.
		FlxG.sound.play(Paths.sound('done'), 1);

		// Handle button actions based on index.
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
		button.x = 69;
		button.y = button.y + 1;
	}

	function onButtonHighlight(index:Int, menuList:Array<String>) 
	{
		curSelected = index;

		var button = btnGroup.members[curSelected];
		button.x = 4;
		button.y = button.y - 1; // No, using -= doesn't work here due to how dumb the FlxButton events are handled.
		button.animation.play('highlighted');
	}

	function onButtonDeselect(index:Int, menuList:Array<String>) 
	{
		curSelected = index;

		var button = btnGroup.members[curSelected];
		button.x = 69;
		button.y = button.y + 1;
		button.animation.play('idle');

		index = -1;
		curSelected = index;
	}

	override function closeSubState() 
	{
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
	}
}