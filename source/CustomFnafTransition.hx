package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;

class CustomFnafTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	private var leTween:FlxTween = null;
	public static var nextCamera:FlxCamera;
	var isTransIn:Bool = false;
	var transitionSprite:FlxSprite;
	var scaleFactor:Float;

	public function new(duration:Float, isTransIn:Bool) {
		super();
		this.isTransIn = isTransIn;
	
		// Funny FNAF static.
		transitionSprite = new FlxSprite();
		transitionSprite.frames = Paths.getSparrowAtlas('menuTransition');
		transitionSprite.animation.addByPrefix('idle', 'idle', 12, true);
		transitionSprite.scale.set(2, 2);
		add(transitionSprite);

		// Calculate the position to center the sprite on the screen.
		transitionSprite.screenCenter();

		// Do funny static transition.
        if (isTransIn) {
			transitionSprite.animation.play('idle');
            transitionSprite.alpha = 0; // Set initial alpha to 0
            FlxTween.tween(transitionSprite, { alpha: 1 }, duration, {
                onComplete: function(twn: FlxTween) {
                    close();
                }
            });
        } else {
            transitionSprite.animation.play('idle');
            transitionSprite.alpha = 1; // Set initial alpha to 1
            leTween = FlxTween.tween(transitionSprite, { alpha: 0 }, duration, {
                onComplete: function(twn: FlxTween) {
                    if (finishCallback != null) {
                        finishCallback();
                    }
                }
            });
        }

		if(nextCamera != null) {
			transitionSprite.cameras = [nextCamera];
		}
		nextCamera = null;
	}

	override function destroy() {
		if(leTween != null) {
			finishCallback();
			leTween.cancel();
		}
		super.destroy();
	}
}