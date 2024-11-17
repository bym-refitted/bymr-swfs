package com.monsters.frontPage.categories
{
   public class WhatsAvailable extends Category
   {
      private static const _TIME_UNTIL_RESET:uint = 24 * 60 * 60;
      
      public function WhatsAvailable()
      {
         super();
         priority = 3;
         name = "What\'s Available";
         _doesViewRepeatedly = false;
      }
      
      override public function setup(param1:Object) : void
      {
         super.setup(param1);
         this.markOldMessagesAsUnseen();
      }
      
      private function markOldMessagesAsUnseen() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < _messages.length)
         {
            if(GLOBAL.Timestamp() - _messages[_loc1_].timeLastSeen >= _TIME_UNTIL_RESET)
            {
               _messages[_loc1_].timeLastSeen = 0;
            }
            _loc1_++;
         }
      }
   }
}

