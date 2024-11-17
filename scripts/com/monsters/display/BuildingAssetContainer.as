package com.monsters.display
{
   import flash.display.Sprite;
   
   public class BuildingAssetContainer extends Sprite
   {
      public function BuildingAssetContainer()
      {
         super();
         this.Clear();
      }
      
      public function Clear() : *
      {
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
   }
}

