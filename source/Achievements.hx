import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using StringTools;

class Achievements {
	public static var achievementsStuff:Array<Dynamic> = [ //Name, Description, Achievement save tag, Hidden achievement
		["Freaky on a Friday Night",		"Play on a Friday... Night.",							'friday_night_play',		 false],
		["Completed Main Week No Miss",		"Beat the Main Week in Story Mode with no Misses.",		'week1_nomiss',				false],
		["Completed Main Week",				"Beat the Main Week in Story Mode.",					'week1',					false],
		["What a Funkin' Disaster!",		"Complete a Song with a rating lower than 20%.",		'ur_bad',					false],
		["Fazbear's Virtuoso",				"Complete a Song with a rating of 100%.",				'ur_good',					false],
		["Oversinging Much...?",			"Hold down a note for 10 seconds.",						'oversinging',				false],
		["Hyperactive",						"Finish a Song without going Idle.",					'hype',						false],
		["Completed Main Week GFC",			"Beat the main week with a rating of GFC or better",	'week1_gfc',				false],
		["Code Cracker",					"You cracked the code!",								'code_cracker',				false],
		["Inaccessible",					"Finished the first secret song",						'secret_song_one',			false],
		["He did hold back",				"Finished the second secret song",						'secret_song_two',			false],
		["Boomer",							"Complete 'Fear Forever' or 'Everlasting'\n without using the system restart menu",			'boomer',				false],
		["What a pretty face!",				"Complete 'Fear Forever' without clicking on Mangle",						'pretty_face',			false],
		["Traumatized",						"Complete 'Fear Forever' without doing any mechanics",						'traumatized',			false]
	];
	public static var achievementsMap:Map<String, Bool> = new Map<String, Bool>();

	public static function unlockAchievement(name:String):Void {
		FlxG.log.add('Completed achievement "' + name +'"');
		achievementsMap.set(name, true);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
	}

	public static function isAchievementUnlocked(name:String) {
		if(achievementsMap.exists(name) && achievementsMap.get(name)) {
			return true;
		}
		return false;
	}

	public static function getAchievementIndex(name:String) {
		for (i in 0...achievementsStuff.length) {
			if(achievementsStuff[i][2] == name) {
				return i;
			}
		}
		return -1;
	}

	public static function loadAchievements():Void {
		if(FlxG.save.data != null) {
			if(FlxG.save.data.achievementsMap != null) {
				achievementsMap = FlxG.save.data.achievementsMap;
			}
		}
	}
}

class AttachedAchievement extends FlxSprite {
	public var sprTracker:FlxSprite;
	private var tag:String;

	// Filepath shortcuts
	var spritePath:String = 'menus/achievementsMenu/';
	var achieveSprites:String = 'menus/achievementsMenu/achievements/';

	public function new(x:Float = 0, y:Float = 0, name:String) {
		super(x, y);

		changeAchievement(name);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function changeAchievement(tag:String) {
		this.tag = tag;
		reloadAchievementImage();
	}

	public function reloadAchievementImage() {
		if(Achievements.isAchievementUnlocked(tag)) {
			loadGraphic(Paths.image(achieveSprites + tag));
		} else {
			loadGraphic(Paths.image(spritePath + 'lockedachievement'));
		}
		scale.set(0.7, 0.7);
		updateHitbox();
	}

	override function update(elapsed:Float) {
		if (sprTracker != null)
			setPosition(sprTracker.x - 130, sprTracker.y + 25);

		super.update(elapsed);
	}
}

class AchievementObject extends FlxSpriteGroup {
	public var onFinish:Void->Void = null;
	var alphaTween:FlxTween;
	public function new(name:String, ?camera:FlxCamera = null)
	{
		super(x, y);
		ClientPrefs.saveSettings();

		var id:Int = Achievements.getAchievementIndex(name);
		var achievementBG:FlxSprite = new FlxSprite(60, 50).makeGraphic(420, 120, FlxColor.BLACK);
		achievementBG.scrollFactor.set();

		var achieveSprites:String = 'menus/achievementsMenu/achievements/';
		var achievementIcon:FlxSprite = new FlxSprite(achievementBG.x + 10, achievementBG.y + 10).loadGraphic(Paths.image(achieveSprites + name));
		achievementIcon.scrollFactor.set();
		achievementIcon.setGraphicSize(Std.int(achievementIcon.width * (2 / 3)));
		achievementIcon.updateHitbox();
		achievementIcon.antialiasing = ClientPrefs.globalAntialiasing;

		var achievementName:FlxText = new FlxText(achievementIcon.x + achievementIcon.width + 20, achievementIcon.y + 16, 280, Achievements.achievementsStuff[id][0], 16);
		achievementName.setFormat(Paths.font("stalker2.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementName.scrollFactor.set();

		var achievementText:FlxText = new FlxText(achievementName.x, achievementName.y + 32, 280, Achievements.achievementsStuff[id][1], 16);
		achievementText.setFormat(Paths.font("stalker2s.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementText.scrollFactor.set();

		add(achievementBG);
		add(achievementName);
		add(achievementText);
		add(achievementIcon);

		var cam:Array<FlxCamera> = FlxCamera.defaultCameras;
		if(camera != null) {
			cam = [camera];
		}
		alpha = 0;
		achievementBG.cameras = cam;
		achievementName.cameras = cam;
		achievementText.cameras = cam;
		achievementIcon.cameras = cam;
		alphaTween = FlxTween.tween(this, {alpha: 1}, 0.5, {onComplete: function (twn:FlxTween) {
			alphaTween = FlxTween.tween(this, {alpha: 0}, 0.5, {
				startDelay: 2.5,
				onComplete: function(twn:FlxTween) {
					alphaTween = null;
					remove(this);
					if(onFinish != null) onFinish();
				}
			});
		}});
	}

	override function destroy() {
		if(alphaTween != null) {
			alphaTween.cancel();
		}
		super.destroy();
	}
}