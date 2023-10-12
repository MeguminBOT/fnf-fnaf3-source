import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using StringTools;

class SongUnlock {
	public static var songStuff:Array<Dynamic> = [
        ["Taken Apart",				"",				"takenapart_unlockSong", 			false],
        ["Retribution",				"",				"retribution_unlockSong", 			false],
        ["Fear Forever",			"", 			"fearforever_unlockSong", 			false],
        ["Everlasting", 			"", 			"everlasting_unlockSong", 			false],
        ["Brain Damage", 			"", 			"braindamage_unlockSong",			false],
        ["Party Room", 				"", 			"partyroom_unlockSong", 			false],
        ["Totally Real", 			"", 			"totallyreal_unlockSong", 			false],
        ["Last Hour", 				"", 			"lasthour_unlockSong", 				false],
        ["Waffles", 				"", 			"waffles_unlockSong", 				false],
        ["Leantrap", 				"",				"leantrap_unlockSong", 				false],
        ["Misconception", 			"", 			"misconception_unlockSong", 		false],
        ["Out Of Bounds", 			"", 			"outofbounds_unlockSong", 			false],
        ["Until Next Time", 		"", 			"untilnexttime_unlockSong", 		false]
    ];


	public static var songMap:Map<String, Bool> = new Map<String, Bool>();

	public static function unlockSong(name:String):Void {
		FlxG.log.add('Completed songUnlock "' + name +'"');
		songMap.set(name, true);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
	}

	public static function isSongUnlocked(name:String) {
		if(songMap.exists(name) && songMap.get(name)) {
			return true;
		}
		return false;
	}

	public static function getSongIndex(name:String) {
		for (i in 0...songStuff.length) {
			if(songStuff[i][2] == name) {
				return i;
			}
		}
		return -1;
	}

	public static function loadUnlockProgress():Void {
		if(FlxG.save.data != null) {
			if(FlxG.save.data.songMap != null) {
				songMap = FlxG.save.data.songMap;
			}
		}
	}
}

class AttachedSongSprite extends FlxSprite {
	public var sprTracker:FlxSprite;
	private var tag:String;
	public function new(x:Float = 0, y:Float = 0, name:String) {
		super(x, y);

		changeSong(name);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function changeSong(tag:String) {
		this.tag = tag;
		reloadSongImage();
	}

	public function reloadSongImage() {
		if(SongUnlock.isSongUnlocked(tag)) {
			loadGraphic(Paths.image('freeplay/songs/' + tag));
		} else {
			loadGraphic(Paths.image('freeplay/lockedSong'));
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

class SongObject extends FlxSpriteGroup {
	public var onFinish:Void->Void = null;
	var alphaTween:FlxTween;
	public function new(name:String, ?camera:FlxCamera = null)
	{
		super(x, y);
		ClientPrefs.saveSettings();

		var id:Int = SongUnlock.getSongIndex(name);
		var songUnlockBG:FlxSprite = new FlxSprite(60, 50).makeGraphic(420, 120, FlxColor.BLACK);
		songUnlockBG.scrollFactor.set();

		var songUnlockIcon:FlxSprite = new FlxSprite(songUnlockBG.x + 10, songUnlockBG.y + 10).loadGraphic(Paths.image('freeplay/songs/' + name.replace("_unlockSong", "")));
		songUnlockIcon.scrollFactor.set();
		songUnlockIcon.setGraphicSize(Std.int(songUnlockIcon.width * (2 / 3)));
		songUnlockIcon.updateHitbox();
		songUnlockIcon.antialiasing = ClientPrefs.globalAntialiasing;

		var songUnlockName:FlxText = new FlxText(songUnlockIcon.x + songUnlockIcon.width + 20, songUnlockIcon.y + 16, 280, SongUnlock.songStuff[id][0], 16);
		songUnlockName.setFormat(Paths.font("5Computers-In-Love.ttf"), 12, FlxColor.WHITE, LEFT);
		songUnlockName.scrollFactor.set();

		var songUnlockText:FlxText = new FlxText(songUnlockName.x, songUnlockName.y + 32, 280, SongUnlock.songStuff[id][1], 16);
		songUnlockText.setFormat(Paths.font("5Computers-In-Love.ttf"), 12, FlxColor.WHITE, LEFT);
		songUnlockText.scrollFactor.set();

		add(songUnlockBG);
		add(songUnlockName);
		add(songUnlockText);
		add(songUnlockIcon);

		var cam:Array<FlxCamera> = FlxCamera.defaultCameras;
		if(camera != null) {
			cam = [camera];
		}
		alpha = 0;
		songUnlockBG.cameras = cam;
		songUnlockName.cameras = cam;
		songUnlockText.cameras = cam;
		songUnlockIcon.cameras = cam;
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