package
{
   import flash.display.StageDisplayState;
   import flash.events.*;
   import gs.*;
   import gs.easing.*;
   
   public class ERRORMESSAGE extends ERRORMESSAGE_CLIP
   {
      public var _mc:*;
      
      public function ERRORMESSAGE()
      {
         super();
      }
      
      public function Show(param1:String, param2:int = 0) : *
      {
         var Resume:Function;
         var _message:String = param1;
         var errortype:int = param2;
         if(GLOBAL._ROOT.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            GLOBAL._ROOT.stage.displayState = StageDisplayState.NORMAL;
         }
         if(errortype != GLOBAL.ERROR_OOPS_ONLY)
         {
            this._mc = GLOBAL._layerTop.addChild(this);
            tMessage.autoSize = "left";
            if(_message)
            {
               tMessage.htmlText = _message;
            }
            else
            {
               tMessage.htmlText = "No message???";
            }
            bg.height = tMessage.height + 20;
            LOGGER.Log("err","HALT: " + _message);
         }
         if(errortype != GLOBAL.ERROR_ORANGE_BOX_ONLY)
         {
            Resume = function(param1:MouseEvent = null):*
            {
               GLOBAL.CallJS("reloadPage");
            };
            try
            {
               throw new Error(_message);
            }
            catch(e:Error)
            {
               LOGGER.Log("err","HALT " + _message + " | " + e.getStackTrace());
            }
            this._mc = GLOBAL._ROOT.addChild(new popup_error());
            (this._mc.mcFrame as frame2).Setup(false);
            if(KEYS._setup)
            {
               this._mc.tA.htmlText = "<b>" + KEYS.Get("pop_oops_title") + "</b>";
               this._mc.tB.htmlText = KEYS.Get("pop_oops_body");
            }
            this._mc.bAction.Setup("Reload");
            this._mc.bAction.addEventListener(MouseEvent.CLICK,Resume);
         }
         this._mc.x -= 50;
         TweenLite.to(this._mc,0.5,{
            "x":this._mc.x + 50,
            "ease":Elastic.easeOut
         });
         GLOBAL._halt = true;
      }
   }
}

