package;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
using StringTools;

class CreditsState extends FlxState
{
    var background:FlxSprite;
    private var camGame:FlxCamera;
    var debugKeys:Array<FlxKey>;

    var sprites:Array<FlxSprite> = [];
    var buttons:Array<FlxButton> = [];

    var spritePath:String = 'menus/creditsMenu/';
    var peopleSprites:String = 'menus/creditsMenu/people/';

    override function create()
    {
		DiscordClient.changePresence("Credits Menu", null);

        background = new FlxSprite(-400, -300);
        background.frames = Paths.getSparrowAtlas(spritePath + 'bg');
        background.animation.addByPrefix('play', 'idle', 18, true);
        background.setGraphicSize(Std.int(background.width * 1.175));
        background.updateHitbox();
        background.screenCenter();
        add(background);
        background.animation.play('play');
        background.scale.set(0.666666, 0.666666);

        var mouseSprite:FlxSprite = new FlxSprite(Paths.image('cursor'));
        FlxG.mouse.load(mouseSprite.pixels);
        FlxG.mouse.visible = true;
        super.create();

        var names = ['pouria', 'thunder', 'penove', 'dom', 'glitch', 'aleks', 'vev', 'others'];
        for (i in 0...names.length)
        {
            var sprite = new FlxSprite();
            sprite.loadGraphic(Paths.image(peopleSprites + names[i]));
            add(sprite);
            sprite.scale.set(0.66, 0.66);
            sprite.screenCenter();
            sprite.visible = i == 0;
            sprites.push(sprite);

            var button = new FlxButton(500, 500, "", onButtonClicked.bind(i));
            button.screenCenter();
            button.loadGraphic(Paths.image(spritePath + 'button' + '${i+1}'), true, 100, 100);
            add(button);
            button.x = 450 + i * 100;
            button.y = 30;
            button.scale.set(1, 1);
            buttons.push(button);
        }
    }

    function onButtonClicked(index:Int)
    {
        for (i in 0...sprites.length)
        {
            sprites[i].visible = i == index;
        }
    }

    override function update(elapsed:Float)
    {
        if (FlxG.keys.justPressed.BACKSPACE || FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.switchState(new MainMenuState());
        }

        super.update(elapsed);
    }
}