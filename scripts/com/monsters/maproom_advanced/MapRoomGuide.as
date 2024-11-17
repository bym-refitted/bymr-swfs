package com.monsters.maproom_advanced
{
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class MapRoomGuide extends MapRoomGuide_CLIP
   {
      private var _page:int = 1;
      
      private var _keys:Array;
      
      public function MapRoomGuide()
      {
         super();
         bContinue.SetupKey("btn_continue");
         bContinue.addEventListener(MouseEvent.CLICK,this.Next);
         this._keys = [KEYS.Get("newmap_g1"),KEYS.Get("newmap_g2"),KEYS.Get("newmap_g3"),KEYS.Get("newmap_g4"),KEYS.Get("newmap_g5"),KEYS.Get("newmap_g6")];
         this.tMessage.autoSize = TextFieldAutoSize.LEFT;
         this.x = 380;
         this.y = 250;
         this.Update();
      }
      
      private function Update() : *
      {
         if(this._page > this._keys.length)
         {
            this.Hide();
         }
         else
         {
            this.tMessage.htmlText = this._keys[this._page - 1];
            this.mcFrame.height = this.tMessage.height + 75;
            this.mcFrame.y = 0 - int(this.mcFrame.height / 2);
            this.tMessage.y = this.mcFrame.y + 20;
            this.bContinue.y = this.mcFrame.y + this.mcFrame.height - 40;
            this.mcFrame.Setup();
         }
      }
      
      private function Next(param1:MouseEvent = null) : *
      {
         this._page += 1;
         this.Update();
      }
      
      public function Hide() : *
      {
         GLOBAL.BlockerRemove();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

