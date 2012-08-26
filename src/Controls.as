package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	
	public class Controls extends Entity
	{
		[Embed(source = 'images/play.png')] private const playImage:Class;
		[Embed(source = 'images/pause.png')] private const pauseImage:Class;
		[Embed(source = 'images/step.png')] private const stepImage:Class;
		[Embed(source = 'images/stepDisabled.png')] private const stepDisabledImage:Class;
		
		private var background:Entity;
		private var playPauseButton:Button;
		private var stepButton:Button;
		private var resetButton:Button;
		private var menuButton:Button;
		
		public function Controls() 
		{
			var backgroundImage:BitmapData = new BitmapData(BoardEntity.BOARD_WIDTH, BoardEntity.HEIGHT_OFFSET, false, 0xFFFFFF);
			background = new Entity(0, 0, new Stamp(backgroundImage));
			
			playPauseButton = new Button(0, 0, 40, 40);
			playPauseButton.setImage(playImage);
			playPauseButton.click = function ():void {
				Main.paused = !Main.paused;
				
				if (Main.paused) {
					playPauseButton.setImage(playImage);
					stepButton.setImage(stepImage);
				} else {
					playPauseButton.setImage(pauseImage);
					stepButton.setImage(stepDisabledImage);
				}
			};	
			
			stepButton = new Button(40, 0, 40, 40);
			stepButton.setImage(stepImage);
			stepButton.click = function ():void {
				Main.stepAheadOneIteration = true;
			}
			
			resetButton = new Button(350, 0, 100, 40);
			var resetText:Text = new Text("Reset");
			resetText.color = 0x000000;
			resetText.font = "Fixedsys Excelsior";
			resetText.size = 36;
			resetButton.graphic = resetText;
			resetButton.click = function ():void {
				Main.reset = true;
			};
			
			menuButton = new Button(700, 0, 100, 40);
			var menuText:Text = new Text("Menu");
			menuText.color = 0x000000;
			menuText.font = "Fixedsys Excelsior";
			menuText.size = 36;
			menuButton.graphic = menuText;
			menuButton.click = function ():void {
				FP.world = new MainMenuWorld;
			}
		}
		
		public function list():Array {
			return [background, playPauseButton, stepButton, resetButton, menuButton];
		}
		
	}

}