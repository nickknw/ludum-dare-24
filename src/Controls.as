package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	
	public class Controls extends Entity
	{
		[Embed(source = 'images/play.png')] private const playImage:Class;
		[Embed(source = 'images/pause.png')] private const pauseImage:Class;
		[Embed(source = 'images/step.png')] private const stepImage:Class;
		[Embed(source = 'images/stepDisabled.png')] private const stepDisabledImage:Class;
		
		private var background:Entity;
		private var playPauseButton:Button;
		private var stepButton:Button;
		
		public function Controls() 
		{
			var backgroundImage:BitmapData = new BitmapData(BoardEntity.boardWidth, BoardEntity.heightOffset, false, 0xFFFFFF);
			background = new Entity(0, 0, new Stamp(backgroundImage));
			
			playPauseButton = new Button(0, 0, 40, 40);
			playPauseButton.setImage(pauseImage);
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
			stepButton.setImage(stepDisabledImage);
			stepButton.click = function ():void {
				Main.stepAheadOneIteration = true;
			}
			
		}
		
		public function list():Array {
			return [background, playPauseButton, stepButton];
		}
		
	}

}