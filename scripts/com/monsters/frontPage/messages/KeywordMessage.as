package com.monsters.frontPage.messages
{
   public class KeywordMessage extends Message
   {
      public static const PREFIX:String = "fp_";
      
      protected var _keyword:String;
      
      public function KeywordMessage(param1:String, param2:String = null)
      {
         this._keyword = param1;
         super(PREFIX + this._keyword + "_title",PREFIX + this._keyword,PREFIX + this._keyword + ".jpg",param2,videoURL);
         name = this._keyword;
      }
   }
}

