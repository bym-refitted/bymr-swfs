package
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class INFERNO_MAGMA_TOWER extends BTOWER
   {
      public var _animMC:*;
      
      public var _animBitmap:BitmapData;
      
      public var _shotsFired:int;
      
      public var _lostCreep:Boolean = false;
      
      public var _fireStage:int = 1;
      
      public var _targetArray:Array = [4,4,6,8,10,12];
      
      public function INFERNO_MAGMA_TOWER()
      {
         super();
         _frameNumber = 0;
         _type = 132;
         _top = -30;
         _footprint = [new Rectangle(0,0,70,70)];
         _gridCost = [[new Rectangle(0,0,70,70),10],[new Rectangle(10,10,50,50),200]];
         this._fireStage = 1;
         SetProps();
      }
      
      override public function TickAttack() : *
      {
         super.TickAttack();
         Rotate();
      }
      
      override public function AnimFrame(param1:Boolean = true) : *
      {
         if(_animLoaded && GLOBAL._render)
         {
            _animContainerBMD.copyPixels(_animBMD,new Rectangle(_animRect.width * _animTick,0,_animRect.width,_animRect.height),new Point(0,0));
         }
         super.AnimFrame(false);
      }
      
      override public function Fire(param1:*) : *
      {
         super.Fire(param1);
         if(Math.random() * 2 <= 1)
         {
            SOUNDS.Play("magma1");
         }
         else
         {
            SOUNDS.Play("magma2");
         }
         var _loc2_:Number = 0.5 + 0.5 / _hpMax.Get() * _hp.Get();
         var _loc3_:Number = 1;
         if(Boolean(GLOBAL._towerOverdrive) && GLOBAL._towerOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc3_ = 1.25;
         }
         FIREBALLS.Spawn2(new Point(_mc.x,_mc.y + _top),null,param1,_speed,int(_damage * _loc2_ * _loc3_),_splash,FIREBALLS.TYPE_MAGMA);
      }
      
      override public function Description() : *
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super.Description();
         _upgradeDescription = "";
         if(_lvl.Get() > 0 && _lvl.Get() < _buildingProps.costs.length)
         {
            _loc1_ = _buildingProps.stats[_lvl.Get() - 1];
            _loc2_ = _buildingProps.stats[_lvl.Get()];
            _loc3_ = int(_loc1_.range);
            _loc4_ = int(_loc2_.range);
            if(BASE._yardType == BASE.OUTPOST)
            {
               _loc3_ = BTOWER.AdjustTowerRange(GLOBAL._currentCell,_loc3_);
               _loc4_ = BTOWER.AdjustTowerRange(GLOBAL._currentCell,_loc4_);
            }
            if(_loc1_.range < _loc2_.range)
            {
               _upgradeDescription += KEYS.Get("building_rangeincrease",{
                  "v1":_loc3_,
                  "v2":_loc4_
               }) + "<br>";
            }
            if(_loc1_.damage < _loc2_.damage)
            {
               _upgradeDescription += KEYS.Get("building_dpsincrease",{
                  "v1":_loc1_.damage,
                  "v2":_loc2_.damage
               }) + "<br>";
            }
            if(_lvl.Get() > 1)
            {
               _upgradeDescription += KEYS.Get("building_sfpsincrease",{
                  "v1":this._targetArray[_lvl.Get() - 1],
                  "v2":this._targetArray[_lvl.Get()]
               }) + "<br>";
            }
         }
      }
      
      override public function Setup(param1:Object) : *
      {
         param1.t = _type;
         super.Setup(param1);
         Props();
      }
   }
}

