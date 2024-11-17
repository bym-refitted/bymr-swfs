package
{
   import flash.display.MovieClip;
   import flash.utils.*;
   import gs.TweenLite;
   import gs.easing.*;
   
   public class PLEASEWAIT extends MovieClip
   {
      public static var _mc:*;
      
      public static var _intervalA:*;
      
      public static var _intervalB:*;
      
      public static var _intervalC:*;
      
      public static var _intervalD:*;
      
      public static var _active:*;
      
      public static var _mcTips:MovieClip;
      
      public static var tipsInited:Boolean;
      
      public static var _mcCount:int = 0;
      
      public static var lastTipTime:Number = 0;
      
      public static var processDuration:int = 0;
      
      public static var processThreshold:int = 21600;
      
      public static var tipsAvailable:int = 33;
      
      public static var tipIndex:int = 0;
      
      public static var tipDelay:int = 6;
      
      public static var tips:Array = [];
      
      public static var tipsLocalKey:String = "tips_hint";
      
      public function PLEASEWAIT()
      {
         super();
      }
      
      public static function Show(param1:String = "Processing...") : *
      {
         if(!_mc)
         {
            _mc = GLOBAL._layerTop.addChild(new PLEASEWAITMC());
            _mc.tMessage.htmlText = "<b>" + param1 + "</b>";
            _mc.mcFrame.Setup(false);
            _mcTips = _mc.tips;
            _mcTips.mcFrame.Setup(false);
            HideTips();
            if(lastTipTime + tipDelay < getTimer() / 1000)
            {
               AddTips();
            }
         }
      }
      
      public static function Update(param1:String = "Processing...") : *
      {
         if(_mc)
         {
            _mc.tMessage.htmlText = "<b>" + param1 + "</b>";
            if(lastTipTime + tipDelay < getTimer() / 1000)
            {
               AddTips();
            }
         }
      }
      
      public static function Hide() : *
      {
         try
         {
            if(_mc)
            {
               GLOBAL._layerTop.removeChild(_mc);
               _mc = null;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public static function MessageChange(... rest) : *
      {
         _mc.tMessage.text = rest[0];
      }
      
      public static function AddTips() : void
      {
         if(GLOBAL._giveTips && KEYS._setup && HasTips())
         {
            if(Boolean(BASE._catchupTime) && BASE._catchupTime >= processThreshold)
            {
               if(lastTipTime + tipDelay < getTimer() / 1000)
               {
                  tipIndex = Math.round(Math.random() * (tips.length - 1));
                  ShowTips(tips[tipIndex]);
               }
            }
         }
      }
      
      public static function HasTips() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc1_:Boolean = true;
         if(tipsInited)
         {
            return true;
         }
         tips = [];
         _loc2_ = 1;
         while(_loc2_ <= tipsAvailable)
         {
            _loc3_ = "" + tipsLocalKey + _loc2_;
            _loc4_ = KEYS.Get(_loc3_);
            if(_loc4_ == "")
            {
               _loc1_ = false;
            }
            tips.push(_loc4_);
            _loc2_++;
         }
         if(_loc1_)
         {
            tipsInited = true;
         }
         return _loc1_;
      }
      
      public static function ShowTips(param1:String) : void
      {
         HideTips();
         _mcTips.tTitle.htmlText = KEYS.Get("tips_title");
         _mcTips.tDesc.htmlText = "<b>" + param1 + "</b>";
         _mcTips.x = 390;
         _mcTips.y = 260;
         _mcTips.scaleY = 0.9;
         _mcTips.scaleX = 0.9;
         TweenLite.to(_mcTips,0.2,{
            "autoAlpha":1,
            "scaleX":1,
            "scaleY":1,
            "ease":Quad.easeOut
         });
         lastTipTime = getTimer() / 1000;
      }
      
      public static function HideTips() : void
      {
         _mcTips.alpha = 0;
         _mcTips.visible = false;
      }
   }
}

