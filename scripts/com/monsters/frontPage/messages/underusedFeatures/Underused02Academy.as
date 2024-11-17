package com.monsters.frontPage.messages.underusedFeatures
{
   import com.monsters.frontPage.messages.KeywordMessage;
   
   public class Underused02Academy extends KeywordMessage
   {
      public function Underused02Academy()
      {
         super("idleacademy","btn_open");
         imageURL = _IMAGE_DIRECTORY + _PREFIX + "academy.jpg";
      }
      
      override public function get areRequirementsMet() : Boolean
      {
         return GLOBAL._bAcademy && this.hasIdleAcademy() && GLOBAL._bTownhall._lvl.Get() >= 3 && GLOBAL.Timestamp() - GLOBAL.StatGet("CM5") > 432000 && Boolean(this.hasUpgradableMonster());
      }
      
      override protected function onView() : void
      {
         GLOBAL.StatSet("CM5",GLOBAL.Timestamp());
      }
      
      override protected function onButtonClick() : void
      {
         ACADEMY.Show(GLOBAL._bAcademy);
         POPUPS.Next();
      }
      
      private function hasUpgradableMonster() : String
      {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc1_:Object = CREATURELOCKER.GetAppropriateCreatures();
         var _loc2_:* = GLOBAL._bAcademy._lvl.Get();
         var _loc3_:* = _loc2_ >= GLOBAL._buildingProps[ACADEMY.ID - 1].costs.length;
         for(_loc4_ in _loc1_)
         {
            _loc5_ = ACADEMY._upgrades[_loc4_];
            if(!_loc5_)
            {
               return null;
            }
            _loc6_ = int(_loc5_.level);
            if(_loc6_ < _loc2_ || _loc6_ == _loc2_ && !_loc3_ && _loc2_ >= _loc1_[_loc4_].page && !ACADEMY._upgrades[_loc4_].time)
            {
               return KEYS.Get(_loc1_[_loc4_].name);
            }
         }
         return null;
      }
      
      private function hasIdleAcademy() : Boolean
      {
         var _loc1_:BFOUNDATION = null;
         for each(_loc1_ in BASE._buildingsAll)
         {
            if(_loc1_._type == ACADEMY.ID && !BUILDING26(_loc1_)._upgrading)
            {
               return true;
            }
         }
         return false;
      }
   }
}

