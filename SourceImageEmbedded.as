package {
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
		
	public class SourceImageEmbedded implements ISourceImage {
		
		private var _imageClass:Class;
		private var _sourceBitmap:BitmapData;
		private var _pieceList:Vector.<BitmapData>;
		
		public function SourceImageEmbedded(linkageName:String) {
			_imageClass = getDefinitionByName(linkageName) as Class;
		}
		
		public function getImages(rows:int, columns:int, width:int = 0, height:int = 0):Vector.<BitmapData> {
			if (_pieceList) return _pieceList;
			_sourceBitmap = new _imageClass(width, height);
			var pieceBitmap:BitmapData;
			var pieceWidth:int = Math.floor(_sourceBitmap.width / columns);
			var pieceHeight:int = Math.floor(_sourceBitmap.height / rows);
			_pieceList = new Vector.<BitmapData>();
			for (var j:int = 0; j < rows; j++) {
				for (var i:int = 0; i < columns; i++) {
					pieceBitmap = new BitmapData(pieceWidth, pieceHeight);
					var rect:Rectangle = new Rectangle(i * pieceWidth, j * pieceHeight, pieceWidth, pieceHeight);
					pieceBitmap.copyPixels(_sourceBitmap, rect, new Point());
					_pieceList.push(pieceBitmap);
				}
			}
			return _pieceList;
		}
		
		public function cleanUp():void {
			for each (var bmd:BitmapData in _pieceList) {
				bmd.dispose();
			}
			_pieceList = null;
		}
		
		public function destroy():void {
			cleanUp();
			_sourceBitmap.dispose();
			_imageClass = null;
		}
		
	}
	
}