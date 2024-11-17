package com.monsters.radio
{
   import flash.events.MouseEvent;
   
   public class popup_radio extends popup_radio_CLIP
   {
      public function popup_radio()
      {
         super();
         if(RADIO._twitterAccount)
         {
            gotoAndStop(2);
            tNameB.htmlText = "<b>" + RADIO._twitterAccount + "</b>";
            bAddB.Setup("Edit");
            bAddB.addEventListener(MouseEvent.CLICK,this.AccountEdit);
         }
         else
         {
            gotoAndStop(1);
            bAddA.Setup("Add");
            bAddA.addEventListener(MouseEvent.CLICK,this.AccountAdd);
            bAddA.Highlight = true;
            tNameA.htmlText = "";
            tNameA.selectable = true;
            GLOBAL._ROOT.stage.focus = tNameA;
            tNameA.setSelection(0,tNameA.text.length);
         }
         this.bFollow.Setup("Follow @BackyardMonster");
         this.bFollow.addEventListener(MouseEvent.CLICK,this.AccountFollow);
         this.bBrag.Setup("Tell Friends");
         this.bBrag.addEventListener(MouseEvent.CLICK,this.Brag);
         this.bRemove.addEventListener(MouseEvent.CLICK,this.AccountRemove);
         this.bRemove.buttonMode = true;
      }
      
      private function AccountAdd(param1:MouseEvent = null) : void
      {
         if(this.tNameA.text != "")
         {
            RADIO.SetName(this.tNameA.text);
            GLOBAL.Message("<b>Important!</b><br>Complete step 2 to receive Attack Alerts.");
            gotoAndStop(2);
            tNameB.htmlText = "<b>" + RADIO._twitterAccount + "</b>";
            bAddB.Setup("Edit");
            bAddB.addEventListener(MouseEvent.CLICK,this.AccountEdit);
            this.bFollow.Highlight = true;
            this.bBrag.Highlight = false;
         }
         else
         {
            GLOBAL.Message("Please enter a valid Twitter account.");
         }
      }
      
      private function AccountEdit(param1:MouseEvent = null) : void
      {
         gotoAndStop(1);
         tNameA.text = RADIO._twitterAccount;
         bAddA.Setup("Add");
         bAddA.addEventListener(MouseEvent.CLICK,this.AccountAdd);
         GLOBAL._ROOT.stage.focus = tNameA;
         tNameA.setSelection(0,tNameA.text.length);
         bAddA.Highlight = true;
         bFollow.Highlight = false;
         bBrag.Highlight = false;
      }
      
      private function AccountFollow(param1:MouseEvent = null) : void
      {
         RADIO.Follow();
         GLOBAL.Message("<b>Make Sure You Clicked Follow!</b><br>You must follow @BackyardMonster to receive Attack Alerts.");
         this.bFollow.Highlight = false;
         this.bBrag.Highlight = true;
      }
      
      private function Brag(param1:MouseEvent = null) : void
      {
         RADIO.Brag();
         this.bFollow.Highlight = false;
         this.bBrag.Highlight = false;
      }
      
      private function AccountRemove(param1:MouseEvent = null) : void
      {
         RADIO.RemoveName();
         GLOBAL.Message("<b>Account Removed!</b><br>You have unsubscribed from Attack Alerts.");
         this.AccountEdit();
         tNameA.htmlText = "";
         RADIO._twitterAccount = "";
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         RADIO.Hide();
      }
   }
}

