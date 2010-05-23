package components.quicksearch
{
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import mx.controls.listClasses.ListBase;
	import mx.core.Application;
	import mx.core.Container;
	import mx.core.IMXMLObject;
	import mx.effects.Move;
	import mx.effects.Parallel;
	import mx.effects.Resize;
	import mx.events.EffectEvent;
	import mx.managers.PopUpManager;

	public class QuickView implements IMXMLObject
	{
	
		private static var activeQuickView:QuickView;
		
		private var document:Object;
		
		private var popUpView:Container;
		
		private var hasPopUp:Boolean;
		
		private var initialSize:Object;
		
		private var item:Object;
		
		public function initialized(document:Object, id:String):void
		{
			this.document = document;
		}


		private var _view:Class;
		
		[Bindable]
		
		public function get view():Class
		{
			return _view;
		}
		
		public function set view(value:Class):void
		{
			_view = value;
		}

		private var _source:ListBase;
		
		[Bindable]
		
		public function get source():ListBase
		{
			return _source;
		}  
		
		public function set source(value:ListBase):void
		{
			_source = value;
		}
		
		public function display(item:Object):void
		{
			this.item = item;

			if (hasPopUp == false)
			{
				showPopUp();
			}
			
			displayData();
		}
		
		private function showPopUp():void
		{
			if (popUpView != null)
			{
				PopUpManager.addPopUp(popUpView, DisplayObject(document));
			}
			else
			{
				popUpView = Container(PopUpManager.createPopUp(DisplayObject(document), view));
				popUpView.addEventListener(KeyboardEvent.KEY_DOWN, popUpViewKeyDownHandler);
			}
			
			popUpView.setFocus();
			
			saveInitialSize();
		
			var point:Point = source.localToGlobal(new Point(source.x, source.y));
			var move:Move = new Move();
			move.xFrom = point.x;
			
			move.yFrom = point.y + ((source.dataProvider.getItemIndex(item)-source.verticalScrollPosition) * source.rowHeight);
			move.yTo = point.y + (source.height/2) - (initialSize.height/2); 
			move.xTo = point.x + (source.width/2) - (initialSize.width/2);
			
			var resize:Resize = new Resize();
			resize.widthTo = initialSize.width;
			resize.heightTo = initialSize.height;
			popUpView.width = source.width;
			popUpView.height = source.rowHeight;
			
			var parallel:Parallel = new Parallel();
			parallel.addChild(resize);
			parallel.addChild(move);

			parallel.duration = 300;

			parallel.play([popUpView]);
			
			hasPopUp = true;
			QuickView.activeQuickView = this;
		}
		
		private function displayData():void
		{
			if (popUpView is IQuickView)
			{
				IQuickView(popUpView).data = item;
				IQuickView(popUpView).displayData();
			}
			else
			{
				throw new Error("The " + view + " must implement IDTODisplayerView");
			}
		}
		
		
		public static function hide():void
		{
			var quickView:QuickView = QuickView.activeQuickView;
			
			if (quickView.hasPopUp == true)
			{
				quickView.hidePopUp();
			}
		}
		
		private function hidePopUp():void
		{
			var point:Point = source.localToGlobal(new Point(source.x, source.y));
			var move:Move = new Move();
			move.yTo = point.y + ((source.dataProvider.getItemIndex(item)-source.verticalScrollPosition) * source.rowHeight); 
			move.xTo = point.x;
			
			var resize:Resize = new Resize();
			resize.widthTo = source.width;
			resize.heightTo = source.rowHeight;
			
			var parallel:Parallel = new Parallel();
			parallel.addChild(resize);
			parallel.addChild(move);
			parallel.addEventListener(EffectEvent.EFFECT_END, hidePopUpEffectEndHandler);

			parallel.duration = 300;
			parallel.play([popUpView]);
			
			hasPopUp = false;
		} 
		
		private function hidePopUpEffectEndHandler(event:EffectEvent):void
		{
			event.currentTarget.removeEventListener(EffectEvent.EFFECT_END, hidePopUpEffectEndHandler);
			restoreInitialSize();
			PopUpManager.removePopUp(popUpView);
		}
		
		private function saveInitialSize():void
		{
			initialSize = new Object();
			initialSize.width = popUpView.width;
			initialSize.height = popUpView.height;
		}

		private function restoreInitialSize():void
		{
			popUpView.width = initialSize.width 
			popUpView.height = initialSize.height;
		}
		
		private function popUpViewKeyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.ESCAPE)
			{
				hide();
			}
		}
		
	}
}