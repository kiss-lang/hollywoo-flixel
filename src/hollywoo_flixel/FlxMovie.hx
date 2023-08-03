package hollywoo_flixel;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.FlxCamera;
import hollywoo.Director;
import hollywoo.Movie;
import hollywoo_flixel.ActorFlxSprite;
import kiss_flixel.SpriteTools;
import kiss_flixel.FlxKeyShortcutHandler;
import kiss_tools.JsonMap;
import hollywoo.HFloat;
import openfl.Assets;
import flixel.tweens.FlxTween;

/**
 * Model/controller of a Hollywoo-Flixel film, and main execution script
 */
class FlxMovie extends Movie<FlxSprite, ActorFlxSprite, FlxSound, FlxSound, FlxSprite, FlxSound, FlxCamera, FlxLightSource> {
    // Think of HollywooFlixelDSL.kiss as the corresponding Kiss file for this class!

    public function new(director:FlxDirector, lightSourceJsonFile:String, positionsJson:String, delayLengthsJson:String, voiceLineMatchesJson:String, propScalesJson:String) {
        super(director, lightSourceJsonFile, new FlxLightSource([], FlxColor.TRANSPARENT), positionsJson, delayLengthsJson, voiceLineMatchesJson);

        propScales = new JsonMap(propScalesJson, new HFloat(1.0));
    }
    public var uiCamera:FlxCamera;
    public var screenCamera:FlxCamera;
    
    public var nextFrameActions:Array<Void->Void> = [];
    
    public var propScales:JsonMap<HFloat>;
    public var propsInScene:Map<String,Array<String>> = [];
    public var overlaidPropsInScenes:Map<String,Map<FlxSprite,String>> = [];
    public var tweenedPositionsOfSpritesInScenes:Map<String,Map<FlxSprite,FlxPoint>> = [];

    public var tweens:Array<FlxTween> = [];
    public var loopingOnCompletes:Map<FlxSound,Void->Void> = [];
    public var STAGE_LEFT_X:Float;
    public var STAGE_RIGHT_X:Float;
    public var ACTOR_WIDTH:Int;
    public var STAGE_BEHIND_DY:Float;
    public var ACTOR_Y:Float;
    public var DIALOG_X:Float;
    public var DIALOG_Y:Float;
    public var DIALOG_WIDTH:Int;
    public var DIALOG_HEIGHT:Int;
    public var presetPositions:Map<String,Bool> = [];

    // HollywooFlixelDSL overrides this in subclasses
    public function update(elapsed:Float):Void {}

    // Such a hack:
    public var skipMovie:FlxMovie = null;
    public function prepareForSkip():Void {}

    public function createCameras():Void {}
}
