package
{
   import com.monsters.effects.ResourceBombs;
   import flash.events.*;
   import flash.geom.Point;
   
   public class DROPZONE extends DROPZONE_CLIP
   {
      public static const GROUND:int = 1;
      
      public static const BUILDINGS:int = 2;
      
      public static const MONSTERS:int = 3;
      
      public var _size:int;
      
      public var _middle:Point = new Point(0,0);
      
      public var _dropTarget:int = 1;
      
      public function DROPZONE(param1:int = 32, param2:int = 1)
      {
         super();
         this._size = param1;
         this._dropTarget = param2;
         ring1.addEventListener(MouseEvent.MOUSE_UP,this.Place);
         ring1.addEventListener(MouseEvent.MOUSE_DOWN,MAP.Click);
         ring1.mouseEnabled = true;
         ring1.buttonMode = true;
         addEventListener(Event.ENTER_FRAME,this.Follow);
         ring1.gotoAndStop(1);
         this.Update(this._size,param2);
      }
      
      public function Update(param1:int, param2:int) : *
      {
         this._size = param1;
         this._dropTarget = param2;
         ring1.width = this._size * 1.2;
         ring1.height = this._size * 1.2 * 0.5;
      }
      
      public function Place(param1:MouseEvent) : *
      {
         if(!MAP._dragged && ATTACK._countdown >= 0)
         {
            this.Drop();
         }
      }
      
      public function Follow(param1:Event = null) : *
      {
         if(MAP._GROUND)
         {
            x = MAP._GROUND.mouseX;
            y = MAP._GROUND.mouseY;
            if(this._dropTarget == GROUND)
            {
               if(BASE.BuildingOverlap(new Point(x,y),this._size,true,true,true))
               {
                  ring1.gotoAndStop(2);
               }
               else
               {
                  ring1.gotoAndStop(1);
               }
            }
            else if(this._dropTarget == BUILDINGS)
            {
               if(BASE.BuildingOverlap(new Point(x,y),this._size,true,true,true))
               {
                  ring1.gotoAndStop(1);
               }
               else
               {
                  ring1.gotoAndStop(2);
               }
            }
            else if(this._dropTarget == MONSTERS)
            {
               if(CREEPS.CreepOverlap(new Point(x,y),this._size))
               {
                  ring1.gotoAndStop(1);
               }
               else
               {
                  ring1.gotoAndStop(2);
               }
            }
         }
      }
      
      public function Drop() : *
      {
         switch(this._dropTarget)
         {
            case GROUND:
               if(!BASE.BuildingOverlap(new Point(x,y),this._size,true,true,true))
               {
                  ATTACK.Spawn(new Point(x,y),this._size / 2);
               }
               break;
            case BUILDINGS:
               if(BASE.BuildingOverlap(new Point(x,y),this._size,true,true,true))
               {
                  ResourceBombs.BombDrop();
               }
               break;
            case MONSTERS:
               if(CREEPS.CreepOverlap(new Point(x,y),this._size))
               {
                  ResourceBombs.BombDrop();
                  break;
               }
         }
      }
   }
}

