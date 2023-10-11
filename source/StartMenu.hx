package;
 
import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
 
class MenuState extends FlxState
{
    override public function create():Void
    {
        super.create();
 
        var button:FlxButton = new FlxButton(50, 50, "Click here", OnClickButton);
        add(button);
    }
 
    function OnClickButton():Void
    {
        trace("clicked!");
    }
 
    override public function update():Void
    {
        super.update();
    }
 
    override public function destroy():Void
    {
        super.destroy();
    }
}