package com.monsters.components.statusEffects
{
   import com.monsters.components.Component;
   import com.monsters.display.SpriteSheetAnimation;
   
   public class CStatusEffect extends Component
   {
      protected static const _MAGIC_PADDING:* = 5;
      
      protected static const _MAX_TICKS:int = 40;
      
      protected var _icon:SpriteSheetAnimation;
      
      protected var _priority:int = 0;
      
      protected var _dps:Number;
      
      protected var _target:CreepBase;
      
      protected var _curLife:int;
      
      protected var _curTick:int;
      
      public function CStatusEffect(param1:CreepBase)
      {
         super();
         this._target = param1;
      }
      
      public function get icon() : SpriteSheetAnimation
      {
         return this._icon;
      }
      
      override protected function onRegister() : void
      {
         this._target.addChild(this._icon);
         this._priority = -1;
         var _loc1_:int = 0;
         while(_loc1_ < this._target._components.length)
         {
            if(this._target._components[_loc1_] is CStatusEffect)
            {
               ++this._priority;
            }
            _loc1_++;
         }
      }
      
      override protected function onUnregister() : void
      {
         this._target.removeChild(this._icon);
         destoy();
      }
      
      override public function tick(param1:int = 1) : Boolean
      {
         if(this._target._health.Get() <= 0)
         {
            owner.removeComponent(this);
         }
         this._curTick += param1;
         if(this._curTick >= _MAX_TICKS)
         {
            this._curTick -= _MAX_TICKS;
            this.updateDPS(param1);
         }
         this.updatePosition();
         if(this._icon)
         {
            this._icon.update();
         }
         return true;
      }
      
      protected function updatePosition() : void
      {
         this._icon.x = -this._icon.width / 2;
         if(this._priority % 2)
         {
            this._icon.x += int(this._priority / 2 + 1) * (this._icon.width + _MAGIC_PADDING);
         }
         else
         {
            this._icon.x -= this._priority / 2 * (this._icon.width + _MAGIC_PADDING);
         }
         this._icon.y = this._target._graphicMC.y - this._icon.height;
      }
      
      public function renew() : void
      {
         this._curLife = 0;
      }
      
      protected function updateDPS(param1:int) : void
      {
         this._target._health.Add(-this._dps);
      }
      
      public function setDPS(param1:Number) : void
      {
         this._dps = param1;
      }
   }
}

