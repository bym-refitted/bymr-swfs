package
{
   import flash.display.StageDisplayState;
   import flash.events.MouseEvent;
   
   public class CHAMPIONNAMEPOPUP extends GUARDIANNAMEPOPUP_CLIP
   {
      public function CHAMPIONNAMEPOPUP()
      {
         var _loc1_:String = null;
         super();
         tTitle.htmlText = "<b>CONGRATULATIONS!</b>";
         tDescription.htmlText = "<b>You can now start raising your Champion. What will you name him?<b>";
         if(CREATURES._guardian._type == 1)
         {
            tInput.text = "Gorgo";
            mcGuard.gotoAndStop(1);
         }
         else if(CREATURES._guardian._type == 2)
         {
            tInput.text = "Drull";
            mcGuard.gotoAndStop(7);
         }
         else
         {
            tInput.text = "Fomor";
            mcGuard.gotoAndStop(13);
         }
         bAction.SetupKey("btn_accept");
         bAction.addEventListener(MouseEvent.CLICK,this.Accept);
         bAction.Highlight = false;
         SOUNDS.Play("levelup");
         if(CREATURES._guardian)
         {
            if(!CREATURES._guardian._name)
            {
               _loc1_ = CHAMPIONCAGE._guardians["G" + CREATURES._guardian._type].name;
               CREATURES._guardian._name = _loc1_;
            }
         }
         if(GLOBAL._ROOT.stage.displayState != StageDisplayState.NORMAL)
         {
            UI2._top.mcZoom.gotoAndStop(1);
            GLOBAL._ROOT.stage.displayState = StageDisplayState.NORMAL;
         }
      }
      
      public function Accept(param1:MouseEvent) : void
      {
         if(tInput.text.length > 12)
         {
            GLOBAL.Message("The name needs to  be 12 characters or less.");
            return;
         }
         var _loc2_:String = tInput.text;
         if(_loc2_.length < 1)
         {
            _loc2_ = CHAMPIONCAGE._guardians["G" + CREATURES._guardian._type].name;
            tInput.text = _loc2_;
         }
         CREATURES._guardian._name = _loc2_;
         POPUPS.Next();
         CHAMPIONCAGE.Hide(null);
         BASE.Save();
      }
      
      public function Hide() : void
      {
         var _loc1_:String = CHAMPIONCAGE._guardians["G" + CREATURES._guardian._type].name;
         CREATURES._guardian._name = _loc1_;
         CHAMPIONCAGE.Hide();
      }
   }
}

