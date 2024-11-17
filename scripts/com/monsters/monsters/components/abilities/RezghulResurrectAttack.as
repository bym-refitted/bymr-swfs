package com.monsters.monsters.components.abilities
{
   import com.monsters.events.ProjectileEvent;
   import com.monsters.interfaces.ITargetable;
   import com.monsters.monsters.MonsterBase;
   import com.monsters.projectiles.Projectilev2;
   import flash.geom.Point;
   
   public class RezghulResurrectAttack extends RangedAttack
   {
      private var m_zombiefy:Zombiefy;
      
      private var m_resurrectRange:uint;
      
      public function RezghulResurrectAttack(param1:uint, param2:int, param3:int, param4:uint, param5:Projectilev2, param6:Zombiefy)
      {
         super(param1,param2,param3,param5);
         this.m_zombiefy = param6;
         this.m_resurrectRange = param4;
      }
      
      override protected function getValidTargetsInRange(param1:uint, param2:Point, param3:int) : Vector.<ITargetable>
      {
         var _loc4_:Vector.<ITargetable> = null;
         var _loc5_:Array = Targeting.getDeadCreeps(param2,param1,param3);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(!_loc4_)
            {
               _loc4_ = new Vector.<ITargetable>();
            }
            _loc4_.push(_loc5_[_loc6_].creep);
            _loc6_++;
         }
         return _loc4_;
      }
      
      override protected function fireAt(param1:ITargetable) : Projectilev2
      {
         var _loc2_:Projectilev2 = super.fireAt(param1);
         _loc2_.addEventListener(ProjectileEvent.k_hit,this.onProjectileHit,false,0,true);
         return _loc2_;
      }
      
      protected function onProjectileHit(param1:ProjectileEvent) : void
      {
         var _loc2_:Projectilev2 = param1.target as Projectilev2;
         _loc2_.removeEventListener(ProjectileEvent.k_hit,this.onProjectileHit);
         this.resurrectAlliesInArea(_loc2_);
      }
      
      private function resurrectAlliesInArea(param1:Projectilev2) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ITargetable = null;
         var _loc2_:Vector.<ITargetable> = this.getValidTargetsInRange(this.m_resurrectRange,new Point(param1.x,param1.y),m_targetFlags);
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_];
               if(_loc4_ is MonsterBase)
               {
                  this.resurrect(_loc4_ as MonsterBase);
               }
               _loc3_++;
            }
         }
      }
      
      private function resurrect(param1:MonsterBase) : void
      {
         var _loc2_:MonsterBase = null;
         if(owner._friendly)
         {
            _loc2_ = CREATURES.Spawn(param1._creatureID,MAP._BUILDINGTOPS,param1._behaviour,new Point(param1.x,param1.y),param1._targetRotation,null,param1._house);
         }
         else
         {
            _loc2_ = CREEPS.Spawn(param1._creatureID,MAP._BUILDINGTOPS,param1._behaviour,new Point(param1.x,param1.y),param1._targetRotation,1,false,true);
         }
         GIBLETS.Create(new Point(param1.x,param1.y),1,75,20);
         _loc2_.findTarget(_loc2_._targetGroup);
         _loc2_.addComponent(this.m_zombiefy.clone());
         param1.corpseDeath();
      }
   }
}

