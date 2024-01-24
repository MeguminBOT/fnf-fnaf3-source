package;

#if desktop
import Discord.DiscordClient;
#end

// Lime
import lime.app.Application;

// OpenFL
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;

// Flixel
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

// Sys
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end

#if VIDEOS_ALLOWED 
import hxvlc.flixel.FlxVideo;
#end

using StringTools;

class TitleState extends MusicBeatState {
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];
	public static var initialized:Bool = false;
	public static var updateVersion:String = '';

	var mustUpdate:Bool = false;
	var videoIntro:FlxVideo;
	var titleTextColors:Array<FlxColor> = [0xFFDEFDB2, 0xFFC2FF6B];
	var titleTextAlphas:Array<Float> = [1, .64];

	var bg:FlxSprite;
	var titleText:FlxSprite;
	var swagShader:ColorSwap = null;

	var spritePath:String = 'menus/titleMenu/';

	function introVideo() {
		#if VIDEOS_ALLOWED
		var filepath:String = Paths.video('fnaf3start');
		#if sys
		if (!FileSystem.exists(filepath))
		#else
		if (!OpenFlAssets.exists(filepath))
		#end
		{
			FlxG.log.warn('Couldnt find video file: ' + filepath);
			return;
		}

		videoIntro = new FlxVideo();
		videoIntro.onEndReached.add(videoIntro.dispose);
		videoIntro.load(filepath);

		new FlxTimer().start(0.001, function(tmr:FlxTimer):Void
		{
			videoIntro.play();
		});
		#end
	}

	override public function create():Void {
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if LUA_ALLOWED
		Paths.pushGlobalMods();
		#end

		FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = muteKeys;
		FlxG.sound.volumeDownKeys = volumeDownKeys;
		FlxG.sound.volumeUpKeys = volumeUpKeys;
		FlxG.keys.preventDefaultKeys = [TAB];

		PlayerSettings.init();

		swagShader = new ColorSwap();
		super.create();

		FlxG.save.bind('savefile', 'vsfnaf3');

		ClientPrefs.loadPrefs();

		#if CHECK_FOR_UPDATES
		if (ClientPrefs.checkForUpdates && !closedState) {
			trace('checking for update');
			var http = new haxe.Http("https://github.com/MeguminBOT/fnf-fnaf3-source/blob/main/gitVersion.txt");

			http.onData = function(data:String) {
				updateVersion = data.split('\n')[0].trim();
				var curVersion:String = MainMenuState.psychEngineVersion.trim();
				trace('version online: ' + updateVersion + ', your version: ' + curVersion);
				if (updateVersion != curVersion) {
					trace('versions arent matching!');
					mustUpdate = true;
				}
			}

			http.onError = function(error) {
				trace('error: $error');
			}

			http.request();
		}
		#end

		Highscore.load();

		fnafIntro();

		if (!initialized) {
			if (FlxG.save.data != null && FlxG.save.data.fullscreen) {
				FlxG.fullscreen = FlxG.save.data.fullscreen;
			}
			persistentUpdate = true;
			persistentDraw = true;
		}

		if (FlxG.save.data.weekCompleted != null) {
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		FlxG.mouse.visible = false;
		#if FREEPLAY
		MusicBeatState.switchState(new FreeplayState());
		#elseif CHARTING
		MusicBeatState.switchState(new ChartingState());
		#else
		if (!FlashingState.leftState && !ClientPrefs.epilepsyDisableWarning) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new FlashingState());
		} else {
			#if desktop
			if (!DiscordClient.isInitialized) {
				DiscordClient.initialize();
				Application.current.onExit.add(function(exitCode) {
					DiscordClient.shutdown();
				});
			}
			#end

			if (initialized)
				introVideo();
			else {
				new FlxTimer().start(1, function(tmr:FlxTimer) {
					introVideo();
				});
			}
		}
		#end
	}

	function fnafIntro() {
		if (!initialized) {
			if (FlxG.sound.music == null) {
				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			}
		}

		Conductor.changeBPM(113);
		persistentUpdate = true;

		bg = new FlxSprite();
		bg.frames = Paths.getSparrowAtlas(spritePath + 'bg');
		bg.animation.addByPrefix('idle', 'idle', 24, true);
		bg.screenCenter();
		add(bg);
		bg.animation.play('idle');
		bg.visible = false;

		swagShader = new ColorSwap();

		titleText = new FlxSprite();
		titleText.frames = Paths.getSparrowAtlas(spritePath + 'start');
		titleText.animation.addByPrefix('idle', 'idle', 24, true);
		titleText.animation.addByPrefix('pressed', 'pressed', 24, true);
		titleText.animation.play('idle');
		titleText.antialiasing = ClientPrefs.globalAntialiasing;
		titleText.screenCenter(X);
		titleText.y = 640;
		titleText.x = 128;
		titleText.updateHitbox();
		add(titleText);
		titleText.visible = false;

		if (initialized)
			skipIntro();
		else
			initialized = true;
	}

	var transitioning:Bool = false;
	var newTitle:Bool = false;
	var titleTimer:Float = 0;

	override function update(elapsed:Float) {
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER || controls.ACCEPT;

		#if mobile
		for (touch in FlxG.touches.list) {
			if (touch.justPressed) {
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null) {
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		if (newTitle) {
			titleTimer += CoolUtil.boundTo(elapsed, 0, 1);
			if (titleTimer > 2) titleTimer -= 2;
		}

		if (initialized && !transitioning && skippedIntro) {
			if (newTitle && !pressedEnter) {
				var timer:Float = titleTimer;
				if (timer >= 1)
					timer = (-timer) + 2;

				timer = FlxEase.quadInOut(timer);

				titleText.color = FlxColor.interpolate(titleTextColors[0], titleTextColors[1], timer);
				titleText.alpha = FlxMath.lerp(titleTextAlphas[0], titleTextAlphas[1], timer);
			}

			if (pressedEnter) {
				titleText.color = FlxColor.WHITE;
				titleText.alpha = 1;

				if (titleText != null) titleText.animation.play('pressed');

				FlxG.camera.flash(ClientPrefs.flashing ? FlxColor.WHITE : 0x4CFFFFFF, 1);
				FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

				transitioning = true;

				new FlxTimer().start(1, function(tmr:FlxTimer) {
					if (mustUpdate) {
						MusicBeatState.switchState(new OutdatedState());
					} else {
						MusicBeatState.switchState(new MainMenuState());
					}
					closedState = true;
				});
			}
		}

		if (initialized && pressedEnter && !skippedIntro) {
			skipIntro();
		}

		if (swagShader != null) {
			if (controls.UI_LEFT) swagShader.hue -= elapsed * 0.1;
			if (controls.UI_RIGHT) swagShader.hue += elapsed * 0.1;
		}

		super.update(elapsed);
	}

	private var sickBeats:Int = 0;
	public static var closedState:Bool = false;
	override function beatHit() {
		super.beatHit();

		if (!closedState) {
			sickBeats++;
			switch (sickBeats) {
				case 1:
					FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
					FlxG.sound.music.fadeIn(1, 0, 5);

				case 17:
					skipIntro();
			}
		}
	}

	var skippedIntro:Bool = false;
	var increaseVolume:Bool = false;
	function skipIntro():Void {
		if (!skippedIntro) {
			FlxG.camera.flash(FlxColor.WHITE, 1);
			bg.visible = true;
			titleText.visible = true;
			skippedIntro = true;
		}
	}
}