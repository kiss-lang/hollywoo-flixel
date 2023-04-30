package;

import kiss.Prelude;
import kiss.List;
import hollywoo.StagePosition;
import hollywoo_flixel.FlxDirector;
import hollywoo_flixel.FlxMovie;
import hollywoo_flixel.MovieFlxState;
import hollywoo_flixel.ActorFlxSprite;
import kiss_flixel.SpriteTools;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.FlxCamera;

@:build(kiss.AsyncEmbeddedScript.build("hollywoo-flixel", "src/hollywoo_flixel/HollywooFlixelDSL.kiss", "Test.hollywoo"))
class Test extends FlxMovie {
    public function new(director:FlxDirector) {
        super(director, "lightSources.json", "positions.json", "delayLengths.json", "voiceLineMatches.json");
    }
}

class TestState extends MovieFlxState {
    var t:Test;

    public override function create() {
        super.create();
        t = new Test(director);
        t.run();
    }

    public override function destroy() {
        t.doCleanup();
        super.destroy();
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
        t.update(elapsed);
    }
}
