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
			for (var i:int = 1; i < boardData.length - 1; i++) {
				for (var j:int = 1; j < boardData[i].length - 1; j++) {
					var neighbours:Array = determineNeighbours(boardData, i, j);
					var strongestPlayer:Object = getLocallyStrongestPlayer(neighbours);
					
					if (strongestPlayer.count < 2 || strongestPlayer.count > 3) {
						boardData[i][j] = 0;
					} else {
						boardData[i][j] = strongestPlayer.player;
					}
				}
			}
			
			return boardData;
		}
		
		private static function determineNeighbours(boardData:Array, i:int, j:int):Array {
			var neighbours:Array = new Array(GameWorld.players.length);
			for (var index:int = 0; index < neighbours.length; index++) {
				neighbours[index] = 0;
			}
		
			neighbours[boardData[i - 1][j - 1]] += 1;
			neighbours[boardData[i - 1][j]] += 1;
			neighbours[boardData[i - 1][j + 1]] += 1;

			neighbours[boardData[i][j - 1]] += 1;
			// omit current cell
			neighbours[boardData[i][j + 1]] += 1;

			neighbours[boardData[i + 1][j - 1]] += 1;
			neighbours[boardData[i + 1][j]] += 1;
			neighbours[boardData[i + 1][j + 1]] += 1;
			
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