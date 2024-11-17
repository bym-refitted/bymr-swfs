package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class CREATUREBUTTON extends CREATUREBUTTON_CLIP
   {
      public var _creatureID:String;
      
      public var _creatureData:Object;
      
      public var _tick:int;
      
      public var _description:bubblepopup3;
      
      public function CREATUREBUTTON(param1:String)
      {
         super();
         this._creatureID = param1;
         this._creatureData = CREATURELOCKER._creatures[this._creatureID];
         ImageCache.GetImageWithCallBack("monsters/" + this._creatureID + "-small.png",this.IconLoaded,true,1);
         txtName.htmlText = "<b>" + KEYS.Get(CREATURELOCKER._creatures[this._creatureID].name) + "</b>";
         this._description = new bubblepopup3();
         this._description.Setup(118,26,KEYS.Get(CREATURELOCKER._creatures[this._creatureID].description),5);
         addChild(this._description);
         this._description.visible = false;
         bMore.Setup("+");
         bMore.addEventListener(MouseEvent.MOUSE_DOWN,this.More);
         bMore.addEventListener(MouseEvent.MOUSE_UP,this.Clear);
         bMore.addEventListener(MouseEvent.ROLL_OVER,this.Over);
         bLess.Setup("-");
         bLess.addEventListener(MouseEvent.MOUSE_DOWN,this.Less);
         bLess.addEventListener(MouseEvent.MOUSE_UP,this.Clear);
         bLess.addEventListener(MouseEvent.ROLL_OVER,this.Over);
         addEventListener(MouseEvent.ROLL_OVER,this.Over);
         addEventListener(MouseEvent.ROLL_OUT,this.Out);
         if(Boolean(GLOBAL._attackerCreatureUpgrades[param1]) && Boolean(GLOBAL._attackerCreatureUpgrades[param1].level))
         {
            mcMonsterLevel.tLevel.htmlText = "<b>" + GLOBAL._attackerCreatureUpgrades[param1].level + "</b>";
         }
         else
         {
            mcMonsterLevel.tLevel.htmlText = "<b>1</b>";
         }
         this._tick = 0;
         this.Update();
      }
      
      public function IconLoaded(param1:String, param2:BitmapData) : *
      {
         mcImage.addChild(new Bitmap(param2));
      }
      
      public function Update() : *
      {
         var _loc1_:int = 0;
         if(GLOBAL._advancedMap)
         {
            _loc1_ = int(GLOBAL._attackerMapCreatures[this._creatureID].Get());
         }
         else
         {
            _loc1_ = int(GLOBAL._attackerCreatures[this._creatureID].Get());
         }
         var _loc2_:* = "<b>";
         if(ATTACK._flingerBucket[this._creatureID])
         {
            _loc2_ = "<font color=\"#FF0000\">" + ATTACK._flingerBucket[this._creatureID].Get() + "</font> / ";
         }
         _loc2_ += _loc1_ + "</b>";
         tNumber.htmlText = _loc2_;
         if(_loc1_ > 0)
         {
            bMore.enabled = true;
         }
         if(_loc1_ <= 0)
         {
            bMore.enabled = false;
         }
      }
      
      public function Over(param1:MouseEvent) : *
      {
         this._description.visible = true;
      }
      
      public function Out(param1:MouseEvent) : *
      {
         this._description.visible = false;
      }
      
      public function Clear(param1:MouseEvent = null) : *
      {
         removeEventListener(Event.ENTER_FRAME,this.MoreTick);
         removeEventListener(Event.ENTER_FRAME,this.LessTick);
      }
      
      public function More(param1:MouseEvent) : *
      {
         UI2._top.BombDeselect();
         this.MoreTickB();
         this._tick = 0;
         addEventListener(Event.ENTER_FRAME,this.MoreTick);
      }
      
      public function MoreTick(param1:Event = null) : *
      {
         if(this._tick > 10 && this._tick % 2 == 0)
         {
            this.MoreTickB();
         }
         this.MovedOut();
         ++this._tick;
      }
      
      public function MoreTickB() : *
      {
         ATTACK.BucketAdd(this._creatureID);
         this.Update();
         ATTACK.BucketUpdate();
      }
      
      public function Less(param1:MouseEvent) : *
      {
         UI2._top.BombDeselect();
         this.LessTickB();
         this._tick = 0;
         addEventListener(Event.ENTER_FRAME,this.LessTick);
      }
      
      public function LessTick(param1:Event = null) : *
      {
         if(this._tick > 10 && this._tick % 2 == 0)
         {
            this.LessTickB();
         }
         this.MovedOut();
         ++this._tick;
      }
      
      public function LessTickB() : *
      {
         ATTACK.BucketRemove(this._creatureID);
         this.Update();
         ATTACK.BucketUpdate();
      }
      
      public function MovedOut() : *
      {
         if(mouseY < 31 || mouseY > 51)
         {
            this.Clear();
         }
      }
   }
}

