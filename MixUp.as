﻿package {		import flash.display.FrameLabel;	import flash.display.MovieClip;	import flash.events.Event;	import flash.utils.setTimeout;		/**	 * DOCUMENT CLASS FOR MIX UP GAME	 */		public class MixUp extends MovieClip {				static public const FRAME_TITLE:String = "title";		static public const FRAME_GAME:String = "game";		static public const FRAME_RESULTS:String = "results";				static public var gameHistory:Array = new Array();				protected var _imageNameList:Array = ["goldengate.jpg"];		protected var _imageList:Vector.<ISourceImage>;				public var title:Title;		public var game:Game;		public var results:Results;				//INITIALIZATION METHODS		public function MixUp() {			enumerateFrameLabels();			addEventListener(FRAME_TITLE, setupTitle, false, 0, true);			addEventListener(FRAME_GAME, setupGame, false, 0, true);			addEventListener(FRAME_RESULTS, setupResults, false, 0, true);			createImagePool();		}				protected function createImagePool():void {			_imageList = new Vector.<ISourceImage>();			for each (var imageName:String in _imageNameList)				_imageList.push(new SourceImageEmbedded(imageName));		}				private function dispatchFrameEvent():void {			dispatchEvent(new Event(currentLabel));		}				private function enumerateFrameLabels():void {			for each (var label:FrameLabel in currentLabels)				addFrameScript(label.frame-1, dispatchFrameEvent);		}				//TITLE SCREEN RELATED METHODS		protected function setupTitle(e:Event):void {			stop();			title.addEventListener(Title.PLAY_GAME, playGame, false, 0, true);			title.addEventListener(Title.SHOW_RULES, showRules, false, 0, true);		}						protected function showRules(e:Event):void {			var rules:RulesPanel = new RulesPanel();			rules.x = stage.stageWidth/2;			rules.y = stage.stageHeight/2;			addChild(rules);		}				protected function playGame(e:Event):void {			gotoAndStop(FRAME_GAME);		}						protected function mainMenu(e:Event):void {			gotoAndStop(FRAME_TITLE);		}						//GAME SCREEN RELATED METHODS		protected function setupGame(e:Event):void {			stop();			//game.init(_imageList[0], 3, 4);			game.init(new SourceImageCamera(640, 480, 24), 3, 4);			setTimeout(game.startGame, 1500);			game.addEventListener(Game.GAME_OVER, gameOver, false, 0, true);		}				protected function gameOver(e:Event):void {			var history:GameHistory = new GameHistory(true, e.target.timeElapsed, e.target.movesMade);			history.formattedTime = e.target.timeElapsedText.text;			gameHistory.unshift(history);			gotoAndStop(FRAME_RESULTS);		}				//RESULTS SCREEN RELATED METHODS		protected function setupResults(e:Event):void {			results.addEventListener(Results.PLAY_AGAIN, playGame, false, 0, true);			results.addEventListener(Results.MAIN_MENU, mainMenu, false, 0, true);		}			}	}