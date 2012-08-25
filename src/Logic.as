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
					var winningPlayer:Object = {player:0, count:0};
					
					for (var playerNum:int = 1; playerNum < neighbours.length; playerNum++) {
						if (neighbours[playerNum] > winningPlayer.count) {
							winningPlayer = { player: playerNum, count: neighbours[playerNum] };
						}
					}
					if (winningPlayer.count < 2 || winningPlayer.count > 3) {
						boardData[i][j] = 0;
					} else {
						boardData[i][j] = winningPlayer.player;
					}
				}
			}
			
			return boardData;
		}
		
		private static function determineNeighbours(boardData:Array, i:int, j:int):Array {
			var neighbours:Array = new Array(GameWorld.players.length);
				for (var i:int = 0; i < neighbours.length; i++) {
					neighbours[i] = 0;
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
		
	}

}