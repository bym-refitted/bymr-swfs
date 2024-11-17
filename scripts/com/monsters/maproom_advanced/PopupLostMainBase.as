package com.monsters.maproom_advanced
{
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class PopupLostMainBase extends MapRoomPopup_LostMainBase_CLIP
   {
      public function PopupLostMainBase()
      {
         super();
      }
      
      public function Setup() : *
      {
         tTitle.htmlText = KEYS.Get("empiredestroyed_title");
         bYes.SetupKey("empiredestroyed_btnflee");
         bYes.addEventListener(MouseEvent.CLICK,this.Relocate);
         bYes.buttonMode = true;
         bNo.SetupKey("empiredestroyed_btnstay");
         bNo.addEventListener(MouseEvent.CLICK,this.Hide);
         if(GLOBAL._mapOutpost.length > 0)
         {
            if(GLOBAL._mapOutpost.length > 1)
            {
               tDesc.htmlText = "<b>" + KEYS.Get("empiredestroyed3",{"v1":GLOBAL._mapOutpost.length}) + "</b>";
            }
            else
            {
               tDesc.htmlText = "<b>" + KEYS.Get("empiredestroyed2") + "</b>";
            }
            tWarning.htmlText = "<b>WARNING: By relocating to a new area you will lose all your outposts in this location and start fresh with just your new main yard.</b>";
         }
         else
         {
            tDesc.htmlText = "<b>" + KEYS.Get("empiredestroyed1") + "</b>";
            tWarning.visible = false;
         }
      }
      
      public function Relocate(param1:MouseEvent = null) : *
      {
         var RelocateSuccess:Function = null;
         var RelocateFail:Function = null;
         var e:MouseEvent = param1;
         RelocateSuccess = function(param1:Object):*
         {
            PLEASEWAIT.Hide();
            if(param1.error == 0)
            {
               GLOBAL._mapOutpost = [];
               MapRoom.ClearCells();
               if(param1.coords && param1.coords.length == 2 && param1.coords[0] > -1 && param1.coords[1] > -1)
               {
                  GLOBAL._mapHome = new Point(param1.coords[0],param1.coords[1]);
                  MapRoom.BookmarksClear();
                  MapRoom.Setup(GLOBAL._mapHome);
                  MapRoom._empiredestroyed = true;
                  MapRoom.ShowDelayed(true);
               }
            }
            else
            {
               GLOBAL.ErrorMessage("PopupLostMainBase.Relocate 1");
               LOGGER.Log("err","PopupLostMainBase.Relocate non-zero error " + param1.error);
            }
         };
         RelocateFail = function(param1:IOErrorEvent):*
         {
            PLEASEWAIT.Hide();
            GLOBAL.ErrorMessage("PopupLostMainBase.Relocate 2");
            LOGGER.Log("err","PopupLostMainBase.Relocate HTTP");
         };
         var relocateVars:Array = [["type","random"],["baseid",0],["shiny",0]];
         POPUPS.Next();
         PLEASEWAIT.Show("Relocating Main Yard");
         new URLLoaderApi().load(GLOBAL._baseURL + "migrate",relocateVars,RelocateSuccess,RelocateFail);
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         POPUPS.Next();
      }
   }
}

