package com.monsters.inferno
{
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   
   public class InfernoPopupMoveYard extends PopupMoveYard_CLIP
   {
      internal var _cell:InfernoMapCell;
      
      public function InfernoPopupMoveYard()
      {
         super();
         this.bMoveRes.SetupKey("btn_movewithresources");
         this.bMoveRes.addEventListener(MouseEvent.CLICK,this.MoveYardResources);
         this.bMoveRes.buttonMode = true;
         this.bMoveShiny.Setup("btn_movewithshiny");
         this.bMoveShiny.addEventListener(MouseEvent.CLICK,this.MoveYardShiny);
         this.bMoveRes.buttonMode = true;
      }
      
      public function Setup(param1:InfernoMapCell) : *
      {
         this._cell = param1;
         tTitle.htmlText = "<b>" + KEYS.Get("popup_title_moveyard") + "</b>";
         tDesc.htmlText = KEYS.Get("popup_desc_moveyard");
      }
      
      public function MoveYardResources(param1:MouseEvent) : *
      {
         var loadVars:Object;
         var url:String;
         var handleMoveYardSuccessful:Function = null;
         var handleMoveYardError:Function = null;
         var e:MouseEvent = param1;
         handleMoveYardSuccessful = function(param1:Object):*
         {
            PLEASEWAIT.Hide();
            if(param1.error != 0)
            {
               LOGGER.Log("err","PopupMoveYard.MoveYardResources",param1.error);
            }
         };
         handleMoveYardError = function(param1:IOErrorEvent):*
         {
            PLEASEWAIT.Hide();
            LOGGER.Log("err","PopupMoveYard.MoveYardResources HTTP");
         };
         if(GLOBAL._resources.r1.Get() >= 500 * 60 * 1000 && GLOBAL._resources.r2.Get() >= 500 * 60 * 1000 && GLOBAL._resources.r3.Get() >= 500 * 60 * 1000 && GLOBAL._resources.r4.Get() >= 500 * 60 * 1000)
         {
         }
         this.Hide();
      }
      
      public function MoveYardShiny(param1:MouseEvent) : *
      {
         var loadVars:Object;
         var url:String;
         var handleMoveYardSuccessful:Function = null;
         var handleMoveYardError:Function = null;
         var e:MouseEvent = param1;
         handleMoveYardSuccessful = function(param1:Object):*
         {
            PLEASEWAIT.Hide();
            if(param1.error != 0)
            {
               LOGGER.Log("err","PopupInfoMine.MoveYard",param1.error);
            }
         };
         handleMoveYardError = function(param1:IOErrorEvent):*
         {
            PLEASEWAIT.Hide();
            LOGGER.Log("err","PopupMoveYard.MoveYardShiny HTTP");
         };
         this.Hide();
      }
      
      public function Hide() : *
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

