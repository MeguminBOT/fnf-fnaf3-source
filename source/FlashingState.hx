package;

import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnSprite:FlxSprite;

	var spritePath:String = 'menus/titleMenu/';

	override function create()
	{
		super.create();

		var camMenu = new FlxCamera();
		camMenu.antialiasing = ClientPrefs.hudAntialiasing;
		camMenu.bgColor.alpha = 0;
		FlxG.cameras.reset(camMenu);
		FlxG.cameras.setDefaultDrawTarget(camMenu, true);

		var mouseSprite:FlxSprite = new FlxSprite(Paths.image('cursor'));
		FlxG.mouse.load(mouseSprite.pixels);
		FlxG.mouse.visible = true; // Make the mouse visible since the UI is made for mouse and touch input.

        warnSprite = new FlxSprite();
        warnSprite.loadGraphic(Paths.image(spritePath + 'seizureWarn'));
        warnSprite.screenCenter();
		warnSprite.antialiasing = true;
        warnSprite.alpha = 0;
        add(warnSprite);

		FlxTween.tween(warnSprite, { alpha: 1 }, 1, {
            onComplete: function(twn: FlxTween) {
                warnSprite.alpha = 1;
            }
        });

		#if android
		addVirtualPad(NONE, A_B);
		#end
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (#if !android controls.ACCEPT #else virtualPad.buttonA.pressed #end) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				FlxG.sound.play(Paths.sound('success'));
				#if android
					FlxTween.tween(virtualPad, {alpha: 0}, 1);
				#end
				FlxTween.tween(warnSprite, { alpha: 0 }, 1, {
					onComplete: function(twn: FlxTween) {
						MusicBeatState.switchState(new TitleState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}
