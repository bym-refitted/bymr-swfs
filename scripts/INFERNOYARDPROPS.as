package
{
   import com.monsters.siege.SiegeFactory;
   import com.monsters.siege.SiegeLab;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class INFERNOYARDPROPS
   {
      public static const _infernoYardProps:Array = [{
         "id":1,
         "group":1,
         "order":1,
         "buildStatus":0,
         "type":"resource",
         "name":"#bi_boneharvester#",
         "size":100,
         "cycle":30,
         "attackgroup":1,
         "tutstage":0,
         "sale":0,
         "description":"bi_boneharvester_desc",
         "costs":[{
            "r1":0,
            "r2":750,
            "r3":0,
            "r4":0,
            "time":15,
            "re":[[14,1,1]]
         },{
            "r1":0,
            "r2":1575,
            "r3":0,
            "r4":0,
            "time":5 * 60,
            "re":[[14,1,1]]
         },{
            "r1":0,
            "r2":55 * 60,
            "r3":0,
            "r4":0,
            "time":20 * 60,
            "re":[[14,1,1]]
         },{
            "r1":0,
            "r2":6950,
            "r3":0,
            "r4":0,
            "time":60 * 60,
            "re":[[14,1,2]]
         },{
            "r1":0,
            "r2":14500,
            "r3":0,
            "r4":0,
            "time":2 * 60 * 60,
            "re":[[14,1,2]]
         },{
            "r1":0,
            "r2":0x7788,
            "r3":0,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":0,
            "r2":64300,
            "r3":0,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":0,
            "r2":135000,
            "r3":0,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":0,
            "r2":283600,
            "r3":0,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":0,
            "r2":10 * 60 * 1000,
            "r3":0,
            "r4":0,
            "time":3 * 24 * 60 * 60,
            "re":[[14,1,5]]
         }],
         "imageData":{
            "baseurl":"buildings/iboneharvester/",
            "1":{
               "anim":["anim.1.v2.png",new Rectangle(-32,-33,65,80),47],
               "top":["top.1.v2.png",new Point(-48,-33)],
               "shadow":["shadow.1.v4.jpg",new Point(-53,11)],
               "topdamaged":["top.1.damaged.v2.png",new Point(-41,-26)],
               "shadowdamaged":["shadow.1.damaged.v2.jpg",new Point(-51,5)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-45,0)],
               "shadowdestroyed":["shadow.1.destroyed.v4.jpg",new Point(-46,4)]
            },
            "3":{
               "anim":["anim.2.png",new Rectangle(-44,-38,90,97),50],
               "top":["top.2.png",new Point(-44,25)],
               "shadow":["shadow.2.jpg",new Point(-39,16)],
               "topdamaged":["top.2.damaged.png",new Point(-37,-27)],
               "shadowdamaged":["shadow.2.damaged.jpg",new Point(-39,19)],
               "topdestroyed":["top.2.destroyed.png",new Point(-57,8)],
               "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-60,19)]
            }
         },
         "buildingbuttons":["bone_crusher.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"bone_crusher.v2.jpg",
               "silhouette_img":"bone_crusher.v2.silhouette.jpg"
            }
         },
         "quantity":[0,1,2,4,5,6,6,6,6,6],
         "produce":[2,4,7,11,16,22,29,37,46,56],
         "cycleTime":[10,10,10,10,10,10,10,10,10,10],
         "capacity":[12 * 60,36 * 60,5670,13365,486 * 60,60142,118918,227584,424414,775018],
         "hp":[500,950,30 * 60,3400,6500,200 * 60,400 * 60,750 * 60,85000,165000],
         "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
      },{
         "id":2,
         "group":1,
         "order":2,
         "buildStatus":0,
         "type":"resource",
         "name":"#bi_coalharvester#",
         "size":100,
         "cycle":30,
         "attackgroup":1,
         "tutstage":0,
         "sale":0,
         "description":"bi_coalharvester_desc",
         "costs":[{
            "r1":750,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":15,
            "re":[[14,1,1]]
         },{
            "r1":1575,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":5 * 60,
            "re":[[14,1,1]]
         },{
            "r1":55 * 60,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":20 * 60,
            "re":[[14,1,1]]
         },{
            "r1":6950,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":60 * 60,
            "re":[[14,1,2]]
         },{
            "r1":14500,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":2 * 60 * 60,
            "re":[[14,1,2]]
         },{
            "r1":0x7788,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":64300,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":135000,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":283600,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":10 * 60 * 1000,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":3 * 24 * 60 * 60,
            "re":[[14,1,5]]
         }],
         "imageData":{
            "baseurl":"buildings/icoalproducer/",
            "1":{
               "anim":["anim.1.v2.png",new Rectangle(-21,-45,40,18),47],
               "anim2":["anim.2.v2.png",new Rectangle(-39,-9,39,63),47],
               "anim3":["anim.3.v2.png",new Rectangle(-3,8.9,31,18),47],
               "top":["top.1.v2.png",new Point(-32,-40)],
               "shadow":["shadow.1.jpg",new Point(-40,14)],
               "topdamaged":["top.1.damaged.v2.png",new Point(-34,-42)],
               "shadowdamaged":["shadow.1.damaged.v2.jpg",new Point(-64,4)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-44,-4)],
               "shadowdestroyed":["shadow.1.destroyed.v2.jpg",new Point(-50,-2)]
            },
            "3":{
               "anim":["anim.1.2.png",new Rectangle(-40,-52,74,105),45],
               "top":["top.2.png",new Point(-40,-50)],
               "shadow":["shadow.2.jpg",new Point(-42,7)],
               "topdamaged":["top.2.damaged.png",new Point(-39,-52)],
               "shadowdamaged":["shadow.2.damaged.jpg",new Point(-43,5)],
               "topdestroyed":["top.2.destroyed.png",new Point(-43,-9)],
               "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-46,17)]
            }
         },
         "buildingbuttons":["coal_producer.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"coal_producer.v2.jpg",
               "silhouette_img":"coal_producer.v2.silhouette.jpg"
            }
         },
         "quantity":[0,1,2,4,5,6,6,6,6,6],
         "produce":[2,4,7,11,16,22,29,37,46,56],
         "cycleTime":[10,10,10,10,10,10,10,10,10,10],
         "capacity":[12 * 60,36 * 60,5670,13365,486 * 60,60142,118918,227584,424414,775018],
         "hp":[500,950,30 * 60,3400,6500,200 * 60,400 * 60,750 * 60,85000,165000],
         "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
      },{
         "id":3,
         "group":1,
         "order":3,
         "buildStatus":0,
         "type":"resource",
         "name":"#bi_sulfurharvester#",
         "size":100,
         "cycle":30,
         "attackgroup":1,
         "tutstage":80,
         "sale":0,
         "description":"bi_sulfurharvester_desc",
         "costs":[{
            "r1":525,
            "r2":224,
            "r3":0,
            "r4":0,
            "time":20,
            "re":[[14,1,1]]
         },{
            "r1":1102,
            "r2":470,
            "r3":0,
            "r4":0,
            "time":5 * 60,
            "re":[[14,1,1]]
         },{
            "r1":2315,
            "r2":992,
            "r3":0,
            "r4":0,
            "time":20 * 60,
            "re":[[14,1,1]]
         },{
            "r1":4862,
            "r2":2086,
            "r3":0,
            "r4":0,
            "time":60 * 60,
            "re":[[14,1,2]]
         },{
            "r1":10210,
            "r2":4375,
            "r3":0,
            "r4":0,
            "time":2 * 60 * 60,
            "re":[[14,1,2]]
         },{
            "r1":21441,
            "r2":9190,
            "r3":0,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":45027,
            "r2":19298,
            "r3":0,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":94557,
            "r2":40524,
            "r3":0,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":198570,
            "r2":85102,
            "r3":0,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":416997,
            "r2":178716,
            "r3":0,
            "r4":0,
            "time":3 * 24 * 60 * 60,
            "re":[[14,1,5]]
         }],
         "imageData":{
            "baseurl":"buildings/isulpherproducer/",
            "1":{
               "anim":["anim.1.v2.png",new Rectangle(-35,-4,20,50),51],
               "anim2":["anim.2.v2.png",new Rectangle(-20,-58,34,36),51],
               "anim3":["anim.3.v2.png",new Rectangle(-11,-14,26,17),51],
               "top":["top.1.v2.png",new Point(-24,-41)],
               "shadow":["shadow.1.jpg",new Point(-33,13)],
               "topdamaged":["top.1.damaged.v2.png",new Point(-45,-48)],
               "shadowdamaged":["shadow.1.damaged.v2.jpg",new Point(-49,17)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-34,4)],
               "shadowdestroyed":["shadow.1.destroyed.v2.jpg",new Point(-34,15)]
            },
            "3":{
               "anim":["anim1.2.png",new Rectangle(-36,-60,60,118),45],
               "top":["top.2.png",new Point(0,-15)],
               "shadow":["shadow.2.jpg",new Point(-25,27)],
               "topdamaged":["top.2.damaged.png",new Point(-38,-62)],
               "shadowdamaged":["shadow.2.damaged.jpg",new Point(-28,30)],
               "topdestroyed":["top.2.destroyed.png",new Point(-45,-6)],
               "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-42,12)]
            }
         },
         "buildingbuttons":["sulfur.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"sulfur.v2.jpg",
               "silhouette_img":"sulfur.v2.silhouette.jpg"
            }
         },
         "quantity":[0,1,2,4,5,6,6,6,6,6],
         "produce":[2,4,7,11,16,22,29,37,46,56],
         "cycleTime":[10,10,10,10,10,10,10,10,10,10],
         "capacity":[12 * 60,36 * 60,5670,13365,486 * 60,60142,118918,227584,424414,775018],
         "hp":[500,950,30 * 60,3400,6500,200 * 60,400 * 60,750 * 60,85000,165000],
         "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
      },{
         "id":4,
         "group":1,
         "order":4,
         "buildStatus":0,
         "type":"resource",
         "name":"#bi_magmaharverster#",
         "size":100,
         "cycle":30,
         "attackgroup":1,
         "tutstage":80,
         "sale":0,
         "description":"bi_magmaharverster_desc",
         "costs":[{
            "r1":247,
            "r2":577,
            "r3":0,
            "r4":0,
            "time":20,
            "re":[[14,1,1]]
         },{
            "r1":520,
            "r2":1212,
            "r3":0,
            "r4":0,
            "time":5 * 60,
            "re":[[14,1,1]]
         },{
            "r1":1090,
            "r2":2546,
            "r3":0,
            "r4":0,
            "time":20 * 60,
            "re":[[14,1,1]]
         },{
            "r1":2290,
            "r2":5348,
            "r3":0,
            "r4":0,
            "time":60 * 60,
            "re":[[14,1,2]]
         },{
            "r1":4810,
            "r2":11231,
            "r3":0,
            "r4":0,
            "time":2 * 60 * 60,
            "re":[[14,1,2]]
         },{
            "r1":10108,
            "r2":23585,
            "r3":0,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":21227,
            "r2":49529,
            "r3":0,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":743 * 60,
            "r2":104012,
            "r3":0,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":26 * 60 * 60,
            "r2":218427,
            "r3":0,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":196584,
            "r2":458696,
            "r3":0,
            "r4":0,
            "time":3 * 24 * 60 * 60,
            "re":[[14,1,5]]
         }],
         "imageData":{
            "baseurl":"buildings/imagmaproducer/",
            "1":{
               "anim":["anim.1.v2.png",new Rectangle(9.2,12.6,25,31),49],
               "anim2":["anim.2.v2.png",new Rectangle(-32,9,36,26),49],
               "anim3":["anim.3.v2.png",new Rectangle(-18,-60,34,58),49],
               "top":["top.1.v2.png",new Point(-35,-15)],
               "shadow":["shadow.1.v2.jpg",new Point(-36,4)],
               "topdamaged":["top.1.damaged.v2.png",new Point(-39,-36)],
               "shadowdamaged":["shadow.1.damaged.v2.jpg",new Point(-49,2)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-37,-2)],
               "shadowdestroyed":["shadow.1.destroyed.v2.jpg",new Point(-41,6)]
            },
            "3":{
               "anim":["anim.1.2.png",new Rectangle(-37,-66,59,52),49],
               "anim2":["anim.2.2.png",new Rectangle(-1,-4,40,63),49],
               "top":["top.2.png",new Point(-40,-15)],
               "shadow":["shadow.2.jpg",new Point(-36,4)],
               "topdamaged":["top.2.damaged.png",new Point(-48,-35)],
               "shadowdamaged":["shadow.2.damaged.jpg",new Point(-38,23)],
               "topdestroyed":["top.2.destroyed.png",new Point(-67,-8)],
               "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,18)]
            }
         },
         "buildingbuttons":["magma_producer.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"magma_producer.v2.jpg",
               "silhouette_img":"magma_producer.v2.silhouette.jpg"
            }
         },
         "quantity":[0,1,2,4,5,6,6,6,6,6],
         "produce":[2,4,7,11,16,22,29,37,46,56],
         "cycleTime":[10,10,10,10,10,10,10,10,10,10],
         "capacity":[12 * 60,36 * 60,5670,13365,486 * 60,60142,118918,227584,424414,775018],
         "hp":[500,950,30 * 60,3400,6500,200 * 60,400 * 60,750 * 60,85000,165000],
         "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
      },{
         "id":5,
         "group":2,
         "order":9,
         "buildStatus":0,
         "type":"special",
         "name":"#b_flinger#",
         "size":190,
         "attackgroup":1,
         "tutstage":60,
         "sale":0,
         "description":"flinger_desc",
         "block":true,
         "costs":[{
            "r1":1000,
            "r2":1000,
            "r3":500,
            "r4":0,
            "time":15 * 60,
            "re":[[14,1,1]]
         },{
            "r1":64300,
            "r2":64300,
            "r3":32150,
            "r4":0,
            "time":3 * 60 * 60,
            "re":[[14,1,3],[11,1,1]]
         },{
            "r1":283600,
            "r2":283600,
            "r3":141800,
            "r4":0,
            "time":9 * 60 * 60,
            "re":[[14,1,4],[11,1,1]]
         },{
            "r1":1247840,
            "r2":1247840,
            "r3":623920,
            "r4":0,
            "time":27 * 60 * 60,
            "re":[[14,1,4],[11,1,1]]
         }],
         "imageData":{
            "baseurl":"buildings/flinger/",
            "1":{
               "top":["top.1.png",new Point(-46,-43)],
               "shadow":["shadow.1.jpg",new Point(-50,20)],
               "topdamaged":["top.1.damaged.png",new Point(-63,-36)],
               "shadowdamaged":["shadow.1.damaged.jpg",new Point(-63,23)],
               "topdestroyed":["top.2.destroyed.png",new Point(-75,-3)],
               "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,24)]
            },
            "2":{
               "top":["top.2.png",new Point(-45,-40)],
               "shadow":["shadow.2.jpg",new Point(-48,19)],
               "topdamaged":["top.2.damaged.png",new Point(-63,-18)],
               "shadowdamaged":["shadow.2.damaged.jpg",new Point(-63,26)],
               "topdestroyed":["top.2.destroyed.png",new Point(-75,-3)],
               "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,24)]
            },
            "3":{
               "top":["top.3.png",new Point(-47,-45)],
               "shadow":["shadow.3.jpg",new Point(-44,20)],
               "topdamaged":["top.3.damaged.png",new Point(-75,-37)],
               "shadowdamaged":["shadow.3.damaged.jpg",new Point(-73,23)],
               "topdestroyed":["top.2.destroyed.png",new Point(-75,-3)],
               "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,24)]
            },
            "4":{
               "top":["top.4.png",new Point(-45,-66)],
               "shadow":["shadow.4.jpg",new Point(-47,22)],
               "topdamaged":["top.4.damaged.png",new Point(-76,-53)],
               "shadowdamaged":["shadow.4.damaged.jpg",new Point(-76,23)],
               "topdestroyed":["top.2.destroyed.png",new Point(-75,-3)],
               "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,24)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"5.1.jpg"},
            "2":{"img":"5.2.jpg"},
            "3":{"img":"5.3.jpg"},
            "4":{"img":"5.4.jpg"}
         },
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"5.1.png"},
            "2":{"img":"5.2.png"},
            "3":{"img":"5.3.png"},
            "4":{"img":"5.4.png"}
         },
         "quantity":[0,1,1,1,1,1,1,1,1,1],
         "capacity":[200,5 * 60,520,640,19 * 60,1820],
         "hp":[0xfa0,0x1f40,16000,28000],
         "repairTime":[100,5 * 60,10 * 60,15 * 60]
      },{
         "id":6,
         "group":1,
         "order":5,
         "buildStatus":0,
         "type":"special",
         "name":"#bi_storagesilo#",
         "size":2 * 60,
         "attackgroup":1,
         "tutstage":200,
         "sale":0,
         "description":"bi_storagesilo_desc",
         "costs":[{
            "r1":3010,
            "r2":1855,
            "r3":0,
            "r4":0,
            "time":20 * 60,
            "re":[[14,1,1]]
         },{
            "r1":7421,
            "r2":3710,
            "r3":0,
            "r4":0,
            "time":30 * 60,
            "re":[[14,1,1]]
         },{
            "r1":14843,
            "r2":7421,
            "r3":0,
            "r4":0,
            "time":45 * 60,
            "re":[[14,1,1]]
         },{
            "r1":29687,
            "r2":14843,
            "r3":0,
            "r4":0,
            "time":4050,
            "re":[[14,1,2]]
         },{
            "r1":59375,
            "r2":29687,
            "r3":0,
            "r4":0,
            "time":6075,
            "re":[[14,1,3]]
         },{
            "r1":118750,
            "r2":59375,
            "r3":0,
            "r4":0,
            "time":9112,
            "re":[[14,1,3]]
         },{
            "r1":237500,
            "r2":118750,
            "r3":0,
            "r4":0,
            "time":13668,
            "re":[[14,1,4]]
         },{
            "r1":475000,
            "r2":237500,
            "r3":0,
            "r4":0,
            "time":20503,
            "re":[[14,1,4]]
         },{
            "r1":950000,
            "r2":475000,
            "r3":0,
            "r4":0,
            "time":30754,
            "re":[[14,1,5]]
         },{
            "r1":1900000,
            "r2":950000,
            "r3":0,
            "r4":0,
            "time":46132,
            "re":[[14,1,6]]
         }],
         "fortify_costs":[{
            "r1":59375,
            "r2":29687,
            "r3":0,
            "r4":0,
            "time":60750,
            "re":[[14,1,5]]
         },{
            "r1":118750,
            "r2":59375,
            "r3":0,
            "r4":0,
            "time":91120,
            "re":[[14,1,6]]
         },{
            "r1":637500,
            "r2":518750,
            "r3":0,
            "r4":0,
            "time":136680,
            "re":[[14,1,7]]
         },{
            "r1":1475000,
            "r2":1237500,
            "r3":0,
            "r4":0,
            "time":205030,
            "re":[[14,1,8]]
         }],
         "imageData":{
            "baseurl":"buildings/istoragesilo/",
            "1":{
               "top":["top.1.v2.png",new Point(-45,-58)],
               "shadow":["shadow.1.v2.jpg",new Point(-48,17)],
               "topdamaged":["top.1.damaged.v2.png",new Point(-47,-56)],
               "shadowdamaged":["shadow.1.damaged.v2.jpg",new Point(-47,17)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-54,-14)],
               "shadowdestroyed":["shadow.1.destroyed.v2.jpg",new Point(-54,12)]
            }
         },
         "buildingbuttons":["sillo.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"sillo.v2.jpg",
               "silhouette_img":"sillo.v2.silhouette.jpg"
            }
         },
         "quantity":[0,2,2,3,4,5,5],
         "capacity":[125 * 60,250 * 60,500 * 60,60 * 1000,2 * 60 * 1000,4 * 60 * 1000,8 * 60 * 1000,16 * 60 * 1000,32 * 60 * 1000,64 * 60 * 1000],
         "hp":[750,1400,2550,4750,8800,16250,500 * 60,55600,105000,190000],
         "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
      },{
         "id":7,
         "group":999,
         "order":1,
         "buildStatus":0,
         "type":"mushroom",
         "name":"#b_mushroom#",
         "size":10,
         "attackgroup":0,
         "tutstage":0,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"7.png"}
         },
         "quantity":[0],
         "hp":[10],
         "repairTime":[10]
      },{
         "id":8,
         "group":2,
         "order":3,
         "buildStatus":0,
         "type":"special",
         "name":"#bi_monsterlocker#",
         "size":2 * 60,
         "attackgroup":2,
         "tutstage":200,
         "sale":0,
         "description":"bi_monsterlocker_desc",
         "block":false,
         "costs":[{
            "r1":30 * 60,
            "r2":2300,
            "r3":0,
            "r4":0,
            "time":10 * 60,
            "re":[[14,1,1],[13,1,1]]
         },{
            "r1":0x7080,
            "r2":18400,
            "r3":0,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,2]]
         },{
            "r1":32 * 60 * 60,
            "r2":147200,
            "r3":0,
            "r4":0,
            "time":20 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":128 * 60 * 60,
            "r2":588800,
            "r3":0,
            "r4":0,
            "time":36 * 60 * 60,
            "re":[[14,1,4]]
         }],
         "imageData":{
            "baseurl":"buildings/imonsterlab/",
            "1":{
               "anim":["anim.1.v2.png",new Rectangle(-42,-41,86,88),31],
               "top":["top.1.v2.png",new Point(-56,8)],
               "shadow":["shadow.1.v2.jpg",new Point(-81,10)],
               "topdamaged":["top.1.damaged.v2.png",new Point(-56,-31)],
               "shadowdamaged":["shadow.1.damaged.v2.jpg",new Point(-76,8)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-53,10)],
               "shadowdestroyed":["shadow.1.destroyed.v2.jpg",new Point(-83,13)]
            }
         },
         "buildingbuttons":["monster_locker.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"monster_locker.v2.jpg",
               "silhouette_img":"monster_locker.v2.silhouette.jpg"
            }
         },
         "quantity":[0,1,1,1,1,1,1,1,1,1],
         "hp":[0xfa0,16000,32000,64000],
         "repairTime":[8 * 60,32 * 60,0xf00,256 * 60]
      },{
         "id":9,
         "group":2,
         "order":14,
         "buildStatus":0,
         "type":"special",
         "name":"#b_monsterjuicer#",
         "size":2 * 60,
         "attackgroup":2,
         "tutstage":200,
         "sale":0,
         "description":"monsterjuicer_desc",
         "cls":BUILDING9,
         "costs":[{
            "r1":1000000,
            "r2":1000000,
            "r3":1000000,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,1],[128,1,1]]
         },{
            "r1":250000,
            "r2":250000,
            "r3":0,
            "r4":0,
            "time":6 * 60 * 60,
            "re":[[14,1,1],[128,1,1]]
         },{
            "r1":500000,
            "r2":500000,
            "r3":0,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,1],[128,1,1]]
         }],
         "imageData":{
            "baseurl":"buildings/monsterjuiceloosener/",
            "1":{
               "anim":["anim.2.png",new Rectangle(-30,-17,60,39),51],
               "top":["top.2.png",new Point(-44,-8)],
               "shadow":["shadow.2.jpg",new Point(-44,16)],
               "topdamaged":["top.2.damaged.png",new Point(-59,-8)],
               "shadowdamaged":["shadow.2.damaged.jpg",new Point(-59,21)],
               "topdestroyed":["top.2.destroyed.png",new Point(-55,0)],
               "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-49,17)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"9.jpg"}
         },
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"9.png"}
         },
         "quantity":[0,0,0,1,1,1,1,1,1,1],
         "hp":[16000,32000,64000],
         "repairTime":[8 * 60,32 * 60,128 * 60]
      },{
         "id":10,
         "group":2,
         "order":13,
         "buildStatus":0,
         "type":"special",
         "name":"#b_yardplanner#",
         "size":2 * 60,
         "attackgroup":2,
         "tutstage":200,
         "sale":0,
         "description":"yardplanner_desc",
         "block":true,
         "costs":[{
            "r1":250000,
            "r2":250000,
            "r3":0,
            "r4":0,
            "r5":0,
            "time":12 * 60 * 60,
            "re":[[14,1,3]]
         }],
         "imageData":{
            "baseurl":"buildings/yardplanner/",
            "1":{
               "top":["top.1.png",new Point(-45,-29)],
               "shadow":["shadow.1.jpg",new Point(-57,16)],
               "topdamaged":["top.1.damaged.png",new Point(-58,-27)],
               "shadowdamaged":["shadow.1.damaged.jpg",new Point(-46,23)],
               "topdestroyed":["top.1.destroyed.png",new Point(-52,6)],
               "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-50,32)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"10.jpg"}
         },
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"10.png"}
         },
         "quantity":[0,0,0,1,1,1,1,1,1,1],
         "hp":[16000],
         "repairTime":[0xf00]
      },{
         "id":11,
         "group":2,
         "order":11,
         "buildStatus":0,
         "type":"special",
         "name":"#b_maproom#",
         "size":2 * 60,
         "attackgroup":1,
         "tutstage":80,
         "sale":0,
         "description":"maproom_desc",
         "block":true,
         "costs":[{
            "r1":2000,
            "r2":2000,
            "r3":0,
            "r4":0,
            "time":15 * 60,
            "re":[[14,1,1]]
         }],
         "imageData":{
            "baseurl":"buildings/maproom/",
            "1":{
               "top":["top.1.png",new Point(-58,-67)],
               "shadow":["shadow.1.jpg",new Point(-68,15)],
               "topdamaged":["top.1.damaged.png",new Point(-73,-44)],
               "shadowdamaged":["shadow.1.damaged.jpg",new Point(-67,23)],
               "topdestroyed":["top.1.destroyed.png",new Point(-70,0)],
               "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-67,27)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"11.jpg"}
         },
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"11.png"}
         },
         "quantity":[0,1,1,1,1,1,1,1,1,1],
         "hp":[5000,10000],
         "repairTime":[5 * 60,10 * 60]
      },{
         "id":12,
         "group":2,
         "order":2,
         "buildStatus":0,
         "type":"special",
         "name":"#b_generalstore#",
         "size":80,
         "attackgroup":2,
         "tutstage":0,
         "sale":0,
         "description":"generalstore_desc",
         "block":true,
         "costs":[{
            "r1":18 * 60,
            "r2":12 * 60,
            "r3":0,
            "r4":0,
            "time":10,
            "re":[[14,1,1]]
         }],
         "imageData":{
            "baseurl":"buildings/generalstore/",
            "1":{
               "top":["top.1.png",new Point(-40,-37)],
               "shadow":["shadow.1.jpg",new Point(-44,13)],
               "topdamaged":["top.1.damaged.png",new Point(-44,-49)],
               "shadowdamaged":["shadow.1.damaged.jpg",new Point(-44,15)],
               "topdestroyed":["top.1.destroyed.png",new Point(-49,-28)],
               "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-48,13)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"12.jpg"}
         },
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"12.png"}
         },
         "quantity":[0,1,1,1,1,1,1,1,1,1],
         "hp":[0xfa0],
         "repairTime":[10]
      },{
         "id":13,
         "group":2,
         "order":7,
         "buildStatus":0,
         "type":"special",
         "name":"#bi_hatchery#",
         "size":2 * 60,
         "attackgroup":2,
         "tutstage":140,
         "sale":0,
         "description":"bi_hatchery_desc",
         "costs":[{
            "r1":2000,
            "r2":2000,
            "r3":0,
            "r4":0,
            "time":15 * 60,
            "re":[[14,1,1],[128,1,1]]
         },{
            "r1":21227,
            "r2":49529,
            "r3":0,
            "r4":0,
            "time":60 * 60,
            "re":[[14,1,3],[8,1,1]]
         },{
            "r1":26 * 60 * 60,
            "r2":218427,
            "r3":0,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,4]]
         }],
         "imageData":{
            "baseurl":"buildings/ihatchery/",
            "1":{
               "anim":["anim.1.v2.png",new Rectangle(-48,-45,33,78),50],
               "anim2":["anim.2.v2.png",new Rectangle(4,13.5,27,31),50],
               "top":["top.1.v2.png",new Point(-55,-28)],
               "shadow":["shadow.1.v2.jpg",new Point(-77,15)],
               "topdamaged":["top.1.damaged.v2.png",new Point(-50,-22)],
               "shadowdamaged":["shadow.1.damaged.v2.jpg",new Point(-75,16)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-40,13)],
               "shadowdestroyed":["shadow.1.destroyed.v2.jpg",new Point(-58,18)]
            }
         },
         "buildingbuttons":["hatchery.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"hatchery.v2.jpg",
               "silhouette_img":"hatchery.v2.silhouette.jpg"
            }
         },
         "quantity":[0,1,2,3,4,5,5,5,5,5],
         "hp":[0xfa0,16000,32000],
         "repairTime":[60,150,5 * 60]
      },{
         "id":14,
         "group":2,
         "order":1,
         "buildStatus":0,
         "type":"special",
         "name":"#bi_townhall#",
         "size":190,
         "attackgroup":1,
         "tutstage":0,
         "sale":0,
         "description":"bi_townhall_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":10,
            "re":[]
         },{
            "r1":7000,
            "r2":7000,
            "r3":0,
            "r4":0,
            "time":10 * 60,
            "re":[[14,1,1]]
         },{
            "r1":700 * 60,
            "r2":700 * 60,
            "r3":0,
            "r4":0,
            "time":4 * 60 * 60,
            "re":[[14,1,2]]
         },{
            "r1":4 * 60 * 1000,
            "r2":4 * 60 * 1000,
            "r3":0,
            "r4":0,
            "time":16 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":1400000,
            "r2":1400000,
            "r3":0,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":7560000,
            "r2":7560000,
            "r3":0,
            "r4":0,
            "time":4 * 24 * 60 * 60,
            "re":[[14,1,5]]
         }],
         "fortify_costs":[{
            "r1":500000,
            "r2":100000,
            "r3":50000,
            "r4":0,
            "time":4 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":1000000,
            "r2":1000000,
            "r3":500000,
            "r4":0,
            "time":16 * 60 * 60,
            "re":[[14,1,6]]
         },{
            "r1":5000000,
            "r2":5000000,
            "r3":2000000,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":10000000,
            "r2":10000000,
            "r3":5000000,
            "r4":0,
            "time":4 * 24 * 60 * 60,
            "re":[[14,1,8]]
         }],
         "imageData":{
            "baseurl":"buildings/itownhall/",
            "1":{
               "top":["top.1.v2.png",new Point(-52,-31)],
               "shadow":["shadow.1.v2.jpg",new Point(-65,49)],
               "topdamaged":["top.1.damaged.v2.png",new Point(-56,-33)],
               "shadowdamaged":["shadow.1.damaged.v2.jpg",new Point(-65,47)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-63,10)],
               "shadowdestroyed":["shadow.1.destroyed.v2.jpg",new Point(-68,43)]
            },
            "2":{
               "top":["top.2.v2.png",new Point(-50,-46)],
               "shadow":["shadow.2.v2.jpg",new Point(-70,35)],
               "topdamaged":["top.2.damaged.v2.png",new Point(-49,-46)],
               "shadowdamaged":["shadow.2.damaged.v2.jpg",new Point(-59,44)],
               "topdestroyed":["top.2.destroyed.v2.png",new Point(-52,5)],
               "shadowdestroyed":["shadow.2.destroyed.v2.jpg",new Point(-76,33)]
            },
            "3":{
               "top":["top.3.v2.png",new Point(-51,-57)],
               "shadow":["shadow.3.v2.jpg",new Point(-74,35)],
               "topdamaged":["top.3.damaged.v2.png",new Point(-56,-55)],
               "shadowdamaged":["shadow.3.damaged.v2.jpg",new Point(-73,33)],
               "topdestroyed":["top.3.destroyed.v2.png",new Point(-62,-12)],
               "shadowdestroyed":["shadow.3.destroyed.v2.jpg",new Point(-75,29)]
            }
         },
         "buildingbuttons":["townhall_L1.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"townhall_L1.v2.jpg",
               "silhouette_img":"townhall_L1.v2.silhouette.jpg"
            },
            "2":{"img":"townhall_L2.v2.jpg"},
            "3":{"img":"townhall_L3.v2.jpg"}
         },
         "fortImgData":{
            "baseurl":"buildings/fortifications/",
            "1":{
               "front":["fort130_F1.png",new Point(-127,46)],
               "back":["fort130_B1.png",new Point(-122,-10)]
            },
            "2":{
               "front":["fort130_F2.png",new Point(-124,48)],
               "back":["fort130_B2.png",new Point(-120,-15)]
            },
            "3":{
               "front":["fort130_F3.png",new Point(-124,32)],
               "back":["fort130_B3.png",new Point(-110,-11)]
            },
            "4":{
               "front":["fort130_F4.png",new Point(-124,15)],
               "back":["fort130_B4.png",new Point(-116,-49)]
            }
         },
         "quantity":[1,1,1,1,1,1,1,1,1,1],
         "hp":[0xfa0,8800,20000,700 * 60,94000,200000],
         "repairTime":[8 * 60,32 * 60,0xf00,128 * 60,256 * 60,512 * 60]
      },{
         "id":15,
         "group":2,
         "order":6,
         "buildStatus":0,
         "type":"special",
         "name":"#bi_housing#",
         "size":200,
         "attackgroup":2,
         "tutstage":50,
         "sale":0,
         "description":"bi_housing_desc",
         "block":true,
         "costs":[{
            "r1":36 * 60,
            "r2":36 * 60,
            "r3":0,
            "r4":0,
            "time":5 * 60,
            "re":[[14,1,1]]
         },{
            "r1":144 * 60,
            "r2":144 * 60,
            "r3":0,
            "r4":0,
            "time":75 * 60,
            "re":[[14,1,3],[8,1,1]]
         },{
            "r1":576 * 60,
            "r2":576 * 60,
            "r3":0,
            "r4":0,
            "time":3 * 60 * 60,
            "re":[[14,1,4],[8,1,1]]
         },{
            "r1":138240,
            "r2":138240,
            "r3":0,
            "r4":0,
            "time":0x7080,
            "re":[[14,1,5],[8,1,1]]
         },{
            "r1":552960,
            "r2":552960,
            "r3":0,
            "r4":0,
            "time":20 * 60 * 60,
            "re":[[14,1,6],[8,1,1]]
         },{
            "r1":2211840,
            "r2":2211840,
            "r3":0,
            "r4":0,
            "time":40 * 60 * 60,
            "re":[[14,1,6],[8,1,1]]
         }],
         "imageData":{
            "baseurl":"buildings/monsterhousing/",
            "1":{
               "top":["top.3.v2.png",new Point(-109,11)],
               "shadow":["shadow.3.v2.jpg",new Point(-112,23)],
               "topdamaged":["top.3.damaged.v2.png",new Point(-107,12)],
               "shadowdamaged":["shadow.3.damaged.v2.jpg",new Point(-110,25)],
               "topdestroyed":["top.3.destroyed.v2.png",new Point(-108,21)],
               "shadowdestroyed":["shadow.3.destroyed.v2.jpg",new Point(-109,25)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"monster_housing.v2.jpg",
               "silhouette_img":"monster_housing.v2.silhouette.jpg"
            }
         },
         "quantity":[0,0,0,0,0,0],
         "capacity":[200,260,320,380,450,9 * 60],
         "hp":[0xfa0,14000,25000,43000,75000,130000],
         "repairTime":[100,200,5 * 60,400,500,10 * 60]
      },{
         "id":16,
         "group":2,
         "order":8,
         "buildStatus":0,
         "type":"special",
         "name":"#b_hcc#",
         "size":2 * 60,
         "attackgroup":2,
         "tutstage":200,
         "sale":0,
         "description":"hcc_desc",
         "block":true,
         "costs":[{
            "r1":4000000,
            "r2":4000000,
            "r3":4000000,
            "r4":0,
            "time":25 * 60 * 60,
            "re":[[14,1,3],[13,3,2]]
         }],
         "imageData":{
            "baseurl":"buildings/hatcherycontrolcenter/",
            "1":{
               "top":["top.1.png",new Point(-40,-58)],
               "shadow":["shadow.1.jpg",new Point(-51,20)],
               "topdamaged":["top.1.damaged.png",new Point(-51,-59)],
               "shadowdamaged":["shadow.1.damaged.jpg",new Point(-50,25)],
               "topdestroyed":["top.1.destroyed.png",new Point(-53,-7)],
               "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-57,24)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"16.jpg"}
         },
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"16.png"}
         },
         "quantity":[0,0,0,0,0,0],
         "hp":[64000],
         "repairTime":[5 * 60]
      },{
         "id":17,
         "group":3,
         "order":7,
         "buildStatus":0,
         "type":"wall",
         "name":"#b_woodenblock#",
         "size":50,
         "attackgroup":1,
         "tutstage":200,
         "sale":0,
         "description":"infernoblock_desc",
         "costs":[{
            "r1":1000,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":5,
            "re":[[14,1,2]]
         },{
            "r1":0,
            "r2":10000,
            "r3":0,
            "r4":0,
            "time":5,
            "re":[[14,1,3]]
         },{
            "r1":100000,
            "r2":100000,
            "r3":0,
            "r4":0,
            "time":5,
            "re":[[14,1,4]]
         }],
         "imageData":{
            "baseurl":"buildings/iwalls/",
            "1":{
               "top":["top.1.v2.png",new Point(-24,-5)],
               "shadow":["shadow.1.v2.jpg",new Point(-20,0.8)],
               "topdamaged":["top.1.damaged.v2.png",new Point(-24,-5)],
               "shadowdamaged":["shadow.1.damaged.v2.jpg",new Point(-20,0.8)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-24,-5)],
               "shadowdestroyed":["shadow.1.destroyed.v2.jpg",new Point(-20,0.8)]
            },
            "2":{
               "top":["top.2.v2.png",new Point(-20,-9)],
               "shadow":["shadow.2.v2.jpg",new Point(-20,-0.9)],
               "topdamaged":["top.2.damaged.v2.png",new Point(-20,-9)],
               "shadowdamaged":["shadow.2.v2.jpg",new Point(-20,-0.9)],
               "topdestroyed":["top.2.destroyed.v2.png",new Point(-20,-9)],
               "shadowdestroyed":["shadow.2.v2.jpg",new Point(-20,-0.9)]
            },
            "3":{
               "top":["top.3.v2.png",new Point(-20,-27)],
               "shadow":["shadow.3.v2.jpg",new Point(-20,-1)],
               "topdamaged":["top.3.damaged.v2.png",new Point(-20,-27)],
               "shadowdamaged":["shadow.3.v2.jpg",new Point(-20,-1)],
               "topdestroyed":["top.3.destroyed.v2.png",new Point(-18,-8)],
               "shadowdestroyed":["shadow.3.v2.jpg",new Point(-20,-1)]
            }
         },
         "buildingbuttons":["coal_wall.v3","iron_wall.v3","steel_wall.v3"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"coal_wall.v3.jpg",
               "silhouette_img":"coal_wall.v3.silhouette.jpg"
            },
            "2":{"img":"iron_wall.v3.jpg"},
            "3":{"img":"steel_wall.v3.jpg"}
         },
         "quantity":[0,0,30,60,2 * 60,200,220],
         "hp":[1000,2300,5750,5 * 60 * 60,450 * 60],
         "repairTime":[5,5,5,5,5]
      },{
         "id":18,
         "group":3,
         "order":7,
         "buildStatus":0,
         "type":"wall",
         "name":"#b_stoneblock#",
         "size":50,
         "attackgroup":1,
         "tutstage":200,
         "sale":0,
         "description":"stoneblock_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":2000,
            "r3":0,
            "r4":0,
            "time":5,
            "re":[[14,1,3]]
         }],
         "imageData":{
            "baseurl":"buildings/walls/stone/",
            "1":{
               "top":["top.1.png",new Point(-16,-21)],
               "shadow":["shadow.1.jpg",new Point(-19,-1)],
               "topdamaged":["top.1.damaged.png",new Point(-17,-19)],
               "shadowdamaged":["shadow.1.jpg",new Point(-19,-1)],
               "topdestroyed":["top.1.destroyed.png",new Point(-16,0)],
               "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-14,5)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"18.jpg"}
         },
         "quantity":[0,0,10,20,40,60,70,90,90,90],
         "hp":[60 * 60],
         "repairTime":[20]
      },{
         "id":19,
         "group":2,
         "order":12,
         "buildStatus":0,
         "type":"special",
         "name":"#b_wildmonsterbaiter#",
         "size":2 * 60,
         "attackgroup":2,
         "tutstage":200,
         "sale":0,
         "description":"wildmonsterbaiter_desc",
         "block":true,
         "costs":[{
            "r1":25000,
            "r2":25000,
            "r3":250 * 60,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,4],[8,1,1]]
         },{
            "r1":1000000,
            "r2":1000000,
            "r3":500000,
            "r4":0,
            "time":10 * 60 * 60,
            "re":[[14,1,4],[8,1,2]]
         },{
            "r1":2000000,
            "r2":2000000,
            "r3":1000000,
            "r4":0,
            "time":20 * 60 * 60,
            "re":[[14,1,4],[8,1,3]]
         },{
            "r1":4000000,
            "r2":4000000,
            "r3":2000000,
            "r4":0,
            "time":40 * 60 * 60,
            "re":[[14,1,5],[8,1,4]]
         },{
            "r1":100 * 60 * 1000,
            "r2":100 * 60 * 1000,
            "r3":4000000,
            "r4":0,
            "time":80 * 60 * 60,
            "re":[[14,1,6],[8,1,4]]
         },{
            "r1":10000000,
            "r2":10000000,
            "r3":100 * 60 * 1000,
            "r4":0,
            "time":160 * 60 * 60,
            "re":[[14,1,7],[8,1,4]]
         },{
            "r1":16000000,
            "r2":16000000,
            "r3":10000000,
            "r4":0,
            "time":320 * 60 * 60,
            "re":[[14,1,8],[8,1,4]]
         }],
         "imageData":{
            "baseurl":"buildings/monsterbaiter/",
            "1":{
               "anim":["anim.1.png",new Rectangle(-33,-23,67,77),41],
               "top":["top.1.png",new Point(-37,-6)],
               "shadow":["shadow.1.jpg",new Point(-9,16)],
               "topdamaged":["top.1.damaged.png",new Point(-37,-14)],
               "shadowdamaged":["shadow.1.jpg",new Point(-9,16)],
               "topdestroyed":["top.1.destroyed.png",new Point(-37,10)],
               "shadowdestroyed":["shadow.1.jpg",new Point(-9,16)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"19.jpg"}
         },
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"19.png"}
         },
         "quantity":[0,0,0,0,0,0],
         "produce":[2,2,2,2,2,2,2],
         "capacity":[10 * 60,15 * 60,20 * 60,25 * 60,35 * 60,3200,80 * 60],
         "hp":[1000,25 * 60,2250,3375,5000,125 * 60,200 * 60],
         "repairTime":[2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60]
      },{
         "id":20,
         "group":3,
         "order":2,
         "buildStatus":0,
         "type":"tower",
         "name":"#bi_cannontower#",
         "size":64,
         "attackgroup":1,
         "tutstage":200,
         "sale":0,
         "description":"bi_cannontower_desc",
         "block":true,
         "stats":[{
            "range":160,
            "damage":20,
            "rate":40,
            "speed":5,
            "splash":30
         },{
            "range":170,
            "damage":40,
            "rate":40,
            "speed":6,
            "splash":35
         },{
            "range":3 * 60,
            "damage":60,
            "rate":40,
            "speed":7,
            "splash":40
         },{
            "range":190,
            "damage":80,
            "rate":40,
            "speed":8,
            "splash":45
         },{
            "range":200,
            "damage":100,
            "rate":40,
            "speed":8,
            "splash":50
         },{
            "range":210,
            "damage":2 * 60,
            "rate":40,
            "speed":8,
            "splash":55
         },{
            "range":220,
            "damage":140,
            "rate":40,
            "speed":8,
            "splash":60
         }],
         "costs":[{
            "r1":2000,
            "r2":25 * 60,
            "r3":500,
            "r4":0,
            "time":30,
            "re":[[14,1,1]]
         },{
            "r1":10000,
            "r2":125 * 60,
            "r3":2500,
            "r4":0,
            "time":15 * 60,
            "re":[[14,1,2]]
         },{
            "r1":50000,
            "r2":625 * 60,
            "r3":12500,
            "r4":0,
            "time":45 * 60,
            "re":[[14,1,3]]
         },{
            "r1":250000,
            "r2":187500,
            "r3":62500,
            "r4":0,
            "time":135 * 60,
            "re":[[14,1,4]]
         },{
            "r1":1250000,
            "r2":937500,
            "r3":312500,
            "r4":0,
            "time":405 * 60,
            "re":[[14,1,4]]
         },{
            "r1":6250000,
            "r2":4687500,
            "r3":1562500,
            "r4":0,
            "time":72900,
            "re":[[14,1,5]]
         },{
            "r1":9375000,
            "r2":7000000,
            "r3":1562500,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,6]]
         }],
         "fortify_costs":[{
            "r1":50000,
            "r2":625 * 60,
            "r3":12500,
            "r4":0,
            "time":135 * 60,
            "re":[[14,1,5]]
         },{
            "r1":250000,
            "r2":187500,
            "r3":62500,
            "r4":0,
            "time":405 * 60,
            "re":[[14,1,6]]
         },{
            "r1":1250000,
            "r2":937500,
            "r3":312500,
            "r4":0,
            "time":72900,
            "re":[[14,1,7]]
         },{
            "r1":6250000,
            "r2":4687500,
            "r3":1562500,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,8]]
         }],
         "imageData":{
            "baseurl":"buildings/icannontower/",
            "1":{
               "anim":["anim.1.v2.png",new Rectangle(-38,-53,74,64),30],
               "animdamaged":["anim.1.damaged.v2.png",new Rectangle(-38,-53,74,64),30],
               "top":["top.1.v2.png",new Point(-38,11)],
               "shadow":["shadow.1.v2.jpg",new Point(-48,11)],
               "topdamaged":["top.1.damaged.v2.png",new Point(-38,11)],
               "shadowdamaged":["shadow.1.v2.jpg",new Point(-48,11)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-57,-18)],
               "shadowdestroyed":["shadow.1.v2.jpg",new Point(-55,8)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"cannon_tower.v2.jpg",
               "silhouette_img":"cannon_tower.v2.silhouette.jpg"
            }
         },
         "fortImgData":{
            "baseurl":"buildings/fortifications/",
            "1":{
               "front":["fort70_F1.png",new Point(-73,21)],
               "back":["fort70_B1.png",new Point(-70,-10)]
            },
            "2":{
               "front":["fort70_F2.png",new Point(-69,22)],
               "back":["fort70_B2.png",new Point(-65,-12)]
            },
            "3":{
               "front":["fort70_F3.png",new Point(-72,10)],
               "back":["fort70_B3.png",new Point(-68,-12)]
            },
            "4":{
               "front":["fort70_F4.png",new Point(-70,-11)],
               "back":["fort70_B4.png",new Point(-61,-36)]
            }
         },
         "quantity":[0,0,0,0,0,0],
         "hp":[100 * 60,150 * 60,210 * 60,294 * 60,441 * 60,34400,750 * 60,58000,75500,98200],
         "repairTime":[6 * 60,12 * 60,24 * 60,48 * 60,96 * 60,192 * 60,23000,46000,18 * 60 * 60,24 * 60 * 60]
      },{
         "id":21,
         "group":3,
         "order":1,
         "buildStatus":0,
         "type":"tower",
         "name":"#bi_snipertower#",
         "size":64,
         "attackgroup":3,
         "tutstage":28,
         "sale":0,
         "description":"bi_snipertower_desc",
         "stats":[{
            "range":5 * 60,
            "damage":100,
            "rate":80,
            "speed":10,
            "splash":0
         },{
            "range":308,
            "damage":210,
            "rate":80,
            "speed":10,
            "splash":0
         },{
            "range":316,
            "damage":320,
            "rate":80,
            "speed":10,
            "splash":0
         },{
            "range":324,
            "damage":430,
            "rate":80,
            "speed":12,
            "splash":0
         },{
            "range":332,
            "damage":9 * 60,
            "rate":80,
            "speed":15,
            "splash":0
         },{
            "range":340,
            "damage":650,
            "rate":80,
            "speed":17,
            "splash":0
         },{
            "range":348,
            "damage":760,
            "rate":80,
            "speed":18,
            "splash":0
         }],
         "costs":[{
            "r1":25 * 60,
            "r2":2000,
            "r3":500,
            "r4":0,
            "time":30,
            "re":[[14,1,1]]
         },{
            "r1":125 * 60,
            "r2":10000,
            "r3":2500,
            "r4":0,
            "time":15 * 60,
            "re":[[14,1,2]]
         },{
            "r1":625 * 60,
            "r2":50000,
            "r3":12500,
            "r4":0,
            "time":45 * 60,
            "re":[[14,1,3]]
         },{
            "r1":187500,
            "r2":250000,
            "r3":62500,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":937500,
            "r2":1250000,
            "r3":312500,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":4687500,
            "r2":6250000,
            "r3":1562500,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":7031250,
            "r2":9375000,
            "r3":2343750,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,6]]
         }],
         "fortify_costs":[{
            "r1":625 * 60,
            "r2":50000,
            "r3":12500,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":187500,
            "r2":250000,
            "r3":62500,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,6]]
         },{
            "r1":937500,
            "r2":1250000,
            "r3":312500,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":4687500,
            "r2":6250000,
            "r3":1562500,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,8]]
         }],
         "imageData":{
            "baseurl":"buildings/isnipertower/",
            "1":{
               "anim":["anim.1.v2.png",new Rectangle(-56,-86,85,81),30],
               "top":["top.1.v2.png",new Point(-35,-5)],
               "shadow":["shadow.1.v2.jpg",new Point(-50,12)],
               "animdamaged":["anim.1.damaged.v2.png",new Rectangle(-52,-90,85,81),30],
               "topdamaged":["top.1.damaged.v2.png",new Point(-40,-9)],
               "shadowdamaged":["shadow.1.v2.jpg",new Point(-50,9)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-43,-8)],
               "shadowdestroyed":["shadow.1.v2.jpg",new Point(-54,2)]
            }
         },
         "buildingbuttons":["sniper_tower.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"sniper_tower.v2.jpg",
               "silhouette_img":"sniper_tower.v2.silhouette.jpg"
            }
         },
         "fortImgData":{
            "baseurl":"buildings/fortifications/",
            "1":{
               "front":["fort70_F1.png",new Point(-73,21)],
               "back":["fort70_B1.png",new Point(-70,-10)]
            },
            "2":{
               "front":["fort70_F2.png",new Point(-69,22)],
               "back":["fort70_B2.png",new Point(-65,-12)]
            },
            "3":{
               "front":["fort70_F3.png",new Point(-72,10)],
               "back":["fort70_B3.png",new Point(-68,-12)]
            },
            "4":{
               "front":["fort70_F4.png",new Point(-70,-11)],
               "back":["fort70_B4.png",new Point(-61,-36)]
            }
         },
         "quantity":[0,2,3,3,4,4,6],
         "hp":[100 * 60,150 * 60,210 * 60,294 * 60,441 * 60,34400,750 * 60],
         "repairTime":[6 * 60,12 * 60,24 * 60,48 * 60,96 * 60,192 * 60,23000]
      },{
         "id":22,
         "group":3,
         "order":5,
         "buildStatus":0,
         "type":"tower",
         "name":"#b_monsterbunker#",
         "size":2 * 60,
         "attackgroup":2,
         "tutstage":200,
         "sale":0,
         "description":"monsterbunker_desc",
         "block":true,
         "stats":[{"range":5 * 60},{"range":350},{"range":400},{"range":450}],
         "costs":[{
            "r1":250000,
            "r2":187500,
            "r3":62500,
            "r4":0,
            "time":6 * 60 * 60,
            "re":[[14,1,3],[15,1,1]]
         },{
            "r1":1000000,
            "r2":1000000,
            "r3":500000,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,4],[15,1,2]]
         },{
            "r1":2000000,
            "r2":2000000,
            "r3":1000000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,5],[15,1,3]]
         },{
            "r1":4000000,
            "r2":4000000,
            "r3":2000000,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,9],[15,1,3]]
         }],
         "imageData":{
            "baseurl":"buildings/bunker/",
            "1":{
               "anim":["anim.1.png",new Rectangle(-46,-15,90,83),15],
               "shadow":["shadow.1.jpg",new Point(-66,10)],
               "topdamaged":["top.1.damaged.png",new Point(-45,-8)],
               "shadowdamaged":["shadow.1.damaged.jpg",new Point(-66,5)],
               "topdestroyed":["top.1.destroyed.png",new Point(-50,4)],
               "shadowdamaged":["shadow.1.destroyed.jpg",new Point(-61,14)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"22.jpg"}
         },
         "quantity":[0,0,0,0,0,0],
         "capacity":[380,450,9 * 60,640],
         "hp":[10000,24500,52000,75000],
         "repairTime":[2 * 60,4 * 60,8 * 60,16 * 60]
      },{
         "id":23,
         "group":3,
         "order":4,
         "buildStatus":0,
         "type":"tower",
         "name":"#b_lasertower#",
         "tutstage":200,
         "sale":0,
         "description":"lasertower_desc",
         "block":true,
         "stats":[{
            "range":160,
            "damage":2 * 60,
            "rate":80,
            "speed":0,
            "splash":40
         },{
            "range":162,
            "damage":150,
            "rate":80,
            "speed":0,
            "splash":40
         },{
            "range":164,
            "damage":3 * 60,
            "rate":80,
            "speed":0,
            "splash":40
         },{
            "range":168,
            "damage":200,
            "rate":80,
            "speed":0,
            "splash":40
         },{
            "range":170,
            "damage":220,
            "rate":80,
            "speed":0,
            "splash":40
         },{
            "range":175,
            "damage":4 * 60,
            "rate":80,
            "speed":0,
            "splash":40
         }],
         "costs":[{
            "r1":500000,
            "r2":250000,
            "r3":100000,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":1000000,
            "r2":500000,
            "r3":200000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":2000000,
            "r2":1000000,
            "r3":400000,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,6]]
         },{
            "r1":4000000,
            "r2":2000000,
            "r3":800000,
            "r4":0,
            "time":3 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":8000000,
            "r2":4000000,
            "r3":1600000,
            "r4":0,
            "time":108 * 60 * 60,
            "re":[[14,1,8]]
         },{
            "r1":16000000,
            "r2":8000000,
            "r3":3200000,
            "r4":0,
            "time":9 * 24 * 60 * 60,
            "re":[[14,1,9]]
         }],
         "fortify_costs":[{
            "r1":500000,
            "r2":250000,
            "r3":100000,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":1000000,
            "r2":500000,
            "r3":200000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,6]]
         },{
            "r1":2000000,
            "r2":1000000,
            "r3":400000,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":4000000,
            "r2":2000000,
            "r3":800000,
            "r4":0,
            "time":3 * 24 * 60 * 60,
            "re":[[14,1,8]]
         }],
         "imageData":{
            "baseurl":"buildings/lasertower/",
            "1":{
               "anim":["anim.1.png",new Rectangle(-13,-50,29,32),54],
               "top":["top.1.png",new Point(-33,-29)],
               "shadow":["shadow.1.jpg",new Point(-36,15)],
               "animdamaged":["anim.1.damaged.png",new Rectangle(-22,-46,52,44),54],
               "topdamaged":["top.1.damaged.png",new Point(-40,-28)],
               "shadowdamaged":["shadow.1.jpg",new Point(-37,-17)],
               "topdestroyed":["top.1.destroyed.png",new Point(-39,-3)],
               "shadowdestroyed":["shadow.1.jpg",new Point(-37,14)],
               "topdestroyedfire":["top.1.destroyed.fire.png",new Point(-39,-3)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"23.jpg"}
         },
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"23.png"}
         },
         "fortImgData":{
            "baseurl":"buildings/fortifications/",
            "1":{
               "front":["fort70_F1.png",new Point(-73,21)],
               "back":["fort70_B1.png",new Point(-70,-10)]
            },
            "2":{
               "front":["fort70_F2.png",new Point(-69,22)],
               "back":["fort70_B2.png",new Point(-65,-12)]
            },
            "3":{
               "front":["fort70_F3.png",new Point(-72,10)],
               "back":["fort70_B3.png",new Point(-68,-12)]
            },
            "4":{
               "front":["fort70_F4.png",new Point(-70,-11)],
               "back":["fort70_B4.png",new Point(-61,-36)]
            }
         },
         "quantity":[0,0,0,0,0,0],
         "hp":[150 * 60,210 * 60,294 * 60,441 * 60,34400,42200],
         "repairTime":[24 * 60,48 * 60,96 * 60,192 * 60,23000,46000]
      },{
         "id":24,
         "group":3,
         "order":6,
         "buildStatus":0,
         "type":"trap",
         "name":"#b_boobytrap#",
         "size":50,
         "attackgroup":4,
         "tutstage":200,
         "sale":0,
         "description":"boobytrap_desc",
         "costs":[{
            "r1":1000,
            "r2":1000,
            "r3":1000,
            "r4":0,
            "time":5,
            "re":[[14,1,2]]
         }],
         "imageData":{
            "baseurl":"buildings/boobytrap/",
            "1":{
               "top":["top.1.png",new Point(-15,1)],
               "shadow":["shadow.1.jpg",new Point(-13,3)],
               "topdestroyed":["top.1.destroyed.png",new Point(-15,2)],
               "shadowdestroyed":["shadow.1.jpg",new Point(-13,3)]
            }
         },
         "buildingbuttons":["booby_trap.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"booby_trap.v2.jpg",
               "silhouette_img":"booby_trap.v2.silhouette.jpg"
            }
         },
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"24.png"}
         },
         "quantity":[0,0,8,15,20,28,35],
         "damage":[1000],
         "hp":[10],
         "repairTime":[1]
      },{
         "id":25,
         "group":3,
         "order":3,
         "buildStatus":0,
         "type":"tower",
         "name":"#b_teslatower#",
         "tutstage":200,
         "sale":0,
         "description":"teslatower_desc",
         "block":true,
         "stats":[{
            "range":250,
            "damage":100,
            "rate":10,
            "speed":10,
            "splash":0
         },{
            "range":270,
            "damage":2 * 60,
            "rate":15,
            "speed":10,
            "splash":0
         },{
            "range":5 * 60,
            "damage":140,
            "rate":20,
            "speed":10,
            "splash":0
         },{
            "range":320,
            "damage":160,
            "rate":25,
            "speed":10,
            "splash":0
         },{
            "range":340,
            "damage":3 * 60,
            "rate":25,
            "speed":10,
            "splash":0
         },{
            "range":6 * 60,
            "damage":200,
            "rate":30,
            "speed":10,
            "splash":0
         }],
         "costs":[{
            "r1":187500,
            "r2":250000,
            "r3":62500,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":750000,
            "r2":1000000,
            "r3":250000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":625 * 60 * 60,
            "r2":50 * 60 * 1000,
            "r3":750000,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,6]]
         },{
            "r1":5250000,
            "r2":5000000,
            "r3":1250000,
            "r4":0,
            "time":4 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":200 * 60 * 1000,
            "r2":10000000,
            "r3":2000000,
            "r4":0,
            "time":6 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":5 * 60 * 60 * 1000,
            "r2":250 * 60 * 1000,
            "r3":5000000,
            "r4":0,
            "time":8 * 24 * 60 * 60,
            "re":[[14,1,9]]
         }],
         "fortify_costs":[{
            "r1":187500,
            "r2":250000,
            "r3":62500,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":750000,
            "r2":1000000,
            "r3":250000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,6]]
         },{
            "r1":625 * 60 * 60,
            "r2":50 * 60 * 1000,
            "r3":750000,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":5250000,
            "r2":5000000,
            "r3":1250000,
            "r4":0,
            "time":4 * 24 * 60 * 60,
            "re":[[14,1,8]]
         }],
         "imageData":{
            "baseurl":"buildings/lightningtower/",
            "1":{
               "anim":["anim.3.png",new Rectangle(-25,-15,27,53),55],
               "top":["top.3.png",new Point(-33,-57)],
               "shadow":["shadow.3.jpg",new Point(-38,18)],
               "animdamaged":["anim.3.damaged.png",new Rectangle(-26,-19,30,57),55],
               "topdamaged":["top.3.damaged.png",new Point(-46,-58)],
               "shadowdamaged":["shadow.3.jpg",new Point(-44,21)],
               "topdestroyed":["top.3.destroyed.png",new Point(-46,6)],
               "shadowdestroyed":["shadow.3.jpg",new Point(-44,17)],
               "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-46,6)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"25.jpg"}
         },
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"25.png"}
         },
         "fortImgData":{
            "baseurl":"buildings/fortifications/",
            "1":{
               "front":["fort70_F1.png",new Point(-73,21)],
               "back":["fort70_B1.png",new Point(-70,-10)]
            },
            "2":{
               "front":["fort70_F2.png",new Point(-69,22)],
               "back":["fort70_B2.png",new Point(-65,-12)]
            },
            "3":{
               "front":["fort70_F3.png",new Point(-72,10)],
               "back":["fort70_B3.png",new Point(-68,-12)]
            },
            "4":{
               "front":["fort70_F4.png",new Point(-70,-11)],
               "back":["fort70_B4.png",new Point(-61,-36)]
            }
         },
         "quantity":[0,0,0,0,0,0],
         "hp":[250 * 60,22000,500 * 60,800 * 60,60 * 1000,20 * 60 * 60],
         "repairTime":[32 * 60,0xf00,128 * 60,9260,200 * 60,5 * 60 * 60]
      },{
         "id":26,
         "group":2,
         "order":5,
         "buildStatus":0,
         "type":"special",
         "name":"#bi_academy#",
         "tutstage":200,
         "sale":0,
         "description":"bi_academy_desc",
         "costs":[{
            "r1":100000,
            "r2":100000,
            "r3":0,
            "r4":0,
            "time":3 * 60 * 60,
            "re":[[14,1,3],[8,1,2]]
         },{
            "r1":250000,
            "r2":250000,
            "r3":0,
            "r4":0,
            "time":6 * 60 * 60,
            "re":[[14,1,4],[8,1,3]]
         },{
            "r1":400000,
            "r2":400000,
            "r3":0,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,5],[8,1,4]]
         },{
            "r1":800000,
            "r2":800000,
            "r3":0,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,6],[8,1,4]]
         }],
         "imageData":{
            "baseurl":"buildings/iacademy/",
            "1":{
               "anim":["anim1.1.png",new Rectangle(11,-2,22,17),44],
               "anim2":["anim2.1.png",new Rectangle(-32,-49,53,84),44],
               "top":["top.1.png",new Point(-50,-27)],
               "shadow":["shadow.1.jpg",new Point(-50,23)],
               "topdamaged":["top.1.damaged.png",new Point(-48,-49)],
               "shadowdamaged":["shadow.1.jpg",new Point(-50,23)],
               "topdestroyed":["top.1.destroyed.png",new Point(-59,-10)],
               "shadowdestroyed":["shadow.1.jpg",new Point(-50,23)]
            },
            "2":{
               "anim":["anim1.2.png",new Rectangle(1,-18,44,26),47],
               "anim2":["anim2.2.png",new Rectangle(-39,-96,67,117),47],
               "top":["top.2.png",new Point(-56,-43)],
               "shadow":["shadow.2.jpg",new Point(-60,10)],
               "topdamaged":["top.2.damaged.png",new Point(-61,-91)],
               "shadowdamaged":["shadow.2.damaged.jpg",new Point(-58,8)],
               "topdestroyed":["top.2.destroyed.png",new Point(-71,-56)],
               "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-73,-17)]
            }
         },
         "buildingbuttons":["inferno_monster_academy"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"inferno_monster_academy.jpg",
               "silhouette_img":"inferno_monster_academy.silhouette.jpg"
            },
            "2":{"img":"inferno_monster_academy.jpg"}
         },
         "quantity":[1,1,1,1,2,2,2],
         "hp":[100 * 60,10000,14000,20000],
         "repairTime":[3800,128 * 60,10640,21280]
      },{
         "id":27,
         "group":999,
         "order":0,
         "buildStatus":0,
         "type":"enemy",
         "name":"#b_trojanhorse#",
         "size":100,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"trojanhorse_desc",
         "block":true,
         "isImmobile":true,
         "isUntargetable":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":5,
            "re":[[14,1,1]]
         }],
         "imageData":{
            "baseurl":"buildings/trojanhorse/",
            "1":{
               "anim":["anim.1.png",new Rectangle(-92,-23,39,31),2],
               "top":["top.1.png",new Point(-91,-65)],
               "shadow":["shadow.1.jpg",new Point(-72,11)]
            }
         },
         "quantity":[1],
         "damage":[1],
         "hp":[1],
         "repairTime":[1]
      },{
         "id":28,
         "group":4,
         "subgroup":3,
         "order":5,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_americanflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-usa.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":29,
         "group":4,
         "subgroup":3,
         "order":6,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_britishflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-britain.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":30,
         "group":4,
         "subgroup":3,
         "order":7,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_australianflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-australia.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":31,
         "group":4,
         "subgroup":3,
         "order":8,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_brazilianflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-brazil.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":32,
         "group":4,
         "subgroup":3,
         "order":25,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_europeanflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "r4":0,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-europe.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":33,
         "group":4,
         "subgroup":3,
         "order":9,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_frenchflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-france.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":34,
         "group":4,
         "subgroup":3,
         "order":10,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_indonesianflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-indonesian.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":35,
         "group":4,
         "subgroup":3,
         "order":11,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_italianflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-italy.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":36,
         "group":4,
         "subgroup":3,
         "order":12,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_malaysianflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-malaysia.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":37,
         "group":4,
         "subgroup":3,
         "order":13,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_dutchflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-dutch.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":38,
         "group":4,
         "subgroup":3,
         "order":14,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_newzealandflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-newzealand.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":39,
         "group":4,
         "subgroup":3,
         "order":15,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_norwegianflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-norway.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":40,
         "group":4,
         "subgroup":3,
         "order":16,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_polishflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-poland.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":41,
         "group":4,
         "subgroup":3,
         "order":17,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_swedishflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-sweden.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":42,
         "group":4,
         "subgroup":3,
         "order":18,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_turkishflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-turkey.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":43,
         "group":4,
         "subgroup":3,
         "order":19,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_canadianflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-canadian.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":44,
         "group":4,
         "subgroup":3,
         "order":20,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_danishflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-denmark.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":45,
         "group":4,
         "subgroup":3,
         "order":21,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_germanflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-germany.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":46,
         "group":4,
         "subgroup":3,
         "order":22,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_filipinoflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-philippines.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":47,
         "group":4,
         "subgroup":3,
         "order":23,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_singaporeanflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-singapore.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":48,
         "group":4,
         "subgroup":3,
         "order":24,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_austrianflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-austria.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":49,
         "group":4,
         "subgroup":3,
         "order":-1,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_pirateflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":1,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":250,
            "r4":0,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-pirate.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":50,
         "group":4,
         "subgroup":3,
         "order":0,
         "buildStatus":0,
         "type":"decoration",
         "name":"#b_peaceflag#",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":1,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":250,
            "r4":0,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-peace.png",new Rectangle(1,-35,24,30),21],
               "top":["flagpole.png",new Point(-5,-43)],
               "shadow":["shadow.jpg",new Point(-3,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":51,
         "group":2,
         "order":10,
         "buildStatus":0,
         "type":"special",
         "name":"#b_catapult#",
         "size":190,
         "attackgroup":1,
         "tutstage":200,
         "sale":0,
         "description":"catapult_desc",
         "block":true,
         "costs":[{
            "r1":75000,
            "r2":75000,
            "r3":75000,
            "r4":0,
            "time":90 * 60,
            "re":[[14,1,3],[5,1,1]]
         },{
            "r1":128600,
            "r2":128600,
            "r3":128600,
            "r4":0,
            "time":3 * 60 * 60,
            "re":[[14,1,4],[5,1,1]]
         },{
            "r1":257200,
            "r2":257200,
            "r3":257200,
            "r4":0,
            "time":6 * 60 * 60,
            "re":[[14,1,5],[5,1,1]]
         },{
            "r1":514400,
            "r2":514400,
            "r3":514400,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,6],[5,1,1],[11,1,2]]
         }],
         "imageData":{
            "baseurl":"buildings/catapult/",
            "1":{
               "top":["top.1.png",new Point(-43,12)],
               "shadow":["shadow.1.jpg",new Point(-42,28)],
               "topdamaged":["top.1.damaged.png",new Point(-40,12)],
               "shadowdamaged":["shadow.1.damaged.jpg",new Point(-39,28)],
               "topdestroyed":["top.3.destroyed.png",new Point(-48,9)],
               "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-47,23)]
            },
            "2":{
               "top":["top.2.png",new Point(-44,-21)],
               "shadow":["shadow.2.jpg",new Point(-49,19)],
               "topdamaged":["top.2.damaged.png",new Point(-43,-16)],
               "shadowdamaged":["shadow.2.damaged.jpg",new Point(-41,29)],
               "topdestroyed":["top.3.destroyed.png",new Point(-48,9)],
               "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-47,23)]
            },
            "3":{
               "top":["top.3.png",new Point(-43,-29)],
               "shadow":["shadow.3.jpg",new Point(-39,27)],
               "topdamaged":["top.3.damaged.png",new Point(-51,-29)],
               "shadowdamaged":["shadow.3.damaged.jpg",new Point(-51,30)],
               "topdestroyed":["top.3.destroyed.png",new Point(-48,9)],
               "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-47,23)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"51.1.jpg"},
            "2":{"img":"51.2.jpg"},
            "3":{"img":"51.3.jpg"}
         },
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"51.1.png"},
            "2":{"img":"51.2.png"},
            "3":{"img":"51.3.png"}
         },
         "quantity":[0,0,0,0,0,0],
         "hp":[0xfa0,0x1f40,16000,32000],
         "repairTime":[2 * 60,4 * 60,8 * 60,16 * 60]
      },{
         "id":52,
         "group":999,
         "subgroup":5,
         "order":1,
         "buildStatus":0,
         "type":"taunt",
         "name":"Simple Sign",
         "lifespan":2 * 24 * 60 * 60,
         "size":100,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"Leave a little note for a friend.",
         "block":true,
         "costs":[{
            "r1":100000,
            "r2":100000,
            "r3":100000,
            "r4":100000,
            "r5":0,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flags/",
            "1":{
               "anim":["flag-pirate.png",new Rectangle(1,-25,24,30),21],
               "top":["flagpole.png",new Point(-5,-33)],
               "shadow":["shadow.jpg",new Point(-3,15)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":53,
         "group":999,
         "order":1,
         "buildStatus":0,
         "type":"immovable",
         "name":"hwn_pumpkin",
         "size":10,
         "attackgroup":0,
         "tutstage":0,
         "sale":0,
         "description":"Temporary pumpkin for picking",
         "block":true,
         "quantity":[0],
         "hp":[10],
         "repairTime":[10],
         "imageData":{
            "baseurl":"buildings/decorations/pumpkins/",
            "1":{
               "anim":["anim.png",new Rectangle(-18,-15,37,36),30],
               "shadow":["shadow.jpg",new Point(-22,-1)]
            }
         }
      },{
         "id":54,
         "group":999,
         "order":1,
         "buildStatus":0,
         "type":"immovable",
         "name":"hwn_massivepumpkin",
         "size":10,
         "attackgroup":0,
         "tutstage":0,
         "sale":0,
         "description":"Massive Pumpkin for the \"Event\"",
         "block":true,
         "quantity":[0],
         "hp":[10],
         "repairTime":[10],
         "imageData":{
            "baseurl":"buildings/decorations/pumpkins/",
            "1":{
               "top":["large-top-6.png",new Point(-169,-60)],
               "shadow":["large-shadow-6.jpg",new Point(-168,5)],
               "anim":["large-anim-6.png",new Rectangle(-119,-113,189,155),45]
            }
         }
      },{
         "id":55,
         "group":4,
         "subgroup":1,
         "order":1,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_acorn",
         "size":30,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_acorn_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/acorn/",
            "1":{
               "top":["top.png",new Point(-10,-9)],
               "shadow":["shadow.jpg",new Point(-9,8)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":56,
         "group":4,
         "subgroup":1,
         "order":11,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_beehive",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_beehive_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/beehive/",
            "1":{
               "top":["top.png",new Point(-18,-15)],
               "shadow":["shadow.jpg",new Point(-14,6)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":57,
         "group":4,
         "subgroup":2,
         "order":2,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_birdhous",
         "size":30,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_birdhous_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/birdhouse/",
            "1":{
               "top":["top.png",new Point(-16,-46)],
               "shadow":["shadow.jpg",new Point(-2,17)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":58,
         "group":4,
         "subgroup":2,
         "order":3,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_tent",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_tent_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/campingtent/",
            "1":{
               "top":["top.png",new Point(-30,-12)],
               "shadow":["shadow.jpg",new Point(-29,6)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":59,
         "group":4,
         "subgroup":1,
         "order":5,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_jax",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_jax_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/childrensjax/",
            "1":{
               "top":["top.png",new Point(-11,-11)],
               "shadow":["shadow.jpg",new Point(-7,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":60,
         "group":4,
         "subgroup":2,
         "order":12,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_redgnome",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_gnome_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/gnomes/",
            "1":{
               "top":["top-red.png",new Point(-10,-31)],
               "shadow":["shadow.jpg",new Point(-13,2)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":61,
         "group":4,
         "subgroup":2,
         "order":10,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_bluegnome",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_gnome_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/gnomes/",
            "1":{
               "top":["top-blue.png",new Point(-10,-31)],
               "shadow":["shadow.jpg",new Point(-13,2)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":62,
         "group":4,
         "subgroup":2,
         "order":11,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_greengnome",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_gnome_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/gnomes/",
            "1":{
               "top":["top-green.png",new Point(-10,-31)],
               "shadow":["shadow.jpg",new Point(-13,2)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":63,
         "group":4,
         "subgroup":2,
         "order":5,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_hammock",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_hammock_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/hammock/",
            "1":{
               "top":["top.png",new Point(-25,-8)],
               "shadow":["shadow.jpg",new Point(-26,6)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":64,
         "group":4,
         "subgroup":2,
         "order":6,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_lawnchair",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_lawnchair_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/lawnchair/",
            "1":{
               "top":["top.png",new Point(-24,-14)],
               "shadow":["shadow.jpg",new Point(-25,4)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":65,
         "group":4,
         "subgroup":2,
         "order":4,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_outhouse",
         "size":30,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_outhouse_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/outhouse/",
            "1":{
               "top":["top.png",new Point(-16,-19)],
               "shadow":["shadow.jpg",new Point(-11,10)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":66,
         "group":4,
         "subgroup":1,
         "order":2,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_pinecone",
         "size":30,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_pinecone_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/pinecone/",
            "1":{
               "top":["top.png",new Point(-13,-10)],
               "shadow":["shadow.jpg",new Point(-23,3)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":67,
         "group":4,
         "subgroup":1,
         "order":4,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_rock",
         "size":30,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_rock_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/rock/",
            "1":{
               "top":["top.png",new Point(-15,0)],
               "shadow":["shadow.jpg",new Point(-15,9)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":68,
         "group":4,
         "subgroup":2,
         "order":15,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_scaleelectric",
         "size":100,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_scaleelectric_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/scaleelectriccartoyset/",
            "1":{
               "top":["top.png",new Point(-48,0)],
               "shadow":["shadow.jpg",new Point(-57,8)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":69,
         "group":4,
         "subgroup":1,
         "order":12,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_scarecrow",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"flag_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/scarecrow/",
            "1":{
               "top":["top.png",new Point(-25,-43)],
               "shadow":["shadow.jpg",new Point(-20,8)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":70,
         "group":4,
         "subgroup":2,
         "order":1,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_sundial",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_sundial_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/sundial/",
            "1":{
               "top":["top.png",new Point(-23,-6)],
               "shadow":["shadow.jpg",new Point(-23,8)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":71,
         "group":4,
         "subgroup":2,
         "order":7,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_tikitorch",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_tikitorch_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/tikitorch/",
            "1":{
               "anim":["anim.png",new Rectangle(-11,-71,16,36),25],
               "top":["top.png",new Point(-8,-38)],
               "shadow":["shadow.jpg",new Point(-6,3)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":72,
         "group":4,
         "subgroup":1,
         "order":3,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_walnut",
         "size":30,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_walnut_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/walnut/",
            "1":{
               "top":["top.png",new Point(-12,-2)],
               "shadow":["shadow.jpg",new Point(-23,3)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":73,
         "group":4,
         "subgroup":0,
         "order":15,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_tombstone",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_tombstone_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/graveyardtombstone/",
            "1":{
               "top":["top.png",new Point(-22,-13)],
               "shadow":["shadow.jpg",new Point(-20,9)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":74,
         "group":4,
         "subgroup":0,
         "order":3,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_pokeyhead",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_pokeyhead_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-pokey.png",new Point(-6,-28)],
               "shadow":["shadow.jpg",new Point(-1,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":75,
         "group":4,
         "subgroup":0,
         "order":4,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_octohead",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_octohead_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-octo.png",new Point(-6,-23)],
               "shadow":["shadow.jpg",new Point(-1,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":76,
         "group":4,
         "subgroup":0,
         "order":5,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_bolthead",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_bolthead_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-bolt.png",new Point(-10,-23)],
               "shadow":["shadow.jpg",new Point(-1,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":77,
         "group":4,
         "subgroup":0,
         "order":6,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_banditohead",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_banditohead_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-bandito.png",new Point(-5,-26)],
               "shadow":["shadow.jpg",new Point(-1,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":78,
         "group":4,
         "subgroup":0,
         "order":7,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_brainhead",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_brainhead_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-brain.png",new Point(-9,-28)],
               "shadow":["shadow.jpg",new Point(-1,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":79,
         "group":4,
         "subgroup":0,
         "order":8,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_crabhead",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_crabhead_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-crabatron.png",new Point(-10,-29)],
               "shadow":["shadow.jpg",new Point(-1,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":80,
         "group":4,
         "subgroup":0,
         "order":14,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_davehead",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_davehead_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-dave.png",new Point(-14,-30)],
               "shadow":["shadow.jpg",new Point(-1,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":81,
         "group":4,
         "subgroup":0,
         "order":9,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_eyerahead",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_eyerahead_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-eyera.png",new Point(-4,-23)],
               "shadow":["shadow.jpg",new Point(-1,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":82,
         "group":4,
         "subgroup":0,
         "order":10,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_fanghead",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_fanghead_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-fang.png",new Point(-10,-30)],
               "shadow":["shadow.jpg",new Point(-1,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":83,
         "group":4,
         "subgroup":0,
         "order":11,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_finkhead",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_finkhead_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-fink.png",new Point(-11,-29)],
               "shadow":["shadow.jpg",new Point(-1,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":84,
         "group":4,
         "subgroup":0,
         "order":12,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_ichihead",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_ichihead_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-ichi.png",new Point(-6,-29)],
               "shadow":["shadow.jpg",new Point(-1,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":85,
         "group":4,
         "subgroup":0,
         "order":13,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_projectxhead",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_projectxhead_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-projectx.png",new Point(-19,-24)],
               "shadow":["shadow.jpg",new Point(-1,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":86,
         "group":4,
         "subgroup":1,
         "order":13,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_blackberrybush",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_blackberrybush_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/blackberrybush/",
            "1":{"top":["top.png",new Point(-25,-13)]}
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":87,
         "group":4,
         "subgroup":1,
         "order":16,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_bonsaitree",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_bonsaitree_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/bonsaitree/",
            "1":{
               "top":["top.png",new Point(-41,-36)],
               "shadow":["shadow.jpg",new Point(-22,15)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":88,
         "group":4,
         "subgroup":1,
         "order":14,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_cactus",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_cactus_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/cactus/",
            "1":{
               "top":["top.png",new Point(-14,-30)],
               "shadow":["shadow.jpg",new Point(-12,2)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":89,
         "group":4,
         "subgroup":1,
         "order":15,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_flytrap",
         "size":70,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_flytrap_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flytrap/",
            "1":{
               "top":["top.png",new Point(-33,-5)],
               "shadow":["shadow.jpg",new Point(-38,20)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":90,
         "group":4,
         "subgroup":1,
         "order":12,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_thorns",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_thorns_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/thorns/",
            "1":{
               "top":["top.png",new Point(-23,-18)],
               "shadow":["shadow.jpg",new Point(-25,7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":91,
         "group":4,
         "subgroup":1,
         "order":5,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_pinkflowers",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_pinkflowers_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flowers/",
            "1":{
               "top":["top-pink.png",new Point(-18,-21)],
               "shadow":["shadow.jpg",new Point(-10,2)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":92,
         "group":4,
         "subgroup":1,
         "order":6,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_purpleflowers",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_purpleflowers_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flowers/",
            "1":{
               "top":["top-purple.png",new Point(-18,-21)],
               "shadow":["shadow.jpg",new Point(-10,2)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":93,
         "group":4,
         "subgroup":1,
         "order":9,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_redflowers",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_redflowers_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flowers/",
            "1":{
               "top":["top-red.png",new Point(-18,-21)],
               "shadow":["shadow.jpg",new Point(-10,2)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":94,
         "group":4,
         "subgroup":1,
         "order":7,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_whiteflowers",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_whiteflowers_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flowers/",
            "1":{
               "top":["top-white.png",new Point(-18,-21)],
               "shadow":["shadow.jpg",new Point(-10,2)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":95,
         "group":4,
         "subgroup":1,
         "order":8,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_yellowflowers",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_yellowflowers_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/flowers/",
            "1":{
               "top":["top-yellow.png",new Point(-18,-21)],
               "shadow":["shadow.jpg",new Point(-10,2)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":96,
         "group":4,
         "subgroup":4,
         "order":5,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_baseballstatue",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_baseballstatue_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "buildingbuttons":["96.v2"],
         "imageData":{
            "baseurl":"buildings/decorations/statue-baseball/",
            "1":{
               "top":["top.v2.png",new Point(-20,-36)],
               "shadow":["shadow.v2.jpg",new Point(-21,10)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":97,
         "group":4,
         "subgroup":4,
         "order":6,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_footballstatue",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_footballstatue_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "buildingbuttons":["97.v2"],
         "imageData":{
            "baseurl":"buildings/decorations/statue-football/",
            "1":{
               "top":["top.v2.png",new Point(-19,-39)],
               "shadow":["shadow.v2.jpg",new Point(-17,10)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":98,
         "group":4,
         "subgroup":4,
         "order":7,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_soccerstatue",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_soccerstatue_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "buildingbuttons":["98.v2"],
         "imageData":{
            "baseurl":"buildings/decorations/statue-soccer/",
            "1":{
               "top":["top.v2.png",new Point(-23,-36)],
               "shadow":["shadow.v2.jpg",new Point(-15,12)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":99,
         "group":4,
         "subgroup":4,
         "order":8,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_libertystatue",
         "size":70,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_libertystatue_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "buildingbuttons":["99.v2"],
         "imageData":{
            "baseurl":"buildings/decorations/statue-liberty/",
            "1":{
               "top":["top.v2.png",new Point(-37,-118)],
               "shadow":["shadow.v2.jpg",new Point(-31,20)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":100,
         "group":4,
         "subgroup":4,
         "order":9,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_eiffelstatue",
         "size":70,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_eiffelstatue_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "buildingbuttons":["100.v2"],
         "imageData":{
            "baseurl":"buildings/decorations/statue-eiffeltower/",
            "1":{
               "top":["top.png",new Point(-60,-121)],
               "shadow":["shadow.jpg",new Point(-60,5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":101,
         "group":4,
         "subgroup":4,
         "order":10,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_bigben",
         "size":70,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_bigben_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "buildingbuttons":["101.v2"],
         "imageData":{
            "baseurl":"buildings/decorations/statue-bigben/",
            "1":{
               "top":["top.v2.png",new Point(-32,-104)],
               "shadow":["shadow.v2.jpg",new Point(-32,19)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":102,
         "group":4,
         "subgroup":2,
         "order":13,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_pool",
         "size":100,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_pool_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/pool/",
            "1":{
               "top":["top.png",new Point(-65,8)],
               "shadow":["shadow.jpg",new Point(-65,15)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":103,
         "group":4,
         "subgroup":2,
         "order":14,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_pond",
         "size":100,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_pond_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/pond/",
            "1":{"top":["top.png",new Point(-40,14)]}
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":104,
         "group":4,
         "subgroup":2,
         "order":16,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_zengarden",
         "size":100,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_zengarden_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/zengarden/",
            "1":{
               "top":["top.png",new Point(-72,-5)],
               "shadow":["shadow.jpg",new Point(-72,16)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":105,
         "group":4,
         "subgroup":2,
         "order":17,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_fountain",
         "size":70,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_fountain_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/fountain/",
            "1":{
               "anim":["anim.png",new Rectangle(-47,-51,89,114),42],
               "shadow":["shadow.jpg",new Point(-41,16)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":106,
         "group":4,
         "subgroup":2,
         "order":18,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_teagarden",
         "size":100,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_teargarden_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/japaneseteagarden/",
            "1":{
               "top":["top.png",new Point(-62,-38)],
               "shadow":["shadow.jpg",new Point(-57,12)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":107,
         "group":4,
         "subgroup":0,
         "order":1,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_monsterskull",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_monsterskull_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/headsonsticks/",
            "1":{
               "top":["top-skull.png",new Point(-7,-39)],
               "shadow":["shadow.jpg",new Point(-1,-7)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":108,
         "group":4,
         "subgroup":2,
         "order":8,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_rubikunsolved",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_rubikunsolved_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/rubikscube/",
            "1":{
               "top":["top-unsolved.png",new Point(-20,-23)],
               "shadow":["shadow.jpg",new Point(-22,-5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":109,
         "group":4,
         "subgroup":2,
         "order":9,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_rubiksolved",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_rubiksolved_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":150,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/rubikscube/",
            "1":{
               "top":["top-solved.png",new Point(-20,-23)],
               "shadow":["shadow.jpg",new Point(-22,-5)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":110,
         "group":4,
         "subgroup":4,
         "order":11,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_halloween",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_halloween_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":1000,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/pumpkins/",
            "1":{
               "top":["attended-large-top.png",new Point(-24,-32)],
               "shadow":["attended-large-shadow.jpg",new Point(-25,1)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":111,
         "group":4,
         "subgroup":4,
         "order":12,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_halloween_small",
         "size":20,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_halloween_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":0,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/decorations/pumpkins/",
            "1":{
               "top":["attended-small-top.png",new Point(-10,-4)],
               "shadow":["attended-small-shadow.jpg",new Point(-12,2)]
            }
         },
         "quantity":[6],
         "hp":[100],
         "repairTime":[1]
      },{
         "id":112,
         "group":2,
         "order":1,
         "buildStatus":0,
         "type":"special",
         "name":"#b_outpost#",
         "size":190,
         "attackgroup":1,
         "tutstage":0,
         "sale":0,
         "description":"outpost_desc",
         "block":true,
         "quantity":[0]
      },{
         "id":113,
         "group":2,
         "order":15,
         "buildStatus":0,
         "type":"special",
         "name":"#b_radio#",
         "size":80,
         "attackgroup":1,
         "tutstage":0,
         "sale":0,
         "description":"radio_build_desc",
         "isNew":true,
         "block":true,
         "costs":[{
            "r1":2000,
            "r2":2000,
            "r3":2000,
            "r4":0,
            "time":5 * 60,
            "re":[[14,1,2]]
         }],
         "imageData":{
            "baseurl":"buildings/radiotower/",
            "1":{
               "top":["top.1.png",new Point(-40,-80)],
               "topdamaged":["top.1.damaged.png",new Point(-40,-83)],
               "topdestroyed":["top.destroyed.png",new Point(-41,11)],
               "shadow":["shadow.1.jpg",new Point(-44,7)],
               "shadowdamaged":["shadow.1.damaged.jpg",new Point(-44,7)],
               "shadowdestroyed":["shadow.destroyed.jpg",new Point(-41,19)]
            }
         },
         "quantity":[1,1,1,1,1,1,1,1,1,1],
         "hp":[3400],
         "repairTime":[4 * 60]
      },{
         "id":114,
         "group":3,
         "order":6,
         "buildStatus":0,
         "type":"cage",
         "name":"#b_monstercage#",
         "size":200,
         "attackgroup":2,
         "tutstage":200,
         "sale":0,
         "description":"monstercage_desc",
         "block":true,
         "costs":[{
            "r1":500000,
            "r2":500000,
            "r3":250000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,4]]
         }],
         "imageData":{
            "baseurl":"buildings/monstercage/",
            "1":{
               "top":["top.1.png",new Point(-128,-13)],
               "topopen":["top.1.v2.png",new Point(-129,-13)],
               "shadow":["shadow.1.jpg",new Point(-132,10)],
               "shadowopen":["shadow.1.jpg",new Point(-132,10)]
            }
         },
         "quantity":[0,0,0,0,0,0],
         "hp":[10000],
         "repairTime":[18 * 60]
      },{
         "id":115,
         "group":3,
         "order":5,
         "buildStatus":0,
         "type":"tower",
         "name":"#b_flaktower#",
         "attackgroup":2,
         "tutstage":200,
         "sale":0,
         "description":"flaktower_desc",
         "block":true,
         "stats":[{
            "range":5 * 60,
            "damage":200,
            "rate":60,
            "speed":20,
            "splash":3 * 60
         },{
            "range":320,
            "damage":250,
            "rate":60,
            "speed":24,
            "splash":185
         },{
            "range":340,
            "damage":250,
            "rate":60,
            "speed":28,
            "splash":190
         },{
            "range":6 * 60,
            "damage":250,
            "rate":60,
            "speed":32,
            "splash":195
         },{
            "range":380,
            "damage":5 * 60,
            "rate":60,
            "speed":36,
            "splash":200
         },{
            "range":400,
            "damage":350,
            "rate":60,
            "speed":40,
            "splash":215
         }],
         "costs":[{
            "r1":215000,
            "r2":280000,
            "r3":62500,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":850000,
            "r2":20 * 60 * 1000,
            "r3":250000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":2750000,
            "r2":3400000,
            "r3":750000,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,6]]
         },{
            "r1":5750000,
            "r2":5200000,
            "r3":1250000,
            "r4":0,
            "time":4 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":13500000,
            "r2":11000000,
            "r3":2000000,
            "r4":0,
            "time":6 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":16000000,
            "r2":14000000,
            "r3":4000000,
            "r4":0,
            "time":8 * 24 * 60 * 60,
            "re":[[14,1,9]]
         }],
         "fortify_costs":[{
            "r1":215000,
            "r2":280000,
            "r3":62500,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":850000,
            "r2":20 * 60 * 1000,
            "r3":250000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,6]]
         },{
            "r1":2750000,
            "r2":3400000,
            "r3":750000,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":5750000,
            "r2":5200000,
            "r3":1250000,
            "r4":0,
            "time":4 * 24 * 60 * 60,
            "re":[[14,1,8]]
         }],
         "imageData":{
            "baseurl":"buildings/flaktower/",
            "1":{
               "anim":["anim.3.png",new Rectangle(-32,-23,62,52),32],
               "top":["top.3.png",new Point(-39,6)],
               "shadow":["shadow.3.jpg",new Point(-43,14)],
               "animdamaged":["anim.3.damaged.png",new Rectangle(-29,-17,62,53),32],
               "topdamaged":["top.3.damaged.png",new Point(-39,5)],
               "shadowdamaged":["shadow.3.jpg",new Point(-40,24)],
               "topdestroyed":["top.3.destroyed.png",new Point(-36,13)],
               "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-33,26)],
               "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-45,-13)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"115.jpg"}
         },
         "fortImgData":{
            "baseurl":"buildings/fortifications/",
            "1":{
               "front":["fort70_F1.png",new Point(-73,21)],
               "back":["fort70_B1.png",new Point(-70,-10)]
            },
            "2":{
               "front":["fort70_F2.png",new Point(-69,22)],
               "back":["fort70_B2.png",new Point(-65,-12)]
            },
            "3":{
               "front":["fort70_F3.png",new Point(-72,10)],
               "back":["fort70_B3.png",new Point(-68,-12)]
            },
            "4":{
               "front":["fort70_F4.png",new Point(-70,-11)],
               "back":["fort70_B4.png",new Point(-61,-36)]
            }
         },
         "quantity":[0,0,0,0,0,0],
         "hp":[250 * 60,22000,500 * 60,800 * 60,60 * 1000,20 * 60 * 60],
         "repairTime":[32 * 60,0xf00,128 * 60,9260,200 * 60,5 * 60 * 60]
      },{
         "id":116,
         "group":2,
         "order":12,
         "buildStatus":0,
         "type":"special",
         "name":"#b_monsterlab#",
         "attackgroup":1,
         "tutstage":200,
         "sale":0,
         "description":"monsterlab_desc",
         "block":true,
         "costs":[{
            "r1":100000,
            "r2":100000,
            "r3":0,
            "r4":0,
            "time":3 * 60 * 60,
            "re":[[14,1,5],[8,1,3],[26,1,2]]
         },{
            "r1":5 * 60 * 1000,
            "r2":5 * 60 * 1000,
            "r3":0,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,6],[8,1,4],[26,1,3]]
         },{
            "r1":10 * 60 * 1000,
            "r2":10 * 60 * 1000,
            "r3":0,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,7],[8,1,4],[26,1,4]]
         }],
         "imageData":{
            "baseurl":"buildings/monsterlab/",
            "1":{
               "anim":["anim.1.png",new Rectangle(-28,-30,54,48),32],
               "anim2":["anim.2.png",new Rectangle(-66,26,33,31),5],
               "anim3":["anim.3.png",new Rectangle(32,26,33,31),5],
               "top":["top.1.v2.png",new Point(-74,-96)],
               "shadow":["shadow.1.jpg",new Point(-73,-6)],
               "topdamaged":["top.1.damaged.png",new Point(-73,-80)],
               "shadowdamaged":["shadow.1.jpg",new Point(-72,-6)],
               "topdestroyed":["top.1.destroyed.png",new Point(-80,-10)],
               "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-77,2)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"116.jpg"}
         },
         "quantity":[0,0,0,0,0,0],
         "hp":[150 * 60,16000,400 * 60,32000],
         "repairTime":[3800,128 * 60,10640,260 * 60]
      },{
         "id":117,
         "group":3,
         "order":10,
         "buildStatus":0,
         "type":"trap",
         "name":"#b_heavytrap#",
         "size":90,
         "attackgroup":4,
         "tutstage":200,
         "sale":0,
         "description":"heavytrap_desc",
         "block":true,
         "costs":[{
            "r1":50000,
            "r2":50000,
            "r3":50000,
            "r4":0,
            "time":5,
            "re":[[14,1,4]]
         }],
         "imageData":{
            "baseurl":"buildings/heavytrap/",
            "1":{
               "top":["top.1.png",new Point(-16,-5)],
               "shadow":["shadow.1.jpg",new Point(-18,1)],
               "topdestroyed":["top.1.destroyed.png",new Point(-16,5)],
               "shadowdestroyed":["shadow.1.jpg",new Point(-18,1)]
            }
         },
         "buildingbuttons":["booby_trap.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"booby_trap.v2.jpg",
               "silhouette_img":"booby_trap.v2.silhouette.jpg"
            }
         },
         "quantity":[0,0,0,0,0,0],
         "damage":[10000],
         "hp":[10],
         "repairTime":[1]
      },{
         "id":118,
         "group":3,
         "order":5,
         "buildStatus":0,
         "type":"tower",
         "name":"#b_railguntower#",
         "size":64,
         "attackgroup":3,
         "tutstage":28,
         "sale":0,
         "description":"railguntower_desc",
         "block":true,
         "stats":[{
            "range":5 * 60,
            "damage":400,
            "rate":160,
            "speed":20,
            "splash":0
         },{
            "range":315,
            "damage":10 * 60,
            "rate":160,
            "speed":20,
            "splash":0
         },{
            "range":330,
            "damage":15 * 60,
            "rate":160,
            "speed":20,
            "splash":0
         },{
            "range":345,
            "damage":20 * 60,
            "rate":160,
            "speed":20,
            "splash":0
         },{
            "range":6 * 60,
            "damage":1600,
            "rate":160,
            "speed":20,
            "splash":0
         },{
            "range":380,
            "damage":2000,
            "rate":160,
            "speed":20,
            "splash":0
         }],
         "costs":[{
            "r1":100 * 60 * 1000,
            "r2":100 * 60 * 1000,
            "r3":100 * 60 * 1000,
            "r4":100 * 60 * 1000,
            "time":1,
            "re":[[14,1,9]]
         },{
            "r1":60 * 60 * 1000,
            "r2":50 * 24 * 60 * 60,
            "r3":800 * 60 * 60,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,6]]
         },{
            "r1":75 * 24 * 60 * 60,
            "r2":90 * 24 * 60 * 60,
            "r3":60 * 24 * 60 * 60,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":135 * 24 * 60 * 60,
            "r2":162 * 24 * 60 * 60,
            "r3":108 * 24 * 60 * 60,
            "r4":0,
            "time":4 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":16995200,
            "r2":18194240,
            "r3":16796160,
            "r4":0,
            "time":6 * 24 * 60 * 60,
            "re":[[14,1,8]]
         },{
            "r1":337 * 60 * 1000,
            "r2":24202000,
            "r3":19000000,
            "r4":0,
            "time":8 * 24 * 60 * 60,
            "re":[[14,1,9]]
         }],
         "fortify_costs":[{
            "r1":2000000,
            "r2":40 * 60 * 1000,
            "r3":1600000,
            "r4":0,
            "time":12 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":2600000,
            "r2":3320000,
            "r3":1880000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,6]]
         },{
            "r1":4480000,
            "r2":4776000,
            "r3":2184000,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":9664000,
            "r2":9996800,
            "r3":4331200,
            "r4":0,
            "time":4 * 24 * 60 * 60,
            "re":[[14,1,8]]
         }],
         "imageData":{
            "baseurl":"buildings/railguntower/",
            "1":{
               "anim":["anim.3.loaded.png",new Rectangle(-49,-9,96,56),32],
               "top":["top.3.png",new Point(-39,7)],
               "shadow":["shadow.3.jpg",new Point(-40,20)],
               "animdamaged":["anim.3.damaged.png",new Rectangle(-49,-9,97,56),32],
               "topdamaged":["top.3.damaged.png",new Point(-39,7)],
               "shadowdamaged":["shadow.3.jpg",new Point(-40,20)],
               "topdestroyed":["top.3.destroyed.png",new Point(-34,-5)],
               "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-36,23)],
               "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-45,-13)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"118.jpg"}
         },
         "thumbImgData":{
            "baseurl":"buildingthumbs/",
            "1":{"img":"118.png"}
         },
         "fortImgData":{
            "baseurl":"buildings/fortifications/",
            "1":{
               "front":["fort70_F1.png",new Point(-73,21)],
               "back":["fort70_B1.png",new Point(-70,-10)]
            },
            "2":{
               "front":["fort70_F2.png",new Point(-69,22)],
               "back":["fort70_B2.png",new Point(-65,-12)]
            },
            "3":{
               "front":["fort70_F3.png",new Point(-72,10)],
               "back":["fort70_B3.png",new Point(-68,-12)]
            },
            "4":{
               "front":["fort70_F4.png",new Point(-70,-11)],
               "back":["fort70_B4.png",new Point(-61,-36)]
            }
         },
         "quantity":[0,0,0,0,0,0],
         "hp":[294 * 60,34400,750 * 60,58000,75500,25 * 60 * 60],
         "repairTime":[48 * 60,96 * 60,192 * 60,23000,46000,69000]
      },{
         "id":119,
         "group":3,
         "order":10,
         "buildStatus":0,
         "type":"special",
         "name":"#b_championchamber#",
         "size":64,
         "attackgroup":3,
         "tutstage":28,
         "sale":0,
         "description":"championchamber_desc",
         "block":true,
         "costs":[{
            "r1":500000,
            "r2":500000,
            "r3":250000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,4],[114,1,1]]
         }],
         "imageData":{
            "baseurl":"buildings/champchamber/",
            "1":{
               "top":["top.3.png",new Point(-66,-62)],
               "shadow":["shadow.3.jpg",new Point(-66,10)],
               "topdamaged":["top.3.damaged.png",new Point(-66,-54)],
               "shadowdamaged":["shadow.3.jpg",new Point(-66,4)],
               "topdestroyed":["top.3.png",new Point(-73,-32)],
               "shadowdestroyed":["shadow.3.jpg",new Point(-67,14)]
            }
         },
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"119.jpg",
               "silhouette_img":"119.silhouette.jpg"
            }
         },
         "quantity":[0,0,0,0,0,0,0,0,0,0],
         "hp":[16000],
         "repairTime":[60 * 60]
      },{
         "id":2 * 60,
         "group":3,
         "order":10,
         "buildStatus":0,
         "type":"special",
         "name":"#b_championchamber#",
         "size":64,
         "attackgroup":3,
         "tutstage":28,
         "sale":0,
         "description":"championchamber_desc",
         "block":true,
         "quantity":[0]
      },{
         "id":121,
         "group":4,
         "subgroup":4,
         "order":7,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_wmitotem1",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_wmitotem1_desc",
         "block":true,
         "quantity":[0]
      },{
         "id":122,
         "group":4,
         "subgroup":4,
         "order":7,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_wmitotem2",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_wmitotem2_desc",
         "block":true,
         "quantity":[0]
      },{
         "id":123,
         "group":4,
         "subgroup":4,
         "order":7,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_wmitotem3",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_wmitotem3_desc",
         "block":true,
         "quantity":[0]
      },{
         "id":124,
         "group":4,
         "subgroup":4,
         "order":7,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_wmitotem4",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_wmitotem4_desc",
         "block":true,
         "quantity":[0]
      },{
         "id":125,
         "group":4,
         "subgroup":4,
         "order":7,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_wmitotem5",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_wmitotem5_desc",
         "block":true,
         "quantity":[0]
      },{
         "id":126,
         "group":4,
         "subgroup":4,
         "order":7,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_wmitotem6",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_wmitotem6_desc",
         "block":true,
         "quantity":[0]
      },{
         "id":127,
         "group":999,
         "order":0,
         "buildStatus":0,
         "type":"enemy",
         "name":"#b_infernoentrance#",
         "size":100,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"trojanhorse_desc",
         "isImmobile":true,
         "isUntargetable":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":5,
            "re":[[14,1,1]]
         },{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":5,
            "re":[[14,1,1]]
         },{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":5,
            "re":[[14,1,1]]
         },{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":5,
            "re":[[14,1,1]]
         },{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":5,
            "re":[[14,1,1]]
         }],
         "imageData":{
            "baseurl":"buildings/iportal/",
            "1":{
               "top":["top.1.v2.png",new Point(-85,-5)],
               "shadow":["shadow.1.v2.jpg",new Point(-43,47)]
            },
            "2":{
               "top":["top.2.v2.png",new Point(-105,-29)],
               "shadow":["shadow.2.v2.jpg",new Point(-87,52)]
            },
            "3":{
               "top":["top.3.v2.png",new Point(-136,-64)],
               "shadow":["shadow.3.v2.jpg",new Point(-110,47)]
            },
            "4":{
               "top":["top.4.v2.png",new Point(-140,-114)],
               "shadow":["shadow.v2.4.jpg",new Point(-140,11)]
            },
            "5":{
               "top":["top.5.v2.png",new Point(-160,-172)],
               "shadow":["shadow.5.v2.jpg",new Point(-169,0)]
            }
         },
         "quantity":[0,1,1,1,1,1],
         "damage":[1,1,1,1,1],
         "hp":[1,1,1,1,1],
         "repairTime":[1,1,1,1,1]
      },{
         "id":128,
         "group":2,
         "order":6,
         "buildStatus":0,
         "type":"tower",
         "name":"#bi_housing#",
         "size":200,
         "attackgroup":2,
         "tutstage":50,
         "sale":0,
         "description":"bi_housing_desc",
         "stats":[{"range":500},{"range":530},{"range":560},{"range":590},{"range":620},{"range":650}],
         "costs":[{
            "r1":36 * 60,
            "r2":36 * 60,
            "r3":0,
            "r4":0,
            "time":5 * 60,
            "re":[[14,1,1]]
         },{
            "r1":144 * 60,
            "r2":144 * 60,
            "r3":0,
            "r4":0,
            "time":75 * 60,
            "re":[[14,1,2]]
         },{
            "r1":576 * 60,
            "r2":576 * 60,
            "r3":0,
            "r4":0,
            "time":3 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":138240,
            "r2":138240,
            "r3":0,
            "r4":0,
            "time":0x7080,
            "re":[[14,1,4]]
         },{
            "r1":552960,
            "r2":552960,
            "r3":0,
            "r4":0,
            "time":20 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":2211840,
            "r2":2211840,
            "r3":0,
            "r4":0,
            "time":40 * 60 * 60,
            "re":[[14,1,6],[8,1,1]]
         }],
         "imageData":{
            "baseurl":"buildings/ihousingbunker/",
            "1":{
               "top":["top.1.v2.png",new Point(-110,-49)],
               "shadow":["shadow.1.jpg",new Point(-118,26)],
               "topdamaged":["top.1.damaged.v2.png",new Point(-106,-39)],
               "shadowdamaged":["shadow.1.damaged.jpg",new Point(-117,30)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-73,10)],
               "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-96,8)]
            }
         },
         "buildingbuttons":["monster_housing.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"monster_housing.v2.jpg"}
         },
         "quantity":[0,1,1,1,1,1,1],
         "capacity":[200,5 * 60,520,13 * 60,19 * 60,1820],
         "hp":[0xfa0,14000,25000,43000,75000,130000],
         "repairTime":[100,200,5 * 60,400,500,10 * 60]
      },{
         "id":129,
         "group":3,
         "order":2,
         "buildStatus":0,
         "type":"tower",
         "name":"#bi_quaketower#",
         "size":64,
         "attackgroup":1,
         "tutstage":200,
         "sale":0,
         "description":"bi_quaketower_desc",
         "block":false,
         "stats":[{
            "range":160,
            "damage":1100,
            "rate":15
         },{
            "range":170,
            "damage":28 * 60,
            "rate":15
         },{
            "range":3 * 60,
            "damage":37 * 60,
            "rate":15
         },{
            "range":190,
            "damage":48 * 60,
            "rate":15
         },{
            "range":200,
            "damage":3640,
            "rate":15
         },{
            "range":210,
            "damage":4400,
            "rate":15
         }],
         "costs":[{
            "r1":312500,
            "r2":187500,
            "r3":125000,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":1250000,
            "r2":750000,
            "r3":500000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":3750000,
            "r2":625 * 60 * 60,
            "r3":25 * 60 * 1000,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":7187500,
            "r2":4312500,
            "r3":2875000,
            "r4":0,
            "time":3 * 24 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":200 * 60 * 1000,
            "r2":9000000,
            "r3":100 * 60 * 1000,
            "r4":0,
            "time":108 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":275 * 60 * 1000,
            "r2":12687500,
            "r3":7562500,
            "r4":0,
            "time":132 * 60 * 60,
            "re":[[14,1,6]]
         }],
         "fortify_costs":[{
            "r1":50000,
            "r2":625 * 60,
            "r3":12500,
            "r4":0,
            "time":135 * 60,
            "re":[[14,1,5]]
         },{
            "r1":250000,
            "r2":187500,
            "r3":62500,
            "r4":0,
            "time":405 * 60,
            "re":[[14,1,6]]
         },{
            "r1":1250000,
            "r2":937500,
            "r3":312500,
            "r4":0,
            "time":72900,
            "re":[[14,1,7]]
         },{
            "r1":6250000,
            "r2":4687500,
            "r3":1562500,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,8]]
         }],
         "imageData":{
            "baseurl":"buildings/iquaketower/",
            "1":{
               "anim":["anim.1.png",new Rectangle(-37,-75,75,132),33],
               "shadow":["shadow.1.v2.jpg",new Point(-37,17)],
               "topdamaged":["top.1.damaged.png",new Point(-40,-75)],
               "animdamaged":["anim.1.damaged.png",new Rectangle(-40,-75,84,133),33],
               "shadowdamaged":["shadow.1.v2.jpg",new Point(-40,16)],
               "topdestroyed":["top.1.destroyed.png",new Point(-42,-8)],
               "shadowdestroyed":["shadow.1.v2.jpg",new Point(-44,10)]
            }
         },
         "buildingbuttons":["quake_tower.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"quake_tower.v2.jpg",
               "silhouette_img":"quake_tower.v2.silhouette.jpg"
            }
         },
         "fortImgData":{
            "baseurl":"buildings/fortifications/",
            "1":{
               "front":["fort70_F1.png",new Point(-73,21)],
               "back":["fort70_B1.png",new Point(-70,-10)]
            },
            "2":{
               "front":["fort70_F2.png",new Point(-69,22)],
               "back":["fort70_B2.png",new Point(-65,-12)]
            },
            "3":{
               "front":["fort70_F3.png",new Point(-72,10)],
               "back":["fort70_B3.png",new Point(-68,-12)]
            },
            "4":{
               "front":["fort70_F4.png",new Point(-70,-11)],
               "back":["fort70_B4.png",new Point(-61,-36)]
            }
         },
         "quantity":[0,0,0,2,2,4,4],
         "hp":[10000,16000,22000,28000,34000,800 * 60],
         "repairTime":[24 * 60,48 * 60,96 * 60,192 * 60,23000,46000]
      },{
         "id":130,
         "group":3,
         "order":2,
         "buildStatus":0,
         "type":"tower",
         "name":"#bi_cannontower#",
         "size":64,
         "attackgroup":1,
         "tutstage":200,
         "sale":0,
         "description":"bi_cannontower_desc",
         "stats":[{
            "range":160,
            "damage":20,
            "rate":40,
            "speed":5,
            "splash":30
         },{
            "range":170,
            "damage":40,
            "rate":40,
            "speed":6,
            "splash":35
         },{
            "range":3 * 60,
            "damage":60,
            "rate":40,
            "speed":7,
            "splash":40
         },{
            "range":190,
            "damage":80,
            "rate":40,
            "speed":8,
            "splash":45
         },{
            "range":200,
            "damage":100,
            "rate":40,
            "speed":8,
            "splash":50
         },{
            "range":210,
            "damage":2 * 60,
            "rate":40,
            "speed":8,
            "splash":55
         },{
            "range":220,
            "damage":140,
            "rate":40,
            "speed":8,
            "splash":60
         }],
         "costs":[{
            "r1":2000,
            "r2":25 * 60,
            "r3":500,
            "r4":0,
            "time":30,
            "re":[[14,1,1]]
         },{
            "r1":10000,
            "r2":125 * 60,
            "r3":2500,
            "r4":0,
            "time":15 * 60,
            "re":[[14,1,2]]
         },{
            "r1":50000,
            "r2":625 * 60,
            "r3":12500,
            "r4":0,
            "time":45 * 60,
            "re":[[14,1,3]]
         },{
            "r1":250000,
            "r2":187500,
            "r3":62500,
            "r4":0,
            "time":135 * 60,
            "re":[[14,1,4]]
         },{
            "r1":1250000,
            "r2":937500,
            "r3":312500,
            "r4":0,
            "time":405 * 60,
            "re":[[14,1,4]]
         },{
            "r1":6250000,
            "r2":4687500,
            "r3":1562500,
            "r4":0,
            "time":72900,
            "re":[[14,1,5]]
         },{
            "r1":9375000,
            "r2":7000000,
            "r3":1562500,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,6]]
         }],
         "fortify_costs":[{
            "r1":50000,
            "r2":625 * 60,
            "r3":12500,
            "r4":0,
            "time":135 * 60,
            "re":[[14,1,5]]
         },{
            "r1":250000,
            "r2":187500,
            "r3":62500,
            "r4":0,
            "time":405 * 60,
            "re":[[14,1,6]]
         },{
            "r1":1250000,
            "r2":937500,
            "r3":312500,
            "r4":0,
            "time":72900,
            "re":[[14,1,7]]
         },{
            "r1":6250000,
            "r2":4687500,
            "r3":1562500,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,8]]
         }],
         "imageData":{
            "baseurl":"buildings/icannontower/",
            "1":{
               "anim":["anim.1.v2.png",new Rectangle(-38,-53,74,64),30],
               "animdamaged":["anim.1.damaged.v2.png",new Rectangle(-38,-53,74,64),30],
               "top":["top.1.v2.png",new Point(-38,11)],
               "shadow":["shadow.1.v2.jpg",new Point(-48,11)],
               "topdamaged":["top.1.damaged.v2.png",new Point(-38,11)],
               "shadowdamaged":["shadow.1.v2.jpg",new Point(-48,11)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-38,11)],
               "shadowdestroyed":["shadow.1.v2.jpg",new Point(-48,11)]
            }
         },
         "buildingbuttons":["canon_tower.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{"img":"canon_tower.v2.jpg"}
         },
         "fortImgData":{
            "baseurl":"buildings/fortifications/",
            "1":{
               "front":["fort70_F1.png",new Point(-73,21)],
               "back":["fort70_B1.png",new Point(-70,-10)]
            },
            "2":{
               "front":["fort70_F2.png",new Point(-69,22)],
               "back":["fort70_B2.png",new Point(-65,-12)]
            },
            "3":{
               "front":["fort70_F3.png",new Point(-72,10)],
               "back":["fort70_B3.png",new Point(-68,-12)]
            },
            "4":{
               "front":["fort70_F4.png",new Point(-70,-11)],
               "back":["fort70_B4.png",new Point(-61,-36)]
            }
         },
         "quantity":[0,2,3,3,4,4,6],
         "hp":[100 * 60,150 * 60,210 * 60,294 * 60,441 * 60,34400,750 * 60],
         "repairTime":[6 * 60,12 * 60,24 * 60,48 * 60,96 * 60,192 * 60,23000]
      },{
         "id":131,
         "group":4,
         "subgroup":4,
         "order":8,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_wmi2totem",
         "size":40,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_wmi2totem_desc",
         "block":true,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":0,
            "time":0,
            "re":[]
         },{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":0,
            "time":0,
            "re":[]
         },{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":0,
            "time":0,
            "re":[]
         },{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":0,
            "time":0,
            "re":[]
         },{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":0,
            "time":0,
            "re":[]
         },{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":0,
            "time":0,
            "re":[]
         }],
         "names":["bdg_wmi2totem1","bdg_wmi2totem2","bdg_wmi2totem3","bdg_wmi2totem4","bdg_wmi2totem5","bdg_wmi2totem6"],
         "descriptions":["bdg_wmi2totem1_desc","bdg_wmi2totem2_desc","bdg_wmi2totem3_desc","bdg_wmi2totem4_desc","bdg_wmi2totem5_desc","bdg_wmi2totem6_desc"],
         "buildingbuttons":["131.bb1","131.bb2","131.bb3","131.bb4","131.bb5.v2","131.bb6"],
         "imageData":{
            "baseurl":"buildings/decorations/wmitotem2/",
            "1":{
               "top":["top1.png",new Point(-31,-25)],
               "shadow":["shadow1.jpg",new Point(-55,-20)]
            },
            "2":{
               "top":["top2.png",new Point(-31,-60)],
               "shadow":["shadow2.jpg",new Point(-64,-44)]
            },
            "3":{
               "top":["top3.png",new Point(-31,-86)],
               "shadow":["shadow3.jpg",new Point(-66,-61)]
            },
            "4":{
               "top":["top4.png",new Point(-31,-122)],
               "shadow":["shadow4.jpg",new Point(-66,-83)]
            },
            "5":{
               "top":["top5.v2.png",new Point(-30,-125)],
               "shadow":["shadow4.jpg",new Point(-66,-83)]
            },
            "6":{
               "top":["top6.png",new Point(-31,-128)],
               "shadow":["shadow4.jpg",new Point(-66,-83)]
            }
         },
         "quantity":[0],
         "hp":[100,100,100,100,100,100],
         "repairTime":[1,1,1,1,1,1,1]
      },{
         "id":132,
         "group":3,
         "order":5,
         "buildStatus":0,
         "type":"tower",
         "name":"#bi_magmatower#",
         "attackgroup":2,
         "tutstage":200,
         "sale":0,
         "description":"bi_magmatower_desc",
         "block":false,
         "stats":[{
            "range":3 * 60,
            "damage":3 * 60,
            "rate":20,
            "speed":14,
            "splash":0
         },{
            "range":190,
            "damage":4 * 60,
            "rate":20,
            "speed":15,
            "splash":0
         },{
            "range":200,
            "damage":5 * 60,
            "rate":20,
            "speed":16,
            "splash":0
         },{
            "range":210,
            "damage":6 * 60,
            "rate":20,
            "speed":17,
            "splash":0
         },{
            "range":220,
            "damage":7 * 60,
            "rate":20,
            "speed":18,
            "splash":0
         },{
            "range":230,
            "damage":8 * 60,
            "rate":20,
            "speed":19,
            "splash":0
         }],
         "costs":[{
            "r1":187500,
            "r2":250000,
            "r3":62500,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,3]]
         },{
            "r1":750000,
            "r2":1000000,
            "r3":250000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":625 * 60 * 60,
            "r2":50 * 60 * 1000,
            "r3":750000,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,4]]
         },{
            "r1":5250000,
            "r2":5000000,
            "r3":1250000,
            "r4":0,
            "time":4 * 24 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":200 * 60 * 1000,
            "r2":10000000,
            "r3":2000000,
            "r4":0,
            "time":6 * 24 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":16000000,
            "r2":250 * 60 * 1000,
            "r3":50 * 60 * 1000,
            "r4":0,
            "time":791200,
            "re":[[14,1,6]]
         }],
         "fortify_costs":[{
            "r1":215000,
            "r2":280000,
            "r3":62500,
            "r4":0,
            "time":5 * 60 * 60,
            "re":[[14,1,5]]
         },{
            "r1":850000,
            "r2":20 * 60 * 1000,
            "r3":250000,
            "r4":0,
            "time":24 * 60 * 60,
            "re":[[14,1,6]]
         },{
            "r1":2750000,
            "r2":3400000,
            "r3":750000,
            "r4":0,
            "time":2 * 24 * 60 * 60,
            "re":[[14,1,7]]
         },{
            "r1":5750000,
            "r2":5200000,
            "r3":1250000,
            "r4":0,
            "time":4 * 24 * 60 * 60,
            "re":[[14,1,8]]
         }],
         "imageData":{
            "baseurl":"buildings/imagmatower/",
            "1":{
               "anim":["anim.1.v2.png",new Rectangle(-26,-50,54,42),31],
               "anim2":["anim.2.v2.png",new Rectangle(-17,26,38,19),31],
               "top":["top.1.v2.png",new Point(-34,-9)],
               "shadow":["shadow.1.v2.jpg",new Point(-31,10)],
               "animdamaged":["anim.1.damaged.v2.png",new Rectangle(-28.6,-47.6,52,43),31],
               "animdamaged2":["anim.2.damaged.v2.png",new Rectangle(-21,28,38,19),31],
               "topdamaged":["top.1.damaged.v2.png",new Point(-38,-4)],
               "shadowdamaged":["shadow.1.v2.jpg",new Point(-38,16)],
               "topdestroyed":["top.1.destroyed.v2.png",new Point(-36,6)],
               "shadowdestroyed":["shadow.1.destroyed.v2.jpg",new Point(-36,22)]
            }
         },
         "buildingbuttons":["magma_tower.v2"],
         "upgradeImgData":{
            "baseurl":"buildingbuttons/",
            "1":{
               "img":"magma_tower.v2.jpg",
               "silhouette_img":"magma_tower.v2.silhouette.jpg"
            }
         },
         "fortImgData":{
            "baseurl":"buildings/fortifications/",
            "1":{
               "front":["fort70_F1.png",new Point(-73,21)],
               "back":["fort70_B1.png",new Point(-70,-10)]
            },
            "2":{
               "front":["fort70_F2.png",new Point(-69,22)],
               "back":["fort70_B2.png",new Point(-65,-12)]
            },
            "3":{
               "front":["fort70_F3.png",new Point(-72,10)],
               "back":["fort70_B3.png",new Point(-68,-12)]
            },
            "4":{
               "front":["fort70_F4.png",new Point(-70,-11)],
               "back":["fort70_B4.png",new Point(-61,-36)]
            }
         },
         "quantity":[0,0,0,1,2,2,3],
         "hp":[250 * 60,22000,500 * 60,49000,59000,70000],
         "repairTime":[24 * 60,48 * 60,96 * 60,192 * 60,23000,46000,92000]
      },{
         "id":133,
         "group":2,
         "order":8,
         "buildStatus":0,
         "type":"special",
         "name":"#b_siegefactory#",
         "size":90,
         "attackgroup":2,
         "tutstage":200,
         "sale":0,
         "description":"b_siegefactory_desc",
         "block":true,
         "cls":SiegeFactory,
         "hitCls":siegeFactoryHit,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":0,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/siegefactory/",
            "1":{
               "top":["top.1.png",new Point(-75,-23)],
               "topdamaged":["top.1.damaged.png",new Point(-75,-96)],
               "topdestroyed":["top.1.destroyed.png",new Point(-75,-48)],
               "anim":["anim.1.png",new Rectangle(-76,-101,154,80),34]
            }
         },
         "stats":[{
            "range":200,
            "duration":380,
            "radius":200
         },{
            "range":210,
            "duration":390,
            "radius":210
         },{
            "range":235,
            "duration":400,
            "radius":235
         },{
            "range":335,
            "duration":410,
            "radius":335
         },{
            "range":6 * 60,
            "duration":200,
            "radius":6 * 60
         },{
            "range":370,
            "duration":210,
            "radius":370
         },{
            "range":380,
            "duration":235,
            "radius":380
         },{
            "range":390,
            "duration":335,
            "radius":390
         },{
            "range":400,
            "duration":6 * 60,
            "radius":400
         },{
            "range":410,
            "duration":370,
            "radius":410
         }],
         "quantity":[1,1,1,1,1,1,1,1,1,1],
         "hp":[100,100,100,100,100,100],
         "repairTime":[1,1,1,1,1,1,1]
      },{
         "id":134,
         "group":2,
         "order":8,
         "buildStatus":0,
         "type":"special",
         "name":"#b_siegeworks#",
         "size":90,
         "attackgroup":2,
         "tutstage":200,
         "sale":0,
         "description":"b_siegeworks_desc",
         "block":true,
         "cls":SiegeLab,
         "hitCls":siegeLabHit,
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":0,
            "time":0,
            "re":[]
         }],
         "imageData":{
            "baseurl":"buildings/siegelab/",
            "1":{
               "top":["top.1.png",new Point(-68,-66)],
               "topdamaged":["top.1.damaged.png",new Point(-69,-111)],
               "topdestroyed":["top.1.destroyed.png",new Point(-68,-47)],
               "anim":["anim.1.png",new Rectangle(-70,-106,118,166),60]
            }
         },
         "stats":[{
            "range":200,
            "duration":380,
            "radius":200
         },{
            "range":210,
            "duration":390,
            "radius":210
         },{
            "range":235,
            "duration":400,
            "radius":235
         },{
            "range":335,
            "duration":410,
            "radius":335
         },{
            "range":6 * 60,
            "duration":200,
            "radius":6 * 60
         },{
            "range":370,
            "duration":210,
            "radius":370
         },{
            "range":380,
            "duration":235,
            "radius":380
         },{
            "range":390,
            "duration":335,
            "radius":390
         },{
            "range":400,
            "duration":6 * 60,
            "radius":400
         },{
            "range":410,
            "duration":370,
            "radius":410
         }],
         "quantity":[1,1,1,1,1,1,1,1,1,1],
         "hp":[100,100,100,100,100,100],
         "repairTime":[1,1,1,1,1,1,1]
      },{
         "id":135,
         "group":4,
         "subgroup":4,
         "order":11,
         "buildStatus":0,
         "type":"decoration",
         "name":"bdg_dave_trophy",
         "size":70,
         "attackgroup":999,
         "tutstage":200,
         "sale":0,
         "description":"bdg_dave_trophy_desc",
         "block":true,
         "locked":true,
         "lockedButtonOverlay":"buildingbuttons/135locked.png",
         "costs":[{
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":0,
            "time":0,
            "re":[]
         }],
         "buildingbuttons":["135"],
         "imageData":{
            "baseurl":"buildings/decorations/dave_trophy/",
            "1":{
               "top":["top.png",new Point(-38,-30)],
               "shadow":["shadow.jpg",new Point(-38,20)]
            }
         },
         "quantity":[0],
         "hp":[100],
         "repairTime":[1]
      }];
      
      public function INFERNOYARDPROPS()
      {
         super();
      }
   }
}

