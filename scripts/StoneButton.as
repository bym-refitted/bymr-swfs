package
{
   import com.monsters.display.ImageCache;
   import com.monsters.display.ImageText;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.bytearray.display.ScaleBitmap;
   
   public class StoneButton extends Sprite
   {
      public static var _bgKeys:Array = [{
         "key":"ui/stone1.png",
         "width":54,
         "height":36
      },{
         "key":"ui/stone2.png",
         "width":59,
         "height":36
      },{
         "key":"ui/stone3.png",
         "width":79,
         "height":36
      }];
      
      public var _enabled:Boolean = true;
      
      public var _bmd:BitmapData;
      
      public var _bm:Bitmap;
      
      public var label:String;
      
      public var size:int;
      
      public var _alert:String = "";
      
      public var spinnerInset:int = 7;
      
      public var alertMC:button_alert;
      
      private var _tgtWidth:int;
      
      public var margin:int = 12;
      
      public function StoneButton()
      {
         super();
      }
      
      public function getButtonWidth() : int
      {
         return this._tgtWidth;
      }
      
      public function getButtonHeight() : int
      {
         return this._bm.height;
      }
      
      public function set Enabled(param1:Boolean) : void
      {
         if(param1 != this._enabled)
         {
            this._enabled = param1;
            this.Clear();
            if(Boolean(this.label) && Boolean(this.size))
            {
               this.Setup(this.label,this.size);
            }
         }
      }
      
      public function get Enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set Alert(param1:String) : void
      {
         if(param1 != "" && param1 != "0")
         {
            this._alert = param1;
            if(!this.alertMC)
            {
               this.alertMC = new button_alert();
               addChild(this.alertMC);
               this.alertMC.mouseChildren = false;
            }
            else
            {
               setChildIndex(this.alertMC,this.numChildren - 1);
            }
            this.alertMC.x = this.getButtonWidth() - this.spinnerInset;
            this.alertMC.y = this.spinnerInset;
            this.alertMC.mcCounter.t.htmlText = param1;
         }
         else if(this.alertMC)
         {
            removeChild(this.alertMC);
            this.alertMC = null;
            this._alert = "";
         }
      }
      
      public function get Alert() : String
      {
         return this._alert;
      }
      
      public function Clear() : void
      {
         if(Boolean(this._bmd) && Boolean(this._bm))
         {
            if(this._bm.parent)
            {
               removeChild(this._bm);
            }
            this._bmd.dispose();
         }
      }
      
      public function SetupKey(param1:String, param2:int = 12) : void
      {
         this.Setup(KEYS.Get(param1),param2);
      }
      
      public function Setup(param1:String, param2:int = 12) : void
      {
         var tgt:int;
         var tgtDiff:int;
         var i:int;
         var tx:BitmapData = null;
         var cbf:Function = null;
         var ct:ColorTransform = null;
         var nd:int = 0;
         var str:String = param1;
         var sz:int = param2;
         cbf = function(param1:String, param2:BitmapData):void
         {
            var _loc3_:BitmapData = new BitmapData(param2.width,param2.height,true,0);
            _loc3_.copyPixels(param2,new Rectangle(0,0,param2.width,param2.height),new Point(0,0));
            var _loc4_:Number = _tgtWidth / _loc3_.width;
            var _loc5_:ScaleBitmap = new ScaleBitmap(_loc3_);
            _loc5_.scale9Grid = new Rectangle(10,10,10,10);
            _loc5_.setSize(_tgtWidth,36);
            _bmd = new BitmapData(_loc5_.width,_loc5_.height,true,0);
            _bmd.draw(_loc5_);
            var _loc6_:Matrix = new Matrix();
            _loc6_.translate(margin,2 + int(_loc5_.height * 0.5 - tx.height * 0.5));
            _bmd.draw(tx,_loc6_);
            _bm = new Bitmap(_bmd);
            addChild(_bm);
         };
         this.Clear();
         this.label = str;
         this.size = sz;
         if(this._enabled)
         {
            this.buttonMode = true;
            this.useHandCursor = true;
            if(this.alertMC)
            {
               this.alertMC.buttonMode = true;
               this.alertMC.useHandCursor = true;
            }
         }
         else
         {
            this.buttonMode = false;
            this.useHandCursor = false;
         }
         tx = ImageText.Get(str,sz);
         if(!this._enabled)
         {
            ct = new ColorTransform(1,1,1,0.5);
            tx.colorTransform(tx.rect,new ColorTransform(1,1,1,0.5));
         }
         tgt = 0;
         tgtDiff = -1;
         this._tgtWidth = tx.width + 2 * this.margin;
         i = 0;
         while(i < _bgKeys.length)
         {
            nd = this._tgtWidth - _bgKeys[i].width;
            if(nd < 0)
            {
               nd *= -1;
            }
            if(tgtDiff == -1 || nd < tgtDiff)
            {
               tgtDiff = nd;
               tgt = i;
            }
            i++;
         }
         ImageCache.GetImageWithCallBack(_bgKeys[tgt].key,cbf);
      }
   }
}

