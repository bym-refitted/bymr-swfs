package
{
   import flash.events.*;
   import flash.text.TextFieldAutoSize;
   import gs.*;
   import gs.easing.*;
   
   public class MESSAGE extends MESSAGE_CLIP
   {
      public var _mc:*;
      
      public var _action:Function;
      
      public var _args:Array;
      
      public function MESSAGE()
      {
         super();
      }
      
      public function Show(param1:String = null, param2:String = null, param3:Function = null, param4:Array = null, param5:int = 1) : *
      {
         this._action = param3;
         this._args = param4;
         tMessage.autoSize = TextFieldAutoSize.CENTER;
         tMessage.htmlText = param1;
         mcBG.height = tMessage.height + 45;
         if(param2)
         {
            bAction.Setup(param2);
            bAction.addEventListener(MouseEvent.CLICK,this.Action);
            mcBG.height += 30;
         }
         else
         {
            bAction.visible = false;
         }
         mcBG.y = 0 - int(mcBG.height * 0.5);
         mcBG.Setup();
         tMessage.y = mcBG.y + 20;
         bAction.y = mcBG.y + mcBG.height - 45;
         GLOBAL.BlockerAdd(GLOBAL._layerTop);
         this._mc = GLOBAL._layerTop.addChild(this);
         this._mc.x = 380;
         this._mc.y = 260;
         this._mc.scaleY = 0.9;
         this._mc.scaleX = 0.9;
         TweenLite.to(this._mc,0.2,{
            "scaleX":1,
            "scaleY":1,
            "ease":Quad.easeOut
         });
      }
      
      public function Action(param1:MouseEvent) : *
      {
         this.Hide();
         if(Boolean(this._action))
         {
            if(!this._args)
            {
               this._action();
            }
            else if(this._args.length == 1)
            {
               this._action(this._args[0]);
            }
            else if(this._args.length == 2)
            {
               this._action(this._args[0],this._args[1]);
            }
            else if(this._args.length == 3)
            {
               this._action(this._args[0],this._args[1],this._args[2]);
            }
         }
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         GLOBAL.BlockerRemove();
         SOUNDS.Play("close");
         if(this._mc && Boolean(this._mc.parent))
         {
            GLOBAL._layerTop.removeChild(this._mc);
         }
         this._mc = null;
      }
   }
}

