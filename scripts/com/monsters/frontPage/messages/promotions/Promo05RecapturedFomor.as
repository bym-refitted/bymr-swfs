package com.monsters.frontPage.messages.promotions
{
   import com.monsters.frontPage.messages.KeywordMessage;
   import com.monsters.marketing.MarketingRecapture;
   
   public class Promo05RecapturedFomor extends KeywordMessage
   {
      private static const TIME_UNTIL_RESET:uint = 7 * 24 * 60 * 60;
      
      public static const NAME:String = "recapturefomor";
      
      private var m_CanBeShown:Boolean = false;
      
      public function Promo05RecapturedFomor()
      {
         super("recapturefomor","btn_opencage","bym_pop_formor.png");
      }
      
      public function get canBeShown() : Boolean
      {
         return this.m_CanBeShown;
      }
      
      public function set canBeShown(param1:Boolean) : void
      {
         this.m_CanBeShown = param1;
      }
      
      override public function setup(param1:Object) : void
      {
         super.setup(param1);
         markAsUnseenIfOlderThan(TIME_UNTIL_RESET);
      }
      
      override public function get areRequirementsMet() : Boolean
      {
         return MarketingRecapture.instance.champPopup === MarketingRecapture.k_POPUP_FOMOR;
      }
      
      override protected function onButtonClick() : void
      {
         POPUPS.Next();
         if(GLOBAL._bCage)
         {
            CHAMPIONCAGE.Show();
         }
      }
   }
}
