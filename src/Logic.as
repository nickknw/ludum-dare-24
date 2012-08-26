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
			var totalCellsPerPlayer:Array = getTotalCellsPerPlayer(boardData);
			return fillBoardWith(
				boardData.length, 
				boardData[0].length, 
				function (i:int, j:int):int {
					// score per enemy eliminated?
					var neighbours:Array = determineNeighbours(boardData, i, j),
						totalNeighbours:int = getTotalNeighbours(neighbours),
						strongestPlayer:Object = getLocallyStrongestPlayer(neighbours, totalCellsPerPlayer);
					
					if ((totalNeighbours >= 3 && totalNeighbours <= 5) && strongestPlayer.count > 2) {
						return strongestPlayer.player;
					} else {
						return 0;
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
		
		private static function getTotalCellsPerPlayer(boardData:Array):Array {
			var players:Array = HelperFunctions.arrayFill(GameWorld.players.length, 0);
			
			for (var i:int = 0; i < boardData.length; i++) {
				for (var j:int = 0; j < boardData[i].length; j++) {
					players[boardData[i][j]] += 1;
				}
			}
			
			return players;
		}
		
		private static function determineNeighbours(boardData:Array, i:int, j:int):Array {
			var neighbours:Array = HelperFunctions.arrayFill(GameWorld.players.length, 0);
		
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
		
		private static function getTotalNeighbours(neighbours:Array):int {
			var total:int = 0;
			
			for (var i:int = 1; i < neighbours.length; i++) {
				total += neighbours[i];
			}
			
			return total;
		}
		
		private static function getLocallyStrongestPlayer(neighbours:Array, totalCellsPerPlayer:Array):Object {
			var strongestPlayer:Object = { player:0, count:0 };
			
			for (var playerNum:int = 1; playerNum < neighbours.length; playerNum++) {
				var newCount:int = neighbours[playerNum],
					oldCount:int = strongestPlayer.count;
					
				if (newCount > oldCount) {
					strongestPlayer = { player: playerNum, count: newCount };
				} else if (newCount == oldCount) {
					// I don't like bringing whole-board state into this, but with multiple players it
					// has a definite tendency to get into a stalemate situation where nobody is making progress.
					// There needs to be a bit of slippery slope for the game to have a winner.
					// I'm addressing this by giving the stronger player a better chance to win ties.
					var newCountPercentage:Number = newCount / (newCount + oldCount),
						diffFromEven:Number = newCountPercentage - .5,
						chanceForNewCountToWin:Number = newCountPercentage + (diffFromEven * .5); // make the slope half again as slippery
					
					if (Math.random() < chanceForNewCountToWin) {
						strongestPlayer = { player: playerNum, count: newCount };
					} 
				}
			}
				
			return strongestPlayer;
		}
	}

}