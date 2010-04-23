////////////////////////////////////////
//
//	Index.as
//
////////////////////////////////////////
import mx.controls.Alert;
import mx.events.ModuleEvent;




//--------------------------------------
//
//	Variaveis
//
//--------------------------------------
[Bindable]
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
	hora=hf.format(new Date());
}

/**
 *
 */
public function init():void
{
	this.timer=new Timer(1000 * 1);
	timer.addEventListener("timer", incrementa);
	timer.start();
	carregarModulo("modulos/login.swf", "Login");
}

/**
 *
 */
public function carregarModulo(modulo:String, titulo:String):void
{

	if (moduloAtual != modulo)
	{
		moduloAtual=modulo;
		moduleHandler(modulo);
	}
}


///////////////////////////////////////////



import mx.effects.Move;
import mx.effects.Fade;
import mx.effects.easing.Cubic;
import flash.display.DisplayObject;
import mx.modules.ModuleManager;

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



private function moduleHandler(moduleUrl:String):void
{
	if (mloader.url != "" || mloader.url != null)
	{
		mloader.unloadModule();
	}
	mloader.url=moduleUrl;
	mloader.addEventListener(ModuleEvent.READY, readyHandler);
	mloader.addEventListener(ModuleEvent.ERROR, errorHandler);
	mloader.loadModule();
}

private function readyHandler(event:ModuleEvent):void
{
//	displayObject=moduleInfo.factory.create() as DisplayObject;
//
//	mloader.addChild(displayObject);
//
//	FadeEffect(displayObject, 1000, 0, 0, 1);
//
//	currentState="";
}

private function errorHandler(event:ModuleEvent):void
{
	Alert.show("ERROR Loading Module: " + mloader.url, "ERROR");

}




