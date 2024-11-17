package
{
   import com.cc.utils.SecNum;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING9 extends BFOUNDATION
   {
      public var _animMC:*;
      
      public var _field:BitmapData;
      
      public var _fieldBMP:Bitmap;
      
      public var _frameNumber:int;
      
      public var _animBitmap:BitmapData;
      
      public var _blend:int;
      
      public var _blending:Boolean;
      
      public var _bank:SecNum;
      
      public var _guardian:int = 0;
      
      public function BUILDING9()
      {
         super();
         this._frameNumber = 0;
         _type = 9;
         this._blend = 0;
         _footprint = [new Rectangle(0,0,80,80)];
         _gridCost = [[new Rectangle(0,0,80,80),50]];
         _spoutPoint = new Point(0,12);
         _spoutHeight = 28;
         this._bank = new SecNum(0);
         SetProps();
      }
      
      public function Prep(param1:String) : *
      {
         this._bank.Add(Math.ceil(CREATURES.GetProperty(param1,"cResource") * 0.7));
         ++QUESTS._global.monstersblended;
         QUESTS._global.monstersblendedgoo += Math.ceil(CREATURES.GetProperty(param1,"cResource") * 0.7);
         ACHIEVEMENTS.Check("monstersblended",QUESTS._global.monstersblended);
         QUESTS.Check();
         if(GLOBAL._mode == "build")
         {
            BASE.Save();
         }
      }
      
      override public function Tick() : *
      {
         super.Tick();
         if(!_repairing && _countdownBuild.Get() + _countdownUpgrade.Get() == 0)
         {
            CatchupRemove();
         }
      }
      
      public function Blend(param1:int, param2:String) : *
      {
         this._blend += param1;
         var _loc3_:Number = 0.6;
         if(_lvl.Get() == 2)
         {
            _loc3_ = 0.8;
         }
         else if(_lvl.Get() == 3)
         {
            _loc3_ = 1;
         }
         this._guardian = 0;
         BASE.Fund(4,Math.ceil(CREATURES.GetProperty(param2,"cResource") * _loc3_));
         this._bank.Add(0 - Math.ceil(CREATURES.GetProperty(param2,"cResource") * _loc3_));
         ResourcePackages.Create(4,this,Math.ceil(CREATURES.GetProperty(param2,"cResource") * _loc3_));
      }
      
      public function BlendGuardian(param1:int) : *
      {
         this._blend += param1;
         this._guardian = 1;
      }
      
      override public function TickFast(param1:Event = null) : *
      {
         super.TickFast(param1);
         if(_animLoaded && !GLOBAL._catchup && (this._blend > 0 || _animTick > 1) && this._frameNumber % 2 == 0)
         {
            this.AnimFrame();
            if(_animTick == 1)
            {
               SOUNDS.Play("juice");
            }
            if(_animTick == 15)
            {
               this._blend = 0;
               if(!this._guardian)
               {
                  ResourcePackages.Create(4,this,1);
               }
            }
            if(_animTick == 52)
            {
               _animTick = 0;
            }
         }
         ++this._frameNumber;
      }
      
      override public function AnimFrame(param1:Boolean = true) : *
      {
         var q:int = 0;
         var increment:Boolean = param1;
         try
         {
            _animContainerBMD.copyPixels(_animBMD,new Rectangle(60 * _animTick,0,60,39),new Point(0,0));
            ++_animTick;
            q = this._blend;
            if(q > 70)
            {
               q = 70;
            }
            if(_lvl.Get() == 2)
            {
               q *= 1.2;
            }
            else if(_lvl.Get() == 3)
            {
               q *= 1.4;
            }
            if(_animTick == 15)
            {
               if(this._guardian == 0)
               {
                  GIBLETS.Create(_spoutPoint.add(new Point(_mc.x,_mc.y)),0.8,100,q,_spoutHeight);
               }
               else
               {
                  GIBLETS.Create(_spoutPoint.add(new Point(_mc.x,_mc.y)),2,1000,q,_spoutHeight);
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      override public function Description() : *
      {
         super.Description();
         if(_lvl.Get() == 1)
         {
            if(_upgradeCosts != "")
            {
               _upgradeDescription = "Increases the conversion back into Goo from 60 to 80% ";
            }
         }
         else if(_lvl.Get() == 2)
         {
            if(_upgradeCosts != "")
            {
               _upgradeDescription = "Increases the conversion back into Goo from 80 to 100% ";
            }
         }
      }
      
      override public function Update(param1:Boolean = false) : *
      {
         if(GLOBAL._catchup && _countdownBuild.Get() + _countdownUpgrade.Get() == 0 && _repairing != 1)
         {
            delete BASE._buildingsCatchup["b" + _id];
         }
         super.Update(param1);
      }
      
      override public function Constructed() : *
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Constructed();
         GLOBAL._bJuicer = this;
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            Brag = function(param1:MouseEvent):*
            {
               GLOBAL.CallJS("sendFeed",["build-mjl",KEYS.Get("pop_juicerbuilt_streamtitle"),KEYS.Get("pop_juicerbuilt_streambody"),"build-monsterjuiceloosener.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_juicerbuilt_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_juicerbuilt_body");
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      override public function Upgraded() : *
      {
         var Brag:Function;
         var percent:int = 0;
         var mc:MovieClip = null;
         super.Upgraded();
         if(GLOBAL._mode == "build")
         {
            Brag = function(param1:MouseEvent):*
            {
               GLOBAL.CallJS("sendFeed",["upgrade-fl-" + _lvl.Get(),KEYS.Get("pop_juicerupgraded_streamtitle",{"v1":_lvl.Get()}),KEYS.Get("pop_juicerupgraded_streambody"),"upgrade-monsterjuiceloosener.png"]);
               POPUPS.Next();
            };
            percent = 60;
            if(_lvl.Get() == 2)
            {
               percent = 80;
            }
            if(_lvl.Get() == 3)
            {
               percent = 100;
            }
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_juicerupgraded_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_juicerupgraded_body",{
               "v1":_lvl.Get(),
               "v2":percent
            });
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      override public function RecycleC() : *
      {
         GLOBAL._bJuicer = null;
         super.RecycleC();
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         if(_countdownBuild.Get() == 0)
         {
            GLOBAL._bJuicer = this;
         }
         if(param1.tjc)
         {
            QUESTS._global.monstersblended = param1.tjc;
         }
         if(param1.tjg)
         {
            QUESTS._global.monstersblendedgoo = param1.tjg;
         }
      }
      
      override public function Export() : *
      {
         return super.Export();
      }
   }
}

