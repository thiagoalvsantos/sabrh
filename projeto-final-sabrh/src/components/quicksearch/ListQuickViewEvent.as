package components.quicksearch
{
	import flash.events.Event;

	public class ListQuickViewEvent extends Event
	{

		public static const QUICK_VIEW_CLICK:String = "quickViewClick";
		
		public var item:Object;
		
		public function ListQuickViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}