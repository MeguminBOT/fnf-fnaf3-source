package;

#if desktop
import Discord.DiscordClient;
#end

import editors.ChartingState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;

// Flash and Lime
import flash.text.TextField;
import lime.utils.Assets;

// FNAF 3 Specific Imports
import flixel.FlxCamera;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import Achievements;

using StringTools;

class AchievementsMenuState extends MusicBeatSubstate
{
	#if ACHIEVEMENTS_ALLOWED
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	private var achievementArray:Array<AttachedAchievement> = [];
	private var achievementIndex:Array<Int> = [];

	/*-------- VS FNAF 3 Custom Freeplay Menu --------*/
	// UI Text Stuff
	var textBG:FlxSprite;
	var dynamicText:FlxText;
	var dynamicHelpText:String;

	// UI Button stuff
	var btnGroup:FlxTypedGroup<FlxButton>;
	var btnGroups:Array<FlxTypedGroup<FlxButton>> = [];

	// achieveList
	var achieveList:Array<String> = ['friday_night_play', 'week1_nomiss', 'week1_gfc', 'week1', 'ur_good', 'ur_bad', 'oversinging', 'hype', 'code_cracker', 'secret_song_one', 'secret_song_two', 'boomer', 'pretty_face', 'traumatized'];
	
	// Filepath shortcuts
	var spritePath:String = 'achievements/';

	// Button properties 
	// DO NOT CHANGE THESE VARIABLES THEY'RE HANDLED IN A FUNCTION LATER ON.
	var btnWidth:Float = 0; // Width of each button.
	var btnHeight:Float = 0; // Height of each button.
	var btnX:Float = 0; // X position of the button row.
	var btnY:Float = 0; // Y position of the button row.
	var btnSpacing:Int = 0; // Space between each button.

	public function new()
	{
		super();
		
		var bg = new FlxSprite().loadGraphic(Paths.image('menus/bg'));
		add(bg);
	
		Achievements.loadAchievements();
		for (i in 0...Achievements.achievementsStuff.length) {
			if(!Achievements.achievementsStuff[i][3] || Achievements.achievementsMap.exists(Achievements.achievementsStuff[i][2])) {
				achieveList.push(Achievements.achievementsStuff[i]);
				achievementIndex.push(i);
			}
		}
		trace(achieveList);

		dynamicText = new FlxText(150, 600, 980, "", 32);
		dynamicText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		dynamicText.scrollFactor.set();
		dynamicText.borderSize = 2.4;
		add(dynamicText);

		btnGroup = createGroup(achieveList); // Initialize btnGroup before adding buttons.
		add(btnGroup);
	
		super.create();
	}


	public function createGroup(achieveList:Array<String>):FlxTypedGroup<FlxButton> 
	{
		// Initialize groups.
		btnGroup = new FlxTypedGroup<FlxButton>();

		for (i in 0...achieveList.length) {
			var achievementName:String = Achievements.achievementsStuff[achievementIndex[i]][2];

			// Sets a bigger or smaller size of the buttons depending on the index range. 
			if (i >= 0 && i <= 3) { // Row 1.
				btnWidth = 150;
				btnHeight = 150;
				btnSpacing = 12;
			} else { // Row 2 and Row 3.
				btnWidth = 150;
				btnHeight = 150;
				btnSpacing = 12;
			}
	
			// Position configuration depending on the index range.
			if (i >= 0 && i <= 5) { // Row 1
				btnX = 200 + (btnWidth + btnSpacing) * i;
				btnY = 64;
			} else if (i >= 6 && i <= 11) { // Row 2
				btnX = 200 + (btnWidth + btnSpacing) * (i - 6);
				btnY = 264;
			} else if (i >= 12 && i <= 17) { // Row 3
				btnX = 200 + (btnWidth + btnSpacing) * (i - 12);
				btnY = 448;
			}

			// Automatically create the appropiate amount of buttons.
			var button = createButton(btnX, btnY, i, achieveList, achievementName);
			btnGroup.add(button);
		}
		add(btnGroup);
	
		return btnGroup;
	}

	function createButton(btnX:Float, btnY:Float, index:Int, achieveList:Array<String>, achieveName:String):FlxButton
	{
		// Button creation.
		var button = new FlxButton(btnX, btnY, "", onButtonClicked.bind(index, achieveList));
	
		// Check if the song is unlocked.
		var achievementSaveTag:String = Achievements.achievementsStuff[achievementIndex[index]][2];

		if (Achievements.isAchievementUnlocked(achievementSaveTag)) {
			// Load achievement sprite.
			button.loadGraphic(Paths.image(spritePath + achieveName));
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

	function onButtonClicked(index:Int, achieveList:Array<String>) 
	{
		persistentUpdate = false;

		// Set the current selection to the index of the clicked button
		curSelected = index; 

		var nameTxt:String = Achievements.achievementsStuff[achievementIndex[curSelected]][0];
		var descTxt:String = Achievements.achievementsStuff[achievementIndex[curSelected]][1];
		dynamicText.text = nameTxt + '\n' + descTxt;
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
	}

	function onButtonDeselect(index:Int, achieveList:Array<String>) 
	{
		persistentUpdate = false;
		curSelected = index;

		index = -1;
		curSelected = index;
		dynamicText.text = '';
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			close();
		}
	}
	#end
}
