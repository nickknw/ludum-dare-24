package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	public class Button extends Entity
	{
		public var click:Function;
		public var enabled:Boolean = true;

		private var hover:Boolean = false;
		
		public function Button(x:int, y:int, width:int, height:int) 
		{
			super(x, y);			
			setHitbox(width, height);
			click = function ():void { };
		}
		
		public function setImage(image:Class):void {
			graphic = new Image(image);
		}
		
		override public function update():void {
			if (collidePoint(x, y, world.mouseX, world.mouseY)) {
				if (enabled) {
					Mouse.cursor = MouseCursor.BUTTON;
					hover = true;
				}
				
				if (Input.mouseReleased) {
					Mouse.cursor = MouseCursor.ARROW;
					hover = false;
					click();
				} 
			} else {
				if (hover == true) {
					Mouse.cursor = MouseCursor.ARROW;
					hover = false;
				}
			}
		}
	}
}