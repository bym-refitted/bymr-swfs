package
{
   import com.monsters.pathing.PATHING;
   import flash.events.*;
   import flash.geom.Rectangle;
   
   public class BWALL extends BFOUNDATION
   {
      public function BWALL()
      {
         super();
      }
      
      override public function GridCost(param1:Boolean = true) : *
      {
         super.GridCost(param1);
         PATHING.RegisterBuilding(new Rectangle(_mc.x,_mc.y,20,20),this,param1);
      }
      
      override public function Tick() : *
      {
         super.Tick();
         if(!GLOBAL._render && _countdownBuild.Get() + _countdownUpgrade.Get() == 0 && _repairing != 1)
         {
            delete BASE._buildingsCatchup["b" + _id];
         }
      }
      
      override public function Description() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.Description();
         if(_lvl.Get() < _buildingProps.hp.length)
         {
            _loc1_ = int(_buildingProps.hp[_lvl.Get() - 1]);
            _loc2_ = int(_buildingProps.hp[_lvl.Get()]);
            _upgradeDescription = "Increases hit points from " + GLOBAL.FormatNumber(_loc1_) + " to " + GLOBAL.FormatNumber(_loc2_) + " (+" + (int(100 / _loc1_ * _loc2_) - 100) + "%).";
         }
      }
      
      override public function RecycleC() : *
      {
         PATHING.RegisterBuilding(new Rectangle(_mc.x,_mc.y,20,20),this,false);
         super.RecycleC();
      }
   }
}
