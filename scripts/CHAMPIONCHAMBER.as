package
{
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gs.easing.*;
   
   public class CHAMPIONCHAMBER extends BFOUNDATION
   {
      public static var _popup:CHAMPIONCHAMBERPOPUP;
      
      public static var _open:Boolean = false;
      
      public var _frozen:Array = [];
      
      public function CHAMPIONCHAMBER()
      {
         super();
         _type = 119;
         _footprint = [new Rectangle(0,0,100,100)];
         _gridCost = [[new Rectangle(0,0,100,100),10],[new Rectangle(10,10,80,80),200]];
         SetProps();
      }
      
      public static function HasFrozen(param1:int) : Boolean
      {
         var _loc2_:CHAMPIONCHAMBER = null;
         var _loc3_:int = 0;
         if(GLOBAL._bChamber)
         {
            _loc2_ = GLOBAL._bChamber as CHAMPIONCHAMBER;
            _loc3_ = 0;
            while(_loc3_ < _loc2_._frozen.length)
            {
               if(_loc2_._frozen[_loc3_].t == param1)
               {
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      public static function Show() : *
      {
         var _loc1_:CHAMPIONCHAMBER = GLOBAL._bChamber as CHAMPIONCHAMBER;
         if(CREATURES._guardian == null && (_loc1_ && _loc1_._frozen.length == 0))
         {
            GLOBAL.Message("You have no Champions!");
            return;
         }
         if(!_open)
         {
            _open = true;
            GLOBAL.BlockerAdd();
            _popup = GLOBAL._layerWindows.addChild(new CHAMPIONCHAMBERPOPUP());
            _popup.Center();
            _popup.ScaleUp();
         }
      }
      
      public static function Hide() : void
      {
         if(_open)
         {
            GLOBAL.BlockerRemove();
            SOUNDS.Play("close");
            BASE.BuildingDeselect();
            _open = false;
            if(_popup)
            {
               GLOBAL._layerWindows.removeChild(_popup);
               _popup = null;
            }
         }
      }
      
      override public function PlaceB() : *
      {
         super.PlaceB();
         GLOBAL._bChamber = this;
      }
      
      override public function Constructed() : *
      {
         super.Constructed();
         GLOBAL._bChamber = this;
      }
      
      override public function Recycle() : *
      {
         if(Boolean(this._frozen) && this._frozen.length > 0)
         {
            GLOBAL.Message(KEYS.Get("bdg_chamber_recycle"));
         }
         else
         {
            GLOBAL._bChamber = null;
            super.Recycle();
         }
      }
      
      public function FreezeGuardian() : *
      {
         if(CREATURES._guardian)
         {
            if(CREATURES._guardian._health.Get() < CREATURES._guardian._maxHealth)
            {
               GLOBAL.Message(KEYS.Get("bdg_chamber_injured"));
               return;
            }
            if(CREATURES._guardian._feedTime.Get() < GLOBAL.Timestamp())
            {
               GLOBAL.Message(KEYS.Get("bdg_chamber_hungry"));
               return;
            }
            LOGGER.Stat([69,BASE._guardianData.t,BASE._guardianData.l.Get()]);
            CREATURES._guardian.Export();
            CREATURES._guardian.ModeFreeze();
            BASE._guardianData.ft -= GLOBAL.Timestamp();
            this._frozen.push(BASE._guardianData);
            BASE._guardianData = null;
            CREATURES._guardian = null;
            if(GLOBAL._mode == "build")
            {
               GLOBAL._playerGuardianData = null;
            }
            BASE.Save();
         }
      }
      
      public function ThawGuardian(param1:int) : *
      {
         var i:int;
         var StreamPost:Function;
         var p:Point = null;
         var level:int = 0;
         var target:Point = null;
         var defaultNames:Array = null;
         var newFrozen:Array = null;
         var j:int = 0;
         var mc:popup_monster = null;
         var type:int = param1;
         if(_hp.Get() < _hpMax.Get())
         {
            GLOBAL.Message(KEYS.Get("bdg_chamber_damaged"));
            return;
         }
         if(CREATURES._guardian)
         {
            GLOBAL.Message(KEYS.Get("bdg_chamber_freeze"));
            return;
         }
         i = 0;
         while(i < this._frozen.length)
         {
            if(this._frozen[i].t == type)
            {
               p = new Point(x,y + 80);
               level = int(this._frozen[i].l.Get());
               target = GRID.FromISO(GLOBAL._bCage.x,GLOBAL._bCage.y + 20);
               CREATURES._guardian = new CHAMPIONMONSTER("cage",p,0,target,true,this,this._frozen[i].l.Get(),this._frozen[i].fd,this._frozen[i].ft + GLOBAL.Timestamp(),this._frozen[i].t,this._frozen[i].hp.Get(),this._frozen[i].fb.Get());
               CREATURES._guardian.Export();
               defaultNames = ["Gorgo","Drull","Fomor"];
               MAP._BUILDINGTOPS.addChild(CREATURES._guardian);
               CREATURES._guardian.ModeCage();
               newFrozen = [];
               j = 0;
               while(j < this._frozen.length)
               {
                  if(i != j)
                  {
                     newFrozen.push(this._frozen[j]);
                  }
                  j++;
               }
               this._frozen = newFrozen;
               if(GLOBAL._mode == "build")
               {
                  StreamPost = function(param1:String, param2:String, param3:String):*
                  {
                     var st:String = param1;
                     var sd:String = param2;
                     var im:String = param3;
                     return function(param1:MouseEvent = null):*
                     {
                        GLOBAL.CallJS("sendFeed",["unlock-end",st,sd,im,0]);
                        POPUPS.Next();
                     };
                  };
                  mc = new popup_monster();
                  mc.bSpeedup.SetupKey("btn_warnyourfriends");
                  mc.bSpeedup.addEventListener(MouseEvent.CLICK,StreamPost(KEYS.Get("chamber_thawstreamtitle",{"v1":CHAMPIONCAGE._guardians["G" + type].name}),KEYS.Get("chamber_thawstreamdesc",{"v1":CHAMPIONCAGE._guardians["G" + type].name}),"G" + type + "_L6-90.png"));
                  mc.bSpeedup.Highlight = true;
                  mc.bAction.visible = false;
                  mc.tText.htmlText = KEYS.Get("chamber_thawstreamdesc",{"v1":CHAMPIONCAGE._guardians["G" + type].name});
                  POPUPS.Push(mc,null,null,null,"G" + type + "_L" + level + "-150.png");
               }
               LOGGER.Stat([70,BASE._guardianData.t,BASE._guardianData.l.Get()]);
               BASE.Save();
               break;
            }
            i++;
         }
      }
      
      override public function Setup(param1:Object) : *
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         super.Setup(param1);
         if(param1.fz)
         {
            _loc2_ = com.adobe.serialization.json.JSON.decode(param1.fz);
            this._frozen = [];
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = {};
               _loc5_ = _loc2_[_loc3_];
               if(_loc5_.nm)
               {
                  _loc4_.nm = _loc5_.nm;
               }
               _loc4_.t = _loc5_.t;
               if(_loc5_.ft)
               {
                  _loc4_.ft = _loc5_.ft;
               }
               if(_loc5_.fd)
               {
                  _loc4_.fd = _loc5_.fd;
               }
               else
               {
                  _loc4_.fd = 0;
               }
               if(_loc5_.l)
               {
                  _loc4_.l = new SecNum(_loc5_.l);
               }
               else
               {
                  _loc4_.l = new SecNum(0);
               }
               if(_loc5_.hp)
               {
                  _loc4_.hp = new SecNum(_loc5_.hp);
               }
               else
               {
                  _loc4_.hp = new SecNum(0);
               }
               if(_loc5_.fb)
               {
                  _loc4_.fb = new SecNum(_loc5_.fb);
               }
               else
               {
                  _loc4_.fb = new SecNum(0);
               }
               this._frozen.push(_loc4_);
               _loc3_++;
            }
         }
      }
      
      override public function Export() : *
      {
         var _loc4_:Object = null;
         var _loc1_:* = super.Export();
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < this._frozen.length)
         {
            _loc4_ = {};
            if(this._frozen[_loc3_].nm)
            {
               _loc4_.nm = this._frozen[_loc3_].nm;
            }
            if(this._frozen[_loc3_].t)
            {
               _loc4_.t = this._frozen[_loc3_].t;
            }
            if(this._frozen[_loc3_].hp)
            {
               _loc4_.hp = this._frozen[_loc3_].hp.Get();
            }
            else
            {
               _loc4_.hp = 0;
            }
            if(this._frozen[_loc3_].l)
            {
               _loc4_.l = this._frozen[_loc3_].l.Get();
            }
            if(this._frozen[_loc3_].ft)
            {
               _loc4_.ft = this._frozen[_loc3_].ft;
            }
            if(this._frozen[_loc3_].fd)
            {
               _loc4_.fd = this._frozen[_loc3_].fd;
            }
            else
            {
               _loc4_.fd = 0;
            }
            if(this._frozen[_loc3_].fb)
            {
               _loc4_.fb = this._frozen[_loc3_].fb.Get();
            }
            else
            {
               _loc4_.fb = 0;
            }
            _loc2_.push(_loc4_);
            _loc3_++;
         }
         _loc1_.fz = com.adobe.serialization.json.JSON.encode(_loc2_);
         return _loc1_;
      }
   }
}

