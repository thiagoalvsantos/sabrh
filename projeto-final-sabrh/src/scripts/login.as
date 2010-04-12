// login
import mx.effects.Blur;
import mx.events.EffectEvent;
import mx.managers.PopUpManager;


 /**
         * @private
         * Trata o CLICK da imagem fechar do HEADER
         */
        private function trateFecharClick(evt:MouseEvent):void{
            var blur:Blur = new Blur(this);
            blur.blurXFrom = 0;
            blur.blurYFrom = 0;
            blur.blurXTo = 10;
            blur.blurYTo = 10;
            blur.duration = 600;
            blur.addEventListener(EffectEvent.EFFECT_END, trateFimEfeitoFechar);
            blur.play();
        }

        
         /**
         * @private
         * Apos terminar o efeito de mafechar, é dispachado o evento do tipo FEHCAR
         * e logo em seguida a tela é removida.
         */
        private function trateFimEfeitoFechar(evt:EffectEvent):void{
            try{
                PopUpManager.removePopUp(this);               
                this.parent.removeChild(this);
            }catch(er:Error){}
           
        }
