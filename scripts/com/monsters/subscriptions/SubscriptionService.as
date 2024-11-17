package com.monsters.subscriptions
{
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   
   public class SubscriptionService extends EventDispatcher
   {
      public function SubscriptionService()
      {
         super();
      }
      
      private function callJS(param1:String, param2:Function = null, param3:Number = 2) : void
      {
         GLOBAL.CallJS(param1,[param3]);
         if(Boolean(param2) && ExternalInterface.available)
         {
            ExternalInterface.addCallback(param1,param2);
         }
      }
      
      public function getSubscriptionData(param1:Number) : void
      {
         this.callJS("cc.getSubscriptionData",this.recievedSubscriptionData,param1);
      }
      
      private function recievedSubscriptionData() : void
      {
      }
      
      public function startSubscription() : void
      {
         this.callJS("cc.showSubscriptionDialog",this.startSubscriptionCallback);
      }
      
      public function reactivateSubscription(param1:Number) : void
      {
         this.callJS("cc.reactivateSubscriptionDialog",this.startSubscriptionCallback,param1);
      }
      
      private function startSubscriptionCallback() : void
      {
         LOGGER.StatB({
            "st1":"Subscriptions",
            "st2":"start",
            "st3":"more infos",
            "value":5
         },"start_subscription");
      }
      
      public function changeSubscription(param1:Number) : void
      {
         this.callJS("cc.changeSubscriptionPayDate",this.changeSubscriptionCallback,param1);
      }
      
      private function changeSubscriptionCallback() : void
      {
         LOGGER.StatB({
            "st1":"Subscriptions",
            "st2":"start",
            "st3":"more infos",
            "value":5
         },"change_subscription_date");
      }
      
      public function cancelSubscription(param1:Number) : void
      {
         this.callJS("cc.cancelSubscriptionDialog",this.cancelSubscriptionCallback,param1);
      }
      
      private function cancelSubscriptionCallback() : void
      {
         LOGGER.StatB({
            "st1":"Subscriptions",
            "st2":"start",
            "st3":"more infos",
            "value":5
         },"cancel_subscription");
      }
   }
}

