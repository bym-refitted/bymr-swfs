package com.monsters.components.statusEffects
{
   import com.monsters.display.SpriteData;
   import com.monsters.display.SpriteSheetAnimation;
   
   public class DecoyEffect extends CStatusEffect
   {
      public function DecoyEffect(param1:CreepBase)
      {
         super(param1);
         _dps = 0;
         SPRITES.SetupSprite("heart");
         _icon = new SpriteSheetAnimation(SPRITES.GetSpriteDescriptor("heart") as SpriteData,1);
         _icon.play();
      }
   }
}

