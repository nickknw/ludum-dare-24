package {
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.utils.Draw;
	
	public class BoardEntity extends Entity	{
		
		public static var cellSize:int = 20;
		public static var boardWidth:int = 800; // should be multiple of cellSize
		public static var boardHeight:int = 560; // should be multiple of cellSize
		public static var heightOffset:int = Main.screenHeight - boardHeight;
		
		private static var borderThickness:int = 1;
		private static var borderOfEmptyCells:int = 2;
		
		private var periodicUpdate:int = 0;
		private var sixTimesASecond:int = Main.framerate / 6;
		
		private var boardData:Array;
		
		public function BoardEntity() {
			setHitbox(boardWidth, boardHeight, 0, heightOffset);
			
			// score per enemy eliminated?
			initializeBoardData();

			var grid:BitmapData = new BitmapData(boardWidth, boardHeight, true, 0x000000);
			addGraphic(new Stamp(grid, 0, heightOffset));
		}
		
		private function initializeBoardData():void {
			boardData = new Array(boardWidth / cellSize + borderOfEmptyCells);
			for (var i:int = 0; i < boardData.length; i++) {
				
				boardData[i] = new Array(boardHeight / cellSize + borderOfEmptyCells);
				for (var j:int = 0; j < boardData[i].length; j++) {
					if (i == 0 || j == 0 || i == boardData.length - 1 || j == boardData[i].length - 1) {
						boardData[i][j] = 0;
					} else {
						var player:int = Math.floor(Math.random() * GameWorld.players.length);
						boardData[i][j] = player;
					}
				}
			}
		}
		
		override public function update():void {
			if ((periodicUpdate == 0 && !Main.paused) || Main.stepAheadOneIteration) {
				boardData = Logic.doIteration(boardData);
			}
			if (Main.stepAheadOneIteration) {
				Main.stepAheadOneIteration = false;
			}
			periodicUpdate = (periodicUpdate + 1) % sixTimesASecond;
		}
		
		override public function render():void {
			super.render();
			
			for (var i:int = 1; i < boardData.length - 1; i++) {
				for (var j:int = 1; j < boardData[i].length - 1; j++) {
					var xpos:int = (i - borderThickness) * cellSize + borderThickness,
						ypos:int = (j - borderThickness) * cellSize + borderThickness,
						cellInterior:int = cellSize - borderThickness,
						colour:uint = GameWorld.players[boardData[i][j]].colour;
					
					Draw.rect(xpos, ypos + heightOffset, cellInterior, cellInterior, colour);
				}
			}
		}
		
	}

}