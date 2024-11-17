package
{
   import com.monsters.display.ImageCache;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class SPRITES
   {
      public static var _sprites:Object;
      
      public function SPRITES()
      {
         super();
      }
      
      public static function Setup() : *
      {
         _sprites = {};
         _sprites.worker = {
            "key":"monsters/worker.png",
            "sprite":null,
            "width":27,
            "height":27,
            "middle":new Point(9,19)
         };
         _sprites.C1 = {
            "key":"monsters/sprite.1.v1.png",
            "sprite":null,
            "width":24,
            "height":21,
            "middle":new Point(8,14)
         };
         _sprites.C2 = {
            "key":"monsters/octoooze.png",
            "sprite":null,
            "width":39,
            "height":28,
            "middle":new Point(19,15)
         };
         _sprites.C3 = {
            "key":"monsters/sprite.3.v2.png",
            "sprite":null,
            "width":30,
            "height":28,
            "middle":new Point(7,20)
         };
         _sprites.C4 = {
            "key":"monsters/fink.png",
            "sprite":null,
            "width":34,
            "height":32,
            "middle":new Point(15,21)
         };
         _sprites.C5 = {
            "key":"monsters/eyera.png",
            "sprite":null,
            "width":26,
            "height":23,
            "middle":new Point(11,15)
         };
         _sprites.C6 = {
            "key":"monsters/ichi.png",
            "sprite":null,
            "width":27,
            "height":26,
            "middle":new Point(11,17)
         };
         _sprites.C7 = {
            "key":"monsters/bandito.png",
            "sprite":null,
            "width":29,
            "height":28,
            "middle":new Point(11,17)
         };
         _sprites.C8 = {
            "key":"monsters/fang.png",
            "sprite":null,
            "width":34,
            "height":31,
            "middle":new Point(16,19)
         };
         _sprites.C9 = {
            "key":"monsters/brain.v2.png",
            "sprite":null,
            "width":34,
            "height":24,
            "middle":new Point(16,13)
         };
         _sprites.C10 = {
            "key":"monsters/crabatron.png",
            "sprite":null,
            "width":37,
            "height":27,
            "middle":new Point(15,18)
         };
         _sprites.C11 = {
            "key":"monsters/sprite.11.v2.png",
            "sprite":null,
            "width":48,
            "height":35,
            "middle":new Point(24,22)
         };
         _sprites.C12 = {
            "key":"monsters/sprite.12.v2.png",
            "sprite":null,
            "width":53,
            "height":46,
            "middle":new Point(21,27)
         };
         _sprites.C13 = {
            "key":"monsters/13.png",
            "sprite":null,
            "width":40,
            "height":26,
            "middle":new Point(19,17)
         };
         _sprites.C14 = {
            "key":"monsters/14.v1.png",
            "sprite":null,
            "width":28,
            "height":28,
            "middle":new Point(15,14)
         };
         _sprites.C15 = {
            "key":"monsters/zafreeti.v2.png",
            "sprite":null,
            "width":56,
            "height":70,
            "middle":new Point(28,35)
         };
         _sprites.G1_1 = {
            "key":"monsters/ape_1.png",
            "sprite":null,
            "width":96,
            "height":69,
            "middle":new Point(26,36)
         };
         _sprites.G1_2 = {
            "key":"monsters/ape_2.png",
            "sprite":null,
            "width":89,
            "height":73,
            "middle":new Point(26,36)
         };
         _sprites.G1_3 = {
            "key":"monsters/ape_3.png",
            "sprite":null,
            "width":103,
            "height":88,
            "middle":new Point(26,36)
         };
         _sprites.G1_4 = {
            "key":"monsters/ape_4.png",
            "sprite":null,
            "width":148,
            "height":127,
            "middle":new Point(26,36)
         };
         _sprites.G1_5 = {
            "key":"monsters/ape_5.png",
            "sprite":null,
            "width":160,
            "height":137,
            "middle":new Point(26,36)
         };
         _sprites.G1_6 = {
            "key":"monsters/ape_6.png",
            "sprite":null,
            "width":140,
            "height":2 * 60,
            "middle":new Point(26,36)
         };
         _sprites.G2_1 = {
            "key":"monsters/dragon_1.png",
            "sprite":null,
            "width":64,
            "height":41,
            "middle":new Point(26,36)
         };
         _sprites.G2_2 = {
            "key":"monsters/dragon_2.png",
            "sprite":null,
            "width":87,
            "height":58,
            "middle":new Point(26,36)
         };
         _sprites.G2_3 = {
            "key":"monsters/dragon_3.png",
            "sprite":null,
            "width":114,
            "height":85,
            "middle":new Point(26,36)
         };
         _sprites.G2_4 = {
            "key":"monsters/dragon_4.png",
            "sprite":null,
            "width":131,
            "height":93,
            "middle":new Point(26,36)
         };
         _sprites.G2_5 = {
            "key":"monsters/dragon_5.png",
            "sprite":null,
            "width":156,
            "height":117,
            "middle":new Point(26,36)
         };
         _sprites.G2_6 = {
            "key":"monsters/dragon_6.png",
            "sprite":null,
            "width":171,
            "height":125,
            "middle":new Point(26,36)
         };
         _sprites.G3_1 = {
            "key":"monsters/fly_1.png",
            "sprite":null,
            "width":53,
            "height":40,
            "middle":new Point(26,36)
         };
         _sprites.G3_2 = {
            "key":"monsters/fly_2.png",
            "sprite":null,
            "width":63,
            "height":46,
            "middle":new Point(26,36)
         };
         _sprites.G3_3 = {
            "key":"monsters/fly_3.png",
            "sprite":null,
            "width":98,
            "height":81,
            "middle":new Point(26,36)
         };
         _sprites.G3_4 = {
            "key":"monsters/fly_4.png",
            "sprite":null,
            "width":2 * 60,
            "height":92,
            "middle":new Point(26,36)
         };
         _sprites.G3_5 = {
            "key":"monsters/fly_5.png",
            "sprite":null,
            "width":133,
            "height":105,
            "middle":new Point(26,36)
         };
         _sprites.G3_6 = {
            "key":"monsters/fly_6.png",
            "sprite":null,
            "width":124,
            "height":105,
            "middle":new Point(26,36)
         };
         _sprites.C200 = {
            "key":"monsters/looter.png",
            "sprite":null,
            "width":51,
            "height":47,
            "middle":new Point(7,33)
         };
         _sprites.shadow = {
            "key":"monsters/flyingshadow.png",
            "sprite":null,
            "width":31,
            "height":20,
            "middle":new Point(15,10)
         };
         _sprites.bigshadow = {
            "key":"monsters/zafreeti-shadow.png",
            "sprite":null,
            "width":48,
            "height":32,
            "middle":new Point(24,16)
         };
      }
      
      public static function Clear() : void
      {
         _sprites = null;
      }
      
      public static function SetupSprite(param1:String) : void
      {
         ImageCache.GetImageWithCallBack(_sprites[param1].key,onAssetLoaded);
      }
      
      public static function GetSpriteDescriptor(param1:String) : Object
      {
         return _sprites[param1];
      }
      
      private static function onAssetLoaded(param1:String, param2:BitmapData) : void
      {
         var _loc3_:Object = null;
         for each(_loc3_ in _sprites)
         {
            if(_loc3_.key == param1)
            {
               _loc3_.sprite = param2;
            }
         }
      }
      
      public static function GetSprite(param1:BitmapData, param2:String, param3:String, param4:int, param5:int = 0, param6:int = -1) : int
      {
         var _loc7_:String = null;
         if(!GLOBAL._render)
         {
            return -1;
         }
         if(param4 < 0)
         {
            param4 = 6 * 60 + param4;
         }
         if(param2 == "worker")
         {
            if(STORE._storeData.BST)
            {
               if(param6 != param4 / 12)
               {
                  GetFrame(param1,_sprites.worker,param4 / 12,1);
               }
               return param4 / 12 + 30;
            }
            if(param6 != param4 / 12)
            {
               GetFrame(param1,_sprites.worker,param4 / 12,0);
            }
         }
         if(param2 == "C1")
         {
            if(param6 != param4 / 12)
            {
               GetFrame(param1,_sprites.C1,param4 / 12);
            }
            return param4 / 12;
         }
         if(param2 == "C2")
         {
            if(param6 != param4 / 12)
            {
               GetFrame(param1,_sprites.C2,param4 / 12);
            }
            return param4 / 12;
         }
         if(param2 == "C3")
         {
            if(param6 != param4 / 12)
            {
               GetFrame(param1,_sprites.C3,param4 / 12);
            }
            return param4 / 12;
         }
         if(param2 == "C4")
         {
            if(param6 != param4 / 12)
            {
               GetFrame(param1,_sprites.C4,param4 / 12);
            }
            return param4 / 12;
         }
         if(param2 == "C5")
         {
            if(param6 != param4 / 12)
            {
               GetFrame(param1,_sprites.C5,param4 / 12);
            }
            return param4 / 12;
         }
         if(param2 == "C6")
         {
            if(param6 != param4 / 12)
            {
               GetFrame(param1,_sprites.C6,param4 / 12);
            }
            return param4 / 12;
         }
         if(param2 == "C7")
         {
            if(param6 != param4 / 12)
            {
               GetFrame(param1,_sprites.C7,param4 / 12);
            }
            return param4 / 12;
         }
         if(param2 == "C8")
         {
            if(param6 != param4 / 12)
            {
               GetFrame(param1,_sprites.C8,param4 / 12);
            }
            return param4 / 12;
         }
         if(param2 == "C9")
         {
            if(param3 == "invisible")
            {
               if(param6 != param4 / 12 + 30)
               {
                  GetFrame(param1,_sprites.C9,param4 / 12,1);
               }
               return param4 / 12 + 30;
            }
            if(param6 != param4 / 12)
            {
               GetFrame(param1,_sprites.C9,param4 / 12,0);
            }
            return param4 / 12;
         }
         if(param2 == "C10")
         {
            if(param6 != param4 / 12)
            {
               GetFrame(param1,_sprites.C10,param4 / 12);
            }
            return param4 / 12;
         }
         if(param2 == "C11")
         {
            if(param6 != param4 / 12)
            {
               GetFrame(param1,_sprites.C11,param4 / 12);
            }
            return param4 / 12;
         }
         if(param2 == "C12")
         {
            if(param6 != param4 * 0.083333333)
            {
               GetFrame(param1,_sprites.C12,param4 * 0.083333333);
            }
            return param4 * 0.083333333;
         }
         if(param2 == "C13")
         {
            if(param3 == "walking")
            {
               if(param6 != param4 / 12)
               {
                  GetFrame(param1,_sprites.C13,param4 / 12);
               }
               return param4 / 12;
            }
            if(param3 == "burrowed")
            {
               if(param6 != 33)
               {
                  GetFrame(param1,_sprites.C13,param4 / 12,4);
               }
               return 33;
            }
            if(param3 == "transition")
            {
               if(param6 != 34)
               {
                  GetFrame(param1,_sprites.C13,param4 / 12,param5);
               }
               return 34;
            }
         }
         if(param2 == "C14")
         {
            if(param6 != param4 / 11.25 + param5 % 9 / 3 * 32)
            {
               GetFrame(param1,_sprites.C14,int(param4 / 11.25),param5 % 9 / 3);
            }
            return param4 / 11.25 + param5 % 9 / 3 * 32;
         }
         if(param2 == "C15")
         {
            if(param6 != param4 / 11.25)
            {
               GetFrame(param1,_sprites.C15,int(param4 / 11.25));
            }
            return param4 / 11.25;
         }
         if(param2.substr(0,2) == "G1" || param2.substr(0,2) == "G2")
         {
            if(_sprites[param2])
            {
               if(param3 == "idle")
               {
                  GetFrame(param1,_sprites[param2],int(param4 / 22.5));
               }
               else if(param3 == "walking")
               {
                  GetFrame(param1,_sprites[param2],int(param4 / 22.5),param5 / 8 % 7 + 1);
               }
               else if(param3 == "attack")
               {
                  _loc7_ = param2.substr(3,1);
                  if(_loc7_ == "4" || _loc7_ == "5" || _loc7_ == "6")
                  {
                     GetFrame(param1,_sprites[param2],int(param4 / 22.5),param5 / 8 % 8 + 8);
                  }
                  else
                  {
                     GetFrame(param1,_sprites[param2],int(param4 / 22.5),param5 / 8 % 7 + 8);
                  }
               }
            }
         }
         if(param2.substr(0,2) == "G3")
         {
            if(_sprites[param2])
            {
               if(param3 == "idle")
               {
                  GetFrame(param1,_sprites[param2],int(param4 / 22.5));
               }
               else
               {
                  _loc7_ = param2.substr(3,1);
                  if(_loc7_ == "1")
                  {
                     GetFrame(param1,_sprites[param2],int(param4 / 22.5),param5 / 8 % 7 + 1);
                  }
                  else if(_loc7_ == "2")
                  {
                     GetFrame(param1,_sprites[param2],int(param4 / 22.5),param5 / 8 % 8 + 1);
                  }
                  else
                  {
                     GetFrame(param1,_sprites[param2],int(param4 / 22.5),param5 / 8 % 6 + 1);
                  }
               }
            }
         }
         if(param2 == "shadow")
         {
            GetFrame(param1,_sprites.shadow,0);
         }
         if(param2 == "bigshadow")
         {
            GetFrame(param1,_sprites.bigshadow,0);
         }
         if(param2 == "C200")
         {
            if(param3 == "empty")
            {
               GetFrame(param1,_sprites.C200,param4 / 12);
            }
            else
            {
               GetFrame(param1,_sprites.C200,param4 / 12,1);
            }
         }
         return 0;
      }
      
      public static function GetFrame(param1:BitmapData, param2:Object, param3:int, param4:int = 0) : void
      {
         var _loc5_:Point = new Point(26,36);
         if(param2)
         {
            _loc5_.x -= param2.middle.x;
            _loc5_.y -= param2.middle.y;
            if(param2.sprite)
            {
               param1.copyPixels(param2.sprite,new Rectangle(param2.width * param3,param2.height * param4,param2.width,param2.height),_loc5_);
            }
         }
      }
   }
}

