package
{
   import com.monsters.maproom_advanced.MapRoom;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public dynamic class popup_attackend extends popup_attackend_CLIP
   {
      private var _success:Boolean;
      
      public function popup_attackend(param1:Boolean)
      {
         super();
         this._success = param1;
         if(param1)
         {
            this.tTitle.htmlText = KEYS.Get("newmap_destroyed");
            if(GLOBAL._advancedMap)
            {
               if(GLOBAL._mode == "wmattack")
               {
                  this.tMessage.htmlText = KEYS.Get("newmap_des_wm1");
               }
               else
               {
                  this.tMessage.htmlText = KEYS.Get("newmap_des_pl1");
               }
            }
            else if(GLOBAL._mode == "wmattack")
            {
               this.tMessage.htmlText = KEYS.Get("newmap_des_wm2");
            }
            else
            {
               this.tMessage.htmlText = KEYS.Get("newmap_des_pl2");
            }
         }
         else
         {
            this.tTitle.htmlText = "Attack Ended";
            if(GLOBAL._advancedMap)
            {
               if(GLOBAL._mode == "wmattack")
               {
                  this.tMessage.htmlText = "You failed to destroy this Wild Monster yard, rebuild your monsters and try again.";
               }
               else if(BASE._isOutpost)
               {
                  this.tMessage.htmlText = "You failed to destroy this outpost, rebuild your monsters and try again.";
               }
               else
               {
                  this.tMessage.htmlText = "";
               }
            }
            else if(GLOBAL._mode == "wmattack")
            {
               this.tMessage.htmlText = "You failed to destroy the Town Hall of this Wild Monster yard, rebuild your monsters and try again.";
            }
            else
            {
               this.tMessage.htmlText = "";
            }
         }
         this.tProcessing.htmlText = "Please Wait...";
         this.bAction.Enabled = false;
         if(!GLOBAL._advancedMap)
         {
            this.bAction.Setup("Return Home");
         }
         else
         {
            this.bAction.Setup("Open Map");
         }
         this.addEventListener(Event.ENTER_FRAME,this.Tick);
      }
      
      private function Tick(param1:Event) : *
      {
         if(BASE._saveCounterA == BASE._saveCounterB)
         {
            this.bAction.Enabled = true;
            this.tProcessing.htmlText = "";
            this.bAction.addEventListener(MouseEvent.CLICK,this.End);
            this.removeEventListener(Event.ENTER_FRAME,this.Tick);
         }
      }
      
      private function End(param1:MouseEvent) : *
      {
         if(GLOBAL._advancedMap)
         {
            MapRoom._showEnemyWait = true;
            if(this._success && Boolean(GLOBAL._currentCell))
            {
               GLOBAL._currentCell._destroyed = 1;
            }
            MapRoom.Show();
         }
         else
         {
            BASE.LoadBase(null,null,0,"build");
         }
         POPUPS.Next();
      }
   }
}

