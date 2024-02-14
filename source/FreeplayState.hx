package;

#if desktop
import Discord.DiscordClient;
#end

import editors.ChartingState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import WeekData;

// FNAF 3 Specific Imports
import flixel.FlxCamera;
import flixel.ui.FlxButton;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import Achievements;
import SongUnlock;

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	private static var curSelected:Int = 0;
	var curDifficulty:Int = -1;
	private static var lastDifficultyName:String = '';

	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	/*-------- VS FNAF 3 Custom Freeplay Menu --------*/
	// Songlist
	var songList:Array<String> = ['taken-apart', 'retribution', 'fear-forever', 'everlasting', 'brain-damage', 'party-room', 'totally-real', 'last-hour', 'waffles', 'leantrap', 'endo-revengo', 'misconception', 'out-of-bounds', 'until-next-time'];
	
	// Filepath shortcuts
	var spritePath:String = 'menus/freeplayMenu/';
	var songSprites:String = 'menus/freeplayMenu/songs/';

	// UI Text Stuff
	var textBG:FlxSprite;
	var scoreText:FlxText;
	var ratingSplit:Array<String>;

	// Song Button stuff
	var btnGroup:FlxTypedGroup<FlxButton>;
	var outlineGroup:FlxSpriteGroup;
	var btnGroups:Array<FlxTypedGroup<FlxButton>> = [];
	var outlineGroups:Array<FlxSpriteGroup> = [];

	// Song Button properties 
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

	// Modifiers
	var modifierButton:FlxButton;

	// Difficulty
	var difficultyButton:FlxButton;
	var difficultyTablet:FlxSprite;
	var isDiffTablet:Bool = false;
	var diffNormal:FlxText;
	var diffEasy:FlxText;

	// Difficulty
	var awardsButton:FlxButton;

	/*------------------------------------------------*/

	override function create()
	{
		Paths.clearStoredMemory(); // Force clear cache.
		Paths.clearUnusedMemory(); // Force clear unused but allocated memory.

		var mouseSprite:FlxSprite = new FlxSprite(Paths.image('cursor'));
		FlxG.mouse.load(mouseSprite.pixels);
		FlxG.mouse.visible = true; // Make the mouse visible since the UI is made for mouse and touch input.

		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Freeplay Menu", null);
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

        var bg = new FlxSprite().loadGraphic(Paths.image('menus/bg'));
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

		/* Call our custom unlock progress. */
		SongUnlock.loadUnlockProgress();

		/* Call our separated function for creating cameras */
		cameraSetup();

		/* Call our separated function for creating song buttons */
		btnGroups.push(createGroup(songList));

		/* Call our separated function for creating text objects */
		createTextStuff();

		/* Call our separated function for creating various other menu buttons */
		createMenuButtons();

		/* Call our separated function for creating the difficulty selection menu */
		createDifficultyMenu();

		super.create();
	}

	/*--------------- Start of FNAF 3 Menu Stuff --------------- */
	function cameraSetup()
	{
		camMenu = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		camMenu.antialiasing = ClientPrefs.hudAntialiasing;
		camAchievement.antialiasing = ClientPrefs.hudAntialiasing;
		FlxG.cameras.reset(camMenu);
		FlxG.cameras.add(camAchievement, false);
		FlxG.cameras.setDefaultDrawTarget(camMenu, true);
	}

	function createTextStuff() 
	{
		// Create a transparent background for the text objects.
		textBG = new FlxSprite(0, 0).makeGraphic(FlxG.width, 100, 0xFF000000);
		textBG.y = FlxG.height * 0.86;
		textBG.screenCenter(X);
		textBG.scrollFactor.set();
		textBG.alpha = 0.5;
		add(textBG);

		// Create text showing the players highest score.
		scoreText = new FlxText(textBG.x + 18, textBG.y + 6, FlxG.width, "", 32);
		scoreText.setFormat(Paths.font("5Computers-In-Love.ttf"), 16, FlxColor.WHITE, CENTER);
		add(scoreText);

	}

	function createMenuButtons()
	{
		modifierButton = new FlxButton(0, 650, "", openModifiers.bind());
		modifierButton.loadGraphic(Paths.image(spritePath + 'modifierButton'), true, 360, 60);
		add(modifierButton);

		awardsButton = new FlxButton(500, 650, "", openAwards.bind());
		awardsButton.loadGraphic(Paths.image(spritePath + 'awardsButton'), true, 240, 60);
		add(awardsButton);

		difficultyButton = new FlxButton(820, 650, "", difficultySelector.bind());
		difficultyButton.loadGraphic(Paths.image(spritePath + 'difficultyButton'), true, 400, 60);
		add(difficultyButton);
	}

	// PLEASE DON'T LOOK AT ME I'M UGLY
	function createDifficultyMenu()
	{
		difficultyTablet = new FlxSprite();
		difficultyTablet.loadGraphic(Paths.image(spritePath + 'tablet_options'));
		difficultyTablet.frames = Paths.getSparrowAtlas(spritePath + 'tablet_options');
		difficultyTablet.antialiasing = ClientPrefs.globalAntialiasing;
		difficultyTablet.x = 800;
		difficultyTablet.y = 340;
		difficultyTablet.scale.x = 0.7;
		difficultyTablet.scale.y = 0.7;
		difficultyTablet.updateHitbox();
		difficultyTablet.animation.addByPrefix('Anim In', 'Anim In', 48, false);
		difficultyTablet.animation.addByPrefix('Anim Out', 'Anim Out', 48, false);
		difficultyTablet.animation.addByPrefix('Anim Opened', 'Anim Opened', 48, true);
		add(difficultyTablet);

		diffNormal = new FlxText(difficultyTablet.x + 72, difficultyTablet.y + 36, 0, '', 16, true);
		diffNormal.setFormat(Paths.font('stalker1.ttf'), 64, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.GREEN, true);
		diffNormal.borderSize = 2;
		diffNormal.visible = false;
		add(diffNormal);

		diffEasy = new FlxText(difficultyTablet.x + 108, diffNormal.y + 64, 0, '', 16, true);
		diffEasy.setFormat(Paths.font('stalker1.ttf'), 64, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.GREEN, true);
		diffEasy.borderSize = 2;
		diffEasy.visible = false;
		add(diffEasy);
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
				btnY = 44;
				outlineX = btnX - (outlineWidth - btnWidth) / 2;
				outlineY = btnY - (outlineHeight - btnHeight) / 2;
			} else if (i >= 4 && i <= 8) { // Row 2
				btnX = 200 + (btnWidth + btnSpacing) * (i - 4);
				btnY = 244;
				outlineX = btnX + (btnWidth - outlineWidth) / 2 - 6;
				outlineY = btnY - (outlineHeight - btnHeight) / 2 - 6;
			} else if (i >= 9 && i <= 13) { // Row 3
				btnX = 200 + (btnWidth + btnSpacing) * (i - 9);
				btnY = 428;
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

		// Check if the song is unlocked.
		var songName = songList[index].split(' ').join('').split('-').join('');
		if (SongUnlock.isSongUnlocked(songName)) {
			// Load a sprite sharing the name of the song.
			button.loadGraphic(Paths.image(songSprites + songList[index]));
		} else {
			if (index >= 12) {
				// Load secret locked song sprite.
				button.loadGraphic(Paths.image(spritePath + "lockedSongCode"));
			} else {
				// Load standard locked song sprite.
				button.loadGraphic(Paths.image(spritePath + "lockedSong"));
			}
		}
		
		// Scale the button to the desired size.
		button.scale.set(btnWidth / button.width, btnHeight / button.height); 

		// Assign button events to functions.
		button.onOver.callback = onButtonHighlight.bind(index, songList);
		button.onOut.callback = onButtonDeselect.bind(index, songList); 
		
		return button;
	}

	function createOutline(outlineX:Float, outlineY:Float):FlxSprite 
	{
		// Outline creation.
		var outline = new FlxSprite(outlineX, outlineY);

		// Load the outline sprite.
		outline.loadGraphic(Paths.image(spritePath + "buttonOutline")); 

		// Scale the button to the desired size.
		outline.scale.set(outlineWidth / outline.width, outlineHeight / outline.height); // Scale the outline to the desired size.
		
		return outline;
	}

	function onButtonClicked(index:Int, songList:Array<String>) 
	{
		persistentUpdate = false;

		// Set the current selection to the index of the clicked button
		curSelected = index; 

		// Prevent player from playing a song if they haven't cleared Story Mode.
		var achieveID:Int = Achievements.getAchievementIndex('week1');
		if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) {
			camMenu.shake(0.05, 0.25);
			return;
		}

		// Prevent player from starting secret songs.
		var songNoSymbol = songList[curSelected].split(' ').join('').split('-').join('');
		if (index >= 12 && !SongUnlock.isSongUnlocked(songNoSymbol)) {
			camMenu.shake(0.05, 0.25);
			return;
		}

		var songLowercase:String = Paths.formatToSongPath(songList[curSelected]);
		var songFormatted:String = Highscore.formatSong(songLowercase, curDifficulty);

		// Play a sound when the button is clicked.
		FlxG.sound.play(Paths.sound('confirmMenu'), 1);

		PlayState.SONG = Song.loadFromJson(songFormatted, songLowercase);
		PlayState.isStoryMode = false;
		PlayState.storyDifficulty = curDifficulty;

		LoadingState.loadAndSwitchState(FlxG.keys.pressed.SHIFT ? new ChartingState() : new PlayState());

		FlxG.mouse.visible = false;
		FlxG.sound.music.volume = 0;
	}

	function onButtonHighlight(index:Int, songList:Array<String>) 
	{
		persistentUpdate = false;

		// Set the current selection to the index of the highlighted button
		curSelected = index;

		var songNoSymbol = songList[curSelected].split(' ').join('').split('-').join('');
		var songLowercase:String = Paths.formatToSongPath(songList[curSelected]);
		var songFormatted:String = Highscore.formatSong(songLowercase, curDifficulty);
		
		#if !switch
		intendedScore = Highscore.getScore(songLowercase, curDifficulty);
		intendedRating = Highscore.getRating(songLowercase, curDifficulty);
		#end

		// Play a sound when the button is highlighted.
		FlxG.sound.play(Paths.sound('scrollMenu'), 1);

		if (SongUnlock.isSongUnlocked(songNoSymbol)) {
			var button = btnGroup.members[curSelected];
			var outline = outlineGroup.members[curSelected];
			button.scale.set(button.scale.x * 1.1, button.scale.y * 1.1);
			outline.scale.set(outline.scale.x * 1.1, outline.scale.y * 1.1);
		}

		#if debug
		/* Debug build stuff. */
		trace("curSelected: " + curSelected + ", songFormatted: " + songFormatted);
		#end
	}

	function onButtonDeselect(index:Int, songList:Array<String>) 
	{
		persistentUpdate = false;
		curSelected = index;
	  
		var songNoSymbol = songList[curSelected].split(' ').join('').split('-').join('');
		if (SongUnlock.isSongUnlocked(songNoSymbol)) {
			var button = btnGroup.members[curSelected];
			var outline = outlineGroup.members[curSelected];
			button.scale.set(button.scale.x / 1.1, button.scale.y / 1.1);
			outline.scale.set(outline.scale.x / 1.1, outline.scale.y / 1.1);
		}

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

		PlayState.isCodeInput = true;
		PlayState.isStoryMode = true;

		PlayState.storyPlaylist = ['out-of-bounds', 'until-next-time'];

		var diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
		if(diffic == null) diffic = '';

		PlayState.storyDifficulty = curDifficulty;
		PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());

		PlayState.campaignScore = 0;
		PlayState.campaignMisses = 0;

		new FlxTimer().start(1, function(tmr:FlxTimer) {
			LoadingState.loadAndSwitchState(new PlayState(), true);
		});

		FlxG.mouse.visible = false;
		FlxG.sound.music.volume = 0;
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

	public function difficultySelector()
	{
		isDiffTablet = true;
		difficultyTablet.visible = true;
		difficultyTablet.animation.play('Anim In');

		difficultyTablet.animation.finishCallback = function(name:String) {
			switch (name) {
				case 'Anim In':
					difficultyTablet.animation.play('Anim Opened');
					diffNormal.visible = true;
					diffEasy.visible = true;
	
				case 'Anim Out':
					isDiffTablet = false;
					difficultyTablet.visible = false;
			}
		};
	}

	public function openModifiers()
	{
		openSubState(new GameplayChangersSubstate());
	}

	public function openAwards()
	{
		MusicBeatState.switchState(new AchievementsMenuState());
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

		if (controls.UI_LEFT_P || controls.UI_RIGHT_P || controls.UI_DOWN_P || controls.UI_UP_P) {
			if (isDiffTablet) {
				if (curDifficulty != 0) {
					curDifficulty = 0;
				} else {
					curDifficulty = 1;
				}
			}
		}

		/* This is such a ugly way to get this working */
		// Lulu
		if (curDifficulty == 1) {
			diffNormal.text = "< Normal >";
			diffEasy.text = "Easy";
			scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';

		} else if (curDifficulty == 0) {
			diffNormal.text = "Normal";
			diffEasy.text = "< Easy >";
			scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		}

		if (controls.BACK) {
			if (isDiffTablet) {
				diffNormal.visible = false;
				diffEasy.visible = false;
				difficultyTablet.animation.play('Anim Out');
				
			} else {
				persistentUpdate = false;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}
		}

		if(FlxG.keys.justPressed.CONTROL && !isDiffTablet) {
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}

		if (FlxG.keys.justPressed.ALT && !isDiffTablet) {
			persistentUpdate = false;
			FlxG.sound.play(Paths.sound('done'), 0.7);
			MusicBeatState.switchState(new AchievementsMenuState());
			
		}

		super.update(elapsed);

		// Check for secret code input.
		checkSecretCode();
	}
	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

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