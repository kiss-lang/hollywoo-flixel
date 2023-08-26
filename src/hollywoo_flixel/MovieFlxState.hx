package hollywoo_flixel;

import flixel.FlxG;
import flixel.FlxState;
import kiss.Prelude;
import haxe.Constraints;

@:build(kiss.Kiss.build())
@:generic
class MovieFlxState<MovieClass:FlxMovie & Constructible<FlxDirector->Void>> extends FlxState {}
