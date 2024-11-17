package
{
   import flash.events.MouseEvent;
   
   public class CHAMPIONSELECTPOPUP extends GUARDIANSELECTPOPUP_CLIP
   {
      private var _guardCage:CHAMPIONCAGE;
      
      public function CHAMPIONSELECTPOPUP()
      {
         super();
         this._guardCage = GLOBAL._bCage as CHAMPIONCAGE;
         tTitle.htmlText = KEYS.Get("popup_championselecttitle");
         tGuard1_label.htmlText = "<b>" + KEYS.Get("mon_gorgotitle") + "<b>";
         tGuard1_desc.htmlText = "<b>" + KEYS.Get("mon_gorgodesc") + "<b>";
         tGuard2_label.htmlText = "<b>" + KEYS.Get("mon_fomortitle") + "<b>";
         tGuard2_desc.htmlText = "<b>" + KEYS.Get("mon_fomordesc") + "<b>";
         tGuard3_label.htmlText = "<b>" + KEYS.Get("mon_drulltitle") + "<b>";
         tGuard3_desc.htmlText = "<b>" + KEYS.Get("mon_drulldesc") + "<b>";
         bAction1.Setup("Raise Gorgo",false,0,0);
         bAction1.addEventListener(MouseEvent.CLICK,this.RaiseGuard1);
         bAction2.Setup("Raise Fomor",false,0,0);
         bAction2.addEventListener(MouseEvent.CLICK,this.RaiseGuard2);
         bAction3.Setup("Raise Drull",false,0,0);
         bAction3.addEventListener(MouseEvent.CLICK,this.RaiseGuard3);
      }
      
      private function RaiseGuard1(param1:MouseEvent) : void
      {
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            if(CHAMPIONCHAMBER.HasFrozen(1))
            {
               GLOBAL.Message(KEYS.Get("championchamber_alreadyfrozen",{"v1":"Gorgo"}));
               return;
            }
            this._guardCage.SpawnGuardian(1,0,0,1,CHAMPIONCAGE.GetGuardianProperty("G1",1,"health"));
            LOGGER.Stat([52,"G1",1]);
            BASE.Save();
            this.Hide();
         }
      }
      
      private function RaiseGuard2(param1:MouseEvent) : void
      {
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            if(CHAMPIONCHAMBER.HasFrozen(3))
            {
               GLOBAL.Message(KEYS.Get("championchamber_alreadyfrozen",{"v1":"Fomor"}));
               return;
            }
            this._guardCage.SpawnGuardian(1,0,0,3,CHAMPIONCAGE.GetGuardianProperty("G3",1,"health"));
            LOGGER.Stat([52,"G3",3]);
            BASE.Save();
            this.Hide();
         }
      }
      
      private function RaiseGuard3(param1:MouseEvent) : void
      {
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            if(CHAMPIONCHAMBER.HasFrozen(2))
            {
               GLOBAL.Message(KEYS.Get("championchamber_alreadyfrozen",{"v1":"Drull"}));
               return;
            }
            this._guardCage.SpawnGuardian(1,0,0,2,CHAMPIONCAGE.GetGuardianProperty("G2",1,"health"));
            LOGGER.Stat([52,"G2",2]);
            BASE.Save();
            this.Hide();
         }
      }
      
      public function FinishGuard() : void
      {
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         CHAMPIONCAGE.Hide(param1);
      }
      
      public function Center() : void
      {
         POPUPSETTINGS.AlignToCenter(this);
      }
      
      public function ScaleUp() : void
      {
         POPUPSETTINGS.ScaleUp(this);
      }
   }
}

