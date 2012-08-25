package {
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.utils.Draw;
	
	public class BoardEntity extends Entity	{
				
		public static var boardWidth:int = 800;
		public static var boardHeight:int = 600;
		public static var cellSize:int = 20;
		public static var borderThickness:int = 1;
		public static var borderOfEmptyCells:int = 2;
		
		private var boardData:Array;
		
		public function BoardEntity() {
			
			initializeBoardData();

			var grid:BitmapData = new BitmapData(boardWidth, boardHeight, true, 0x000000);
			addGraphic(new Stamp(grid));
		}
		
		private function initializeBoardData():void {
			boardData = new Array(boardWidth / cellSize + borderOfEmptyCells);
			for (var i:int = 0; i < boardData.length; i++) {
				
				boardData[i] = new Array(boardHeight / cellSize + borderOfEmptyCells);
				for (var j:int = 0; j < boardData[i].length; j++) {
					var player:int = Math.floor(Math.random() * 4);
					boardData[i][j] = player;
				}
			}
		}
		
		override public function update():void {
			boardData = Logic.doIteration(boardData);
		}
		
		override public function render():void {
			super.render();
			
			for (var i:int = 1; i < boardData.length - 1; i++) {
				for (var j:int = 1; j < boardData[i].length - 1; j++) {
					var xpos:int = (i - borderThickness) * cellSize + borderThickness,
						ypos:int = (j - borderThickness) * cellSize + borderThickness,
						cellInterior:int = cellSize - borderThickness,
						colour:uint = GameWorld.players[boardData[i][j]].colour;
					
					Draw.rect(xpos, ypos, cellInterior, cellInterior, colour);
				}
			}
		}
		
	}

}