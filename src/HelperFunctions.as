package  
{
	public class HelperFunctions 
	{
		public static function arrayFill(length:int, value:Object):Array {
			var array:Array = new Array(length);
			
			for (var i:int = 0; i < array.length; i++) {
				array[i] = value;
			}
			
			return array;
		}
		
	}

}