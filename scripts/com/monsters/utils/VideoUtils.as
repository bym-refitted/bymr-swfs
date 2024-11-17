package com.monsters.utils
{
   import flash.events.AsyncErrorEvent;
   import flash.events.NetStatusEvent;
   import flash.events.SecurityErrorEvent;
   import flash.media.Video;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   
   public class VideoUtils
   {
      public function VideoUtils()
      {
         super();
      }
      
      public static function getVideoStream(param1:Video, param2:String = null) : NetStream
      {
         var _loc3_:NetConnection = new NetConnection();
         _loc3_.addEventListener(NetStatusEvent.NET_STATUS,netStatusHandler);
         _loc3_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
         _loc3_.connect(null);
         var _loc4_:NetStream = new NetStream(_loc3_);
         _loc4_.addEventListener(NetStatusEvent.NET_STATUS,netStatusHandler);
         _loc4_.addEventListener(AsyncErrorEvent.ASYNC_ERROR,asyncErrorHandler);
         _loc4_.client = {"onMetaData":onMetaData};
         if(param2)
         {
            _loc4_.play(param2);
         }
         param1.attachNetStream(_loc4_);
         return _loc4_;
      }
      
      private static function onMetaData(param1:*) : void
      {
      }
      
      public static function loopStream(param1:NetStream) : void
      {
         param1.addEventListener(NetStatusEvent.NET_STATUS,loopNetStream);
      }
      
      private static function netStatusHandler(param1:NetStatusEvent) : void
      {
         switch(param1.info.code)
         {
            case "NetStream.Play.StreamNotFound":
         }
      }
      
      private static function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
      }
      
      private static function asyncErrorHandler(param1:AsyncErrorEvent) : void
      {
      }
      
      private static function loopNetStream(param1:NetStatusEvent) : void
      {
         if(param1.info.code == "NetStream.Play.Stop")
         {
            NetStream(param1.target).seek(0);
         }
      }
   }
}

