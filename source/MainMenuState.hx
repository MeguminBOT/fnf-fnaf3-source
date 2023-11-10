package;

#if desktop
import Discord.DiscordClient;
#end

import lime.app.Application;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import Achievements;

#if debug
import SongUnlock;
import flixel.input.keyboard.FlxKey;
import editors.MasterEditorMenu;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2 (Modified)'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;

	var spritePath:String = 'menus/mainMenu/';

	override function create()
	{
		FlxG.mouse.visible = true;

		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Main Menu", null);
		#end

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(spritePath + 'bg'));
		bg.frames = Paths.getSparrowAtlas(spritePath + 'bg');
		bg.animation.addByPrefix('play', 'idle', 18, true);
		bg.antialiasing = ClientPrefs.globalAntialiasing;

		bg.scale.set(0.666666, 0.666666);
		bg.updateHitbox();
		bg.animation.play('play');
		add(bg);

		var logothing:FlxSprite = new FlxSprite().loadGraphic(Paths.image(spritePath + 'fnaf3logo'));
		logothing.scrollFactor.set(0, 0);
		logothing.screenCenter();
		logothing.updateHitbox();
		logothing.scale.set(0.666666, 0.666666);
		add(logothing);

		var versionShit:FlxText = new FlxText(1000, FlxG.height - 44, 0, '', 16);
		versionShit.setFormat("stalker2.ttf", 16, FlxColor.WHITE, FlxTextAlign.RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionShit.scrollFactor.set();
		versionShit.text = 'Vs FNaF 3 v' + Application.current.meta.get('version') + '\nPsych Engine v' + psychEngineVersion;
		add(versionShit);

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	
		var newgame = new FlxButton(0, 0, " ", newgamestart);
		newgame.loadGraphic(Paths.image(spritePath + 'buttonStory'), true, 500, 55);
		newgame.screenCenter();
		newgame.x = -1;
		newgame.y = 380;
		add(newgame);

		var loadgame = new FlxButton(0, 0, " ", loadgamestart);
		loadgame.loadGraphic(Paths.image(spritePath + 'buttonFreeplay'), true, 500, 55);
		loadgame.screenCenter();
		loadgame.x = -1;
		loadgame.y = 460;
		add(loadgame);
	
		var credits = new FlxButton(0, 0, " ", creditsstart);
		credits.loadGraphic(Paths.image(spritePath + 'buttonCredits'), true, 500, 55);
		credits.screenCenter();
		credits.x = -1;
		credits.y = 540;
		add(credits);

		var extra = new FlxButton(0, 0, " ", extrastart);
		extra.loadGraphic(Paths.image(spritePath + 'buttonOptions'), true, 500, 55);
		extra.screenCenter();
		extra.x = -1;
		extra.y = 620;
		add(extra);
	}

	function newgamestart()
	{
		MusicBeatState.switchState(new StoryMenuState());
		FlxG.sound.play(Paths.sound('done'), 0.7);
	}

	function loadgamestart()
	{
		MusicBeatState.switchState(new FreeplayState());
		FlxG.sound.play(Paths.sound('done'), 0.7);
	}

	function creditsstart()
	{
		MusicBeatState.switchState(new CreditsState());
		FlxG.sound.play(Paths.sound('done'), 0.7);
	}

	function extrastart()
	{
		MusicBeatState.switchState(new options.OptionsState());
		FlxG.sound.play(Paths.sound('done'), 0.7);
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() 
	{
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8) {
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (FlxG.keys.justPressed.SEVEN) {
			selectedSomethin = true;
			MusicBeatState.switchState(new editors.MasterEditorMenu());
		}

		super.update(elapsed);

		// Here for debugging purposes only
		if (FlxG.keys.justPressed.ONE) {
			var achieveID2:Int = Achievements.getAchievementIndex('week1');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID2][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID2][2], true);
				giveAchievement();
			}
			SongUnlock.unlockSong('takenapart');
			SongUnlock.unlockSong('retribution');
			SongUnlock.unlockSong('fearforever');
			SongUnlock.unlockSong('everlasting');
			SongUnlock.unlockSong('braindamage');
			SongUnlock.unlockSong('partyroom');
			SongUnlock.unlockSong('totallyreal');
			SongUnlock.unlockSong('lasthour');
			SongUnlock.unlockSong('waffles');
			SongUnlock.unlockSong('leantrap');
			SongUnlock.unlockSong('endorevengo');
			SongUnlock.unlockSong('misconception');	
			ClientPrefs.saveSettings();
		}
	}
}