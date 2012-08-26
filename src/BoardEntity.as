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
		
		public static const CELL_SIZE:int = 20;
		public static const BOARD_WIDTH:int = 800; // should be multiple of cellSize
		public static const BOARD_HEIGHT:int = 560; // should be multiple of cellSize
		public static const HEIGHT_OFFSET:int = Main.SCREEN_HEIGHT - BOARD_HEIGHT;
		
		private static const BORDER_THICKNESS:int = 1;
		private static const BORDER_OF_EMPTY_CELLS:int = 2;
		private static const SIX_TIMES_A_SECOND:int = Main.FRAMERATE / 6;
		private static const ONCE_EVERY_SECOND:int = Main.FRAMERATE;
		
		private var gameLogicPeriodicUpdate:int = 0;
		private var musicLogicPeriodicUpdate:int = 0;
		private var gameMode:String;
		
		private var boardData:Array;
		private var musicPosition:int;
		
		public function BoardEntity(_gameMode:String) {
			gameMode = _gameMode;
			
			setHitbox(BOARD_WIDTH, BOARD_HEIGHT, 0, -HEIGHT_OFFSET);
			
			boardData = initializeBoardData();
			musicPosition = 0;

			var grid:BitmapData = new BitmapData(BOARD_WIDTH, BOARD_HEIGHT, true, 0x000000);
			addGraphic(new Stamp(grid, 0, HEIGHT_OFFSET));
			
			Input.define("Alternate", Key.CONTROL);
		}
		
		private function initializeBoardData():Array {
			var customLogic:Function;
			if (gameMode == GameModes.BATTLE_ROYALE) {
				customLogic = function (i:int, j:int):int {
					// should be empty more than half the time
					if (Math.random() < .5) {
						return 0;
					} else {
						return Math.floor(Math.random() * GameWorld.players.length);
					}
				};
			} else if (gameMode == GameModes.SANDBOX) {
				customLogic = function (i:int, j:int):int {
					return 0;
				}
			} else {
				throw("Unsupported gameMode");
			}
			
			return Logic.fillBoardWith(
				BOARD_WIDTH / CELL_SIZE + BORDER_OF_EMPTY_CELLS,
				BOARD_HEIGHT / CELL_SIZE + BORDER_OF_EMPTY_CELLS,
				customLogic);
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
			
			// check for reset
			if (Main.reset) {
				Main.reset = false;
				Main.paused = true;
				boardData = initializeBoardData();
			}
			
			// do grid logic
			if ((gameLogicPeriodicUpdate == 0 && !Main.paused) || Main.stepAheadOneIteration) {
				boardData = Logic.doIteration(boardData);
			}
			if (Main.stepAheadOneIteration) {
				Main.stepAheadOneIteration = false;
			}
			gameLogicPeriodicUpdate = (gameLogicPeriodicUpdate + 1) % SIX_TIMES_A_SECOND;
			
			// do music logic
			/*
			if (musicLogicPeriodicUpdate == 0) {
				Logic.playMusicUsing(boardData, musicPosition);
				musicPosition += 1;
			}
			musicLogicPeriodicUpdate = (musicLogicPeriodicUpdate + 1) % ONCE_EVERY_SECOND;
			*/
		}
		
		private static function determineArrayIndexes(mouseX:int, mouseY:int):Object {
			var xIndex:int = Math.floor(mouseX / CELL_SIZE) + 1;
			var yIndex:int = Math.floor((mouseY - HEIGHT_OFFSET) / CELL_SIZE) + 1;

			return { x: xIndex, y: yIndex };
		}
		
		override public function render():void {
			super.render();
			
			for (var i:int = 1; i < boardData.length - 1; i++) {
				for (var j:int = 1; j < boardData[i].length - 1; j++) {
					var xpos:int = (i - BORDER_THICKNESS) * CELL_SIZE + BORDER_THICKNESS,
						ypos:int = (j - BORDER_THICKNESS) * CELL_SIZE + BORDER_THICKNESS,
						cellInterior:int = CELL_SIZE - BORDER_THICKNESS,
						colour:uint = GameWorld.players[boardData[i][j]].colour;
					
					Draw.rect(xpos, ypos + HEIGHT_OFFSET, cellInterior, cellInterior, colour);
				}
			}
		}
		
	}

}