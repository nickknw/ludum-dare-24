package  
{
	public class Logic 
	{

		/**
		 * Implements rules similar to Conway's Game Of Life and applies them to the
		 * passed-in grid of data.
		 * 
		 * @param	data 	a two dimensional array holding board data
		 * @return a two dimensional array holding the modified board data
		 */
		public static function doIteration(boardData:Array):Array {	
			return fillBoardWith(
				boardData.length, 
				boardData[0].length, 
				function (i:int, j:int):int {
					// score per enemy eliminated?
					var neighbours:Array = determineNeighbours(boardData, i, j);
					var strongestPlayer:Object = getLocallyStrongestPlayer(neighbours);
					
					if (strongestPlayer.count < 2 || strongestPlayer.count > 3) {
						return 0;
					} else {
						return strongestPlayer.player;
					}
				});
		}
		
		public static function fillBoardWith(numCellsWide:int, numCellsTall:int, customLogic:Function):Array {
			var boardData:Array = new Array(numCellsWide);
			for (var i:int = 0; i < boardData.length; i++) {
				
				boardData[i] = new Array(numCellsTall);
				for (var j:int = 0; j < boardData[i].length; j++) {
					// always fill outside edge with blanks to make logic simpler
					if (i == 0 || j == 0 || i == boardData.length - 1 || j == boardData[i].length - 1) {
						boardData[i][j] = 0;
					} else {
						boardData[i][j] = customLogic(i, j);
					}
				}
			}
			
			return boardData;
		}
		
		private static function determineNeighbours(boardData:Array, i:int, j:int):Array {
			var neighbours:Array = HelperFunctions.arrayFill(GameWorld.players.length, 0);
		
			//neighbours[boardData[i - 1][j - 1]] += 1;
			neighbours[boardData[i - 1][j]] += 1;
			//neighbours[boardData[i - 1][j + 1]] += 1;

			neighbours[boardData[i][j - 1]] += 1;
			// omit current cell
			neighbours[boardData[i][j + 1]] += 1;

			//neighbours[boardData[i + 1][j - 1]] += 1;
			neighbours[boardData[i + 1][j]] += 1;
			//neighbours[boardData[i + 1][j + 1]] += 1;
			
			return neighbours;
		}
		
		private static function getLocallyStrongestPlayer(neighbours:Array):Object {
			var strongestPlayer:Object = { player:0, count:0 };
			
			for (var playerNum:int = 1; playerNum < neighbours.length; playerNum++) {
				if (neighbours[playerNum] > strongestPlayer.count) {
					strongestPlayer = { player: playerNum, count: neighbours[playerNum] };
				} else if (neighbours[playerNum] == strongestPlayer.count) {
					strongestPlayer = { player: 0, count: neighbours[playerNum] };
				}
			}
				
			return strongestPlayer;
		}
	}

}