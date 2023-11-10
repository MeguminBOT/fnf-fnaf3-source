package;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;

// FNAF 3 Specific Imports
import flixel.ui.FlxButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import Achievements;

using StringTools;

class AchievementsMenuState extends MusicBeatState
{
	#if ACHIEVEMENTS_ALLOWED
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	private var achievementArray:Array<AttachedAchievement> = [];
	private var achievementIndex:Array<Int> = [];

	/*-------- VS FNAF 3 Custom Achievements Menu --------*/
	// UI Text Stuff
	var textBG:FlxSprite;
	var dynamicText:FlxText;

	// UI Button stuff
	var btnGroup:FlxTypedGroup<FlxButton>;
	var btnGroups:Array<FlxTypedGroup<FlxButton>> = [];

	// Achievement List
	var achieveList:Array<String> = [];
	
	// Filepath shortcuts
	var spritePath:String = 'menus/achievementsMenu/';
	var achieveSprites:String = 'menus/achievementsMenu/achievements/';

	// Button properties 
	// DO NOT CHANGE THESE VARIABLES THEY'RE HANDLED IN A FUNCTION LATER ON.
	var btnWidth:Float = 0; // Width of each button.
	var btnHeight:Float = 0; // Height of each button.
	var btnX:Float = 0; // X position of the button row.
	var btnY:Float = 0; // Y position of the button row.
	var btnSpacing:Int = 0; // Space between each button.

	override function create()
	{
		FlxG.mouse.visible = true; // Make the mouse visible since the UI is made for mouse and touch input.

		Paths.clearStoredMemory(); // Force clear cache.
		Paths.clearUnusedMemory(); // Force clear unused but allocated memory.

		persistentUpdate = true;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Achievements Menu", null);
		#end

        var bg = new FlxSprite().loadGraphic(Paths.image(spritePath + 'bg'));
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg);
        bg.screenCenter();

		Achievements.loadAchievements();
		for (i in 0...Achievements.achievementsStuff.length) {
			if(!Achievements.achievementsStuff[i][3] || Achievements.achievementsMap.exists(Achievements.achievementsStuff[i][2])) {
				achievementIndex.push(i);
				achieveList.push(Achievements.achievementsStuff[i][2]);
			}
		}

		/* Call our separated function for creating song buttons */
		btnGroups.push(createGroup(achieveList));

		/* Call our separated function for creating text objects */
		createTextStuff();

		super.create();
	}

	function createTextStuff()
	{
		// Create a transparent background for the text objects.
		textBG = new FlxSprite(0, 0).makeGraphic(FlxG.width, 66, 0xFF000000);
		textBG.y = FlxG.height * 0.89;
		textBG.screenCenter(X);
		textBG.scrollFactor.set();
		textBG.alpha = 0.5;
		add(textBG);

		dynamicText = new FlxText(textBG.x + 4, textBG.y + 4, FlxG.width, "", 24);
		dynamicText.setFormat(Paths.font("stalker2.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		dynamicText.scrollFactor.set();
		dynamicText.borderSize = 2.4;
		add(dynamicText);
	}

	public function createGroup(achieveList:Array<String>):FlxTypedGroup<FlxButton> 
	{
		// Initialize groups.
		btnGroup = new FlxTypedGroup<FlxButton>();

		for (i in 0...achieveList.length) {
			btnWidth = 150;
			btnHeight = 150;
			btnSpacing = 12;

			// Position configuration depending on the index range.
			if (i >= 0 && i <= 5) { // Row 1
				btnX = 160 + (btnWidth + btnSpacing) * i;
				btnY = 64;
			} else if (i >= 6 && i <= 11) { // Row 2
				btnX = 160 + (btnWidth + btnSpacing) * (i - 6);
				btnY = 264;
			} else if (i >= 12 && i <= 17) { // Row 3
				btnX = 160 + (btnWidth + btnSpacing) * (i - 12);
				btnY = 448;
			}

			// Automatically create the appropiate amount of buttons.
			var button = createButton(btnX, btnY, i, achieveList);
			btnGroup.add(button);
		}
		add(btnGroup);
	
		return btnGroup;
	}

	function createButton(btnX:Float, btnY:Float, index:Int, achieveList:Array<String>):FlxButton
	{
		// Button creation.
		var button = new FlxButton(btnX, btnY, "", onButtonClicked.bind(index, achieveList));
	
		// Check if the achievement is unlocked.
		if (Achievements.isAchievementUnlocked(achieveList[index])) {
			// Load a sprite sharing the name of the achievement.
			button.loadGraphic(Paths.image(achieveSprites + achieveList[index]));
		} else {
			// Load locked sprite.
			button.loadGraphic(Paths.image(spritePath + "lockedachievement"));
		}

		// Scale the button to the desired size.
		button.scale.set(btnWidth / button.width, btnHeight / button.height); 
	
		// Assign button events to functions.
		button.onOver.callback = onButtonHighlight.bind(index, achieveList);
		button.onOut.callback = onButtonDeselect.bind(index, achieveList); 
		
		return button;
	}

	/*THIS FUNCTION CURRENTLY DOES NOTHING */
	function onButtonClicked(index:Int, achieveList:Array<String>) 
	{
		persistentUpdate = false;

		// Set the current selection to the index of the clicked button
		curSelected = index; 

		if (Achievements.isAchievementUnlocked(achieveList[curSelected])) {
			var button = btnGroup.members[curSelected];
			button.scale.set(button.scale.x / 1.1, button.scale.y / 1.1);
		}
	}

	function onButtonHighlight(index:Int, achieveList:Array<String>) 
	{
		persistentUpdate = false;

		// Set the current selection to the index of the highlighted button
		curSelected = index;

		var nameTxt:String = Achievements.achievementsStuff[achievementIndex[curSelected]][0];
		var descTxt:String = Achievements.achievementsStuff[achievementIndex[curSelected]][1];
		dynamicText.text = nameTxt + '\n' + descTxt;

		// Play a sound when the button is highlighted.
		FlxG.sound.play(Paths.sound('scrollMenu'), 1);

		if (Achievements.isAchievementUnlocked(achieveList[curSelected])) {
			var button = btnGroup.members[curSelected];
			button.scale.set(button.scale.x * 1.1, button.scale.y * 1.1);
		}

		#if debug
		/* Debug build stuff. */
		var indexName:String = Achievements.achievementsStuff[achievementIndex[curSelected]][2];
		trace("curSelected: " + curSelected + ", indexName: " + indexName);
		#end
	}

	function onButtonDeselect(index:Int, achieveList:Array<String>) 
	{
		persistentUpdate = false;
		curSelected = index;

		if (Achievements.isAchievementUnlocked(achieveList[curSelected])) {
			var button = btnGroup.members[curSelected];
			button.scale.set(button.scale.x / 1.1, button.scale.y / 1.1);
		}

		index = -1;
		curSelected = index;
		dynamicText.text = '';
	}

	override function update(elapsed:Float) 
	{
		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new FreeplayState());
		}
		super.update(elapsed);
	}
	#end
}