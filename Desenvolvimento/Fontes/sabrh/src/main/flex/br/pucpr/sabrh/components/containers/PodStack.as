package br.pucpr.sabrh.components.containers
{
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import mx.containers.ViewStack;
	import mx.core.UIComponent;
	import mx.effects.Effect;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	
	
	[Event("showAll")]
	
	/**
	 * @private
	 * 
	 * The PodStack is a ViewStack that applies effect to selectedItem's children. 
	 * To do that it uses chindren's "showEffect" and "hideEffect" since it implements the IPod Interface
	 * 
	 * It changes it's selectedIndex only after selectedItem's children that implements the 
	 * IPod Interface finishes his hideEffect Transition 
	 * 
	 */
	public class PodStack extends ViewStack
	{
		public function PodStack()
		{
			addEventListener(IndexChangedEvent.CHANGE, changeHandler);
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler)
		}
		
		private function creationCompleteHandler(event:FlexEvent):void
		{
			showPods();
		}
		
		private var newSelectedIndex:uint;
		
		override public function set selectedIndex(value:int):void
		{
			if (newSelectedIndex != value)
			{
				newSelectedIndex = value;
				hidePods();
			}
		}
		
		private var hideCount:uint;
		
		private function hidePods():void
		{
			hideCount = 0;
			
			var hasPod:Boolean;
			
			for each (var child:UIComponent in selectedChild.getChildren())
			{
				if (child is IPod)
				{
					hasPod = true;
					hideCount++;
					child.addEventListener(EffectEvent.EFFECT_END, hidePodEffectEndHandler);
					child.visible = false;
				}
			}
			
			// if there is no podStack
			// the hideHandler will never be called
			// so we need to set the super.selectedIndex here
			if (hasPod == false)
			{
				super.selectedIndex = newSelectedIndex;
			}
		}
		
		private function hidePodEffectEndHandler(event:EffectEvent):void
		{
			hideCount--;
			event.currentTarget.removeEventListener(EffectEvent.EFFECT_END, hidePodEffectEndHandler);

			// changes the selectedIndex only after all pods has stoped his effect
			if (hideCount == 0)
			{
				super.selectedIndex = newSelectedIndex;
			}
		}
		
		private var showCount:uint;
		
		private function changeHandler(event:IndexChangedEvent):void
		{
			showPods();
		}
		
		private function showPods():void
		{
			showCount = 0;
			
			for each (var child:UIComponent in selectedChild.getChildren())
			{
				if (child is IPod)
				{
					showCount++;
					child.addEventListener(EffectEvent.EFFECT_START, showPodEffectStartHandler);
					child.addEventListener(EffectEvent.EFFECT_END, showPodEffectEndHandler);
					var e:Effect = child.getStyle("showEffect");
					e.play([child]);
				}
			}
		}
		
		private function showPodEffectStartHandler(event:EffectEvent):void
		{
			var child:UIComponent = UIComponent(event.target);
			child.removeEventListener(EffectEvent.EFFECT_START, showPodEffectStartHandler);
			
			// if I don't use this, the component will be showed before
			// the effect has started. so, it just need to wait a little
			setTimeout
			(
				function():void
				{
					var oldEffect:Effect = child.getStyle("showEffect");
					child.setStyle("showEffect", null);
					event.target.setVisible(true);
					event.target.dispatchEvent(new FlexEvent(FlexEvent.SHOW));
					child.setStyle("showEffect", oldEffect);
				}, 30
			);
			
		}
		
		private function showPodEffectEndHandler(event:EffectEvent):void
		{
			showCount--;
			
			event.currentTarget.removeEventListener(EffectEvent.EFFECT_END, showPodEffectEndHandler);
			
			if (showCount == 0)
			{
				dispatchEvent(new Event("showAll"));
			}
		}

	}
}