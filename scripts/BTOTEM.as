package
{
   import com.cc.utils.SecNum;
   
   public class BTOTEM extends BDECORATION
   {
      public static const BTOTEM_BUILDING_TYPE:int = 131;
      
      public function BTOTEM(param1:int)
      {
         super(param1);
         if(Boolean(BASE._buildingsStored["b" + _type]) && Boolean(BASE._buildingsStored["bl" + _type]))
         {
            _lvl = new SecNum(BASE._buildingsStored["bl" + _type].Get());
            _hpLvl = _lvl.Get();
         }
      }
      
      public static function TotemReward() : void
      {
         RemoveAllFromStorage(false,true);
         RemoveAllFromYard(false,true);
         BASE.BuildingStorageAdd(BTOTEM_BUILDING_TYPE,1);
      }
      
      public static function TotemPlace() : void
      {
         BUILDINGS._buildingID = BTOTEM_BUILDING_TYPE;
         BUILDINGS.Show();
         BUILDINGS._mc.SwitchB(4,4,0);
      }
      
      public static function UpgradeTotem() : void
      {
         var _loc1_:BFOUNDATION = null;
         for each(_loc1_ in BASE._buildingsAll)
         {
            if(IsTotem2(_loc1_._type))
            {
               _loc1_.Upgraded();
            }
         }
         if(BASE._buildingsStored["bl" + BTOTEM_BUILDING_TYPE])
         {
            BASE._buildingsStored["bl" + BTOTEM_BUILDING_TYPE].Add(1);
         }
      }
      
      public static function DowngradeTotem() : void
      {
         var _loc1_:BFOUNDATION = null;
         for each(_loc1_ in BASE._buildingsAll)
         {
            if(IsTotem2(_loc1_._type))
            {
               _loc1_.Downgrade_TOTEM_DEBUG();
            }
         }
         if(BASE._buildingsStored["bl" + BTOTEM_BUILDING_TYPE])
         {
            BASE._buildingsStored["bl" + BTOTEM_BUILDING_TYPE].Add(-1);
         }
      }
      
      private static function RemoveAllFromStorage(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:Number = NaN;
         if(param1)
         {
            _loc3_ = 121;
            while(_loc3_ <= 126)
            {
               if(BASE._buildingsStored["b" + _loc3_])
               {
                  delete BASE._buildingsStored["b" + _loc3_];
               }
               if(BASE._buildingsStored["bl" + _loc3_])
               {
                  delete BASE._buildingsStored["bl" + _loc3_];
               }
               _loc3_++;
            }
         }
         if(param2)
         {
            if(BASE._buildingsStored["b" + BTOTEM_BUILDING_TYPE])
            {
               delete BASE._buildingsStored["b" + BTOTEM_BUILDING_TYPE];
            }
            if(BASE._buildingsStored["bl" + BTOTEM_BUILDING_TYPE])
            {
               delete BASE._buildingsStored["bl" + BTOTEM_BUILDING_TYPE];
            }
         }
      }
      
      private static function RemoveAllFromYard(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:BFOUNDATION = null;
         for each(_loc3_ in BASE._buildingsAll)
         {
            if(param1)
            {
               if(_loc3_._type >= 121 && _loc3_._type <= 126)
               {
                  _loc3_.GridCost(false);
                  _loc3_.Clean();
               }
            }
            if(param2)
            {
               if(IsTotem2(_loc3_._type))
               {
                  _loc3_.GridCost(false);
                  _loc3_.Clean();
               }
            }
         }
      }
      
      public static function FindMissingTotem() : void
      {
         var _loc2_:BFOUNDATION = null;
         if(GLOBAL._mode != "build")
         {
            return;
         }
         var _loc1_:int = EarnedTotemLevel();
         if(_loc1_ > 0 && BASE._yardType == BASE.MAIN_YARD)
         {
            for each(_loc2_ in BASE._buildingsAll)
            {
               if(IsTotem2(_loc2_._type))
               {
                  return;
               }
            }
            if(!BASE._buildingsStored["b" + BTOTEM_BUILDING_TYPE])
            {
               BASE.BuildingStorageAdd(BTOTEM_BUILDING_TYPE,_loc1_);
               GLOBAL.Message("It\'s come to our attention that the Wild Monsters have been stealing some players\' Totems. If yours seems to be missing, don\'t fret! Just check your storage and it should be ready for placement.");
            }
         }
      }
      
      private static function EarnedTotemLevel() : int
      {
         switch(SPECIALEVENT.wave)
         {
            case 1:
               return 0;
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
               return 1;
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
               return 2;
            case 21:
            case 22:
            case 23:
            case 24:
            case 25:
            case 26:
            case 27:
            case 28:
            case 29:
            case 30:
               return 3;
            case 31:
               return 4;
            case 32:
               return 5;
            default:
               return 6;
         }
      }
      
      public static function IsTotem(param1:int, param2:Boolean = true) : Boolean
      {
         return param1 >= 121 && param1 <= 126 || !param2 && param1 == BTOTEM_BUILDING_TYPE;
      }
      
      public static function IsTotem2(param1:int) : Boolean
      {
         return param1 == BTOTEM_BUILDING_TYPE;
      }
      
      override public function Tick(param1:int) : void
      {
         super.Tick(param1);
         var _loc2_:int = EarnedTotemLevel();
         if(_lvl.Get() != _loc2_)
         {
            _lvl.Set(_loc2_);
            _hpLvl = _loc2_;
         }
      }
   }
}

