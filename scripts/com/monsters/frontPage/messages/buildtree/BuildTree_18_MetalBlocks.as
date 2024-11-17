package com.monsters.frontPage.messages.buildtree
{
   import com.monsters.frontPage.FrontPageHandler;
   import com.monsters.frontPage.messages.KeywordMessage;
   
   public class BuildTree_18_MetalBlocks extends KeywordMessage
   {
      public function BuildTree_18_MetalBlocks()
      {
         super("blocks3","btn_buildnow");
      }
      
      override public function get areRequirementsMet() : Boolean
      {
         return GLOBAL._bTownhall._lvl.Get() >= 4 && BASE.hasNumBuildings(17,1) >= 1 && BASE.hasNumBuildings(17,3) <= 0;
      }
      
      override protected function onButtonClick() : void
      {
         FrontPageHandler.closeAll();
         if(BASE.isInferno())
         {
            STORE.ShowB(1,0,["BLK2I","BLK3I"]);
         }
         else
         {
            STORE.ShowB(1,0,["BLK2","BLK3","BLK4","BLK5"]);
         }
      }
   }
}

