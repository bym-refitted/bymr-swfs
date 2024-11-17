package
{
   import flash.events.MouseEvent;
   
   public class Checkbox extends CheckBox_CLIP
   {
      private var checked:Boolean = false;
      
      private var _enabled:Boolean = true;
      
      private var _over:Boolean = false;
      
      private var _down:Boolean = false;
      
      public function Checkbox()
      {
         super();
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onUp);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         stop();
      }
      
      private function onDown(param1:MouseEvent) : void
      {
         this._down = true;
         this.Update();
      }
      
      private function onUp(param1:MouseEvent) : void
      {
         this._down = false;
         if(this._enabled)
         {
            this.Checked = !this.checked;
         }
         this.Update();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(this._enabled)
         {
            this.Checked = !this.checked;
         }
      }
      
      private function onOver(param1:MouseEvent) : void
      {
         this._over = true;
         this.Update();
      }
      
      private function onOut(param1:MouseEvent) : void
      {
         this._over = false;
         this.Update();
      }
      
      public function Update() : void
      {
         if(this._enabled)
         {
            if(this._over)
            {
               gotoAndStop(this.checked ? 4 : 3);
            }
            else
            {
               gotoAndStop(this.checked ? 2 : 1);
            }
            if(this._down)
            {
               gotoAndStop(this.checked ? 8 : 7);
            }
         }
         else
         {
            gotoAndStop(this.checked ? 6 : 5);
         }
      }
      
      public function set Checked(param1:Boolean) : void
      {
         this.checked = param1;
         this.Update();
      }
      
      public function get Checked() : Boolean
      {
         return this.checked;
      }
      
      public function set Enabled(param1:Boolean) : void
      {
         this._enabled = param1;
         this.Update();
      }
      
      public function get Enabled() : Boolean
      {
         return this._enabled;
      }
   }
}

