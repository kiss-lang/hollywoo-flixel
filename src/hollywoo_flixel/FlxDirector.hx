package hollywoo_flixel;

using StringTools;

import kiss.Prelude;
import kiss.List;
import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.input.actions.FlxAction;
import flixel.input.FlxInput;
import flixel.input.actions.FlxActionInput;
import flixel.input.actions.FlxActionManager;
import flixel.input.keyboard.FlxKey;
import flixel.input.mouse.FlxMouseButton;
import flixel.math.FlxRect;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import hollywoo.Movie;
import hollywoo.Scene;
import hollywoo.Director;
import hollywoo.StagePosition;
import kiss_tools.JsonFloat;
import hollywoo_flixel.FlxMovie;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.addons.text.FlxTypeText;
import flixel.system.FlxSound;
import flixel.FlxCamera;
import flixel.util.FlxTimer;
import flixel.ui.FlxBar;
import flixel.math.FlxPoint;
import haxe.Constraints;
import kiss_flixel.SpriteTools;
import kiss_flixel.SimpleWindow;
import kiss_flixel.DebugLayer;
import haxe.ds.Option;
import kiss_tools.KeyShortcutHandler;
import kiss_flixel.FlxKeyShortcutHandler;
using flixel.util.FlxSpriteUtil;
import openfl.display.BitmapData;
import openfl.display.BitmapDataChannel;
import openfl.geom.Rectangle;
import openfl.geom.Point;
import flixel.input.mouse.FlxMouseButton;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.input.gamepad.*;
import hollywoo_flixel.HFlxSound;

@:build(kiss.Kiss.build())
class FlxDirector implements Director<FlxSprite, ActorFlxSprite, FlxSound, FlxSound, FlxSprite, FlxSound, FlxCamera, FlxLightSource> {
    public static function blackAlphaMaskFlxSprite(sprite:FlxSprite, mask:FlxSprite, output:FlxSprite):FlxSprite
    {
        sprite.drawFrame();
        var data:BitmapData = sprite.pixels.clone();
        data.copyChannel(mask.pixels, new Rectangle(0, 0, sprite.width, sprite.height), new Point(), BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
        output.pixels = data;
        return output;
    }

}
