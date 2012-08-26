package {
	import net.flashpunk.Engine;
	import flash.events.Event;
	import net.flashpunk.FP;
	
	public class Main extends Engine {
		
		public static const SCREEN_WIDTH:int = 800;
		public static const SCREEN_HEIGHT:int = 600;
		public static const FRAMERATE:int = 60;
		
		public static var paused:Boolean = true;
		public static var stepAheadOneIteration:Boolean = false;
		public static var reset:Boolean = false;
		
		public function Main():void {
			 super(SCREEN_WIDTH, SCREEN_HEIGHT, FRAMERATE, false);
			 
			 FP.world = new MainMenuWorld;
		}
	
		 override public function init():void { 
			 trace("FlashPunk has started successfully!"); 
		 }
	}
	
}