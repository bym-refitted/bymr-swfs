package com.monsters.monsters.creeps
{
   import com.monsters.interfaces.ITargetable;
   import com.monsters.monsters.MonsterBase;
   import com.monsters.monsters.components.abilities.RezghulResurrectAttack;
   import com.monsters.monsters.components.abilities.Zombiefy;
   import com.monsters.projectiles.ProjectileUtils;
   import com.monsters.projectiles.Projectilev2;
   import com.monsters.projectiles.ResurrectProjectile;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import org.kissmyas.utils.loanshark.LoanShark;
   
   public class Rezghul extends CreepBase
   {
      private static const k_projectileSpeed:uint = 3;
      
      private static const k_projectilePoolSize:uint = 4;
      
      private var m_projectilePool:LoanShark;
      
      public function Rezghul(param1:String, param2:String, param3:Point, param4:Number, param5:int = 0, param6:int = 2147483647, param7:Point = null, param8:Boolean = false, param9:BFOUNDATION = null, param10:Number = 1, param11:Boolean = false, param12:MonsterBase = null)
      {
         var _loc13_:Zombiefy = null;
         var _loc14_:ResurrectProjectile = null;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         SPRITES.SetupSprite(ResurrectProjectile.k_resurecctProjectile);
         this.m_projectilePool = new LoanShark(Projectilev2,true,k_projectilePoolSize);
         _loc13_ = new Zombiefy(0.5,0.5,1.5);
         _loc14_ = new ResurrectProjectile();
         var _loc15_:RezghulResurrectAttack = new RezghulResurrectAttack(5 * 60,6,Targeting.getFriendlyFlag(this) | Targeting.k_TARGETS_GROUND,50,_loc14_,_loc13_);
         addComponent(_loc15_);
      }
      
      override protected function rangedAttack(param1:ITargetable) : ITargetable
      {
         var _loc2_:Projectilev2 = this.m_projectilePool.borrowObject() as Projectilev2;
         _loc2_.setup(this.getProjectileBitmapData(),x,getDisplayY(),param1,k_projectileSpeed,damage,this);
         return _loc2_;
      }
      
      override public function die() : void
      {
         super.die();
         this.m_projectilePool.dispose();
      }
      
      private function getProjectileBitmapData() : BitmapData
      {
         return ProjectileUtils.getFomorballBitmapData();
      }
   }
}

