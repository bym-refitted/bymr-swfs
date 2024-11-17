package com.monsters.components.statusEffects
{
   import com.monsters.display.SpriteData;
   import com.monsters.display.SpriteSheetAnimation;
   
   public class VenomEffect extends CStatusEffect
   {
      private var _initialDPS:Number = 0;
      
      private var _numRenews:int = 1;
      
      public function VenomEffect(param1:CreepBase, param2:Number = 0)
      {
         super(param1);
         this._initialDPS = _dps = param2;
         SPRITES.SetupSprite("venom");
         _icon = new SpriteSheetAnimation(SPRITES.GetSpriteDescriptor("venom") as SpriteData,1);
         _icon.play();
      }
      
      override public function tick(param1:int = 1) : Boolean
      {
         super.tick(param1);
         return true;
      }
      
      override protected function updateDPS(param1:int) : void
      {
         super.updateDPS(param1);
         this._numRenews = 0;
      }
      
      override public function renew() : void
      {
         ++this._numRenews;
         _dps = this._initialDPS * this._numRenews;
      }
   }
}

