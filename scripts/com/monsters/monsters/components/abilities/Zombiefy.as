package com.monsters.monsters.components.abilities
{
   import com.monsters.monsters.components.Component;
   import com.monsters.monsters.components.modifiers.ArmorPropertyModifier;
   import com.monsters.monsters.components.modifiers.DivisionModifier;
   import com.monsters.monsters.components.modifiers.MultiplicationPropertyModifier;
   import gs.TweenMax;
   
   public class Zombiefy extends Component
   {
      private var m_attackDelayModifier:DivisionModifier;
      
      private var m_moveSpeedModifier:MultiplicationPropertyModifier;
      
      private var m_damageModifier:MultiplicationPropertyModifier;
      
      private var m_armorModifier:ArmorPropertyModifier;
      
      public function Zombiefy(param1:Number, param2:uint, param3:Number)
      {
         super();
         this.m_attackDelayModifier = new DivisionModifier(param1);
         this.m_moveSpeedModifier = new MultiplicationPropertyModifier(param1);
         this.m_damageModifier = new MultiplicationPropertyModifier(param3);
         this.m_armorModifier = new ArmorPropertyModifier(param2);
      }
      
      override protected function onRegister() : void
      {
         owner.attackDelayProperty.addModifier(this.m_attackDelayModifier);
         owner.moveSpeedProperty.addModifier(this.m_moveSpeedModifier);
         owner.armorProperty.addModifier(this.m_armorModifier);
         owner.damageProperty.addModifier(this.m_damageModifier);
         TweenMax.to(owner._graphicMC,1,{"colorMatrixFilter":{"saturation":0}});
         owner.isDisposable = true;
      }
      
      override protected function onUnregister() : void
      {
         owner.attackDelayProperty.removeModifier(this.m_attackDelayModifier);
         owner.moveSpeedProperty.removeModifier(this.m_moveSpeedModifier);
         owner.armorProperty.removeModifier(this.m_armorModifier);
         owner.damageProperty.removeModifier(this.m_damageModifier);
         TweenMax.to(owner._graphicMC,1,{"colorMatrixFilter":{"saturation":1}});
      }
      
      override public function clone() : Component
      {
         return new Zombiefy(this.m_moveSpeedModifier.multiple,this.m_armorModifier.multiple,this.m_damageModifier.multiple);
      }
   }
}

