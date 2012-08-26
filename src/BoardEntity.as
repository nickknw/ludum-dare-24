package {
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
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
			setHitbox(boardWidth, boardHeight, 0, -heightOffset);
			
			boardData = initializeBoardData();

			var grid:BitmapData = new BitmapData(boardWidth, boardHeight, true, 0x000000);
			addGraphic(new Stamp(grid, 0, heightOffset));
			
			Input.define("Alternate", Key.CONTROL);
		}
		
		private function initializeBoardData():Array {
			return Logic.fillBoardWith(
				boardWidth / cellSize + borderOfEmptyCells,
				boardHeight / cellSize + borderOfEmptyCells,
				function (i:int, j:int):int {
					//return 0;
					return Math.floor(Math.random() * GameWorld.players.length);
				});
		}
		
		override public function update():void {
			// look for clicks
			if (collidePoint(x, y, world.mouseX, world.mouseY) && Input.mouseDown) {
				var point:Object = determineArrayIndexes(world.mouseX, world.mouseY);
				if (Input.check("Alternate")) {
					boardData[point.x][point.y] = 2;
				} else {
					boardData[point.x][point.y] = 1;
				}
			}
			
			// do grid logic
			if ((periodicUpdate == 0 && !Main.paused) || Main.stepAheadOneIteration) {
				boardData = Logic.doIteration(boardData);
			}
			if (Main.stepAheadOneIteration) {
				Main.stepAheadOneIteration = false;
			}
			periodicUpdate = (periodicUpdate + 1) % sixTimesASecond;
		}
		
		private static function determineArrayIndexes(mouseX:int, mouseY:int):Object {
			var xIndex:int = Math.floor(mouseX / cellSize) + 1;
			var yIndex:int = Math.floor((mouseY - heightOffset) / cellSize) + 1;

			return { x: xIndex, y: yIndex };
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