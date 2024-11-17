package
{
   import flash.events.MouseEvent;
   
   public class GUARDIANSELECTPOPUP extends GUARDIANSELECTPOPUP_CLIP
   {
      private var _guardCage:GUARDIANCAGE;
      
      public function GUARDIANSELECTPOPUP()
      {
         super();
         this._guardCage = GLOBAL._bCage as GUARDIANCAGE;
         tTitle.htmlText = "SELECT YOUR CHAMPION";
         tGuard1_label.htmlText = "<b>GORGO<br>High Defense<b>";
         tGuard1_desc.htmlText = "<b>" + KEYS.Get("mon_gorgodesc") + "<b>";
         tGuard2_label.htmlText = "<b>FOMOR<br>Powers up other Monsters<b>";
         tGuard2_desc.htmlText = "<b>" + KEYS.Get("mon_fomordesc") + "<b>";
         tGuard3_label.htmlText = "<b>DRULL<br>High Attack<b>";
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
            this._guardCage.SpawnGuardian(1,0,0,1,GUARDIANCAGE.GetGuardianProperty("G1",1,"health"));
            LOGGER.Stat([52,"G1",1]);
            BASE.Save();
            this.Hide();
         }
      }
      
      private function RaiseGuard2(param1:MouseEvent) : void
      {
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            this._guardCage.SpawnGuardian(1,0,0,3,GUARDIANCAGE.GetGuardianProperty("G3",1,"health"));
            LOGGER.Stat([52,"G2",2]);
            BASE.Save();
            this.Hide();
         }
      }
      
      private function RaiseGuard3(param1:MouseEvent) : void
      {
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            this._guardCage.SpawnGuardian(1,0,0,2,GUARDIANCAGE.GetGuardianProperty("G2",1,"health"));
            LOGGER.Stat([52,"G3",3]);
            BASE.Save();
            this.Hide();
         }
      }
      
      public function FinishGuard() : void
      {
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         GUARDIANCAGE.Hide(param1);
      }
      
      public function Resize() : void
      {
         this.x = GLOBAL._SCREENCENTER.x;
         this.y = GLOBAL._SCREENCENTER.y;
      }
   }
}

