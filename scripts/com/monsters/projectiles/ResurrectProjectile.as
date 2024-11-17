package com.monsters.projectiles
{
   import com.monsters.display.SpriteData;
   import com.monsters.interfaces.IAttackable;
   import com.monsters.interfaces.ITargetable;
   import flash.display.IBitmapDrawable;
   
   public class ResurrectProjectile extends Projectilev2
   {
      public static const k_resurecctProjectile:String = "resurrectProjectile";
      
      public static const k_projectileImageURL:String = "monsters/projectiles/rezghul_projectile.png";
      
      private static const k_projectileSpeed:uint = 2;
      
      public function ResurrectProjectile()
      {
         super();
      }
      
      override public function setup(param1:IBitmapDrawable, param2:Number, param3:Number, param4:ITargetable, param5:Number, param6:Number = 0, param7:IAttackable = null, ... rest) : void
      {
         param5 = k_projectileSpeed;
         param1 = SpriteData(SPRITES.GetSpriteDescriptor(k_resurecctProjectile)).sprite;
         if(!param1)
         {
            param1 = ProjectileUtils.getFireballBitmapData();
         }
         super.setup(param1,param2,param3,param4,param5,param6,param7,rest);
      }
   }
}

