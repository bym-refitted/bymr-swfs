package com.monsters.subscriptions.rewards
{
   import com.monsters.rewarding.Reward;
   
   public class DAVEStatueReward extends Reward
   {
      public static const ID:String = "daveStatue";
      
      public static const DAVE_STATUE_TYPE_ID:int = 135;
      
      private static const DAVE_STATUE_BUILDING_PROPS_INDEX:int = DAVE_STATUE_TYPE_ID - 1;
      
      public function DAVEStatueReward()
      {
         super();
      }
      
      public static function makeVisibleInStore(param1:Function) : void
      {
         GLOBAL._buildingProps[DAVE_STATUE_BUILDING_PROPS_INDEX].block = false;
         GLOBAL._buildingProps[DAVE_STATUE_BUILDING_PROPS_INDEX].locked = true;
         BUILDINGBUTTON.setOnClickedWhenLockedCallback(DAVE_STATUE_TYPE_ID,param1);
      }
      
      public static function doesStatueRewardExistsInInventory() : Boolean
      {
         return BASE.BuildingStorageCount(DAVE_STATUE_TYPE_ID) > 0;
      }
      
      public static function findStatueRewardInWorld() : BFOUNDATION
      {
         var _loc1_:BFOUNDATION = null;
         for each(_loc1_ in BASE._buildingsAll)
         {
            if(_loc1_._type == DAVE_STATUE_TYPE_ID)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      override protected function onApplication() : void
      {
         GLOBAL._buildingProps[DAVE_STATUE_BUILDING_PROPS_INDEX].block = true;
         GLOBAL._buildingProps[DAVE_STATUE_BUILDING_PROPS_INDEX].locked = false;
         var _loc1_:Boolean = doesStatueRewardExistsInInventory();
         var _loc2_:* = findStatueRewardInWorld() != null;
         if(!_loc1_ && !_loc2_)
         {
            BASE.BuildingStorageAdd(DAVE_STATUE_TYPE_ID,1);
         }
      }
      
      override public function removed() : void
      {
         var _loc1_:BFOUNDATION = null;
         GLOBAL._buildingProps[DAVE_STATUE_BUILDING_PROPS_INDEX].block = false;
         GLOBAL._buildingProps[DAVE_STATUE_BUILDING_PROPS_INDEX].locked = true;
         for each(_loc1_ in BASE._buildingsAll)
         {
            if(_loc1_._type == DAVE_STATUE_TYPE_ID)
            {
               _loc1_.RecycleC();
            }
         }
         BASE.BuildingStorageRemove(DAVE_STATUE_TYPE_ID);
      }
   }
}

