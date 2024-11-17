package com.monsters.frontPage.messages.events.kingOfTheHill
{
   public class KOTHStartMessage extends KOTHPromoMessage
   {
      public function KOTHStartMessage()
      {
         super("event_kothstart");
         if(GLOBAL._advancedMap)
         {
            _action = this.openMapRoom;
            _buttonCopy = "btn_rsvp";
         }
      }
      
      private function openMapRoom() : void
      {
         MAPROOM.Show();
      }
   }
}

