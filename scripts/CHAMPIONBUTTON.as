package
{
   import com.adobe.serialization.json.*;
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   
   public class CHAMPIONBUTTON extends GUARDIANBUTTON_CLIP
   {
      public var _creatureID:String;
      
      public var _creatureData:Object;
      
      public var _level:int;
      
      public var _description:bubblepopup3;
      
      public var _sent:Boolean = false;
      
      public function CHAMPIONBUTTON(param1:String, param2:int)
      {
         super();
         this._creatureID = param1;
         this._creatureData = CHAMPIONCAGE._guardians[param1];
         this._level = param2;
         var _loc3_:String = CHAMPIONCAGE._guardians[param1].name;
         txtName.htmlText = "<b>" + _loc3_ + "</b>";
         ImageCache.GetImageWithCallBack("monsters/" + this._creatureID + "_L" + this._level + "-small.png",this.IconLoaded,true,1);
         this._description = new bubblepopup3();
         this._description.Setup(158,26,KEYS.Get(CHAMPIONCAGE._guardians[this._creatureID].description),5);
         addChild(this._description);
         this._description.visible = false;
         bSend.Setup("Send");
         bSend.addEventListener(MouseEvent.CLICK,this.Send);
         bRetreat.Setup("Retreat");
         bRetreat.addEventListener(MouseEvent.CLICK,this.Retreat);
         addEventListener(MouseEvent.ROLL_OVER,this.Over);
         addEventListener(MouseEvent.ROLL_OUT,this.Out);
         if(Boolean(GLOBAL._playerGuardianData) && Boolean(GLOBAL._playerGuardianData.l.Get()))
         {
            mcMonsterLevel.tLevel.htmlText = "<b>" + GLOBAL._playerGuardianData.l.Get() + "</b>";
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
         if(CREEPS._flungGuardian)
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
            bSend.Setup("Hold");
            ATTACK.BucketUpdate();
            this._sent = true;
         }
         else
         {
            ATTACK.BucketRemove(this._creatureID);
            bSend.Setup("Send");
            ATTACK.BucketUpdate();
            this._sent = false;
         }
         this.Update();
      }
      
      public function Retreat(param1:MouseEvent) : *
      {
         if(CREEPS._guardian)
         {
            CREEPS._guardian.ModeRetreat();
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
   }
}

