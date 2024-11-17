package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class BUILDING15 extends BFOUNDATION
   {
      public var _capacity:*;
      
      public var _space:int;
      
      public var _housing:Object;
      
      public function BUILDING15()
      {
         super();
         _type = 15;
         this._capacity = 0;
         this._housing = {};
         _footprint = [new Rectangle(0,0,160,160)];
         _gridCost = [[new Rectangle(10,10,140,20),400],[new Rectangle(130,30,20,2 * 60),400],[new Rectangle(10,30,20,2 * 60),400],[new Rectangle(30,130,30,20),400],[new Rectangle(100,130,30,20),400]];
         SetProps();
      }
      
      override public function StopMoveB() : *
      {
         var _loc2_:CREEP = null;
         super.StopMoveB();
         var _loc1_:int = 0;
         while(_loc1_ < _creatures.length)
         {
            _loc2_ = _creatures[_loc1_];
            if(_loc2_._behaviour != "juice")
            {
               _loc2_._targetCenter = GRID.FromISO(_mc.x,_mc.y);
               _loc2_.ModeHousing();
            }
            _loc1_++;
         }
      }
      
      override public function Tick() : *
      {
         super.Tick();
         if(_countdownBuild.Get() + _countdownUpgrade.Get() == 0 && _repairing != 1)
         {
            delete BASE._buildingsCatchup["b" + _id];
         }
      }
      
      override public function Description() : *
      {
         super.Description();
         _upgradeDescription = KEYS.Get("bdg_housing_capacitydesc",{
            "v1":GLOBAL.FormatNumber(_buildingProps.capacity[_lvl.Get() - 1]),
            "v2":GLOBAL.FormatNumber(_buildingProps.capacity[_lvl.Get()])
         });
         _recycleDescription = "<b>" + KEYS.Get("bdg_housing_recycledesc") + "</b><br>" + _recycleCosts;
         HOUSING.HousingSpace();
         if(BASE._yardType == BASE.MAIN_YARD || BASE._yardType == BASE.INFERNO_YARD)
         {
            _blockRecycle = false;
         }
         var _loc1_:int = HOUSING._housingSpace.Get();
         var _loc2_:int = int(_buildingProps.capacity[_lvl.Get() - 1]);
         if(HOUSING._housingSpace.Get() - _buildingProps.capacity[_lvl.Get() - 1] < 0)
         {
            _recycleDescription = "<font color=\"#CC0000\">" + KEYS.Get("bdg_housing_recyclewarning") + "</font>";
            _blockRecycle = true;
         }
      }
      
      override public function Constructed() : *
      {
         super.Constructed();
         HOUSING.AddHouse(this);
      }
      
      override public function Upgraded() : *
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Upgraded();
         HOUSING.HousingSpace();
         if(GLOBAL._mode == "build" && BASE._yardType == BASE.MAIN_YARD)
         {
            Brag = function(param1:MouseEvent):*
            {
               GLOBAL.CallJS("sendFeed",["upgrade-ho-" + _lvl.Get(),KEYS.Get("pop_housingupgraded_streamtitle",{"v1":_lvl.Get()}),KEYS.Get("pop_housingupgraded_streambody"),"upgrade-housing.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_housingupgraded_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_housingupgraded_body",{"v1":_lvl.Get()});
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      override public function Update(param1:Boolean = false) : *
      {
         super.Update(param1);
      }
      
      override public function RecycleC() : *
      {
         super.RecycleC();
         HOUSING.HousingSpace();
         HOUSING.RemoveHouse(this);
      }
      
      override public function Destroyed(param1:Boolean = true) : *
      {
         super.Destroyed(param1);
         var _loc2_:int = 0;
         while(_loc2_ < _creatures.length)
         {
            _creatures[_loc2_]._health.Set(0);
            _loc2_++;
         }
         HOUSING.Cull();
         HOUSING.RemoveHouse(this);
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         if(_hp.Get() > 10 && _hp.Get() < _hpMax.Get() && _hp.Get() % 1000 == 0)
         {
            _hp.Set(_hpMax.Get());
         }
         if(_countdownBuild.Get() == 0)
         {
            HOUSING.AddHouse(this);
         }
      }
   }
}

