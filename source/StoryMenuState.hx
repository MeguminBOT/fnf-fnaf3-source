package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.graphics.FlxGraphic;
import WeekData;
import flixel.ui.FlxButton;

using StringTools;

class StoryMenuState extends MusicBeatState
{
	private static var curWeek:Int = 0;
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();
	var loadedWeeks:Array<WeekData> = [];

	private static var lastDifficultyName:String = '';
	var curDifficulty:Int = 1;

	var spritePath:String = 'menus/storyMenu/';

	var startButton:FlxButton;
	var normalButton:FlxButton;
	var easyButton:FlxButton;

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		var camMenu = new FlxCamera();
		camMenu.antialiasing = ClientPrefs.hudAntialiasing;
		FlxG.cameras.reset(camMenu);
		FlxG.cameras.setDefaultDrawTarget(camMenu, true);

		var mouseSprite:FlxSprite = new FlxSprite(Paths.image('cursor'));
		FlxG.mouse.load(mouseSprite.pixels);
		FlxG.mouse.visible = true; // Make the mouse visible since the UI is made for mouse and touch input.

		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);

		if(curWeek >= WeekData.weeksList.length) curWeek = 0;
		persistentUpdate = persistentDraw = true;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Story Menu", null);
		#end

		var num:Int = 0;
		for (i in 0...WeekData.weeksList.length) {
			var weekFile:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var isLocked:Bool = weekIsLocked(WeekData.weeksList[i]);
			if(!isLocked || !weekFile.hiddenUntilUnlocked) {
				loadedWeeks.push(weekFile);
				WeekData.setDirectoryFromWeek(weekFile);
				// Needs an offset thingie
				if (isLocked)
				{

				}
				num++;
			}
		}
		WeekData.setDirectoryFromWeek(loadedWeeks[0]);

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		if(lastDifficultyName == '') {
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}

		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));

		changeWeek();
		changeDifficulty();

		#if android
		addVirtualPad(LEFT_FULL, A_B_X_Y);
		#end

		super.create();

		var bg = new FlxSprite(-200, -200);
		bg.frames = Paths.getSparrowAtlas(spritePath + 'bg');
		bg.animation.addByPrefix('play', 'idle', 18, true);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
		bg.animation.play('play');
		bg.scale.set(0.666666, 0.666666);
		bg.updateHitbox();
		bg.x = 0;
		bg.y = 0;

		startButton = new FlxButton(0, 0, " ", selectDiff);
		startButton.screenCenter();
		add(startButton);
		startButton.loadGraphic(Paths.image(spritePath + 'start'), true, 169, 35);
		startButton.antialiasing = ClientPrefs.globalAntialiasing;
		startButton.x = 535;
		startButton.y = 385;

		FlxG.mouse.visible = true;
	}
	
	override function closeSubState()
	{
		persistentUpdate = true;
		changeWeek();

		super.closeSubState();
	}

	override function update(elapsed:Float)
	{
		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			MusicBeatState.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectDiff()
	{
		remove(startButton);

		normalButton = new FlxButton(0, 0, " ", startweek);
		normalButton.screenCenter();
		add(normalButton);
		normalButton.loadGraphic(Paths.image(spritePath + 'diffNormal'), true, 169, 35);
		normalButton.antialiasing = ClientPrefs.globalAntialiasing;
		normalButton.x = 535;
		normalButton.y = 367;
		normalButton.onOver.callback = onNormalHighlight.bind();

		easyButton = new FlxButton(0, 0, " ", startweekEasy);
		easyButton.screenCenter();
		add(easyButton);
		easyButton.loadGraphic(Paths.image(spritePath + 'diffEasy'), true, 169, 35);
		easyButton.antialiasing = ClientPrefs.globalAntialiasing;
		easyButton.x = 535;
		easyButton.y = 403;
		easyButton.onOver.callback = onEasyHighlight.bind();
	}

	function startweek()
	{
		persistentUpdate = false;

		if (!weekIsLocked(loadedWeeks[curWeek].fileName)) {
			if (stopspamming == false) {
				FlxG.sound.play(Paths.sound('confirmMenu'));
				stopspamming = true;
			}

			FlxG.mouse.visible = false;
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}

			PlayState.storyPlaylist = songArray;
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
			if(diffic == null) diffic = '';
			
			#if debug
			trace('Difficulty: ' + diffic);
			#end

			PlayState.storyDifficulty = curDifficulty;
			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.campaignMisses = 0;

			new FlxTimer().start(1, function(tmr:FlxTimer) {
				LoadingState.loadAndSwitchState(new PlayState(), true);
			});

		} else {
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
	}

	function startweekEasy()
	{
		persistentUpdate = false;

		if (!weekIsLocked(loadedWeeks[curWeek].fileName)) {
			if (stopspamming == false) {
				FlxG.sound.play(Paths.sound('confirmMenu'));
				stopspamming = true;
			}

			FlxG.mouse.visible = false;
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}

			PlayState.storyPlaylist = songArray;
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
			if(diffic == null) diffic = '';

			#if debug
			trace('Difficulty: ' + diffic);
			#end
	
			PlayState.storyDifficulty = curDifficulty;
			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.campaignMisses = 0;

			new FlxTimer().start(1, function(tmr:FlxTimer) {
				LoadingState.loadAndSwitchState(new PlayState(), true);
			});

		} else {
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
	}

	function onNormalHighlight() 
	{
		persistentUpdate = false;

		if (curDifficulty != 1) {
			curDifficulty = 1;
		}

		#if debug
		trace('Difficulty: ' + curDifficulty);
		#end
	}
	
	function onEasyHighlight() 
	{
		persistentUpdate = false;

		if (curDifficulty != 0) {
			curDifficulty = 0;
		}

		#if debug
		trace('Difficulty: ' + curDifficulty);
		#end
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		WeekData.setDirectoryFromWeek(loadedWeeks[curWeek]);

		var diff:String = CoolUtil.difficulties[curDifficulty];
		lastDifficultyName = diff;
	}

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= loadedWeeks.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = loadedWeeks.length - 1;

		var leWeek:WeekData = loadedWeeks[curWeek];
		WeekData.setDirectoryFromWeek(leWeek);
		PlayState.storyWeek = curWeek;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5

		if(diffStr != null && diffStr.length > 0) {
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0) {
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0) {
				CoolUtil.difficulties = diffs;
			}
		}
		
		if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty)) {
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		} else {
			curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1) {
			curDifficulty = newPos;
		}
	}

	function weekIsLocked(name:String):Bool 
	{
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}
}
