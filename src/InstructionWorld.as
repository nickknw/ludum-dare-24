package {
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import flash.display.BitmapData;
	
	public class InstructionWorld extends World	{
		
		[Embed(source = 'images/OK.png')] private const OK_IMAGE:Class;
		
		public function InstructionWorld(gameMode:String) {
			var background:BitmapData = new BitmapData(Main.SCREEN_WIDTH, Main.SCREEN_HEIGHT, false, 0xFFFFFF);
			addGraphic(new Stamp(background));
			
			var okButton:Button = new Button(350, 500, 104, 52);
			okButton.setImage(OK_IMAGE);
			okButton.click = function ():void {
				FP.world = new GameWorld;
			};
			add(okButton);
		}
	}
}