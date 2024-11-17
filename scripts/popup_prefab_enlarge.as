package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   
   public class popup_prefab_enlarge extends popup_prefab_enlarge_CLIP
   {
      public function popup_prefab_enlarge()
      {
         super();
      }
      
      public function Setup(param1:int) : *
      {
         ImageCache.GetImageWithCallBack("ui/prefab-large-" + param1 + ".jpg",this.ShowImage,true,1);
         x = 450;
         y = 250;
      }
      
      public function ShowImage(param1:String, param2:BitmapData) : *
      {
         this.mcImage.addChild(new Bitmap(param2));
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         GLOBAL.BlockerRemove();
         this.parent.removeChild(this);
      }
   }
}

