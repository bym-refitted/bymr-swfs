package com.monsters.frontPage.messages.events.kingOfTheHill
{
   import com.monsters.frontPage.messages.KeywordMessage;
   
   public class KOTHRewardMessage extends KeywordMessage
   {
      public function KOTHRewardMessage()
      {
         super("event_kothwin");
      }
      
      override public function get areRequirementsMet() : Boolean
      {
         return false;
      }
   }
}

