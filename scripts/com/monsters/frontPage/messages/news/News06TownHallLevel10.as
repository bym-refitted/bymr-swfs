package com.monsters.frontPage.messages.news
{
   import com.monsters.frontPage.messages.KeywordMessage;
   
   public class News06TownHallLevel10 extends KeywordMessage
   {
      public function News06TownHallLevel10()
      {
         super("townhall10","btn_upgradenow");
      }
      
      override protected function onButtonClick() : void
      {
         POPUPS.Next();
         BUILDINGOPTIONS.Show(GLOBAL._bTownhall,"upgrade");
      }
      
      override public function get areRequirementsMet() : Boolean
      {
         return GLOBAL._bTownhall._lvl.Get() == 9;
      }
   }
}

