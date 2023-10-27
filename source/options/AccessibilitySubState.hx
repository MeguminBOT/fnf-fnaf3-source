package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class AccessibilitySubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Accessibility Settings';
		rpcTitle = 'Accessibility Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Epilepsy Safety',
			"Enables extra measures increase safety for people with Epilepsy.\nEspecially for those sensitive to lights and sounds.",
			'epilepsy',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Epilepsy Level',
			"Each level prevents something and includes the level above.\nOne = Rapid flashing lights.\nTwo = Sudden bright lights (Includes some jumpscares).\nThree = Jumpscares and loud sounds",
			'epilepsyLevel',
			'string',
			'One',
			['One', 'Two', 'Three']);
		addOption(option);

		var option:Option = new Option('Disable Epilepsy Warning',
			"Disables the epilepsy warning screen when starting the mod.",
			'epilepsyDisableWarning',
			'bool',
			false);
		addOption(option);

		super();
	}
}