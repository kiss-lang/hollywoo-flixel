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

@:build(kiss.Kiss.fossilBuild())
class FlxDirector implements Director<FlxSprite, ActorFlxSprite, FlxSound, FlxSound, FlxSprite, FlxSound, FlxCamera, FlxLightSource> {
    public static function blackAlphaMaskFlxSprite(sprite:FlxSprite, mask:FlxSprite, output:FlxSprite):FlxSprite
    {
        sprite.drawFrame();
        var data:BitmapData = sprite.pixels.clone();
        data.copyChannel(mask.pixels, new Rectangle(0, 0, sprite.width, sprite.height), new Point(), BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
        output.pixels = data;
        return output;
    }


	// BEGIN KISS FOSSIL CODE
	// ["/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/FlxDirector.kiss","/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/Aliases.kiss"]
	public final continueAction:FlxActionDigital;
	public final fastForwardAction:FlxActionDigital;
	public final actionManager = new FlxActionManager();
	public var movie:Movie<FlxSprite,ActorFlxSprite,FlxSound,FlxSound,FlxSprite,FlxSound,FlxCamera,FlxLightSource>;
	public final spriteLayers:FlxTypedGroup<FlxTypedGroup<FlxBasic>> = new FlxTypedGroup();
	public static final LAYER_MAX = 8;
	public static var lastSceneLabels(get,set):Map<String,String>;
	public static function get_lastSceneLabels():Map<String,String>  return {
		if (Prelude.truthy({
			final _p6LrZAnE338fNht4xCNZ6S:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_p6LrZAnE338fNht4xCNZ6S)) {
					final _nLRjC9dmQsBTGRMN3fCofZ:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_nLRjC9dmQsBTGRMN3fCofZ;
					};
				} else _p6LrZAnE338fNht4xCNZ6S;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				if (Prelude.truthy(json.exists("lastSceneLabels"))) {
					var v:Map<String, String> = tink.Json.parse(json['lastSceneLabels']);
					v;
				} else new Map();
			};
		} else {
			new Map();
		};
	}
	public static function set_lastSceneLabels(v:Map<String,String>):Map<String,String>  return {
		if (Prelude.truthy({
			final _dtDEySjaC9Aw3sBcAMSHJv:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_dtDEySjaC9Aw3sBcAMSHJv)) {
					final _wQX87xankXpS8b4yPq79SG:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_wQX87xankXpS8b4yPq79SG;
					};
				} else _dtDEySjaC9Aw3sBcAMSHJv;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				json["lastSceneLabels"] = tink.Json.stringify(v);
				sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
				v;
			};
		} else {
			{
				final json:haxe.DynamicAccess<String> = haxe.Json.parse('{}');
				{
					json["lastSceneLabels"] = tink.Json.stringify(v);
					sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
					v;
				};
			};
		};
	}
	public static function lastSceneForMovie(m:FlxMovie, ?setValue:String):String  return {
		{
			final clazz = Type.getClass(m); final className = Type.getClassName(clazz); final currentValue = lastSceneLabels[className];
			{
				if (Prelude.truthy(setValue)) {
					var _chzVccojDUHKgxkVx1PEo2 = null;
					{
						final _wXyzycFJy8zrrc8RQu8wx8 = lastSceneLabels;
						{
							{
								final lastSceneLabels = _wXyzycFJy8zrrc8RQu8wx8;
								{
									_chzVccojDUHKgxkVx1PEo2 = {
										lastSceneLabels[className] = setValue;
										setValue;
									};
								};
							};
							lastSceneLabels = _wXyzycFJy8zrrc8RQu8wx8;
						};
					};
					_chzVccojDUHKgxkVx1PEo2;
				} else currentValue;
			};
		};
	}
	public function promptForResume(movie:FlxMovie):Void  {
		movie.createCameras();
		if (Prelude.truthy(movie.labelRunners().exists(lastSceneForMovie(movie)))) {
			_chooseString((Prelude.add("Resume from \'", Std.string(lastSceneForMovie(movie)), "\'?") : String), new kiss.List(["", "Resume", "Scene Selection", "Start From Beginning"]), function(choice) return {
				switch choice {
					case _cxvhoXcLzjVhByQmXxu7yk if (Prelude.truthy(Prelude.isNull(_cxvhoXcLzjVhByQmXxu7yk))):{
						{
							throw kiss.Prelude.runtimeInsertAssertionMessage("case should never match pattern otherwise", "/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/FlxDirector.kiss:37:37: Assertion failed: \nFrom:[(never otherwise)]", 4);
						};
					};
					case "Resume":{
						movie.runFromLabel(lastSceneForMovie(movie));
					};
					case "Scene Selection":{
						sceneSelection(function() {
							{
								movie.doCleanup();
								flixel.FlxG.switchState(new MenuState());
							};
						});
					};
					case "Start From Beginning":{
						movie.run();
					};
					default:{
						throw kiss.Prelude.runtimeInsertAssertionMessage("case should never match pattern otherwise", "/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/FlxDirector.kiss:37:37: Assertion failed: \nFrom:[(never otherwise)]", 4);
					};
				};
			}, true, "escape");
			pauseMenu.onClose = function() {
				{
					movie.doCleanup();
					flixel.FlxG.switchState(new MenuState());
				};
			};
		} else movie.run();
	}
	public function new(?demoDirector:Bool) {
		if (Prelude.truthy(!Prelude.truthy(demoDirector))) {
			continueAction = new FlxActionDigital("Continue", onContinue);
			fastForwardAction = new FlxActionDigital("Fast Forward");
			{
				for (_pCtjmr5q3eaZiaiPVhUQ5y in (Prelude.zipThrow(new kiss.List([continueAction, fastForwardAction]), new kiss.List([JUST_PRESSED, PRESSED])) : Array<Array<Dynamic>>)) {
					final _mWbdR2jcD6J3Vkcv5hxf4x = _pCtjmr5q3eaZiaiPVhUQ5y; final action:FlxActionDigital = _mWbdR2jcD6J3Vkcv5hxf4x[0]; final trigger:FlxInputState = _mWbdR2jcD6J3Vkcv5hxf4x[1];
					{
						action.addKey(SPACE, trigger);
						action.addKey(ENTER, trigger);
						action.addMouse(LEFT, trigger);
						action.addGamepad(FlxGamepadInputID.A, trigger, FlxInputDeviceID.ALL);
						actionManager.addAction(action);
					};
				};
				null;
			};
			flixel.FlxG.inputs.add(actionManager);
			{
				kiss_flixel.DebugTools.f1ToRecord(actionManager);
				kiss_flixel.DebugTools.f2ToLogSprites(actionManager);
			};
			actionManager.resetOnStateSwitch = NONE;
			{
				for (i in Prelude.range(0, Prelude.add(1, LAYER_MAX), 1)) {
					{
						final g = new FlxTypedGroup<FlxBasic>();
						{
							spriteLayers.add(g);
						};
					};
				};
				null;
			};
		} else null;
	}
	public final skySprites:Map<SceneTime,flixel.FlxSprite> = new Map();
	public var skySprite:flixel.FlxSprite;
	public final sh:FlxKeyShortcutHandler<(Continuation)->Void> = new FlxKeyShortcutHandler();
	public function shortcutHandler():KeyShortcutHandler<(Continuation)->Void>  return {
		sh.cancelKey = null;
		sh;
	}
	public function pause():Void  {
		flixel.FlxG.inputs.remove(actionManager);
		flixel.FlxG.state.forEach(function(child) {
			{
				final _kDTwrkhVP98ZwxVuS55ZJx:Dynamic = child;
				{
					switch [_kDTwrkhVP98ZwxVuS55ZJx] {
						case [typeText] if (Prelude.truthy({
							final _feaU81utVbNP5tFbsMqzhy:Dynamic = Std.isOfType(typeText, FlxTypeText);
							{
								_feaU81utVbNP5tFbsMqzhy;
							};
						})):{
							{
								final typeText:FlxTypeText = typeText;
								{
									if (Prelude.truthy(typeText.sounds)) {
										{
											for (sound in typeText.sounds) {
												if (Prelude.truthy(sound.playing)) {
													sound.pause();
												} else null;
											};
											null;
										};
									} else null;
									typeText.paused = true;
								};
							};
						};
						case [sprite] if (Prelude.truthy({
							final _v7FjvtAQy4K8kw6gZWe13C:Dynamic = Std.isOfType(sprite, flixel.FlxSprite);
							{
								_v7FjvtAQy4K8kw6gZWe13C;
							};
						})):{
							{
								final sprite:flixel.FlxSprite = sprite;
								{
									sprite.animation?.pause();
								};
							};
						};
						default:{ };
					};
				};
			};
		}, true);
		{
			for (sound in currentSounds) {
				sound.pause();
			};
			null;
		};
		{
			for (track in currentVoiceTracks) {
				track.pause();
			};
			null;
		};
		if (Prelude.truthy(music)) {
			music.pause();
		} else null;
	}
	public function resumeAndUpdateCurrentVolume(sounds:Array<FlxSound>, newVolume:Float) return {
		{
			for (sound in sounds) {
				{
					final _7fn2wexzRy7Ti9mCCCxWRK = currentSoundVolumes[sound]; final original = _7fn2wexzRy7Ti9mCCCxWRK[0]; final mod = _7fn2wexzRy7Ti9mCCCxWRK[1];
					{
						sound.volume = Prelude.multiply(original, mod, newVolume);
						sound.resume();
					};
				};
			};
			null;
		};
	}
	public function resume():Void  {
		if (Prelude.truthy(!Prelude.truthy(movie.promptedRecording))) {
			flixel.FlxG.mouse.visible = true;
		} else null;
		flixel.FlxG.inputs.add(actionManager);
		flixel.FlxG.state.forEach(function(child) {
			{
				final _pmVcK9xfvg11X4CzcEAQP5:Dynamic = child;
				{
					switch [_pmVcK9xfvg11X4CzcEAQP5] {
						case [typeText] if (Prelude.truthy({
							final _ks5RN4CyR5o6cBgsTLVGs8:Dynamic = Std.isOfType(typeText, FlxTypeText);
							{
								_ks5RN4CyR5o6cBgsTLVGs8;
							};
						})):{
							{
								final typeText:FlxTypeText = typeText;
								{
									if (Prelude.truthy(typeText.sounds)) {
										{
											for (sound in typeText.sounds) {
												if (Prelude.truthy(sound.playing)) {
													sound.resume();
												} else null;
											};
											null;
										};
									} else null;
									typeText.paused = false;
								};
							};
						};
						case [sprite] if (Prelude.truthy({
							final _9hLuf9ReXyYa7dMiBp1Efy:Dynamic = Std.isOfType(sprite, flixel.FlxSprite);
							{
								_9hLuf9ReXyYa7dMiBp1Efy;
							};
						})):{
							{
								final sprite:flixel.FlxSprite = sprite;
								{
									sprite.animation?.resume();
								};
							};
						};
						default:{ };
					};
				};
			};
		}, true);
		resumeAndUpdateCurrentVolume(currentSounds, soundVolume);
		resumeAndUpdateCurrentVolume(currentVoiceTracks, voiceVolume);
		if (Prelude.truthy(music)) {
			resumeAndUpdateCurrentVolume(new kiss.List([music]), musicVolume);
		} else null;
	}
	public var pauseMenu:SimpleWindow = null;
	public function sceneSelection(cancel:Continuation):Void  {
		{
			final runners = movie.labelRunners(); final labels = Prelude.sort([for (elem in runners.keys()) {
				elem;
			}]); final lastLabelIndex = labels.indexOf(movie.lastLabel);
			{
				_chooseString("Skip to scene?", labels, function(label) return {
					{
						{
							final m = cast(movie, FlxMovie);
							{
								if (Prelude.truthy(m.didLoading)) {
									m.prepareForSkip();
									runners[label](m.skipMovie);
								} else if (Prelude.truthy(true)) {
									runners[label](m);
								} else null;
							};
						};
					};
				}, true, "escape");
				if (Prelude.truthy(!Prelude.truthy(Prelude.areEqual(-1, lastLabelIndex)))) {
					pauseMenu.selectedIndex = Prelude.add(1, lastLabelIndex);
				} else null;
				pauseMenu.onClose = cancel;
			};
		};
	}
	public function showPauseMenu(resume:Continuation):Void  {
		{
			final oldResume = resume; final previousFullscreen = MenuState.fullscreen; final resume = function() {
				if (Prelude.truthy(Prelude.areEqual(previousFullscreen, MenuState.fullscreen))) oldResume() else {
					final m = cast(movie, FlxMovie); final instructionPointer = Reflect.field(m, "lastInstructionPointer");
					{
						m.prepareForSkip();
						m.skipMovie.runFromInstruction(instructionPointer);
					};
				};
			};
			{
				sh.registerItem("{escape} resume", function(cc) return {
					{
						pauseMenu.hide();
						resume();
					};
				}, true);
				{
					final choices = new kiss.List(["", "Resume", "Scene Selection", "Options", "Send Feedback", "Main Menu", "Quit to Desktop"]); final sceneSelectionIndex = choices.indexOf("Scene Selection"); final optsIdx = choices.indexOf("Options"); final feedbackIdx = choices.indexOf("Send Feedback");
					{
						chooseString("PAUSED", choices, function(choice) {
							switch choice {
								case _inEZJwqyYwuTe9hEsUmtj4 if (Prelude.truthy(Prelude.isNull(_inEZJwqyYwuTe9hEsUmtj4))):{
									{
										throw kiss.Prelude.runtimeInsertAssertionMessage("case should never match pattern otherwise", "/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/FlxDirector.kiss:214:25: Assertion failed: \nFrom:[(never otherwise)]", 4);
									};
								};
								case "Resume":{
									resume();
								};
								case "Scene Selection":{
									function backToPause() return {
										pauseMenu.onClose = null;
										pauseMenu.hide();
										showPauseMenu(resume);
										pauseMenu.selectedIndex = sceneSelectionIndex;
									};
									sh.registerItem("{escape} pause", function(cc) return {
										backToPause();
									}, true);
									sceneSelection(function() {
										{
											backToPause();
										};
									});
								};
								case "Options":{
									sh.cancel();
									MenuState.optionsMenu(function() return {
										{
											sh.start();
											showPauseMenu(resume);
											pauseMenu.selectedIndex = optsIdx;
										};
									}, null, null, this);
								};
								case "Send Feedback":{
									sh.cancel();
									kiss_flixel.FeedbackWindow.collectFeedback(function() {
										{
											sh.start();
											showPauseMenu(resume);
											pauseMenu.selectedIndex = feedbackIdx;
										};
									}, null, null, true, "escape").enableGamepadInput(true);
								};
								case "Main Menu":{
									flixel.FlxG.switchState(new MenuState());
								};
								case "Quit to Desktop":{
									Sys.exit(0);
								};
								default:{
									throw kiss.Prelude.runtimeInsertAssertionMessage("case should never match pattern otherwise", "/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/FlxDirector.kiss:214:25: Assertion failed: \nFrom:[(never otherwise)]", 4);
								};
							};
						});
					};
				};
			};
		};
	}
	public static function specialHistoryChars(text:String) return {
		text.replace("✓", "<check mark>");
	}
	public static function specialTypesSpeakerName(name:String, type:SpeechType<hollywoo_flixel.ActorFlxSprite>) return {
		switch type {
			case _oQbPed1sZn9KLbhqz2skjy if (Prelude.truthy(Prelude.isNull(_oQbPed1sZn9KLbhqz2skjy))):{
				{
					name;
				};
			};
			case VoiceOver(_):{
				(Prelude.add("", Std.string({
					name;
				}), " (voiceover)") : String);
			};
			case TextMessage(_):{
				(Prelude.add("", Std.string({
					name;
				}), " (text message)") : String);
			};
			case FromPhone(_):{
				(Prelude.add("", Std.string({
					name;
				}), " (from phone)") : String);
			};
			case Custom(type, _, _):{
				(Prelude.add("", Std.string({
					name;
				}), " (", Std.string({
					type;
				}), ")") : String);
			};
			default:{
				name;
			};
		};
	}
	public function showDialogHistory(history:Array<HistoryElement<hollywoo_flixel.ActorFlxSprite>>, resume:Continuation):Void  {
		{
			final _resume = function(cc) return {
				{
					pauseMenu.hide();
					resume();
				};
			};
			{
				pauseMenu = new SimpleWindow("HISTORY", flixel.util.FlxColor.BLACK, textColor, 0.6, 0.9, true, null, null, null, "up", "down", function() {
					_resume(null);
				});
				pauseMenu.enableVerticalScrolling();
				pauseMenu.enableGamepadInput(true);
				pauseMenu.makeText("");
				{
					for (element in history) {
						switch element {
							case _pgEU2vCbamUfhH7u5bZhA9 if (Prelude.truthy(Prelude.isNull(_pgEU2vCbamUfhH7u5bZhA9))):{
								{
									throw kiss.Prelude.runtimeInsertAssertionMessage("case should never match pattern otherwise", "/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/FlxDirector.kiss:255:17: Assertion failed: \nFrom:[(never otherwise)]", 4);
								};
							};
							case Sound(caption):{
								pauseMenu.makeText((Prelude.add("<", Std.string({
									caption;
								}), ">") : String));
								pauseMenu.makeText("");
							};
							case Dialog(speaker, type, _wryly, text):{
								pauseMenu.makeText(specialTypesSpeakerName(speaker, type));
								pauseMenu.makeMultilineText(specialHistoryChars(text));
								pauseMenu.makeText("");
							};
							case Super(text):{
								pauseMenu.makeText(text);
								pauseMenu.makeText("");
							};
							default:{
								throw kiss.Prelude.runtimeInsertAssertionMessage("case should never match pattern otherwise", "/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/FlxDirector.kiss:255:17: Assertion failed: \nFrom:[(never otherwise)]", 4);
							};
						};
					};
					null;
				};
				sh.registerItem("{tab} resume", _resume, true);
				sh.registerItem("{escape} resume", _resume, true);
				pauseMenu.setUIControlColor(buttonColor);
				pauseMenu.show();
				pauseMenu.scrollToBottom();
			};
		};
	}
	public function loadSet(path) return {
		{
			final setSprite = new flixel.FlxSprite(0, 0);
			{
				setSprite.loadGraphic(path, false, 0, 0, true);
			};
		};
	}
	public function cloneSet(set) return {
		set.clone();
	}
	public function showSet(setSprite:flixel.FlxSprite, time:SceneTime, perspective:ScenePerspective, appearance:Appearance, camera:flixel.FlxCamera, skipping:Bool, cc:Continuation):Void  {
		{
			for (layer in spriteLayers) {
				layer.cameras = new kiss.List([camera]);
			};
			null;
		};
		switch appearance {
			case _ucU4BiTbA2WaGE1qP3jhBB if (Prelude.truthy(Prelude.isNull(_ucU4BiTbA2WaGE1qP3jhBB))):{
				{ };
			};
			case FirstAppearance:{
				setSprite.setGraphicSize(flixel.FlxG.width);
				if (Prelude.truthy(Prelude.greaterThan(setSprite.height, flixel.FlxG.height))) {
					setSprite.setGraphicSize(0, flixel.FlxG.height);
				} else null;
				setSprite.updateHitbox();
				setSprite.screenCenter();
			};
			default:{ };
		};
		{
			final _9ummKhLkHNvzLL1zcTtR8b = skySprites[time];
			{
				if (Prelude.truthy(_9ummKhLkHNvzLL1zcTtR8b)) switch _9ummKhLkHNvzLL1zcTtR8b {
					case _pM2nMhQ6DVBhq7sHM7ojCt if (Prelude.truthy(Prelude.isNull(_pM2nMhQ6DVBhq7sHM7ojCt))):{
						{
							{
								final skyColor = switch time {
									case _sfQH6VGwEKfSZva7FNHqCw if (Prelude.truthy(Prelude.isNull(_sfQH6VGwEKfSZva7FNHqCw))):{
										{
											{
												throw kiss.Prelude.runtimeInsertAssertionMessage("case should never match pattern null", "/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/FlxDirector.kiss:300:29: Assertion failed: \nFrom:[(never null)]", 4);
											};
										};
									};
									case Morning | Day:{
										{
											DAY_SKY_COLOR;
										};
									};
									case Evening:{
										{
											EVENING_SKY_COLOR;
										};
									};
									case Night:{
										{
											NIGHT_SKY_COLOR;
										};
									};
								};
								{
									skySprite = new flixel.FlxSprite();
									skySprite.makeGraphic(Std.int(setSprite.width), Std.int(setSprite.height), skyColor, true);
								};
							};
						};
					};
					case specialSkySprite:{
						{
							skySprite = specialSkySprite.clone();
							skySprite.setGraphicSize(Std.int(setSprite.width));
							skySprite.updateHitbox();
							if (Prelude.truthy(!Prelude.truthy(Prelude.greaterEqual(skySprite.height, setSprite.height)))) {
								skySprite.setGraphicSize(0, Std.int(setSprite.height));
								skySprite.updateHitbox();
								{
									final hOverflow = Prelude.subtract(skySprite.width, setSprite.width); final unscaledOverflow = Prelude.divide(hOverflow, skySprite.scale.x); final half = Prelude.iHalf(unscaledOverflow);
									{
										skySprite.clipRect = new FlxRect(0, 0, Std.int(Prelude.subtract(skySprite.frameWidth, unscaledOverflow)), skySprite.frameHeight);
									};
								};
							} else null;
						};
					};
					default:{
						{
							final skyColor = switch time {
								case _sfQH6VGwEKfSZva7FNHqCw if (Prelude.truthy(Prelude.isNull(_sfQH6VGwEKfSZva7FNHqCw))):{
									{
										throw kiss.Prelude.runtimeInsertAssertionMessage("case should never match pattern null", "/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/FlxDirector.kiss:300:29: Assertion failed: \nFrom:[(never null)]", 4);
									};
								};
								case Morning | Day:{
									DAY_SKY_COLOR;
								};
								case Evening:{
									EVENING_SKY_COLOR;
								};
								case Night:{
									NIGHT_SKY_COLOR;
								};
							};
							{
								skySprite = new flixel.FlxSprite();
								skySprite.makeGraphic(Std.int(setSprite.width), Std.int(setSprite.height), skyColor, true);
							};
						};
					};
				} else {
					final skyColor = switch time {
						case _b41NqV9BmzMPPGYgZVezsy if (Prelude.truthy(Prelude.isNull(_b41NqV9BmzMPPGYgZVezsy))):{
							{
								throw kiss.Prelude.runtimeInsertAssertionMessage("case should never match pattern null", "/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/FlxDirector.kiss:300:29: Assertion failed: \nFrom:[(never null)]", 4);
							};
						};
						case Morning | Day:{
							DAY_SKY_COLOR;
						};
						case Evening:{
							EVENING_SKY_COLOR;
						};
						case Night:{
							NIGHT_SKY_COLOR;
						};
					};
					{
						skySprite = new flixel.FlxSprite();
						skySprite.makeGraphic(Std.int(setSprite.width), Std.int(setSprite.height), skyColor, true);
					};
				};
			};
		};
		skySprite.x = setSprite.x;
		skySprite.y = 0;
		skySprite.alpha = lastSkyAlpha;
		cast(movie, FlxMovie).setCameras(skySprite, new kiss.List([camera]));
		spriteLayers.members[0].add(skySprite);
		flixel.FlxG.cameras.remove(cast(movie, FlxMovie).spriteChangeDebugCamera, false);
		flixel.FlxG.cameras.remove(cast(movie, FlxMovie).uiCamera, false);
		if (Prelude.truthy(!Prelude.truthy(skipping))) {
			{
				for (camera in cast(movie, FlxMovie).tempCamerasOrder) {
					flixel.FlxG.cameras.remove(camera, false);
				};
				null;
			};
		} else null;
		flixel.FlxG.cameras.remove(cast(movie, FlxMovie).screenCamera, false);
		if (Prelude.truthy(!Prelude.truthy(skipping))) {
			{
				for (camera in cast(movie, FlxMovie).tempBgCamerasOrder) {
					flixel.FlxG.cameras.remove(camera, false);
				};
				null;
			};
		} else null;
		if (Prelude.truthy(!Prelude.truthy(skipping))) {
			{
				for (camera in cast(movie, FlxMovie).tempBgCamerasOrder) {
					flixel.FlxG.cameras.add(camera, cast(movie, FlxMovie).tempBgCameras[camera]);
				};
				null;
			};
		} else null;
		flixel.FlxG.cameras.add(camera, false);
		flixel.FlxG.cameras.add(cast(movie, FlxMovie).screenCamera, false);
		if (Prelude.truthy(!Prelude.truthy(skipping))) {
			{
				for (camera in cast(movie, FlxMovie).tempCamerasOrder) {
					flixel.FlxG.cameras.add(camera, cast(movie, FlxMovie).tempCameras[camera]);
				};
				null;
			};
		} else null;
		flixel.FlxG.cameras.add(cast(movie, FlxMovie).uiCamera, false);
		flixel.FlxG.cameras.add(cast(movie, FlxMovie).spriteChangeDebugCamera, false);
		cast(movie, FlxMovie).setCameras(setSprite, new kiss.List([camera]));
		spriteLayers.members[0].add(setSprite);
		cc();
	}
	public var lastSkyAlpha = 1.0;
	public function hideSet(set:flixel.FlxSprite, camera:flixel.FlxCamera, cc:Continuation):Void  {
		if (Prelude.truthy(flixel.FlxG.cameras.list.contains(camera))) {
			flixel.FlxG.cameras.remove(camera, false);
		} else null;
		lastSkyAlpha = skySprite.alpha;
		spriteLayers.members[0].remove(skySprite, true);
		spriteLayers.members[0].remove(set, true);
		cc();
	}
	public function drawLight(source:FlxLightSource):flixel.FlxSprite  return {
		lightSprite.drawPolygon(source.points, source.color, { color : flixel.util.FlxColor.TRANSPARENT });
		lightMask.drawPolygon(source.points, flixel.util.FlxColor.BLACK, { color : flixel.util.FlxColor.TRANSPARENT });
	}
	public static final DAY_SKY_COLOR = flixel.util.FlxColor.CYAN;
	public static final NIGHT_SKY_COLOR = flixel.util.FlxColor.BLACK;
	public static final EVENING_SKY_COLOR = flixel.util.FlxColor.fromRGB(23, 28, 70);
	public static final EVENING_COLOR = flixel.util.FlxColor.fromRGBFloat(0.5, 0, 0.5, 0.2);
	public static final NIGHT_COLOR = flixel.util.FlxColor.fromRGBFloat(0, 0, 0, 0.5);
	public var lightSprite:flixel.FlxSprite = null;
	public var lightMask:flixel.FlxSprite = null;
	public var darkness:flixel.FlxSprite = null;
	public var darkColor:flixel.util.FlxColor = flixel.util.FlxColor.BLACK;
	public static var mm:FlxMouseEventManager = null;
	public function chooseString(prompt:String, choices:Array<String>, submit:(String)->Void):Void  {
		_chooseString(prompt, choices, submit);
	}
	private static var _textColor(get,set):Int;
	public static function get__textColor():Int  return {
		if (Prelude.truthy({
			final _3njSJxNvKkvHhvf9bKsNdT:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_3njSJxNvKkvHhvf9bKsNdT)) {
					final _qrGXCQFeEN1a1hjLs78DdP:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_qrGXCQFeEN1a1hjLs78DdP;
					};
				} else _3njSJxNvKkvHhvf9bKsNdT;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				if (Prelude.truthy(json.exists("_textColor"))) {
					var v:Int = tink.Json.parse(json['_textColor']);
					v;
				} else flixel.util.FlxColor.GRAY.getLightened(0.4);
			};
		} else {
			flixel.util.FlxColor.GRAY.getLightened(0.4);
		};
	}
	public static function set__textColor(v:Int):Int  return {
		if (Prelude.truthy({
			final _dod86LyW8RhJjA2J2zSr4T:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_dod86LyW8RhJjA2J2zSr4T)) {
					final _3AWjKpyLnC4kE193N8ufJ1:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_3AWjKpyLnC4kE193N8ufJ1;
					};
				} else _dod86LyW8RhJjA2J2zSr4T;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				json["_textColor"] = tink.Json.stringify(v);
				sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
				v;
			};
		} else {
			{
				final json:haxe.DynamicAccess<String> = haxe.Json.parse('{}');
				{
					json["_textColor"] = tink.Json.stringify(v);
					sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
					v;
				};
			};
		};
	}
	public static var textColor(get,null):flixel.util.FlxColor;
	public static function get_textColor() return {
		flixel.util.FlxColor.fromInt(_textColor);
	}
	private static var _buttonColor(get,set):Int;
	public static function get__buttonColor():Int  return {
		if (Prelude.truthy({
			final _45KE5qa66W3DfwQqUAwx7q:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_45KE5qa66W3DfwQqUAwx7q)) {
					final _2VJ14jhu4ALszNHtLYChzv:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_2VJ14jhu4ALszNHtLYChzv;
					};
				} else _45KE5qa66W3DfwQqUAwx7q;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				if (Prelude.truthy(json.exists("_buttonColor"))) {
					var v:Int = tink.Json.parse(json['_buttonColor']);
					v;
				} else flixel.util.FlxColor.WHITE;
			};
		} else {
			flixel.util.FlxColor.WHITE;
		};
	}
	public static function set__buttonColor(v:Int):Int  return {
		if (Prelude.truthy({
			final _bGCG49efRec9xxoKyNpLy3:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_bGCG49efRec9xxoKyNpLy3)) {
					final _qPP94H5uu4DkwU2Q2HukuS:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_qPP94H5uu4DkwU2Q2HukuS;
					};
				} else _bGCG49efRec9xxoKyNpLy3;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				json["_buttonColor"] = tink.Json.stringify(v);
				sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
				v;
			};
		} else {
			{
				final json:haxe.DynamicAccess<String> = haxe.Json.parse('{}');
				{
					json["_buttonColor"] = tink.Json.stringify(v);
					sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
					v;
				};
			};
		};
	}
	public static var buttonColor(get,null):flixel.util.FlxColor;
	public static function get_buttonColor() return {
		flixel.util.FlxColor.fromInt(_buttonColor);
	}
	private static var _disabledButtonColor(get,set):Int;
	public static function get__disabledButtonColor():Int  return {
		if (Prelude.truthy({
			final _vDNEFWXyqLXoUaZvV8R5RX:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_vDNEFWXyqLXoUaZvV8R5RX)) {
					final _oRedZfYNLMyNeJuK3zRrBc:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_oRedZfYNLMyNeJuK3zRrBc;
					};
				} else _vDNEFWXyqLXoUaZvV8R5RX;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				if (Prelude.truthy(json.exists("_disabledButtonColor"))) {
					var v:Int = tink.Json.parse(json['_disabledButtonColor']);
					v;
				} else flixel.util.FlxColor.GRAY;
			};
		} else {
			flixel.util.FlxColor.GRAY;
		};
	}
	public static function set__disabledButtonColor(v:Int):Int  return {
		if (Prelude.truthy({
			final _ix1S38uKcxmrc7rnqWUgQo:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_ix1S38uKcxmrc7rnqWUgQo)) {
					final _7DYAgkpTixpBc4kJSK18GA:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_7DYAgkpTixpBc4kJSK18GA;
					};
				} else _ix1S38uKcxmrc7rnqWUgQo;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				json["_disabledButtonColor"] = tink.Json.stringify(v);
				sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
				v;
			};
		} else {
			{
				final json:haxe.DynamicAccess<String> = haxe.Json.parse('{}');
				{
					json["_disabledButtonColor"] = tink.Json.stringify(v);
					sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
					v;
				};
			};
		};
	}
	public static var disabledButtonColor(get,null):flixel.util.FlxColor;
	public static function get_disabledButtonColor() return {
		flixel.util.FlxColor.fromInt(_disabledButtonColor);
	}
	private function _chooseString(prompt:String, choices:Array<String>, submit:(String)->Void, ?xButton:Bool, ?xKey:String):Void  {
		pauseMenu = kiss_flixel.SimpleWindow.promptForChoice(prompt, choices, submit, flixel.util.FlxColor.BLACK, textColor, buttonColor, 0.8, 0.8, Prelude.truthy(xButton), {
			final _uZ3KA1DF92ALHSgGxxjQXk:Dynamic = xKey;
			{
				if (Prelude.truthy(_uZ3KA1DF92ALHSgGxxjQXk)) _uZ3KA1DF92ALHSgGxxjQXk else {
					final _4pBG9YrcYhv7AiGyCngse:Dynamic = "";
					{
						_4pBG9YrcYhv7AiGyCngse;
					};
				};
			};
		}, "left", "right", "up", "down", "enter", null, false, true);
		pauseMenu.setUIControlColor(buttonColor);
		pauseMenu.enableGamepadInput(true, [START => ""]);
	}
	public function enterString(prompt:String, submit:(String)->Void):Void  {
		sh.cancel();
		pauseMenu = SimpleWindow.promptForString(prompt, function(s) return {
			{
				sh.start();
				submit(s);
			};
		}, null, null, null, null, null, false, null, null, null, null, null, null, null, true);
	}
	public function defineFlxPoint(submit:(flixel.math.FlxPoint)->Void):Void  {
		if (Prelude.truthy(!Prelude.truthy(mm))) {
			mm = new FlxMouseEventManager();
		} else null;
		flixel.FlxG.state.add(mm);
		{
			final screen = new flixel.FlxSprite();
			{
				screen.makeGraphic(flixel.FlxG.width, flixel.FlxG.height, flixel.util.FlxColor.fromRGBFloat(0, 1, 0, 0.2));
				screen.cameras = new kiss.List([cast(movie, FlxMovie).uiCamera]);
				cast(movie, FlxMovie).nextFrameActions.push(function() {
					{
						{
							for (camera in flixel.FlxG.cameras.list) {
								camera.zoom = 0.5;
							};
							null;
						};
						cast(movie, FlxMovie).uiCamera.zoom = 1;
						cast(movie, FlxMovie).spriteChangeDebugCamera.zoom = 1;
						mm.add(screen, function(screen) return {
							{
								mm.remove(screen);
								flixel.FlxG.state.remove(screen, true);
								{
									final pos = flixel.FlxG.mouse.getScreenPosition(flixel.FlxG.camera);
									{
										{
											for (camera in flixel.FlxG.cameras.list) {
												camera.zoom = 1;
											};
											null;
										};
										submit(pos);
									};
								};
							};
						});
						flixel.FlxG.state.add(screen);
					};
				});
			};
		};
	}
	public function defineStagePosition(camera:flixel.FlxCamera, submit:(StagePosition)->Void, ?oldPos:StagePosition):Void  {
		{
			final db = new DebugLayer();
			{
				db.cameras = new kiss.List([camera]);
				if (Prelude.truthy(oldPos)) {
					db.drawCircle(oldPos.x, oldPos.y, 4, flixel.util.FlxColor.YELLOW, 2);
				} else null;
				flixel.FlxG.state.add(db);
				defineFlxPoint(function(point) return {
					{
						flixel.FlxG.state.remove(db, true);
						submit(new StagePosition(point.x, point.y, {
							final _jKkoBaEMzSbXr5DCBvrzg3:Dynamic = oldPos?.z;
							{
								if (Prelude.truthy(_jKkoBaEMzSbXr5DCBvrzg3)) _jKkoBaEMzSbXr5DCBvrzg3 else {
									final _uVgyRin8HuQ4SFtMtohdCq:Dynamic = 5.0;
									{
										_uVgyRin8HuQ4SFtMtohdCq;
									};
								};
							};
						}));
					};
				});
			};
		};
	}
	public function defineLightSource(submit:(FlxLightSource)->Void):Void  {
		{
			final points = new kiss.List([]);
			{
				{
					function getNextPoint() return {
						defineFlxPoint(function(point) return {
							{
								points.push(point);
								getNextPoint();
							};
						});
					};
					getNextPoint();
					sh.registerItem("{enter} submit light source", {
						var _tQf3Mc5LqvQi52TRgtjC86 = false;
						{
							function(cc) return {
								if (Prelude.truthy(!Prelude.truthy(_tQf3Mc5LqvQi52TRgtjC86))) {
									_tQf3Mc5LqvQi52TRgtjC86 = true;
									{
										for (camera in flixel.FlxG.cameras.list) {
											camera.zoom = 1;
										};
										null;
									};
									if (Prelude.truthy(points)) {
										submit(new FlxLightSource(points, flixel.util.FlxColor.TRANSPARENT));
									} else null;
									cc();
								} else null;
							};
						};
					}, true);
				};
			};
		};
	}
	public function showLighting(sceneTime:SceneTime, lightSources:Array<FlxLightSource>, camera:flixel.FlxCamera):Void  {
		lightSprite = new flixel.FlxSprite();
		lightSprite.makeGraphic(flixel.FlxG.width, flixel.FlxG.height, flixel.util.FlxColor.TRANSPARENT, true);
		lightMask = new flixel.FlxSprite();
		lightMask.makeGraphic(flixel.FlxG.width, flixel.FlxG.height, flixel.util.FlxColor.WHITE, true);
		darkness = new flixel.FlxSprite();
		darkColor = switch sceneTime {
			case _2T8azGfQKrwjX5fH6pBTwh if (Prelude.truthy(Prelude.isNull(_2T8azGfQKrwjX5fH6pBTwh))):{
				{
					flixel.util.FlxColor.TRANSPARENT;
				};
			};
			case Evening:{
				EVENING_COLOR;
			};
			case Night:{
				NIGHT_COLOR;
			};
			default:{
				flixel.util.FlxColor.TRANSPARENT;
			};
		};
		darkness.makeGraphic(flixel.FlxG.width, flixel.FlxG.height, darkColor, true);
		{
			for (source in lightSources) {
				drawLight(source);
			};
			null;
		};
		blackAlphaMaskFlxSprite(darkness, lightMask, darkness);
		lightSprite.cameras = new kiss.List([cast(movie, FlxMovie).screenCamera]);
		darkness.alpha = darkColor.alphaFloat;
		darkness.cameras = new kiss.List([cast(movie, FlxMovie).screenCamera]);
		flixel.FlxG.state.add(darkness);
		flixel.FlxG.state.add(lightSprite);
	}
	public function hideLighting():Void  {
		if (Prelude.truthy(darkness)) {
			flixel.FlxG.state.remove(darkness, true);
			darkness = null;
		} else null;
		if (Prelude.truthy(lightSprite)) {
			flixel.FlxG.state.remove(lightSprite, true);
			lightSprite = null;
		} else null;
	}
	public function cleanup():Void  {
		if (Prelude.truthy(music)) {
			stopSong();
		} else null;
		hideTitleCard();
		hideTitleCard(true);
		hideBlackScreen();
		_hideDialog();
		hideLighting();
		if (Prelude.truthy({
			final _6CZoffC2FXFyzAorWZZRN2:Dynamic = cast(movie, FlxMovie).sceneKey;
			{
				if (Prelude.truthy(_6CZoffC2FXFyzAorWZZRN2)) {
					final _kAANnru6KAveaGrEREQmMJ:Dynamic = Prelude.lessThan(0, Lambda.count(cast(movie, FlxMovie).scenes));
					{
						_kAANnru6KAveaGrEREQmMJ;
					};
				} else _6CZoffC2FXFyzAorWZZRN2;
			};
		})) {
			{
				final scene = cast(movie, FlxMovie).scenes[cast(movie, FlxMovie).sceneKey];
				{
					hideSet(scene.set, scene.camera, function() {
						{ };
					});
					{
						for (prop in scene.props) {
							hideProp(prop.prop, scene.camera, function() {
								{ };
							});
						};
						null;
					};
					{
						for (character in scene.characters) {
							hideCharacter(character, scene.camera, function() {
								{ };
							});
						};
						null;
					};
				};
			};
		} else null;
		{
			for (layer in spriteLayers) {
				layer.clear();
			};
			null;
		};
		restoreOriginalVolumes.clear();
		while (true) {
			{
				final _6aUNWRz4n8HfynMkQYqsia = currentSounds.pop();
				{
					if (Prelude.truthy(_6aUNWRz4n8HfynMkQYqsia)) switch _6aUNWRz4n8HfynMkQYqsia {
						case _6dbHayLXMCCCrHpsTnxUup if (Prelude.truthy(Prelude.isNull(_6dbHayLXMCCCrHpsTnxUup))):{
							{
								break;
							};
						};
						case sound:{
							{
								stopSound(sound);
							};
						};
						default:{
							break;
						};
					} else break;
				};
			};
		};
		currentSoundVolumes.clear();
		while (true) {
			{
				final _kgAZDzNvpgALJF9svTuKXk = currentVoiceTracks.pop();
				{
					if (Prelude.truthy(_kgAZDzNvpgALJF9svTuKXk)) switch _kgAZDzNvpgALJF9svTuKXk {
						case _mvcNnR98w4YxTZxEbP8bAX if (Prelude.truthy(Prelude.isNull(_mvcNnR98w4YxTZxEbP8bAX))):{
							{
								break;
							};
						};
						case vt:{
							{
								stopVoiceTrack(vt);
							};
						};
						default:{
							break;
						};
					} else break;
				};
			};
		};
		{
			for (text in creditsText) {
				flixel.FlxG.state.remove(text, true);
				text.destroy();
			};
			null;
		};
		creditsText = new kiss.List([]);
	}
	public function autoZConfig():Option<AutoZConfig>  return {
		Some({ zPerLayer : cast(movie, FlxMovie).STAGE_BEHIND_DY, frontLayer : 0 });
	}
	public function loadActor(path) return {
		null;
	}
	public function showCharacter(character:Character<hollywoo_flixel.ActorFlxSprite>, appearance:Appearance, camera:flixel.FlxCamera, cc:Continuation):Void  {
		{
			final _pkv1WGjoWxdF2MynVrYjVb = appearance;
			{
				if (Prelude.truthy(_pkv1WGjoWxdF2MynVrYjVb)) switch _pkv1WGjoWxdF2MynVrYjVb {
					case _fe2rMKuigHw11UwDR4zM1N if (Prelude.truthy(Prelude.isNull(_fe2rMKuigHw11UwDR4zM1N))):{
						{
							null;
						};
					};
					case FirstAppearance:{
						{
							character.actor.setGraphicSize(cast(movie, FlxMovie).ACTOR_WIDTH);
							character.actor.updateHitbox();
						};
					};
					default:{
						null;
					};
				} else null;
			};
		};
		cast(movie, FlxMovie).setCameras(character.actor, new kiss.List([camera]));
		character.actor.flipX = Prelude.truthy(!Prelude.truthy(Prelude.areEqual(character.stageFacing, character.actor.defaultFacing)));
		if (Prelude.truthy(character.actor.portraitFacingForward)) {
			character.actor.flipX = false;
		} else null;
		character.actor.x = Prelude.subtract(character.stagePosition.x, Prelude.divide(character.actor.width, 2));
		character.actor.y = character.stagePosition.y;
		if (Prelude.truthy(cast(movie, FlxMovie).presetPositions.exists(character.stagePosition.stringify()))) {
			{
				final bottom = Prelude.add(character.actor.y, character.actor.height);
				{
					if (Prelude.truthy(Prelude.greaterThan(bottom, flixel.FlxG.height))) {
						character.actor.y = Prelude.subtract(character.actor.y, Prelude.subtract(bottom, flixel.FlxG.height));
					} else null;
				};
			};
			character.actor.y = Prelude.subtract(character.actor.y, character.stagePosition.z);
			{
				final layer = Prelude.subtract(LAYER_MAX, 1, Std.int(Prelude.divide(character.stagePosition.z, cast(movie, FlxMovie).STAGE_BEHIND_DY)));
				{
					spriteLayers.members[layer].add(character.actor);
				};
			};
		} else if (Prelude.truthy(true)) {
			spriteLayers.members[Prelude.min(Prelude.subtract(LAYER_MAX, 1), Std.int(character.stagePosition.z))].add(character.actor);
		} else null;
		cc();
	}
	public function hideCharacter(character:Character<hollywoo_flixel.ActorFlxSprite>, camera:flixel.FlxCamera, cc:Continuation):Void  {
		flixel.FlxG.state.remove(character.actor, true);
		{
			for (layer in spriteLayers) {
				layer.remove(character.actor, true);
			};
			null;
		};
		cc();
	}
	public var nextCC:Null<Continuation>;
	public function onContinue(continueAction:FlxActionDigital) return {
		{
			final _6nPPVd5aH9QvChYiHSvSvr = nextCC;
			{
				if (Prelude.truthy(_6nPPVd5aH9QvChYiHSvSvr)) switch _6nPPVd5aH9QvChYiHSvSvr {
					case _jUhCstzW6WwSyqbk8P3fje if (Prelude.truthy(Prelude.isNull(_jUhCstzW6WwSyqbk8P3fje))):{
						{
							null;
						};
					};
					case cc:{
						{
							nextCC = null;
							cc();
						};
					};
					default:{
						null;
					};
				} else null;
			};
		};
	}
	public function _startWaitForInput(cc:Continuation):Void  {
		nextCC = cc;
	}
	public function _stopWaitForInput():Void  {
		nextCC = null;
	}
	public static final TITLE_Y = 240;
	public static final TITLE_SIZE = 72;
	public static final TITLE_MARGIN = 100;
	public static final SUBTITLES_MARGIN = 30;
	public static final SUBTITLES_SIZE = 48;
	public var titleCard:flixel.FlxSprite = null;
	public var loadingCard:flixel.FlxSprite = null;
	public function showTitleCard(text:Array<String>, cc:Continuation, ?loading:Bool):Void  {
		if (Prelude.truthy(loading)) {
			loadingCard = new flixel.FlxSprite();
			kiss_flixel.SpriteTools.ignoreObjects[loadingCard] = true;
			loadingCard.cameras = new kiss.List([cast(movie, FlxMovie).uiCamera]);
		} else {
			titleCard = new flixel.FlxSprite();
			titleCard.cameras = new kiss.List([cast(movie, FlxMovie).screenCamera]);
		};
		{
			final card = if (Prelude.truthy(loading)) loadingCard else titleCard;
			{
				card.makeGraphic(flixel.FlxG.width, flixel.FlxG.height, flixel.util.FlxColor.BLACK, true);
				SpriteTools.writeOnSprite(text.shift(), TITLE_SIZE, card, { x : Percent(0.5), y : Pixels(TITLE_Y) });
				var subtitleY = Prelude.add(TITLE_Y, TITLE_SIZE, TITLE_MARGIN);
				{
					for (subtitle in text) {
						SpriteTools.writeOnSprite(subtitle, SUBTITLES_SIZE, card, { x : Percent(0.5), y : Pixels(subtitleY) });
						subtitleY = Prelude.add(subtitleY, SUBTITLES_SIZE, SUBTITLES_MARGIN);
					};
					null;
				};
				flixel.FlxG.state.add(card);
				cc();
			};
		};
	}
	public var isLoading:Bool = false;
	public static final LOAD_CALLS_PER_FRAME = 2;
	public static final LOAD_CALLS_PER_FRAME_SCAVENGE = 20;
	public var doneLoadingCC:()->Void;
	public function doneLoading():Void  {
		flixel.FlxG.mouse.visible = true;
		isLoading = false;
		if (Prelude.truthy(!Prelude.truthy(Reflect.field(flixel.FlxG.state, "focused")))) {
			pause();
		} else null;
		flixel.FlxG.autoPause = true;
		flixel.FlxG.state.remove(bar, true);
		flixel.FlxG.state.remove(loop, true);
		Prelude.print(Prelude.divide(Prelude.divide(flash.system.System.totalMemory, 1024), 1000), "Memory in use: ");
		doneLoadingCC();
	}
	public var lastIp:Int = 0;
	public var inputIconElapsed:Float = 0;
	public final inputIconFluctuation = 0.2;
	public final inputIconFluctuationSpeed = 2;
	public function update():Void  {
		inputIconElapsed = Prelude.add(inputIconElapsed, flixel.FlxG.elapsed);
		{
			final currentScale = Prelude.add(1.0, Prelude.multiply(inputIconFluctuation, Math.sin(Prelude.multiply(inputIconFluctuationSpeed, inputIconElapsed))));
			{
				inputIcon?.scale.set(currentScale, currentScale);
			};
		};
		if (Prelude.truthy(movie.skipTarget)) {
			barProgress = Prelude.add(barProgress, Prelude.subtract(movie.lastInstructionPointer, lastIp));
			lastIp = movie.lastInstructionPointer;
			if (Prelude.truthy(Prelude.areEqual(barProgress, barMax))) {
				doneLoading();
			} else null;
		} else null;
	}
	public var bar:FlxBar;
	public var loop:flixel.addons.util.FlxAsyncLoop = null;
	public var barProgress:Int = 0;
	public var barMax:Int = 0;
	public function doLoading(_load:Array<()->Void>, scavenged:Bool, cc:Continuation, done:Continuation):Void  {
		isLoading = true;
		flixel.FlxG.autoPause = false;
		flixel.FlxG.mouse.visible = false;
		barProgress = 0;
		lastIp = 0;
		barMax = Prelude.add(_load.length, {
			final _dkaCFkpyKRfM4qf3dbjgeX:Dynamic = movie.skipTarget;
			{
				if (Prelude.truthy(_dkaCFkpyKRfM4qf3dbjgeX)) _dkaCFkpyKRfM4qf3dbjgeX else {
					final _iMks8Ci6oo41HNa7f8kNrb:Dynamic = 1;
					{
						_iMks8Ci6oo41HNa7f8kNrb;
					};
				};
			};
		}, -1);
		bar = new FlxBar(0, 0, LEFT_TO_RIGHT, Prelude.iThird(flixel.FlxG.width), SimpleWindow.textSize, this, "barProgress", 0, barMax, true);
		doneLoadingCC = done;
		loop = new flixel.addons.util.FlxAsyncLoop(Prelude.add(1, _load.length), function() {
			{
				final _u6yf3DYa1xUDFaHiVJjWFv = _load.shift();
				{
					if (Prelude.truthy(_u6yf3DYa1xUDFaHiVJjWFv)) switch _u6yf3DYa1xUDFaHiVJjWFv {
						case _q1Tsjhp3jzCX49HFiEoWgE if (Prelude.truthy(Prelude.isNull(_q1Tsjhp3jzCX49HFiEoWgE))):{
							{
								{
									if (Prelude.truthy(!Prelude.truthy(movie.skipTarget))) {
										doneLoading();
									} else null;
									cast(movie, FlxMovie).nextFrameActions.push(cc);
								};
							};
						};
						case nextLoad:{
							{
								nextLoad();
								barProgress = Prelude.add(barProgress, 1);
							};
						};
						default:{
							{
								if (Prelude.truthy(!Prelude.truthy(movie.skipTarget))) {
									doneLoading();
								} else null;
								cast(movie, FlxMovie).nextFrameActions.push(cc);
							};
						};
					} else {
						if (Prelude.truthy(!Prelude.truthy(movie.skipTarget))) {
							doneLoading();
						} else null;
						cast(movie, FlxMovie).nextFrameActions.push(cc);
					};
				};
			};
		}, if (Prelude.truthy(scavenged)) LOAD_CALLS_PER_FRAME_SCAVENGE else LOAD_CALLS_PER_FRAME);
		haxe.Timer.delay(function() {
			loop.start();
		}, 1);
		bar.cameras = new kiss.List([cast(movie, FlxMovie).uiCamera]);
		bar.createColoredEmptyBar(flixel.util.FlxColor.BLACK, true, flixel.util.FlxColor.WHITE);
		bar.createColoredFilledBar(flixel.util.FlxColor.WHITE, false);
		bar.screenCenter();
		flixel.FlxG.state.add(bar);
		flixel.FlxG.state.add(loop);
		kiss_flixel.SpriteTools.ignoreObjects[bar] = true;
		kiss_flixel.SpriteTools.ignoreObjects[loop] = true;
	}
	public function hideTitleCard(?loading:Bool):Void  {
		if (Prelude.truthy(loading)) if (Prelude.truthy(loadingCard)) {
			flixel.FlxG.state.remove(loadingCard, true);
			loadingCard = null;
		} else null else if (Prelude.truthy(titleCard)) {
			flixel.FlxG.state.remove(titleCard, true);
			titleCard = null;
		} else null;
	}
	public static final DIALOG_BOX_COLOR = flixel.util.FlxColor.BLACK;
	public static final DIALOG_COLOR = flixel.util.FlxColor.WHITE;
	public static final DIALOG_SIZE = 24;
	public var dialogBox:flixel.FlxSprite;
	public var superText:flixel.FlxSprite;
	public var dialogText:FlxText;
	private var _speakerNameText:FlxText;
	public var speakerNameText(get,set):FlxText;
	public function set_speakerNameText(text) return {
		if (Prelude.truthy(_speakerNameText)) {
			flixel.FlxG.state.remove(_speakerNameText, true);
			_speakerNameText = null;
		} else null;
		_speakerNameText = text;
	}
	public function get_speakerNameText() return {
		_speakerNameText;
	}
	public static final SUPER_MARGIN = 10;
	public function applyFormat(text:FlxText) return {
		text.applyMarkup(text.text, new kiss.List([new FlxTextFormatMarkerPair(new FlxTextFormat(flixel.util.FlxColor.CYAN), "*")]));
	}
	public function showExpression(actor:hollywoo_flixel.ActorFlxSprite, wryly:String) return {
		if (Prelude.truthy(wryly)) actor.playAnimation(wryly) else actor.playAnimation("neutral");
	}
	public function _showDialog(speakerName:String, type:SpeechType<hollywoo_flixel.ActorFlxSprite>, wryly:String, text:String, cc:Continuation) return {
		var speakerNameX:Float = -1;
		switch type {
			case _3YEntcDf5U5ay9HNf8fUWC if (Prelude.truthy(Prelude.isNull(_3YEntcDf5U5ay9HNf8fUWC))):{
				{ };
			};
			case Super:{
				if (Prelude.truthy(superText)) {
					flixel.FlxG.state.remove(superText, true);
				} else null;
				superText = SpriteTools.textPlate(text, DIALOG_SIZE, SUPER_MARGIN, null, null, applyFormat);
				if (Prelude.truthy(Prelude.lesserEqual(superText.width, flixel.FlxG.width))) {
					superText.cameras = new kiss.List([cast(movie, FlxMovie).uiCamera]);
					superText.screenCenter();
					superText.y = cast(movie, FlxMovie).DIALOG_Y;
					flixel.FlxG.state.add(superText);
					return;
				} else null;
			};
			case OnScreen(character):{
				speakerNameX = Prelude.add(character.actor.x, Prelude.fHalf(character.actor.width));
			};
			case OffScreen(actor) | VoiceOver(actor) | TextMessage(actor) | FromPhone(actor):{
				null;
			};
			default:{ };
		};
		if (Prelude.truthy(!Prelude.truthy(dialogBox))) {
			dialogBox = new flixel.FlxSprite(cast(movie, FlxMovie).DIALOG_X, cast(movie, FlxMovie).DIALOG_Y);
			dialogBox.makeGraphic(cast(movie, FlxMovie).DIALOG_WIDTH, cast(movie, FlxMovie).DIALOG_HEIGHT, DIALOG_BOX_COLOR);
		} else null;
		dialogBox.cameras = new kiss.List([cast(movie, FlxMovie).uiCamera]);
		flixel.FlxG.state.add(dialogBox);
		if (Prelude.truthy(!Prelude.truthy(dialogText))) {
			dialogText = new FlxText(cast(movie, FlxMovie).DIALOG_X, cast(movie, FlxMovie).DIALOG_Y, cast(movie, FlxMovie).DIALOG_WIDTH, "", DIALOG_SIZE);
		} else null;
		dialogText.cameras = new kiss.List([cast(movie, FlxMovie).uiCamera]);
		flixel.FlxG.state.add(dialogText);
		dialogText.text = text;
		applyFormat(dialogText);
		speakerNameText = null;
		speakerNameText = new FlxText(cast(movie, FlxMovie).DIALOG_X, cast(movie, FlxMovie).DIALOG_Y, 0, "", DIALOG_SIZE);
		speakerNameText.cameras = new kiss.List([cast(movie, FlxMovie).uiCamera]);
		flixel.FlxG.state.add(speakerNameText);
		if (Prelude.truthy(speakerName)) {
			speakerNameText.text = (Prelude.add("", Std.string({
				speakerName;
			}), ":") : String);
			if (Prelude.truthy(Prelude.areEqual(speakerNameX, -1))) {
				speakerNameX = cast(movie, FlxMovie).DIALOG_X;
			} else null;
			speakerNameX = Prelude.subtract(speakerNameX, Prelude.fHalf(speakerNameText.width));
			{
				final minVal = cast(movie, FlxMovie).DIALOG_X; final maxVal = Prelude.subtract(Prelude.add(cast(movie, FlxMovie).DIALOG_X, cast(movie, FlxMovie).DIALOG_WIDTH), speakerNameText.width);
				{
					if (Prelude.truthy(minVal)) {
						speakerNameX = Prelude.max(minVal, speakerNameX);
					} else null;
					if (Prelude.truthy(maxVal)) {
						speakerNameX = Prelude.min(maxVal, speakerNameX);
					} else null;
					speakerNameX;
				};
			};
			speakerNameText.x = speakerNameX;
			dialogText.y = Prelude.add(cast(movie, FlxMovie).DIALOG_Y, speakerNameText.height);
		} else dialogText.y = cast(movie, FlxMovie).DIALOG_Y;
		dialogText.size = DIALOG_SIZE;
		while (Prelude.truthy(Prelude.lessThan(flixel.FlxG.height, Prelude.add(dialogText.y, dialogText.height)))) {
			dialogText.size = Prelude.subtract(dialogText.size, 6);
		};
	}
	public function _hideDialog():Void  {
		if (Prelude.truthy(dialogText)) {
			flixel.FlxG.state.remove(dialogText);
			dialogText = null;
		} else null;
		if (Prelude.truthy(speakerNameText)) {
			flixel.FlxG.state.remove(speakerNameText);
			speakerNameText = null;
		} else null;
		if (Prelude.truthy(dialogBox)) {
			flixel.FlxG.state.remove(dialogBox);
			dialogBox = null;
		} else null;
		if (Prelude.truthy(superText)) {
			flixel.FlxG.state.remove(superText, true);
			superText = null;
		} else null;
	}
	public static var soundVolume(get,set):Float;
	public static function get_soundVolume():Float  return {
		if (Prelude.truthy({
			final _32b1c5GPC2yiRnqqxjGiCD:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_32b1c5GPC2yiRnqqxjGiCD)) {
					final _8N6k3YczunfgANyfqg9ozQ:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_8N6k3YczunfgANyfqg9ozQ;
					};
				} else _32b1c5GPC2yiRnqqxjGiCD;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				if (Prelude.truthy(json.exists("soundVolume"))) {
					var v:Float = tink.Json.parse(json['soundVolume']);
					v;
				} else 1.0;
			};
		} else {
			1.0;
		};
	}
	public static function set_soundVolume(v:Float):Float  return {
		if (Prelude.truthy({
			final _ji2fTjxtzfEgDY7N7Gsfu4:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_ji2fTjxtzfEgDY7N7Gsfu4)) {
					final _mX49QVYa8DNmekR7Xbwvk:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_mX49QVYa8DNmekR7Xbwvk;
					};
				} else _ji2fTjxtzfEgDY7N7Gsfu4;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				json["soundVolume"] = tink.Json.stringify(v);
				sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
				v;
			};
		} else {
			{
				final json:haxe.DynamicAccess<String> = haxe.Json.parse('{}');
				{
					json["soundVolume"] = tink.Json.stringify(v);
					sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
					v;
				};
			};
		};
	}
	public static var masterVolume(get,set):Float;
	public static function get_masterVolume():Float  return {
		if (Prelude.truthy({
			final _ibJnTyWqhFFRC8nVWWPC7T:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_ibJnTyWqhFFRC8nVWWPC7T)) {
					final _pvnwGf9L8wppDbKPWw13fp:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_pvnwGf9L8wppDbKPWw13fp;
					};
				} else _ibJnTyWqhFFRC8nVWWPC7T;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				if (Prelude.truthy(json.exists("masterVolume"))) {
					var v:Float = tink.Json.parse(json['masterVolume']);
					v;
				} else 1.0;
			};
		} else {
			1.0;
		};
	}
	public static function set_masterVolume(v:Float):Float  return {
		if (Prelude.truthy({
			final _rXCpn1qcBrFMukz3YCG1yC:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_rXCpn1qcBrFMukz3YCG1yC)) {
					final _eySGREcdg5NQ7VDKNq63CS:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_eySGREcdg5NQ7VDKNq63CS;
					};
				} else _rXCpn1qcBrFMukz3YCG1yC;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				json["masterVolume"] = tink.Json.stringify(v);
				sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
				v;
			};
		} else {
			{
				final json:haxe.DynamicAccess<String> = haxe.Json.parse('{}');
				{
					json["masterVolume"] = tink.Json.stringify(v);
					sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
					v;
				};
			};
		};
	}
	public final currentSounds:Array<FlxSound> = new kiss.List([]);
	public final currentSoundVolumes:Map<FlxSound,Array<Float>> = new Map();
	public function loadSound(path) return {
		{
			final s = new HFlxSound();
			{
				s.loadEmbedded(path);
				s.persist = true;
				s.autoDestroy = false;
				s;
			};
		};
	}
	public function playSound(sound:FlxSound, volumeMod:Float, ?cc:Continuation):Void  {
		{
			final originalVolume = sound.volume; final onComplete = function() return {
				{
					currentSounds.remove(sound);
					currentSoundVolumes.remove(sound);
					sound.volume = originalVolume;
					if (Prelude.truthy(cc)) {
						cc();
					} else null;
				};
			};
			{
				currentSoundVolumes[sound] = new kiss.List([originalVolume, volumeMod]);
				sound.volume = Prelude.multiply(sound.volume, volumeMod, soundVolume);
				sound.onComplete = onComplete;
			};
		};
		currentSounds.push(sound);
		sound.play();
	}
	public function stopSound(sound:FlxSound):Void  {
		currentSounds.remove(sound);
		sound.stop();
	}
	public static final CAPTION_Y = 50;
	public var captions:FlxGroup = null;
	public final captionIds:Map<Int,flixel.FlxSprite> = new Map();
	public function showCaption(description:String, id:Int):Void  {
		if (Prelude.truthy(!Prelude.truthy(captions))) {
			captions = new FlxGroup();
		} else null;
		{
			final firstNull = captions.getFirstNull(); final row = switch firstNull {
				case _pFptSSihjiSbmdGbT3863D if (Prelude.truthy(Prelude.isNull(_pFptSSihjiSbmdGbT3863D))):{
					{
						firstNull;
					};
				};
				case -1:{
					0;
				};
				default:{
					firstNull;
				};
			}; final plate = SpriteTools.textPlate((Prelude.add("[", Std.string({
				description;
			}), "]") : String), DIALOG_SIZE, SUPER_MARGIN);
			{
				plate.screenCenter();
				plate.y = Prelude.add(CAPTION_Y, Prelude.multiply(plate.height, row));
				plate.cameras = new kiss.List([cast(movie, FlxMovie).uiCamera]);
				captions.add(plate);
				captionIds[id] = plate;
				flixel.FlxG.state.add(plate);
			};
		};
	}
	public function hideCaption(id:Int):Void  {
		{
			final plate = captionIds[id];
			{
				captions.remove(plate);
				flixel.FlxG.state.remove(plate, true);
				captionIds.remove(id);
			};
		};
	}
	public function getSoundLength(sound:FlxSound):Float  return {
		sound.length;
	}
	public function loadSong(path) return {
		{
			final song = flixel.FlxG.sound.load(path);
			{
				{
					final _8HZ3AtdvMqywTExfYhotHP = !Prelude.truthy(Prelude.areEqual(0, song.length));
					{
						if (Prelude.truthy(_8HZ3AtdvMqywTExfYhotHP)) _8HZ3AtdvMqywTExfYhotHP else throw kiss.Prelude.runtimeInsertAssertionMessage((Prelude.add("song from ", Std.string(path), " has 0 length! avoid mp3s for this reason") : String), "/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/FlxDirector.kiss:873:9: Assertion failed: \nFrom:[(assert (not (= 0 song.length)) (the String (+ \"song from \" (Std.string path) \" has 0 length! avoid mp3s for this reason\")))]", 4);
					};
				};
				song.persist = true;
				song.autoDestroy = false;
				song;
			};
		};
	}
	public function getSongLength(song:FlxSound):Float  return {
		Prelude.divide(song.length, 1000);
	}
	public static var voiceVolume(get,set):Float;
	public static function get_voiceVolume():Float  return {
		if (Prelude.truthy({
			final _uUZwKCQxMynr1hrWMeEeDC:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_uUZwKCQxMynr1hrWMeEeDC)) {
					final _bE5EA8B4LAtSP5TbaTf88n:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_bE5EA8B4LAtSP5TbaTf88n;
					};
				} else _uUZwKCQxMynr1hrWMeEeDC;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				if (Prelude.truthy(json.exists("voiceVolume"))) {
					var v:Float = tink.Json.parse(json['voiceVolume']);
					v;
				} else 1.0;
			};
		} else {
			1.0;
		};
	}
	public static function set_voiceVolume(v:Float):Float  return {
		if (Prelude.truthy({
			final _m4jKeED5Kx5CGnNFWYWDjZ:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_m4jKeED5Kx5CGnNFWYWDjZ)) {
					final _wcnUNNSB5Hytm4vfKQTc7G:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_wcnUNNSB5Hytm4vfKQTc7G;
					};
				} else _m4jKeED5Kx5CGnNFWYWDjZ;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				json["voiceVolume"] = tink.Json.stringify(v);
				sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
				v;
			};
		} else {
			{
				final json:haxe.DynamicAccess<String> = haxe.Json.parse('{}');
				{
					json["voiceVolume"] = tink.Json.stringify(v);
					sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
					v;
				};
			};
		};
	}
	public final currentVoiceTracks:Array<FlxSound> = new kiss.List([]);
	public final restoreOriginalVolumes:Map<FlxSound,Function> = new Map();
	public function loadVoiceTrack(wavPath) return {
		{
			final vt = flixel.FlxG.sound.load(wavPath);
			{
				vt.persist = true;
				vt.autoDestroy = false;
				vt;
			};
		};
	}
	public function playVoiceTrack(track:FlxSound, volumeMod:Float, start:Float, end:Float, cc:Continuation):Void  {
		{
			final originalVolume = track.volume; final restoreOriginalVolume = function() return {
				{
					track.volume = originalVolume;
					currentSoundVolumes.remove(track);
				};
			};
			{
				currentSoundVolumes[track] = new kiss.List([originalVolume, volumeMod]);
				restoreOriginalVolumes[track] = restoreOriginalVolume;
				track.volume = Prelude.multiply(track.volume, volumeMod, voiceVolume);
				track.onComplete = function() return {
					{
						currentVoiceTracks.remove(track);
						restoreOriginalVolume();
						cc();
					};
				};
			};
		};
		currentVoiceTracks.push(track);
		track.play(true, Prelude.multiply(1000, start), Prelude.multiply(1000, end));
	}
	public function stopVoiceTrack(track:FlxSound):Void  {
		currentVoiceTracks.remove(track);
		track.stop();
		if (Prelude.truthy(restoreOriginalVolumes.exists(track))) {
			restoreOriginalVolumes[track];
		} else null;
	}
	public var music:FlxSound;
	public var musicFadeTimer:FlxTimer;
	public final MUSIC_FADE_SEC = 1;
	public final MUSIC_FADE_STEPS = 10;
	public static var musicVolume(get,set):Float;
	public static function get_musicVolume():Float  return {
		if (Prelude.truthy({
			final _4p22YUMz252TCTXDKFmLRJ:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_4p22YUMz252TCTXDKFmLRJ)) {
					final _7m38c2RqM5ywgZjvMwSwA8:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_7m38c2RqM5ywgZjvMwSwA8;
					};
				} else _4p22YUMz252TCTXDKFmLRJ;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				if (Prelude.truthy(json.exists("musicVolume"))) {
					var v:Float = tink.Json.parse(json['musicVolume']);
					v;
				} else 1.0;
			};
		} else {
			1.0;
		};
	}
	public static function set_musicVolume(v:Float):Float  return {
		if (Prelude.truthy({
			final _n8pKXvMCfPnfkKVWdQthSP:Dynamic = sys.FileSystem.exists(".FlxDirector.json");
			{
				if (Prelude.truthy(_n8pKXvMCfPnfkKVWdQthSP)) {
					final _itpFFQm2frqzAsaPF7xUQW:Dynamic = !Prelude.truthy(sys.FileSystem.isDirectory(".FlxDirector.json"));
					{
						_itpFFQm2frqzAsaPF7xUQW;
					};
				} else _n8pKXvMCfPnfkKVWdQthSP;
			};
		})) {
			final content = sys.io.File.getContent(".FlxDirector.json"); final json:haxe.DynamicAccess<String> = haxe.Json.parse(content);
			{
				json["musicVolume"] = tink.Json.stringify(v);
				sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
				v;
			};
		} else {
			{
				final json:haxe.DynamicAccess<String> = haxe.Json.parse('{}');
				{
					json["musicVolume"] = tink.Json.stringify(v);
					sys.io.File.saveContent(".FlxDirector.json", haxe.Json.stringify(json));
					v;
				};
			};
		};
	}
	public function updateMusicVolume():Void  {
		if (Prelude.truthy(music)) {
			{
				final originalVolumeSet = currentSoundVolumes[music];
				{
					if (Prelude.truthy(Prelude.greaterThan(1.0, originalVolumeSet[0]))) {
						originalVolumeSet[0] = Prelude.add(originalVolumeSet[0], Prelude.divide(1.0, MUSIC_FADE_STEPS));
					} else null;
					music.volume = Prelude.multiply(originalVolumeSet[0], originalVolumeSet[1], musicVolume);
				};
			};
		} else null;
	}
	public function playSong(song:FlxSound, volumeMod:Float, loop:Bool, waitForEnd:Bool, cc:Continuation):Void  {
		if (Prelude.truthy(music)) {
			stopSong();
		} else null;
		{
			final onFinish = function() return {
				{
					currentSoundVolumes.remove(music);
					music = null;
					if (Prelude.truthy(waitForEnd)) {
						cc();
					} else null;
				};
			};
			{
				music = flixel.FlxG.sound.play(Reflect.field(song, "_sound"), 0, loop, null, true, onFinish);
				currentSoundVolumes[music] = new kiss.List([0, volumeMod]);
				musicFadeTimer = new FlxTimer().start(Prelude.divide(MUSIC_FADE_SEC, MUSIC_FADE_STEPS), function(_) {
					updateMusicVolume();
				}, MUSIC_FADE_STEPS);
				music.persist = true;
				if (Prelude.truthy(!Prelude.truthy(waitForEnd))) {
					cc();
				} else null;
			};
		};
	}
	public function changeSongVolume(volumeMod:Float, cc:Continuation):Void  {
		{
			final _xeD7RncvoYkPGf11exYbDk = currentSoundVolumes[music]; final fade = _xeD7RncvoYkPGf11exYbDk[0]; final oldMod = _xeD7RncvoYkPGf11exYbDk[1];
			{
				music.volume = Prelude.multiply(fade, volumeMod, musicVolume);
				currentSoundVolumes[music] = new kiss.List([fade, volumeMod]);
			};
		};
		cc();
	}
	public function stopSong():Void  {
		if (Prelude.truthy(music)) {
			music.stop();
		} else null;
		if (Prelude.truthy(musicFadeTimer)) {
			musicFadeTimer.cancel();
		} else null;
		music = null;
	}
	public static final PROP_MIN_WIDTH = 200;
	public static final PROP_MAX_WIDTH = 500;
	public var autoPlaceProps:Bool = true;
	public function scaleProp(prop:flixel.FlxSprite) return {
		{
			final propKey = _propKey(prop);
			{
				if (Prelude.truthy(!Prelude.truthy(cast(movie, FlxMovie).propScales.exists(propKey)))) {
					if (Prelude.truthy(cast(movie, FlxMovie).textProps.contains(prop))) {
						return;
					} else null;
					if (Prelude.truthy(!Prelude.truthy(StringTools.contains(propKey, "anonProp")))) {
						prop.setGraphicSize(flixel.FlxG.width);
						prop.updateHitbox();
						if (Prelude.truthy(Prelude.greaterThan(prop.height, flixel.FlxG.height))) {
							prop.setGraphicSize(0, flixel.FlxG.height);
						} else null;
						cast(movie, FlxMovie).propScales.put(propKey, new JsonFloat(prop.scale.x));
					} else null;
				} else null;
				{
					final scale:Float = cast(movie, FlxMovie).propScales.get(propKey).value;
					{
						if (Prelude.truthy(StringTools.contains(propKey, "anonProp"))) {
							return;
						} else null;
						if (Prelude.truthy(!Prelude.truthy(cast(movie, FlxMovie).propsInScene.exists(cast(movie, FlxMovie).sceneKey)))) {
							cast(movie, FlxMovie).propsInScene[cast(movie, FlxMovie).sceneKey] = new kiss.List([]);
						} else null;
						if (Prelude.truthy(!Prelude.truthy(!Prelude.truthy(Prelude.areEqual(-1, cast(movie, FlxMovie).propsInScene[cast(movie, FlxMovie).sceneKey].indexOf(propKey)))))) {
							cast(movie, FlxMovie).propsInScene[cast(movie, FlxMovie).sceneKey].push(propKey);
						} else null;
						prop.scale.set(scale, scale);
						prop.updateHitbox();
					};
				};
			};
		};
	}
	public function loadProp(path) return {
		{
			final propSprite = new flixel.FlxSprite(0, 0);
			{
				propSprite.loadGraphic(path, false, 0, 0, true);
			};
		};
	}
	public var oldScaleBehavior:Bool = false;
	public function showProp(prop:flixel.FlxSprite, position:StagePosition, appearance:Appearance, camera:flixel.FlxCamera, cc:Continuation):Void  {
		cast(movie, FlxMovie).setCameras(prop, new kiss.List([camera]));
		{
			final width = Prelude.min(Prelude.max(prop.width, PROP_MIN_WIDTH), PROP_MAX_WIDTH);
			{
				if (Prelude.truthy(!Prelude.truthy({
					final _t6cKwGq1xua5QBd6AbJQ5A:Dynamic = !Prelude.truthy(oldScaleBehavior);
					{
						if (Prelude.truthy(_t6cKwGq1xua5QBd6AbJQ5A)) {
							final _vjCyAqqi6dnfYhZWQQPrUk:Dynamic = cast(movie, FlxMovie).textProps.contains(prop);
							{
								_vjCyAqqi6dnfYhZWQQPrUk;
							};
						} else _t6cKwGq1xua5QBd6AbJQ5A;
					};
				}))) {
					{
						final _wiDyL2H4THY6bh9FucMqA4 = appearance;
						{
							if (Prelude.truthy(_wiDyL2H4THY6bh9FucMqA4)) switch _wiDyL2H4THY6bh9FucMqA4 {
								case _o2vRfwZf3qJf22XxVPfJVr if (Prelude.truthy(Prelude.isNull(_o2vRfwZf3qJf22XxVPfJVr))):{
									{
										null;
									};
								};
								case FirstAppearance:{
									{
										if (Prelude.truthy(Prelude.areEqual(1, prop.scale.x, prop.scale.y))) {
											prop.setGraphicSize(width);
											prop.updateHitbox();
										} else null;
									};
								};
								default:{
									null;
								};
							} else null;
						};
					};
				} else null;
				prop.x = position.x;
				prop.y = position.y;
				if (Prelude.truthy(cast(movie, FlxMovie).presetPositions.exists(position.stringify()))) {
					if (Prelude.truthy(Prelude.greaterThan(prop.height, cast(movie, FlxMovie).DIALOG_Y))) {
						prop.setGraphicSize(0, Std.int(cast(movie, FlxMovie).DIALOG_Y));
						prop.updateHitbox();
					} else null;
					prop.x = Prelude.subtract(prop.x, Prelude.divide(prop.width, 2));
					prop.y = Prelude.subtract(prop.y, Prelude.divide(prop.height, 2));
					{
						final propBottom = Prelude.add(prop.y, prop.height);
						{
							if (Prelude.truthy(Prelude.greaterThan(propBottom, flixel.FlxG.height))) {
								prop.y = Prelude.subtract(prop.y, Prelude.subtract(propBottom, flixel.FlxG.height));
							} else null;
						};
					};
				} else if (Prelude.truthy(true)) {
					scaleProp(prop);
				} else null;
				{
					final layerNum = position.z;
					{
						{
							final _gnQLzEAcdCp3jYasxu14tp = layerNum; final _iHW1PSDYkBSjqWhnbD1fYw = Std.int(layerNum);
							{
								{
									final _pm3og1nusV5HS5CmvJHHft = Prelude.areEqual(_gnQLzEAcdCp3jYasxu14tp, _iHW1PSDYkBSjqWhnbD1fYw);
									{
										if (Prelude.truthy(_pm3og1nusV5HS5CmvJHHft)) _pm3og1nusV5HS5CmvJHHft else throw kiss.Prelude.runtimeInsertAssertionMessage(Prelude.add("expected ", _gnQLzEAcdCp3jYasxu14tp, " but it was ", _iHW1PSDYkBSjqWhnbD1fYw), "/Users/nat/repos/hollywoo-flixel/src/hollywoo_flixel/FlxDirector.kiss:1022:13: Assertion failed: \nFrom:[(assert (= _gnQLzEAcdCp3jYasxu14tp _iHW1PSDYkBSjqWhnbD1fYw) (+ \"expected \" _gnQLzEAcdCp3jYasxu14tp \" but it was \" _iHW1PSDYkBSjqWhnbD1fYw))]", 4);
									};
								};
							};
						};
						spriteLayers.members[Prelude.min(LAYER_MAX, Prelude.add(1, Std.int(layerNum)))].add(prop);
					};
				};
			};
		};
		prop.x = Math.round(prop.x);
		prop.y = Math.round(prop.y);
		cc();
	}
	private static final _propKeys:Map<flixel.FlxSprite,String> = new Map();
	public static var anonProps = 0;
	private static function _propKey(prop:flixel.FlxSprite) return {
		{
			final _kGw2dWa2znyEWNdSeCX6p9 = _propKeys[prop];
			{
				if (Prelude.truthy(_kGw2dWa2znyEWNdSeCX6p9)) switch _kGw2dWa2znyEWNdSeCX6p9 {
					case _aUUQpBqVAdjeD2Kow2H3Ni if (Prelude.truthy(Prelude.isNull(_aUUQpBqVAdjeD2Kow2H3Ni))):{
						{
							_propKeys[prop] = {
								final _avso2EwiGjh98xubRBNqJN:Dynamic = prop.graphic.assetsKey;
								{
									if (Prelude.truthy(_avso2EwiGjh98xubRBNqJN)) _avso2EwiGjh98xubRBNqJN else {
										final _rJXDvupZu5qCzbwp6SHnLC:Dynamic = ((Prelude.add("anonProp#", Std.string({
											anonProps++;
										}), "") : String));
										{
											_rJXDvupZu5qCzbwp6SHnLC;
										};
									};
								};
							};
						};
					};
					case key:{
						key;
					};
					default:{
						_propKeys[prop] = {
							final _avso2EwiGjh98xubRBNqJN:Dynamic = prop.graphic.assetsKey;
							{
								if (Prelude.truthy(_avso2EwiGjh98xubRBNqJN)) _avso2EwiGjh98xubRBNqJN else {
									final _rJXDvupZu5qCzbwp6SHnLC:Dynamic = (Prelude.add("anonProp#", Std.string({
										anonProps++;
									}), "") : String);
									{
										_rJXDvupZu5qCzbwp6SHnLC;
									};
								};
							};
						};
					};
				} else _propKeys[prop] = {
					final _26grs6Svi5dCeF1jaGRuXP:Dynamic = prop.graphic.assetsKey;
					{
						if (Prelude.truthy(_26grs6Svi5dCeF1jaGRuXP)) _26grs6Svi5dCeF1jaGRuXP else {
							final _bqnYakvstE4vhBxPEVEovF:Dynamic = (Prelude.add("anonProp#", Std.string({
								anonProps++;
							}), "") : String);
							{
								_bqnYakvstE4vhBxPEVEovF;
							};
						};
					};
				};
			};
		};
	}
	public function hideProp(prop:flixel.FlxSprite, camera:flixel.FlxCamera, cc):Void  {
		flixel.FlxG.state.remove(prop, true);
		if (Prelude.truthy(!Prelude.truthy(cast(movie, FlxMovie).propsInScene.exists(cast(movie, FlxMovie).sceneKey)))) {
			cast(movie, FlxMovie).propsInScene[cast(movie, FlxMovie).sceneKey] = new kiss.List([]);
		} else null;
		{
			final propKey = _propKey(prop);
			{
				cast(movie, FlxMovie).propsInScene[cast(movie, FlxMovie).sceneKey].remove(propKey);
			};
		};
		{
			for (layer in spriteLayers) {
				layer.remove(prop, true);
			};
			null;
		};
		cc();
	}
	public var creditsText:kiss.List<FlxText> = new kiss.List([]);
	private function _ctext(text:String, size:Int) return {
		{
			final t = new FlxText(0, 0, 0, text, size);
			{
				creditsText.push(t);
				t;
			};
		};
	}
	public var blackBG:flixel.FlxSprite = null;
	public function showBlackScreen():Void  {
		blackBG = new flixel.FlxSprite();
		blackBG.cameras = new kiss.List([cast(movie, FlxMovie).screenCamera]);
		blackBG.makeGraphic(flixel.FlxG.width, flixel.FlxG.height, flixel.util.FlxColor.BLACK, true);
		flixel.FlxG.state.add(blackBG);
	}
	public function hideBlackScreen():Void  {
		if (Prelude.truthy(blackBG)) {
			flixel.FlxG.state.remove(blackBG, true);
			blackBG = null;
		} else null;
	}
	public static final IDEAL_SCROLL_SPEED = 200;
	public static final oneColSize = 64;
	public static final twoColSize = 48;
	public static final threeColSize = 32;
	public static final creditMargin = 20;
	public static final twoColumnGap = 50;
	public function rollCredits(credits:Array<CreditsLine>, cc, ?timeLimit:Float):Void  {
		var calledCC = false;
		var textY = flixel.FlxG.height;
		{ };
		{ };
		{ };
		{ };
		{ };
		{
			for (line in credits) {
				switch line {
					case _rBRjFBXYX5T9jeJuXgdSxb if (Prelude.truthy(Prelude.isNull(_rBRjFBXYX5T9jeJuXgdSxb))):{
						{ };
					};
					case Break:{
						textY = Prelude.add(textY, oneColSize);
					};
					case OneColumn(col1):{
						{
							final t = _ctext(col1, oneColSize);
							{
								t.screenCenter();
								t.y = textY;
							};
						};
						textY = Prelude.add(textY, oneColSize, creditMargin);
					};
					case TwoColumn(col1, col2):{
						{
							final t1 = _ctext(col1, twoColSize); final t2 = _ctext(col2, twoColSize);
							{
								t1.x = Prelude.subtract(Prelude.multiply(flixel.FlxG.width, 0.3), t1.width, Prelude.divide(twoColumnGap, 2));
								t1.y = textY;
								t2.x = Prelude.add(Prelude.multiply(flixel.FlxG.width, 0.3), Prelude.divide(twoColumnGap, 2));
								{
									final clippedRight = Prelude.subtract(Prelude.add(t2.x, t2.width), flixel.FlxG.width);
									{
										if (Prelude.truthy(Prelude.greaterThan(clippedRight, 0))) {
											t2.x = Prelude.subtract(t2.x, clippedRight);
										} else null;
									};
								};
								t2.y = textY;
							};
						};
						textY = Prelude.add(textY, twoColSize, creditMargin);
					};
					case ThreeColumn(col1, col2, col3):{
						{
							final t1 = _ctext(col1, threeColSize); final t2 = _ctext(col2, threeColSize); final t3 = _ctext(col3, threeColSize);
							{
								t1.x = creditMargin;
								t1.y = textY;
								t2.screenCenter();
								t2.y = textY;
								t3.x = Prelude.subtract(flixel.FlxG.width, creditMargin, t3.width);
								t3.y = textY;
							};
						};
						textY = Prelude.add(textY, threeColSize, creditMargin);
					};
					default:{ };
				};
			};
			null;
		};
		{
			for (text in creditsText) {
				if (Prelude.truthy(Prelude.lessThan(text.x, 0))) {
					text.setGraphicSize(Prelude.subtract(text.width, Prelude.subtract(text.x)));
					text.x = 0;
				} else null;
				if (Prelude.truthy(Prelude.greaterThan(Prelude.add(text.x, text.width), flixel.FlxG.width))) {
					text.setGraphicSize(Prelude.subtract(text.width, Prelude.subtract(Prelude.add(text.x, text.width), flixel.FlxG.width)));
				} else null;
			};
			null;
		};
		{
			final pixelsToScroll = Prelude.add(textY, creditsText[-1].height); final idealTimeLimit = Prelude.divide(pixelsToScroll, IDEAL_SCROLL_SPEED); final timeLimitDifference = Prelude.subtract(idealTimeLimit, timeLimit); final scrollSpeed = if (Prelude.truthy(timeLimit)) Prelude.divide(pixelsToScroll, timeLimit) else IDEAL_SCROLL_SPEED;
			{
				{
					if (Prelude.truthy(!Prelude.truthy(Prelude.areEqual(scrollSpeed, IDEAL_SCROLL_SPEED)))) {
						Prelude.print((Prelude.add("Time given for credit roll (", Std.string({
							timeLimit;
						}), "s) is ", Std.string(Math.abs(timeLimitDifference)), "sec ", Std.string(if (Prelude.truthy(Prelude.greaterThan(timeLimitDifference, 0))) "too short" else "too long"), " for ideal speed.") : String));
					} else null;
				};
				{
					for (text in creditsText) {
						flixel.FlxG.state.add(text);
						text.cameras = new kiss.List([cast(movie, FlxMovie).uiCamera]);
						{
							final tweenArgs:Array<Dynamic> = new kiss.List([]);
							{
								tweenArgs.push(false);
								tweenArgs.push(text);
								tweenArgs.push(text.x);
								tweenArgs.push(Prelude.subtract(text.y, textY));
								tweenArgs.push(scrollSpeed);
								tweenArgs.push(function() {
									if (Prelude.truthy(!Prelude.truthy(calledCC))) {
										calledCC = true;
										cc();
									} else null;
								});
								Reflect.callMethod(cast(movie, FlxMovie), Reflect.field(cast(movie, FlxMovie), "linearMotion"), tweenArgs);
							};
						};
					};
					null;
				};
			};
		};
	}
	public var inputIcon:flixel.FlxSprite;
	public function showInputIcon():Void  {
		inputIconElapsed = 0;
		if (Prelude.truthy(!Prelude.truthy(inputIcon))) {
			inputIcon = SpriteTools.textPlate("[...]", DIALOG_SIZE, SUPER_MARGIN, null, null, applyFormat);
			flixel.util.FlxSpriteUtil.drawRect(inputIcon, 0, 0, inputIcon.width, inputIcon.height, flixel.util.FlxColor.TRANSPARENT, { thickness : 1, color : flixel.util.FlxColor.WHITE });
		} else null;
		inputIcon.cameras = new kiss.List([cast(movie, FlxMovie).uiCamera]);
		inputIcon.screenCenter();
		inputIcon.y = Prelude.subtract(cast(movie, FlxMovie).DIALOG_Y, inputIcon.height);
		flixel.FlxG.state.add(inputIcon);
	}
	public function hideInputIcon():Void  {
		flixel.FlxG.state.remove(inputIcon, true);
	}
	public function prepareForRecording():Void  {
		flixel.FlxG.mouse.visible = false;
	}
	public function offsetLightSource(source:FlxLightSource, offset:StagePosition):FlxLightSource  return {
		new FlxLightSource([for (point in source.points) {
			flixel.math.FlxPoint.get(Prelude.add(point.x, offset.x), Prelude.add(point.y, offset.y));
		}], source.color);
	}
	// END KISS FOSSIL CODE
}
