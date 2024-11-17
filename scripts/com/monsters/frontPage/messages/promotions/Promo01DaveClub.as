package com.monsters.frontPage.messages.promotions
{
   import com.monsters.frontPage.messages.KeywordMessage;
   import com.monsters.subscriptions.SubscriptionHandler;
   
   public class Promo01DaveClub extends KeywordMessage
   {
      public function Promo01DaveClub()
      {
         super("promodaveclub","btn_tellmore");
      }
      
      override public function get areRequirementsMet() : Boolean
      {
         return !SubscriptionHandler.instance.isSubscriptionActive;
      }
      
      override protected function onButtonClick() : void
      {
         POPUPS.Next();
         SubscriptionHandler.instance.showPromoPopup();
      }
   }
}

