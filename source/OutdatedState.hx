package;

import lime.app.Application;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class OutdatedState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var camMenu = new FlxCamera();
		camMenu.antialiasing = ClientPrefs.hudAntialiasing;
		camMenu.bgColor.alpha = 0;
		FlxG.cameras.reset(camMenu);
		FlxG.cameras.setDefaultDrawTarget(camMenu, true);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"It looks like you're running an   \n
			outdated version of 'Vs. FNaF 3' (" + MainMenuState.fnafVersion + "),\n
			please update to " + TitleState.updateVersion + "!\n
			Press ESCAPE to proceed anyway.\n
			\n
			Thank you for playing the mod!",
			24);
		warnText.setFormat("stalker2.ttf", 24, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);

		#if android
		addVirtualPad(NONE, A_B);
		#end
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT) {
				leftState = true;
				CoolUtil.browserLoad("https://github.com/MeguminBOT/fnf-fnaf3-source/releases/");
			}
			else if(controls.BACK) {
				leftState = true;
			}

			if(leftState)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}
