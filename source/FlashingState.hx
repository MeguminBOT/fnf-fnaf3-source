package;

import flixel.FlxG;
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

        warnSprite = new FlxSprite();
        warnSprite.loadGraphic(Paths.image(spritePath + 'seizureWarn'));
        warnSprite.screenCenter();
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
			if (controls.ACCEPT || controls.BACK) {
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
		super.update(elapsed);
	}
}