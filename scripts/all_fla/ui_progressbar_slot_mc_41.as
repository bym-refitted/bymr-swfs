package all_fla
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1419")]
   public dynamic class ui_progressbar_slot_mc_41 extends MovieClip
   {
      public var mcHit:MovieClip;
      
      public var tProgress:TextField;
      
      public var mcMask:MovieClip;
      
      public var mcBG:MovieClip;
      
      public var mcInstant:MovieClip;
      
      public var tDesc:TextField;
      
      public var mcAlert:button_alert2;
      
      public var tDescBG:MovieClip;
      
      public var mcWorker:icon_worker2;
      
      public var mcImage:MovieClip;
      
      public var mcBGMask:MovieClip;
      
      public var mcProgress:MovieClip;
      
      public var __setTabDict:Dictionary = new Dictionary(true);
      
      public var __lastFrameTab:int = -1;
      
      public function ui_progressbar_slot_mc_41()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3);
         addEventListener(Event.FRAME_CONSTRUCTED,this.__setTab_handler,false,0,true);
      }
      
      internal function __setTab_tProgress_ui_progressbar_slot_mc_pBarTxt_0(param1:int) : *
      {
         if(this.tProgress != null && param1 >= 1 && param1 <= 2 && (this.__setTabDict[this.tProgress] == undefined || !(int(this.__setTabDict[this.tProgress]) >= 1 && int(this.__setTabDict[this.tProgress]) <= 2)))
         {
            this.__setTabDict[this.tProgress] = param1;
            this.tProgress.tabIndex = 0;
         }
      }
      
      internal function __setTab_tDesc_ui_progressbar_slot_mc_tDesc_0(param1:int) : *
      {
         if(this.tDesc != null && param1 >= 1 && param1 <= 2 && (this.__setTabDict[this.tDesc] == undefined || !(int(this.__setTabDict[this.tDesc]) >= 1 && int(this.__setTabDict[this.tDesc]) <= 2)))
         {
            this.__setTabDict[this.tDesc] = param1;
            this.tDesc.tabIndex = 0;
         }
      }
      
      internal function __setTab_tDesc_ui_progressbar_slot_mc_tDesc_2() : *
      {
         if(this.__setTabDict[this.tDesc] == undefined || int(this.__setTabDict[this.tDesc]) != 3)
         {
            this.__setTabDict[this.tDesc] = 3;
            this.tDesc.tabIndex = 0;
         }
      }
      
      internal function __setTab_handler(param1:Object) : *
      {
         var _loc2_:int = currentFrame;
         if(this.__lastFrameTab == _loc2_)
         {
            return;
         }
         this.__lastFrameTab = _loc2_;
         this.__setTab_tProgress_ui_progressbar_slot_mc_pBarTxt_0(_loc2_);
         this.__setTab_tDesc_ui_progressbar_slot_mc_tDesc_0(_loc2_);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         this.__setTab_tDesc_ui_progressbar_slot_mc_tDesc_2();
      }
   }
}

