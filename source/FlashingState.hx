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

// Mobile specific:
import flixel.input.touch.FlxTouch;

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
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			for (touch in FlxG.touches.list) {
				if (touch.pressed) {
					leftState = true;
					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					FlxG.sound.play(Paths.sound('success'));
	
					FlxTween.tween(warnSprite, { alpha: 0 }, 1, {
						onComplete: function(twn: FlxTween) {
							MusicBeatState.switchState(new TitleState());
						}
					});
				}
			}
		}
		super.update(elapsed);
	}
}
