package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class BMUSHROOM extends BFOUNDATION
   {
      public var _mushroom:DisplayObject;
      
      public var _mushroomFrame:int;
      
      public function BMUSHROOM()
      {
         super();
      }
      
      override public function SetProps() : *
      {
         super.SetProps();
      }
      
      override public function PlaceB() : *
      {
         super.PlaceB();
         var _loc1_:* = _mc.addChild(new doodad_mushroom_mc());
         _loc1_.mc.gotoAndStop(this._mushroomFrame);
         _loc1_.mouseEnabled = false;
         _loc1_.mouseChildren = false;
         var _loc2_:DisplayObject = _mcBase.addChild(new doodad_mushroom_shadow());
         MovieClip(_loc2_).gotoAndStop(this._mushroomFrame);
         _loc2_.blendMode = "multiply";
         _origin = new Point(x,y);
      }
      
      override public function Setup(param1:Object) : *
      {
         this._mushroomFrame = param1.frame;
         super.Setup(param1);
         _hp.Set(_hpMax.Get());
      }
      
      override public function Export() : *
      {
         var _loc1_:Object = super.Export();
         _loc1_.frame = this._mushroomFrame;
         return _loc1_;
      }
      
      override public function Description() : *
      {
      }
      
      override public function HasWorker() : *
      {
         if(_shake > 60 && BASE._pendingPurchase.length == 0)
         {
            _mc.x = _origin.x;
            _mc.y = _origin.y;
            _mcBase.x = _origin.x;
            _mcBase.y = _origin.y;
            MUSHROOMS.Pick(this);
         }
         else if(_shake % 2 == 0)
         {
            _mc.x = _origin.x - 2 + Math.random() * 4;
            _mc.y = _origin.y - 2 + Math.random() * 4;
            _mcBase.x = _origin.x - 1 + Math.random() * 2;
            _mcBase.y = _origin.y - 1 + Math.random() * 2;
         }
         ++_shake;
      }
      
      override public function Click(param1:MouseEvent = null) : *
      {
         if(TUTORIAL._stage >= 200 && !_picking)
         {
            super.Click(param1);
         }
      }
      
      override public function Render(param1:String = "") : *
      {
      }
      
      public function SoundGood() : *
      {
      }
      
      public function SoundBad() : *
      {
      }
   }
}

