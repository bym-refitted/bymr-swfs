package
{
   import com.adobe.serialization.json.JSON;
   import flash.events.*;
   import flash.net.*;
   
   public class BUY
   {
      public function BUY()
      {
         super();
      }
      
      public static function Show(param1:MouseEvent = null) : *
      {
         LOGGER.Stat([22]);
         GLOBAL.CallJS("cc.showTopup",[{
            "type":"fbc",
            "callback":"fbcAdd"
         }]);
      }
      
      public static function Offers(param1:String) : *
      {
         switch(param1)
         {
            case "daily":
               GLOBAL.CallJS("cc.showTopup",[{
                  "type":"daily",
                  "callback":"fbcOfferDaily"
               }]);
               break;
            case "earn":
               GLOBAL.CallJS("cc.showTopup",[{
                  "type":"offers",
                  "callback":"fbcOfferEarn"
               }]);
         }
      }
      
      public static function FBCAdd(param1:String) : void
      {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1);
         if(!_loc2_.status)
         {
            LOGGER.Log("err","FBCAdd " + param1);
         }
      }
      
      public static function FBCOfferEarn(param1:String) : void
      {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1);
         if(_loc2_.status)
         {
            if(_loc2_.status != "settled")
            {
               if(_loc2_.status != "failed")
               {
                  if(_loc2_.status == "canceled")
                  {
                  }
               }
            }
         }
         else
         {
            LOGGER.Log("err","FBCDailyEarn " + param1);
         }
      }
      
      public static function FBCOfferDaily(param1:String) : void
      {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1);
         if(_loc2_.status)
         {
            if(_loc2_.status != "settled")
            {
               if(_loc2_.status != "failed")
               {
                  if(_loc2_.status == "canceled")
                  {
                  }
               }
            }
         }
         else
         {
            LOGGER.Log("err","FBCDailyEarn " + param1);
         }
      }
      
      public static function MidGameOffers(param1:String) : void
      {
         switch(param1)
         {
            case "text":
               GLOBAL.CallJS("cc.showTopup",[{
                  "type":"fbc",
                  "callback":"fbcAdd"
               }]);
               break;
            case "gift":
               GLOBAL.CallJS("cc.showTopup",[{
                  "special":"gift",
                  "callback":"fbcAdd"
               }]);
               break;
            case "shinydiscount":
               GLOBAL.CallJS("cc.showTopup",[{
                  "special":"discount",
                  "callback":"fbcAdd"
               }]);
               break;
            case "shinybonus":
               GLOBAL.CallJS("cc.showTopup",[{
                  "special":"bonus",
                  "callback":"fbcAdd"
               }]);
         }
      }
      
      public static function purchaseReceive(param1:String) : void
      {
         POPUPS.Next();
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1);
         if(_loc2_.error == 0)
         {
            if(LOGIN.checkHash(param1))
            {
               BUY.purchaseProcess(_loc2_.items);
               BUY.purchaseComplete(param1);
               BASE._pendingPromo = 1;
               BASE.Save();
            }
            else
            {
               LOGGER.Log("err","BUY.purchaseReceive " + param1);
            }
         }
      }
      
      public static function purchaseComplete(param1:String) : void
      {
         if(param1 == "biggulp")
         {
            SALESPECIALSPOPUP.Show("biggulp");
         }
         else
         {
            SALESPECIALSPOPUP.EndSale();
            SALESPECIALSPOPUP.Show("giftconfirm");
         }
         BASE.Save();
      }
      
      public static function startPromo(param1:String) : void
      {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1);
         if(_loc2_.endtime)
         {
            SALESPECIALSPOPUP.StartSale(_loc2_.endtime);
         }
         else
         {
            LOGGER.Log("err","startPromo " + _loc2_.endtime);
         }
      }
      
      public static function purchaseProcess(param1:Array) : void
      {
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_][0];
            _loc4_ = Number(param1[_loc2_][1]);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(_loc3_ == "BIGGULP")
               {
                  BASE.BuildingStorageAdd(2 * 60);
               }
               else
               {
                  STORE.AddInventory(_loc3_);
               }
               _loc5_++;
            }
            _loc2_++;
         }
      }
      
      public static function logPromoShown(param1:String = null) : void
      {
         LOGGER.Log("pro","POPUPS.CallbackShiny " + param1);
      }
      
      public static function logFB711PromoShown(param1:String = null) : void
      {
         LOGGER.Log("pro7-11","POPUPS.CallbackShiny " + param1);
         LOGGER.Stat([74,"popupshow"]);
      }
      
      public static function logFB711NoticeShown(param1:String = null) : void
      {
         LOGGER.Stat([77,"noticeshow"]);
      }
   }
}

