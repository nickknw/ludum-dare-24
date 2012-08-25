package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	public class Button extends Entity
	{
		public var click:Function;
		
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
				if(Input.mouseReleased) {
					click();
				}
			}
		}
	}

}