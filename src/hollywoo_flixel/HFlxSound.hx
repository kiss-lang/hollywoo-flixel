package hollywoo_flixel;

import flixel.sound.FlxSound;

class HFlxSound extends FlxSound {
    public function new() {
        super();
    }

    // To accomodate hollywoo's sound looping, onComplete() needs to come AFTER cleanup():
    override function stopped(?_) {
		if (looped)
		{
			cleanup(false);
			play(false, loopTime, endTime);
		}
		else
			cleanup(autoDestroy);
  
		if (onComplete != null)
			onComplete();
    }
}