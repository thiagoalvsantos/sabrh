////////////////////////////////////////
//
//	Index.as
//
////////////////////////////////////////
import mx.containers.Canvas;
import mx.events.ModuleEvent;
import mx.effects.Move;
import mx.effects.Fade;
import mx.effects.easing.Cubic;
import flash.display.DisplayObject;
import mx.modules.ModuleManager;

//--------------------------------------
//
//	Variaveis
//
//--------------------------------------
[Bindable]
/**
 *
 * @default
 */
public var hora:String;
private var timer:Timer=null;
private var moduloAtual:String;

//--------------------------------------
//
//	Funções
//
//--------------------------------------


/**
 *
 * @param event
 */
public function incrementa(event:TimerEvent):void
{
	//hora=hf.format(new Date());
}

/**
 *
 */
public function init():void
{
	this.timer=new Timer(1000 * 1);
	timer.addEventListener("timer", incrementa);
	timer.start();
	//menu.enabled=false;
}





///////////////////////////////////////////





/**
 *
 * @param target
 * @param duration
 * @param delay
 * @param xStart
 * @param xEnd
 * @param yStart
 * @param yEnd
 */
public function MoveEffect(target:Object, duration:Number, delay:Number, xStart:Number, xEnd:Number, yStart:Number, yEnd:Number):void
{
	var moveEffect:Move=new Move();
	moveEffect.end();
	moveEffect.target=target;
	moveEffect.duration=duration;
	moveEffect.startDelay=delay;
	moveEffect.easingFunction=Cubic.easeInOut;
	moveEffect.xFrom=xStart;
	moveEffect.xTo=xEnd;
	moveEffect.yFrom=yStart;
	moveEffect.yTo=yEnd;
	moveEffect.play();
}

/**
 *
 * @param target
 * @param duration
 * @param delay
 * @param alphaFrom
 * @param alphaTo
 */
public function FadeEffect(target:Object, duration:Number, delay:Number, alphaFrom:Number, alphaTo:Number):void
{
	var fadeEffect:Fade=new Fade();
	fadeEffect.end();
	fadeEffect.target=target;
	fadeEffect.duration=duration;
	fadeEffect.startDelay=delay;
	fadeEffect.easingFunction=Cubic.easeInOut;
	fadeEffect.alphaFrom=alphaFrom;
	fadeEffect.alphaTo=alphaTo;
	fadeEffect.play();
}

//////////////////////////////////////////////////////






