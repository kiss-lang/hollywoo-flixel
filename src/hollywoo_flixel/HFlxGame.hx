package hollywoo_flixel;

import kiss.Prelude;
import kiss.List;
import flixel.FlxGame;
import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxState;
import hollywoo_flixel.FlxMovie;

class HFlxGame extends FlxGame {
    public static var currentMovie:FlxMovie;

    public function new(gameWidth = 0, gameHeight = 0, ?initialState:Class<FlxState>, updateFramerate = 60, drawFramerate = 60, skipSplash = false, startFullscreen = false) {
        super(gameWidth, gameHeight, initialState, updateFramerate, drawFramerate, skipSplash, startFullscreen);
    }
    
    override function step():Void
	{
		// Handle game reset request
		if (_resetGame)
		{
			resetGame();
			_resetGame = false;
		}

		handleReplayRequests();

		#if FLX_DEBUG
		// Finally actually step through the game physics
		FlxBasic.activeCount = 0;
		#end

        // THIS PART IS CHANGED:
        if (currentMovie != null) {
            currentMovie.runWithErrorChecking(() -> {
                update();
            });
        }
        else {
            update();
        }

		#if FLX_DEBUG
		debugger.stats.activeObjects(FlxBasic.activeCount);
		#end
	}

    override function onEnterFrame(_):Void
	{
		ticks = getTicks();
		_elapsedMS = ticks - _total;
		_total = ticks;

		#if FLX_SOUND_TRAY
		if (soundTray != null && soundTray.active)
			soundTray.update(_elapsedMS);
		#end

		if (!_lostFocus || !FlxG.autoPause)
		{
			if (FlxG.vcr.paused)
			{
				if (FlxG.vcr.stepRequested)
				{
					FlxG.vcr.stepRequested = false;
				}
				else if (_state == _requestedState) // don't pause a state switch request
				{
					#if FLX_DEBUG
					debugger.update();
					// If the interactive debug is active, the screen must
					// be rendered because the user might be doing changes
					// to game objects (e.g. moving things around).
					if (debugger.interaction.isActive())
					{
                        // THIS PART IS CHANGED
                        if (currentMovie != null) {
                            currentMovie.runWithErrorChecking(() -> {
                                draw();
                            });
                        } else {
                            draw();
                        }
					}
					#end
					return;
				}
			}

			if (FlxG.fixedTimestep)
			{
				_accumulator += _elapsedMS;
				_accumulator = (_accumulator > _maxAccumulation) ? _maxAccumulation : _accumulator;

				while (_accumulator >= _stepMS)
				{
					step();
					_accumulator -= _stepMS;
				}
			}
			else
			{
				step();
			}

			#if FLX_DEBUG
			FlxBasic.visibleCount = 0;
			#end
            
            // THIS PART IS CHANGED
            if (currentMovie != null) {
                currentMovie.runWithErrorChecking(() -> {
                    draw();
                });
            } else {
                draw();
            }

			#if FLX_DEBUG
			debugger.stats.visibleObjects(FlxBasic.visibleCount);
			debugger.update();
			#end
		}
	}
}
