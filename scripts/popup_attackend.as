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
         if(this._success)
         {
            this.tTitle.htmlText = KEYS.Get("newmap_destroyed");
            if(GLOBAL._advancedMap)
            {
               if(GLOBAL._mode == "wmattack")
               {
                  this.tMessage.htmlText = KEYS.Get("newmap_des_wm2");
               }
               else
               {
                  this.tMessage.htmlText = KEYS.Get("newmap_des_pl1");
               }
            }
            else if(GLOBAL._mode == "wmattack")
            {
               if(BASE.isInferno())
               {
                  if(MAPROOM_DESCENT.InDescent)
                  {
                     this.tMessage.htmlText = KEYS.Get("descent_newmap_des_wm2");
                  }
                  else
                  {
                     this.tMessage.htmlText = KEYS.Get("inf_newmap_des_wm2");
                  }
               }
               else
               {
                  this.tMessage.htmlText = KEYS.Get("newmap_des_wm2");
               }
            }
            else
            {
               this.tMessage.htmlText = KEYS.Get("newmap_des_pl2");
            }
         }
         else
         {
            this.tTitle.htmlText = KEYS.Get("popup_attackended_title");
            if(GLOBAL._advancedMap)
            {
               if(GLOBAL._mode == "wmattack")
               {
                  this.tMessage.htmlText = KEYS.Get("popup_attackended_failedWMYard");
               }
               else if(BASE._yardType == BASE.OUTPOST)
               {
                  this.tMessage.htmlText = KEYS.Get("popup_attackended_failedOutpost");
               }
               else
               {
                  this.tMessage.htmlText = "";
               }
            }
            else if(GLOBAL._mode == "wmattack")
            {
               if(BASE.isInferno())
               {
                  if(MAPROOM_DESCENT.InDescent)
                  {
                     this.tMessage.htmlText = KEYS.Get("descent_popup_attackended_failedWMTH");
                  }
                  else
                  {
                     this.tMessage.htmlText = KEYS.Get("inf_popup_attackended_failedWMTH");
                  }
               }
               else
               {
                  this.tMessage.htmlText = KEYS.Get("popup_attackended_failedWMTH");
               }
            }
            else
            {
               this.tMessage.htmlText = "";
            }
         }
         this.tProcessing.htmlText = KEYS.Get("please_wait");
         this.bAction.Enabled = false;
         if(!GLOBAL._advancedMap || BASE.isInferno())
         {
            this.bAction.Setup(KEYS.Get("btn_returnhome"));
         }
         else
         {
            this.bAction.Setup(KEYS.Get("btn_openmap"));
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
            if(this._success && GLOBAL._currentCell)
            {
               GLOBAL._currentCell._destroyed = 1;
            }
            MapRoom.Show();
         }
         else if(GLOBAL._loadmode == GLOBAL._mode)
         {
            BASE.LoadBase(null,null,0,"build",false,BASE.MAIN_YARD);
         }
         else if(MAPROOM_DESCENT._inDescent)
         {
            MAPROOM_DESCENT.ExitDescent();
            BASE.LoadBase(null,null,0,"build",false,BASE.MAIN_YARD);
         }
         else
         {
            BASE.LoadBase(GLOBAL._infBaseURL,0,0,"ibuild",false,BASE.INFERNO_YARD);
         }
         POPUPS.Next();
      }
   }
}

