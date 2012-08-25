package {
	import net.flashpunk.Engine;
	import flash.events.Event;
	import net.flashpunk.FP;
	
	public class Main extends Engine {
		
		public static var screenWidth:int = 800;
		public static var screenHeight:int = 600;
		public static var framerate:int = 60;
		
		public function Main():void {
			 super(screenWidth, screenHeight, framerate, false);
			 
			 FP.world = new GameWorld;
		}
	
		 override public function init():void { 
			 trace("FlashPunk has started successfully!"); 
		 }
	}
	
}