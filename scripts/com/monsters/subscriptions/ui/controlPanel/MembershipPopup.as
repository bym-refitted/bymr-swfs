package com.monsters.subscriptions.ui.controlPanel
{
   import com.monsters.subscriptions.SubscriptionHandler;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MembershipPopup extends subscriptions_membership_popup
   {
      public function MembershipPopup()
      {
         var _loc1_:Boolean = false;
         super();
         _loc1_ = this.subscriptionActive();
         tTitle.htmlText = KEYS.Get("dc_panel_benefits");
         tDescription.htmlText = KEYS.Get("dc_benefits_desc");
         if(_loc1_)
         {
            tRenew.htmlText = KEYS.Get("dc_benefits_renew",{"v1":GLOBAL.ToTime(SubscriptionHandler.instance.renewalDate)});
         }
         else
         {
            tRenew.htmlText = KEYS.Get("dc_benefits_expire",{"v1":GLOBAL.ToTime(SubscriptionHandler.instance.expirationDate)});
         }
         if(_loc1_)
         {
            bChange.buttonMode = true;
            bChange.Setup(KEYS.Get("btn_changepayment"));
            bChange.addEventListener(MouseEvent.CLICK,this.clickedChange);
         }
         else
         {
            bChange.Enabled = false;
            bChange.buttonMode = false;
            bChange.mouseEnabled = false;
            bChange.visible = false;
         }
         bCancel.buttonMode = true;
         if(_loc1_)
         {
            bCancel.Setup(KEYS.Get("btn_cancelsub"));
            bCancel.addEventListener(MouseEvent.CLICK,this.clickedCancel);
         }
         else
         {
            bCancel.Setup(KEYS.Get("btn_reactivatesub"));
            bCancel.addEventListener(MouseEvent.CLICK,this.clickedChange);
         }
         bClose.Highlight = true;
         bClose.buttonMode = true;
         bClose.Setup(KEYS.Get("btn_close"));
         bClose.addEventListener(MouseEvent.CLICK,this.Hide);
      }
      
      private function subscriptionActive() : Boolean
      {
         return SubscriptionHandler.instance.renewalDate;
      }
      
      private function clickedChange(param1:MouseEvent = null) : void
      {
         dispatchEvent(new Event(SubscriptionHandler.CHANGE));
         this.Hide(param1);
      }
      
      private function clickedCancel(param1:MouseEvent = null) : void
      {
         dispatchEvent(new Event(SubscriptionHandler.CANCEL));
         this.Hide(param1);
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         bChange.removeEventListener(MouseEvent.CLICK,this.clickedChange);
         bCancel.removeEventListener(MouseEvent.CLICK,this.clickedCancel);
         bClose.removeEventListener(MouseEvent.CLICK,this.Hide);
         dispatchEvent(new Event(Event.CLOSE));
      }
   }
}

