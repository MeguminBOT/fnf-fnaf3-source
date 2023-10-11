// Early Custom Freeplay Menu version.

package;
#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end

// FNAF 3 Specific Imports
import flixel.FlxCamera;
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.input.keyboard.FlxKeyList;
import Achievements;

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	private static var curSelected:Int = 0;
	var curDifficulty:Int = -1;
	private static var lastDifficultyName:String = '';

	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var intendedColor:Int;
	var colorTween:FlxTween;

	/*-------- VS FNAF 3 Custom Freeplay Menu --------*/
	// UI Text Stuff
	var textBG:FlxSprite;
	var scoreText:FlxText;
	var helpText:FlxText;
	var dynamicHelpText:String;

	// UI Button stuff
	var btnGroup:FlxTypedGroup<FlxButton>;
	var outlineGroup:FlxSpriteGroup;
	var btnGroups:Array<FlxTypedGroup<FlxButton>> = [];
	var outlineGroups:Array<FlxSpriteGroup> = [];

	// Songlist
	var songList:Array<String> = ['taken-apart', 'retribution', 'fear-forever', 'everlasting', 'brain-damage', 'party-room', 'totally-real', 'last-hour', 'waffles', 'leantrap', 'endo-revengo', 'misconception', 'out-of-bounds', 'until-next-time'];

	// Filepath shortcuts
	var menuPath:String = 'freeplay/';
	var songSprites:String = 'freeplay/songs/';

	// Button properties 
	// DO NOT CHANGE THESE VARIABLES THEY'RE HANDLED IN A FUNCTION LATER ON.
	var btnWidth:Float = 0; // Width of each button.
	var btnHeight:Float = 0; // Height of each button.
	var outlineWidth:Float = 0; // Width of the outline image.
	var outlineHeight:Float = 0; // Height of the outline image. 
	var btnX:Float = 0; // X position of the button row.
	var btnY:Float = 0; // Y position of the button row.
	var outlineX:Float = 0; // X position of the outline.
	var outlineY:Float = 0; // Y position of the outline.
	var btnSpacing:Int = 0; // Space between each button.

	// Secret Code properties 395248
	var secretCode:Array<Int> = [3, 9, 5, 2, 4, 8];
	var userInput:Array<Int> = [];

	// Cameras
	private var camMenu:FlxCamera;
	private var camAchievement:FlxCamera;

	/*------------------------------------------------*/

	override function create()
	{
		
		FlxG.mouse.visible = true; // Make the mouse visible since the UI is made for mouse and touch input.

		Paths.clearStoredMemory(); // Force clear cache.
		Paths.clearUnusedMemory(); // Force clear unused but allocated memory.
		
		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		for (i in 0...WeekData.weeksList.length) {
			if(weekIsLocked(WeekData.weeksList[i])) continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			for (j in 0...leWeek.songs.length)
			{
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}

			WeekData.setDirectoryFromWeek(leWeek);
			for (song in leWeek.songs)
			{
				var colors:Array<Int> = song[2];
				if(colors == null || colors.length < 3)
				{
					colors = [146, 113, 253];
				}
				addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
			}
		}

		WeekData.loadTheFirstEnabledMod();

        var bg = new FlxSprite().loadGraphic(Paths.image(menuPath + 'menuBG'));
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg);
        bg.screenCenter();

		WeekData.setDirectoryFromWeek();

		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		changeSelection();

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		/* Call our separated function for creating cameras */
		cameraSetup(); /* Call our separated function for creating cameras */

		/* Call our separated function for creating song buttons */
		btnGroups.push(createGroup(songList));

		/* Call our separated function for creating text objects */
		createTextStuff();

		super.create();
	}

	/*--------------- Start of FNAF 3 Menu Stuff --------------- */
	function cameraSetup()
	{
		camMenu = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camMenu);
		FlxG.cameras.add(camAchievement, false);
		FlxG.cameras.setDefaultDrawTarget(camMenu, true);
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

		// Create text showing the players highest score.
		scoreText = new FlxText(textBG.x + 4, textBG.y + 4, FlxG.width, "", 32);
		scoreText.setFormat(Paths.font("5Computers-In-Love.ttf"), 16, FlxColor.WHITE, CENTER);
		add(scoreText);

		// Choose what help text to display based on target build.
		#if PRELOAD_ALL
		dynamicHelpText = "Press SPACE to listen to the Song - Press CTRL to open the Gameplay Changers Menu - Press RESET to Reset your Score and Accuracy.\nPress ALT to open the Achievements Menu.";
		#else
		dynamicHelpText = "Press CTRL to open the Gameplay Changers Menu";
		#end

		// Create text showing the players highest score.
		helpText = new FlxText(textBG.x + 4, textBG.y + 36, FlxG.width, dynamicHelpText, 16);
		helpText.setFormat(Paths.font("5Computers-In-Love.ttf"), 8, FlxColor.WHITE, CENTER);
		helpText.scrollFactor.set();
		add(helpText);
	}

	public function createGroup(songList:Array<String>):FlxTypedGroup<FlxButton> 
	{
		// Initialize groups.
		btnGroup = new FlxTypedGroup<FlxButton>();
		outlineGroup = new FlxSpriteGroup();
	
		for (i in 0...songList.length) {
			// Sets a bigger or smaller size of the buttons depending on the index range. 
			if (i >= 0 && i <= 3) { // Row 1.
				btnWidth = 185;
				btnHeight = 185;
				outlineWidth = 237;
				outlineHeight = 237;
				btnSpacing = 25;
			} else { // Row 2 and Row 3.
				btnWidth = 148;
				btnHeight = 148;
				outlineWidth = 189;
				outlineHeight = 189;
				btnSpacing = 25;
			}
	
			// Position configuration depending on the index range.
			if (i >= 0 && i <= 3) { // Row 1
				btnX = 230 + (btnWidth + btnSpacing) * i;
				btnY = 64;
				outlineX = btnX - (outlineWidth - btnWidth) / 2;
				outlineY = btnY - (outlineHeight - btnHeight) / 2;
			} else if (i >= 4 && i <= 8) { // Row 2
				btnX = 200 + (btnWidth + btnSpacing) * (i - 4);
				btnY = 264;
				outlineX = btnX + (btnWidth - outlineWidth) / 2 - 6;
				outlineY = btnY - (outlineHeight - btnHeight) / 2 - 6;
			} else if (i >= 9 && i <= 13) { // Row 3
				btnX = 200 + (btnWidth + btnSpacing) * (i - 9);
				btnY = 448;
				outlineX = btnX + (btnWidth - outlineWidth) / 2 - 6;
				outlineY = btnY - (outlineHeight - btnHeight) / 2 - 6;
			}

			// Automatically create the appropiate amount of buttons.
			var button = createButton(btnX, btnY, i, songList);
			btnGroup.add(button);
	
			// Automatically create the appropiate amount of outlines.
			var outline = createOutline(outlineX, outlineY);
			outlineGroup.add(outline);
		}
		add(btnGroup);
		add(outlineGroup);
	
		return btnGroup;
	}

	function createButton(btnX:Float, btnY:Float, index:Int, songList:Array<String>):FlxButton
	{
		// Button creation.
		var button = new FlxButton(btnX, btnY, "", onButtonClicked.bind(index, songList));

		// Load a sprite sharing the exact name of the song.
		button.loadGraphic(Paths.image(songSprites + songList[index]));
		
		// Scale the button to the desired size.
		button.scale.set(btnWidth / button.width, btnHeight / button.height); 

		// Assign button events to functions.
		button.onOver.callback = onButtonHighlight.bind(index, songList);
		button.onOut.callback = onButtonDeselect.bind(index, songList); 
		
		return button;
	}

	/* 	function createButton(btnX:Float, btnY:Float, index:Int, songList:Array<String>):FlxButton {
		var button = new FlxButton(btnX, btnY, "", onButtonClicked.bind(index, songList));
		
		var song:String = songList[index];
		var daSong:String = FNAFdata.formatSong(song, 0); // Assuming difficulty level 0 for simplicity
		
		if (FNAFdata.getProgress(song, 0) > 0) {
			// Song is unlocked, load the unlocked sprite
			button.loadGraphic(Paths.image(songSprites + song));
		} else {
			// Song is locked, load the locked sprite
			button.loadGraphic(Paths.image(lockedSongSprites + song));
		}
		
		button.scale.set(btnWidth / button.width, btnHeight / button.height); // Scale the button to the desired size.
		button.onOver.callback = onButtonHighlight.bind(index, songList); // Assign the onOver event with the callback function
		button.onOut.callback = onButtonDeselect.bind(index, songList); // Assign the onOut event with the callback function
		
		return button;
	} */

	function createOutline(outlineX:Float, outlineY:Float):FlxSprite 
	{
		// Outline creation.
		var outline = new FlxSprite(outlineX, outlineY);

		// Load the outline sprite.
		outline.loadGraphic(Paths.image(menuPath + "buttonOutline")); 

		// Scale the button to the desired size.
		outline.scale.set(outlineWidth / outline.width, outlineHeight / outline.height); // Scale the outline to the desired size.
		
		return outline;
	}

	function onButtonClicked(index:Int, songList:Array<String>) 
	{
		persistentUpdate = false;

		// Set the current selection to the index of the clicked button
		curSelected = index; 

		var songLowercase:String = Paths.formatToSongPath(songList[curSelected]);
		var songFormatted:String = Highscore.formatSong(songLowercase, curDifficulty);

		// Play a sound when the button is highlighted.
		FlxG.sound.play(Paths.sound('confirmMenu'), 1);

		PlayState.SONG = Song.loadFromJson(songFormatted, songLowercase);
		PlayState.isStoryMode = false;
		PlayState.storyDifficulty = curDifficulty;

		LoadingState.loadAndSwitchState(FlxG.keys.pressed.SHIFT ? new ChartingState() : new PlayState());

		FlxG.mouse.visible = false;
		FlxG.sound.music.volume = 0;
		destroyFreeplayVocals();
	}

	function onButtonHighlight(index:Int, songList:Array<String>) 
	{
		persistentUpdate = false;

		// Set the current selection to the index of the highlighted button
		curSelected = index;

		var songLowercase:String = Paths.formatToSongPath(songList[curSelected]);
		var songFormatted:String = Highscore.formatSong(songLowercase, curDifficulty);
		
		#if !switch
		intendedScore = Highscore.getScore(songLowercase, curDifficulty);
		intendedRating = Highscore.getRating(songLowercase, curDifficulty);
		#end

		// Play a sound when the button is highlighted.
		FlxG.sound.play(Paths.sound('scrollMenu'), 1);

		// Scale up the button size by 10%
		var button = btnGroup.members[curSelected];
		var outline = outlineGroup.members[curSelected];
		button.scale.set(button.scale.x * 1.1, button.scale.y * 1.1);
		outline.scale.set(outline.scale.x * 1.1, outline.scale.y * 1.1);

		#if debug
		/* Debug build stuff. */
		trace("curSelected: " + curSelected + ", songFormatted: " + songFormatted);
		#end
	}

	function onButtonDeselect(index:Int, songList:Array<String>) 
	{
		persistentUpdate = false;
		curSelected = index;
	  
		// Scale down the button size to original size.
		var button = btnGroup.members[curSelected];
		var outline = outlineGroup.members[curSelected];
		button.scale.set(button.scale.x / 1.1, button.scale.y / 1.1);
		outline.scale.set(outline.scale.x / 1.1, outline.scale.y / 1.1);

		index = -1;
		curSelected = index;

		#if debug
		/* Debug build stuff. */
		trace("curSelected: " + curSelected);
		#end
	}

	function onSecretCode() 
	{
		persistentUpdate = false;

		#if ACHIEVEMENTS_ALLOWED
			unlockAchievement();
		#end

		FlxG.sound.play(Paths.sound('confirmMenu'), 1);

		PlayState.SONG = Song.loadFromJson('out-of-bounds', 'out-of-bounds');
		PlayState.isCodeInput = true;

		LoadingState.loadAndSwitchState(FlxG.keys.pressed.SHIFT ? new ChartingState() : new PlayState());

		FlxG.mouse.visible = false;
		FlxG.sound.music.volume = 0;
		destroyFreeplayVocals();
    }

	function checkSecretCode(): Void {
		// Initialize with an invalid value.
		var keyPressed:Int = -1; 
		
		// Array access was apparently not "allowed" so here's some ugly if/else conditions.
		// Checks if any of the specific keys are pressed.
		if (FlxG.keys.justPressed.THREE) {
			keyPressed = 3;
			trace("Button pressed: THREE");
		} else if (FlxG.keys.justPressed.NINE) {
			keyPressed = 9;
			trace("Button pressed: NINE");
		} else if (FlxG.keys.justPressed.FIVE) {
			keyPressed = 5;
			trace("Button pressed: FIVE");
		} else if (FlxG.keys.justPressed.TWO) {
			keyPressed = 2;
			trace("Button pressed: TWO");
		} else if (FlxG.keys.justPressed.FOUR) {
			keyPressed = 4;
			trace("Button pressed: FOUR");
		} else if (FlxG.keys.justPressed.EIGHT) {
			keyPressed = 8;
			trace("Button pressed: EIGHT");
		}
		
		if (keyPressed != -1) {
			// Check if the pressed key matches the expected number.
			if (userInput.length < secretCode.length) {
				if (keyPressed == secretCode[userInput.length]) {
					// Pressed key matches, push it into userInput.
					userInput.push(keyPressed);
					FlxG.sound.play(Paths.sound('success'), 1);
					trace("Current userInput: " + userInput);
				} else {
					// Pressed key doesn't match, reset userInput.
					userInput = []; 
					FlxG.sound.play(Paths.sound('fail'), 1);
					trace("Invalid key press. userInput cleared.");
				}
			}
			
			if (userInput.length == secretCode.length) {
				var isSecretCodeMatched:Bool = true;
				
				// Check if the userInput matches the secretCode.
				for (i in 0...userInput.length) {
					if (userInput[i] != secretCode[i]) {
						isSecretCodeMatched = false;
						break;
					}
				}

				if (isSecretCodeMatched) {
					trace("Secret code matched!");
					onSecretCode();
				} else {
					userInput = []; // Clear userInput if the secret code is not matched
					trace("Secret code not matched. userInput cleared.");
				}
			}
		}
	}

	function unlockAchievement()
	{
		Achievements.loadAchievements();
		var achieveID:Int = Achievements.getAchievementIndex('code_cracker');
		if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) {
			Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
			add(new AchievementObject('code_cracker', camAchievement));
			trace('Giving achievement "code_cracker"');
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
			ClientPrefs.saveSettings();
		}
	}
	/*--------------- End of FNAF 3 Menu Stuff --------------- */

	override function closeSubState() 
	{
		changeSelection(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color));
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}

	var instPlaying:Int = -1;
	public static var vocals:FlxSound = null;
	var holdTime:Float = 0;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		positionHighscore();

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
	
		if (FlxG.keys.justPressed.SPACE) {
			try {
				if (instPlaying != curSelected && curSelected != -1) {
					var songLowercase:String = Paths.formatToSongPath(songList[curSelected]);
					var songFormatted:String = Highscore.formatSong(songLowercase, curDifficulty);
					#if PRELOAD_ALL
					destroyFreeplayVocals();
					FlxG.sound.music.volume = 0;
					Paths.currentModDirectory = songs[curSelected].folder;
					PlayState.SONG = Song.loadFromJson(songFormatted, songLowercase);
					if (PlayState.SONG.needsVoices)
						vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
					else
						vocals = new FlxSound();
		
					FlxG.sound.list.add(vocals);
					FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.7);
					vocals.play();
					vocals.persist = true;
					vocals.looped = true;
					vocals.volume = 0.7;
					instPlaying = curSelected;
					#end
				}
			} catch (error:Dynamic) {
				// Handle the error here
				trace("An error occurred: " + error);
			}
		}

		if (controls.BACK) {
			persistentUpdate = false;
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if(FlxG.keys.justPressed.CONTROL) {
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}

		if (FlxG.keys.justPressed.ALT) {
			persistentUpdate = false;
			openSubState(new AchievementsMenuState());
			FlxG.sound.play(Paths.sound('done'), 0.7);
		}

		super.update(elapsed);

		// Check for secret code input.
		checkSecretCode();
	}

	public static function destroyFreeplayVocals() {
		if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;
		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end
		
		Paths.currentModDirectory = songs[curSelected].folder;
		PlayState.storyWeek = songs[curSelected].week;

		// Get the difficulties for the current song
		CoolUtil.getDifficulties(Paths.formatToSongPath(songs[curSelected].songName), true);
			
		if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
		{
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		}
		else
		{
			curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
		{
			curDifficulty = newPos;
		}
	}

	private function positionHighscore() {

	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";

	public function new(song:String, week:Int, songCharacter:String, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}