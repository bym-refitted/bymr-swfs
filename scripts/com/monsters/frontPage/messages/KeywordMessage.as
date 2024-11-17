package com.monsters.frontPage.messages
{
   public class KeywordMessage extends Message
   {
      protected const _PREFIX:String = "fp_";
      
      protected var _keyword:String;
      
      public function KeywordMessage(param1:String, param2:String = null)
      {
         this._keyword = param1;
         super(this._PREFIX + this._keyword + "_title",this._PREFIX + this._keyword,this._PREFIX + this._keyword + ".jpg",param2,videoURL);
         name = this._keyword;
      }
   }
}

