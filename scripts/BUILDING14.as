package
{
   import com.monsters.ai.WMBASE;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING14 extends BSTORAGE
   {
      public function BUILDING14()
      {
         super();
         _type = 14;
         _footprint = BASE.isInferno() ? [new Rectangle(0,0,160,160)] : [new Rectangle(0,0,130,130)];
         _gridCost = BASE.isInferno() ? [[new Rectangle(0,0,160,160),10],[new Rectangle(10,10,140,140),200]] : [[new Rectangle(0,0,130,130),10],[new Rectangle(10,10,110,110),200]];
         _spoutPoint = new Point(1,-67);
         _spoutHeight = 135;
         SetProps();
      }
      
      override public function Repair() : *
      {
         super.Repair();
      }
      
      override public function Tick() : *
      {
         super.Tick();
         if(_countdownBuild.Get() + _countdownUpgrade.Get() + _countdownFortify.Get() == 0 && _repairing != 1)
         {
            delete BASE._buildingsCatchup["b" + _id];
         }
      }
      
      override public function Place(param1:MouseEvent = null) : *
      {
         if(!MAP._dragged)
         {
            super.Place(param1);
            _hasResources = true;
         }
      }
      
      override public function Cancel() : *
      {
         GLOBAL._bTownhall = null;
         super.Cancel();
      }
      
      override public function Recycle() : *
      {
         if(!GLOBAL._aiDesignMode)
         {
            GLOBAL.Message(KEYS.Get("msg_cantrecycleth"));
         }
         else
         {
            super.Recycle();
         }
      }
      
      override public function RecycleB(param1:MouseEvent = null) : *
      {
         if(!GLOBAL._aiDesignMode)
         {
            GLOBAL.Message(KEYS.Get("msg_cantrecycleth"));
         }
         else
         {
            super.RecycleB(param1);
         }
      }
      
      override public function RecycleC() : *
      {
         if(!GLOBAL._aiDesignMode)
         {
            GLOBAL.Message(KEYS.Get("msg_cantrecycleth"));
         }
         else
         {
            super.RecycleC();
         }
      }
      
      override public function Destroyed(param1:Boolean = true) : *
      {
         super.Destroyed(param1);
         if(GLOBAL._advancedMap == 0 && GLOBAL._mode == "wmattack")
         {
            WMBASE._destroyed = true;
         }
      }
      
      override public function Description() : *
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:Array = null;
         super.Description();
         _buildingDescription = KEYS.Get("th_upgradedesc");
         if(_lvl.Get() == 1)
         {
            _recycleDescription = KEYS.Get("th_recycledesc");
         }
         if(_lvl.Get() > 0 && _lvl.Get() < _buildingProps.costs.length)
         {
            _loc1_ = [];
            _loc2_ = [];
            _loc3_ = [];
            for each(_loc4_ in GLOBAL._buildingProps)
            {
               if(_loc4_.id != 14)
               {
                  _loc5_ = int(_loc4_.quantity[_lvl.Get()]);
                  _loc6_ = int(_loc4_.quantity[_lvl.Get() + 1]);
                  _loc7_ = _loc6_ - _loc5_;
                  if(_loc5_ == 0 && _loc6_ > 0 && !_loc4_.block)
                  {
                     _loc1_.push([0,KEYS.Get(_loc4_.name)]);
                  }
                  else if(_loc7_ > 0 && !_loc4_.block)
                  {
                     _loc2_.push([0,KEYS.Get(_loc4_.name) + "s"]);
                  }
                  _loc5_ = 0;
                  _loc6_ = 0;
                  for each(_loc8_ in _loc4_.costs)
                  {
                     for each(_loc9_ in _loc8_.re)
                     {
                        if(_loc9_[0] == 14)
                        {
                           if(_loc9_[2] <= _lvl.Get())
                           {
                              _loc5_ = 1;
                           }
                           if(_loc9_[2] == _lvl.Get() + 1)
                           {
                              _loc6_ = 1;
                           }
                        }
                     }
                  }
                  if(_loc5_ > 0 && _loc6_ > 0 && !_loc4_.block)
                  {
                     _loc3_.push([0,KEYS.Get(_loc4_.name)]);
                  }
               }
            }
            if(_loc1_.length > 0)
            {
               _upgradeDescription += KEYS.Get("th_willunlockthe",{"v1":GLOBAL.Array2StringB(_loc1_)}) + "<br><br>";
            }
            if(_loc2_.length > 0)
            {
               _upgradeDescription += "<b>" + KEYS.Get("th_willbuildmore") + "</b><br>" + GLOBAL.Array2StringB(_loc2_) + "<br><br>";
            }
            if(_loc3_.length > 0)
            {
               _upgradeDescription += "<b>" + KEYS.Get("th_willupgrade") + "</b><br>" + GLOBAL.Array2StringB(_loc3_);
            }
         }
      }
      
      override public function Update(param1:Boolean = false) : *
      {
         super.Update(param1);
      }
      
      override public function Constructed() : *
      {
         GLOBAL._bTownhall = this;
         ACHIEVEMENTS.Check("thlevel",_lvl.Get());
         super.Constructed();
      }
      
      override public function UpgradeB() : *
      {
         super.UpgradeB();
         if(_lvl.Get() >= 2 && _countdownUpgrade.Get() > 0 && _countdownUpgrade.Get() * 0.005555555555555555 > BASE._credits.Get())
         {
            POPUPS.DisplayPleaseBuy("TH");
         }
      }
      
      override public function Upgraded() : *
      {
         LOGGER.KongStat([2,_lvl.Get()]);
         ACHIEVEMENTS.Check("thlevel",_lvl.Get());
         super.Upgraded();
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         GLOBAL._bTownhall = this;
         ACHIEVEMENTS.Check("thlevel",_lvl.Get());
      }
   }
}

