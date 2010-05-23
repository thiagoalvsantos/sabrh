package components.quicksearch
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;

	[Event("search")]
	[Event("clear")]
	
	public class QuickSearchTextInput extends TextInput
	{
		
		[Embed('assets/clear-search-icon.png')]
		private var clearSearchCls:Class;
		private var clearSearchAsset:UIComponent;

		[Embed('assets/search-icon.png')]
		private var searchCls:Class;
		private var searchAsset:UIComponent;

		public function QuickSearchTextInput()
		{
			super();
			addEventListener(Event.CHANGE, changeHandler);
			addEventListener(FlexEvent.ENTER, enterHandler);
			addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
		}
		
		private function enterHandler(event:FlexEvent):void
		{
			if (text != prompt)
			{
				dispatchEvent(new Event("search"));
			}
		}
		
		override protected function focusOutHandler(event:FocusEvent):void
		{
			super.focusOutHandler(event);
			if (text != prompt)
			{
				dispatchEvent(new Event("search"));
			}
			if (text == "")
			{
				clear();
			}
		}
		
		override protected function focusInHandler(event:FocusEvent):void
		{
			super.focusInHandler(event);
			if (text == prompt)
			{
				selectionBeginIndex = 0;
				selectionEndIndex = text.length;
			}
		}
		
		private function changeHandler(event:Event):void
		{
			clearSearchAsset.visible = text != prompt;
		}
		
		private var textChanged:Boolean;
		
		override public function set text(value:String):void
		{
			super.text = value;
			textChanged = true;
			invalidateProperties();
		}
		
		override protected function commitProperties():void
		{
			if (textChanged)
			{
				textChanged = false;
				if (text == "")
				{
					super.text = prompt;
				}
			}
			super.commitProperties();
		}
		
		private var _prompt:String = "";
		
		public function set prompt(value:String):void
		{
			_prompt = value;
			text = "";
		}
		
		public function get prompt():String
		{
			return _prompt;			
		}

		private var _displaySearchIcon:Boolean = true;
		
		public function set displaySearchIcon(value:Boolean):void
		{
			_displaySearchIcon = value;
		}
		
		public function get displaySearchIcon():Boolean
		{
			return _displaySearchIcon;			
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			if (searchAsset == null)
			{
				searchAsset =  new UIComponent();
				searchAsset.addChild(new searchCls())
				searchAsset.addEventListener(MouseEvent.CLICK, searchClickHandler);
				addChild(searchAsset);
			}
			if (clearSearchAsset == null)
			{
				clearSearchAsset =  new UIComponent();
				clearSearchAsset.addChild(new clearSearchCls())
				addChild(clearSearchAsset);
				clearSearchAsset.visible = false;
				clearSearchAsset.addEventListener(MouseEvent.CLICK, clearSearchClickHandler);
				addChild(clearSearchAsset);
			}
		}
		
		private function searchClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event("search"));
		}
		
		private function clearSearchClickHandler(event:MouseEvent):void
		{
			clear();
		}
		
		private function clear():void
		{
			text = prompt;
			selectionBeginIndex = 0;
			selectionEndIndex = text.length;
			clearSearchAsset.visible = false;
			dispatchEvent(new Event("clear"));
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if (displaySearchIcon)
			{
				searchAsset.visible = true;
				searchAsset.move(2, 2);
				textField.x = 20;
				textField.setActualSize(unscaledWidth-40, unscaledHeight);
			}
			else
			{
				searchAsset.visible = false;
				textField.x = 0;
				textField.setActualSize(unscaledWidth-20, unscaledHeight);
			}
			clearSearchAsset.move(unscaledWidth-2-16, 3);
		}		
		
		
	}
}