package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class CHAMPIONBUTTON extends GUARDIANBUTTON_CLIP
   {
      public var _creatureID:String;
      
      public var _creatureData:Object;
      
      public var _level:int;
      
      public var _description:bubblepopup3;
      
      public var _sent:Boolean = false;
      
      private var _index:int = 0;
      
      private const MAX_ICON_LEVEL:uint = 6;
      
      public function CHAMPIONBUTTON(param1:String, param2:int, param3:int)
      {
         super();
         this._index = param3;
         this._creatureID = param1;
         this._creatureData = CHAMPIONCAGE._guardians[param1];
         this._level = Math.min(this.MAX_ICON_LEVEL,param2);
         var _loc4_:String = CHAMPIONCAGE._guardians[param1].name;
         txtName.htmlText = "<b>" + _loc4_ + "</b>";
         ImageCache.GetImageWithCallBack("monsters/" + this._creatureID + "_L" + this._level + "-small.png",this.IconLoaded,true,1);
         this._description = new bubblepopup3();
         this._description.Setup(158,26,KEYS.Get(CHAMPIONCAGE._guardians[this._creatureID].description),5);
         addChild(this._description);
         this._description.visible = false;
         bSend.SetupKey("btn_send");
         bSend.addEventListener(MouseEvent.CLICK,this.Send);
         bRetreat.SetupKey("btn_retreat");
         bRetreat.addEventListener(MouseEvent.CLICK,this.Retreat);
         addEventListener(MouseEvent.ROLL_OVER,this.Over);
         addEventListener(MouseEvent.ROLL_OUT,this.Out);
         CREEPS._flungGuardian[this._index] = false;
         if(Boolean(GLOBAL._playerGuardianData[this._index]) && Boolean(GLOBAL._playerGuardianData[this._index].l.Get()))
         {
            mcMonsterLevel.tLevel.htmlText = "<b>" + GLOBAL._playerGuardianData[this._index].l.Get() + "</b>";
         }
         else
         {
            mcMonsterLevel.tLevel.htmlText = "<b>1</b>";
         }
         this.Update();
      }
      
      public function IconLoaded(param1:String, param2:BitmapData) : *
      {
         mcImage.addChild(new Bitmap(param2));
      }
      
      public function Update() : *
      {
         if(CREEPS._flungGuardian[this._index])
         {
            bSend.removeEventListener(MouseEvent.CLICK,this.Send);
            bSend.Enabled = false;
         }
      }
      
      public function Send(param1:MouseEvent) : *
      {
         if(!this._sent)
         {
            ATTACK.BucketAdd(this._creatureID);
            bSend.SetupKey("btn_hold");
            ATTACK.BucketUpdate();
            this._sent = true;
         }
         else
         {
            ATTACK.BucketRemove(this._creatureID);
            bSend.SetupKey("btn_send");
            ATTACK.BucketUpdate();
            this._sent = false;
         }
         this.Update();
      }
      
      public function Retreat(param1:MouseEvent) : *
      {
         var _loc2_:int = CREEPS.getGuardianIndex(int(this._creatureID.substr(1)));
         if(_loc2_ >= 0)
         {
            CREEPS._guardianList[_loc2_].ModeRetreat();
         }
      }
      
      public function Over(param1:MouseEvent) : *
      {
         dispatchEvent(new Event(UI_TOP.CREATUREBUTTONOVER));
         this._description.visible = true;
      }
      
      public function Out(param1:MouseEvent) : *
      {
         this._description.visible = false;
      }
   }
}

