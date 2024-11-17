package
{
   import com.monsters.display.ImageCache;
   import com.monsters.effects.ResourceBombs;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import gs.TweenLite;
   import gs.easing.Bounce;
   
   public class CATAPULTPOPUP extends CATAPULTPOPUP_view
   {
      private var _t:Timer;
      
      private var _open:Boolean;
      
      private var _items:Array;
      
      private var _currentImage:String;
      
      private var _bm:Bitmap;
      
      private var _canClose:Boolean;
      
      public function CATAPULTPOPUP()
      {
         super();
      }
      
      public static function Format(param1:Number, param2:Boolean = false) : String
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1 > 1000000)
         {
            _loc3_ = "" + param1 / 1000000;
            _loc4_ = param2 ? " " + KEYS.Get("bomb_million_long") : KEYS.Get("bomb_million_short");
            _loc3_ += _loc4_;
         }
         else
         {
            _loc3_ = GLOBAL.FormatNumber(param1);
         }
         return _loc3_;
      }
      
      public function Setup() : void
      {
         var _loc3_:String = null;
         var _loc4_:CATAPULTITEM = null;
         _bOpen.addEventListener(MouseEvent.MOUSE_DOWN,this.Show);
         _image.addEventListener(MouseEvent.MOUSE_DOWN,this.Show);
         _image.buttonMode = true;
         _image.mouseChildren = false;
         _bFire.SetupKey("bomb_fire_btn");
         _bFire.addEventListener(MouseEvent.MOUSE_DOWN,this.Fire);
         this._items = [];
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for(_loc3_ in ResourceBombs._bombs)
         {
            _loc2_ = int(ResourceBombs._bombs[_loc3_].col);
            _loc1_ = int(ResourceBombs._bombs[_loc3_].group);
            _loc4_ = new CATAPULTITEM();
            _loc4_.x = _mc[_loc3_].x;
            _loc4_.y = _mc[_loc3_].y;
            _mc.removeChild(_mc[_loc3_]);
            _loc4_.Setup(_loc3_);
            _loc4_.addEventListener(MouseEvent.MOUSE_OVER,this.overBomb(_loc4_));
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.hideBomb(_loc4_));
            _loc4_.addEventListener(MouseEvent.MOUSE_DOWN,this.downBomb(_loc4_));
            _mc.addChild(_loc4_);
            this._items.push(_loc4_);
         }
         this._t = new Timer(100);
         this._t.addEventListener(TimerEvent.TIMER,this.testMouseOff);
         ResourceBombs._mc = this;
         this.Update();
         this.Hide();
      }
      
      private function downBomb(param1:CATAPULTITEM) : Function
      {
         var b:CATAPULTITEM = param1;
         return function(param1:MouseEvent):void
         {
            if(b.Enabled)
            {
               Hide();
               ResourceBombs._bombid = b._bombid;
               Update();
            }
         };
      }
      
      private function hideBomb(param1:CATAPULTITEM) : Function
      {
         var b:CATAPULTITEM = param1;
         return function(param1:MouseEvent):void
         {
            b.Hide();
         };
      }
      
      private function overBomb(param1:CATAPULTITEM) : Function
      {
         var b:CATAPULTITEM = param1;
         return function(param1:MouseEvent):*
         {
            b.ShowOver();
            b.parent.setChildIndex(b,b.parent.numChildren - 1);
         };
      }
      
      private function testMouseOff(param1:TimerEvent) : void
      {
         if(this._open)
         {
            if(this._canClose && (_mc.mouseX < _mc._bg.x || _mc.mouseX > _mc._bg.width + _mc._bg.x || _mc.mouseY < _mc._bg.y || _mc.mouseY > _mc._bg.height + _mc._bg.y))
            {
               this.Hide();
            }
            else if(_mc.mouseX > _mc._bg.x && _mc.mouseX < _mc._bg.width + _mc._bg.x && _mc.mouseY > _mc._bg.y && _mc.mouseY < _mc._bg.height + _mc._bg.y)
            {
               this._canClose = true;
            }
         }
      }
      
      public function Update() : void
      {
         var _loc4_:CATAPULTITEM = null;
         var _loc1_:Object = {
            "tw":KEYS.Get("bomb_tw_name"),
            "pb":KEYS.Get("bomb_pb_name"),
            "pu":KEYS.Get("bomb_pu_name")
         };
         var _loc2_:Object = ResourceBombs._bombs[ResourceBombs._bombid];
         var _loc3_:String = _loc1_[ResourceBombs._bombid.substr(0,2)];
         _tType.htmlText = "<b>" + _loc2_.name + " " + _loc3_ + "</b>";
         if(!_loc2_.used)
         {
            _tCost.htmlText = "<b>" + Format(_loc2_.cost,true) + " " + KEYS.Get(GLOBAL._resourceNames[_loc2_.resource - 1]) + "</b>";
         }
         else
         {
            _tCost.htmlText = "";
         }
         if(_loc2_.image != this._currentImage)
         {
            ImageCache.GetImageWithCallBack(_loc2_.image,this.onImageLoaded);
         }
         for each(_loc4_ in this._items)
         {
            _loc4_.Update();
         }
         if(ResourceBombs._state == 0)
         {
            _bFire.SetupKey("bomb_fire_btn");
            if(Boolean(_loc2_.used) || _loc2_.cost > GLOBAL._attackersResources["r" + _loc2_.resource].Get())
            {
               _bFire.Enabled = false;
               _bFire.Highlight = false;
               _image.alpha = 0.5;
               _bOpen.Highlight = true;
            }
            else
            {
               _bFire.Highlight = true;
               _bFire.Enabled = true;
               _image.alpha = 1;
               _bOpen.Highlight = false;
            }
            TweenLite.to(_bar,0.6,{"y":23});
         }
         else if(ResourceBombs._state == 1)
         {
            _bFire.SetupKey("btn_cancel");
            _bFire.Enabled = true;
            _bFire.Highlight = false;
            _bOpen.Highlight = false;
            TweenLite.to(_bar,0.6,{
               "y":48,
               "ease":Bounce.easeOut
            });
            if(_loc2_.resource == 3)
            {
               _bar._tA.text = KEYS.Get("bomb_target_monsters");
            }
            else
            {
               _bar._tA.text = KEYS.Get("bomb_target_buildings");
            }
         }
      }
      
      private function onImageLoaded(param1:String, param2:BitmapData) : void
      {
         if(this._bm)
         {
            if(this._bm.parent)
            {
               this._bm.parent.removeChild(this._bm);
            }
            this._bm = null;
         }
         this._bm = new Bitmap(param2);
         this._bm.height = 60;
         this._bm.width = 60;
         _image.addChild(this._bm);
         this._currentImage = param1;
      }
      
      public function fired() : void
      {
         _bFire.SetupKey("bomb_fire_btn");
         _bFire.Enabled = false;
      }
      
      public function Show(param1:MouseEvent = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         for(_loc2_ in ATTACK._flingerBucket)
         {
            if(ATTACK._flingerBucket[_loc2_].Get() > 0)
            {
               if(GLOBAL._advancedMap)
               {
                  GLOBAL._attackerMapCreatures[_loc2_].Add(ATTACK._flingerBucket[_loc2_].Get());
               }
               else
               {
                  GLOBAL._attackerCreatures[_loc2_].Add(ATTACK._flingerBucket[_loc2_].Get());
               }
               ATTACK._flingerBucket[_loc2_].Set(0);
            }
         }
         for each(_loc3_ in UI2._top._creatureButtons)
         {
            _loc3_.Update();
         }
         ATTACK.RemoveDropZone();
         ResourceBombs.BombRemove();
         addChild(_mc);
         this._t.start();
         this._open = true;
         this._canClose = false;
      }
      
      public function Fire(param1:MouseEvent = null) : void
      {
         if(ResourceBombs._state == 0)
         {
            if(ResourceBombs._bombid && !ResourceBombs._bombs[ResourceBombs._bombid].used && GLOBAL._attackersResources["r" + ResourceBombs._bombs[ResourceBombs._bombid].resource].Get() >= ResourceBombs._bombs[ResourceBombs._bombid].cost)
            {
               ResourceBombs.BombAdd(ResourceBombs._bombs[ResourceBombs._bombid]);
            }
         }
         else
         {
            ResourceBombs.BombRemove();
         }
      }
      
      public function Hide() : void
      {
         if(_mc.parent)
         {
            _mc.parent.removeChild(_mc);
         }
         this._t.stop();
         this._open = false;
         this.Update();
      }
      
      public function CanUse() : Boolean
      {
         return true;
      }
   }
}

