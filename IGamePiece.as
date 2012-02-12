package {
	
	import flash.display.BitmapData;
	import flash.events.IEventDispatcher;
	
	public interface IGamePiece extends IEventDispatcher {
		
		//DisplayObject Properties
		function get x():Number;
		function set x(value:Number):void;
		function get y():Number;
		function set y(value:Number):void;
		function get width():Number;
		function set width(value:Number):void;
		function get height():Number;
		function set height(value:Number):void;
		
		//GamePiece-specific Methods
		function select():void;
		function deselect():void;
		function activate():void;
		function deactivate():void;
		function movePiece(x:Number, y:Number):void;
		function lock():void;
		
		//GamePiece-specific Accessors
		function get image():BitmapData;
		function set image(value:BitmapData):void;
		function get index():int;
		function set index(value:int):void;
		function get currentIndex():int;
		function set currentIndex(value:int):void;
		
	}
	
}