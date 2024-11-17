package com.monsters.frontPage.messages
{
   public class KeywordMessage extends Message
   {
      public static const PREFIX:String = "fp_";
      
      protected var _keyword:String;
      
      public function KeywordMessage(param1:String, param2:String = null)
      {
         this._keyword = param1;
         super(PREFIX + this._keyword + "_title",PREFIX + this._keyword,PREFIX + param1 + ".jpg",param2,videoURL);
         name = this._keyword;
      }
      
      public static function getImageURLFromKeyword(param1:String) : String
      {
         return _IMAGE_DIRECTORY + PREFIX + param1 + ".jpg";
      }
   }
}

