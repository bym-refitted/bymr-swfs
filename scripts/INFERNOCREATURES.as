package
{
   public class INFERNOCREATURES
   {
      public static var infernoCreatures:* = {
         "IC1":{
            "page":1,
            "order":1,
            "resource":40 * 60,
            "time":60 * 60,
            "level":1,
            "name":"#m_spurtz#",
            "description":"spurtz",
            "stream":["mon_spurtzstream","mon_spurtzstreambody","quests/monster1.v2.png"],
            "trainingCosts":[[40 * 60,60 * 60],[80 * 60,2 * 60 * 60],[2 * 60 * 60,3 * 60 * 60],[160 * 60,4 * 60 * 60],[4 * 60 * 60,6 * 60 * 60]],
            "props":{
               "speed":[1.2],
               "health":[400,425,450,475,510,550],
               "damage":[2 * 60,130,140,150,160,175],
               "cTime":[15,10,8,7,6,5],
               "cResource":[500,1000,2000,0xfa0,100 * 60,10000],
               "cStorage":[10],
               "bucket":[20],
               "targetGroup":[1]
            }
         },
         "IC2":{
            "page":1,
            "order":2,
            "resource":80 * 60,
            "time":4 * 60 * 60,
            "level":1,
            "name":"#m_zagnoid#",
            "description":"zagnoid",
            "stream":["mon_zagnoidstream","mon_zagnoidstreambody","quests/monster1.v2.png"],
            "trainingCosts":[[80 * 60,4 * 60 * 60],[160 * 60,0x7080],[4 * 60 * 60,12 * 60 * 60],[320 * 60,16 * 60 * 60],[0x7080,24 * 60 * 60]],
            "props":{
               "speed":[0.9,0.9,0.9,0.9,0.9,0.9],
               "health":[25 * 60,27 * 60,1760,1900,2150,2300],
               "damage":[80,85,90,95,100,110],
               "cTime":[15,16,16,16,16,16],
               "cResource":[2500,0xfa0,0x1f40,200 * 60,16000,20000],
               "cStorage":[15],
               "bucket":[20],
               "targetGroup":[4]
            }
         },
         "IC4":{
            "page":2,
            "order":1,
            "resource":640 * 60,
            "time":18 * 60 * 60,
            "level":2,
            "name":"#m_valgos#",
            "description":"valgos",
            "stream":["mon_valgosstream","mon_valgosstreambody","quests/monster1.v2.png"],
            "trainingCosts":[[640 * 60,18 * 60 * 60],[76800,36 * 60 * 60],[32 * 60 * 60,54 * 60 * 60],[153600,3 * 24 * 60 * 60],[64 * 60 * 60,108 * 60 * 60]],
            "movement":"burrow",
            "pathing":"direct",
            "props":{
               "speed":[2,2,2,2,2,2],
               "health":[715,730,750,765,13 * 60,800],
               "damage":[490,530,580,645,700,775],
               "cTime":[450,350,250,225,195,195],
               "cResource":[31000,35000,650 * 60,44000,50000,55000],
               "cStorage":[30],
               "bucket":[20],
               "targetGroup":[2]
            }
         },
         "IC3":{
            "page":2,
            "order":2,
            "resource":76800,
            "time":18 * 60 * 60,
            "level":2,
            "name":"#m_malphus#",
            "description":"malphus",
            "stream":["mon_malphusstream","mon_malphusstreambody","quests/monster1.v2.png"],
            "trainingCosts":[[76800,18 * 60 * 60],[153600,36 * 60 * 60],[64 * 60 * 60,54 * 60 * 60],[307200,3 * 24 * 60 * 60],[128 * 60 * 60,108 * 60 * 60]],
            "movement":"jump",
            "props":{
               "speed":[2,2.048,2.097152,2.147483648,2.199023255552,2.25179981368525],
               "health":[450,470,500,9 * 60,580,620],
               "damage":[100,105,110,2 * 60,130,140],
               "cTime":[100,100,90,90,90,90],
               "cResource":[50 * 60,3500,4100,80 * 60,5500,7000],
               "cStorage":[15],
               "bucket":[20],
               "targetGroup":[3]
            }
         },
         "IC5":{
            "page":3,
            "order":1,
            "resource":614400,
            "time":24 * 60 * 60,
            "level":3,
            "name":"#m_balthazar#",
            "description":"balthazar",
            "stream":["mon_balthazarstream","mon_balthazarstreambody","quests/monster1.v2.png"],
            "trainingCosts":[[614400,24 * 60 * 60],[1228800,2 * 24 * 60 * 60],[512 * 60 * 60,3 * 24 * 60 * 60],[2457600,4 * 24 * 60 * 60],[3686400,6 * 24 * 60 * 60]],
            "movement":"fly",
            "pathing":"direct",
            "props":{
               "speed":[3],
               "health":[800,14 * 60,880,920,965,1125],
               "damage":[400,430,460,490,520,560],
               "cTime":[30 * 60,32 * 60,34 * 60,36 * 60,38 * 60,40 * 60],
               "cResource":[800 * 60,15 * 60 * 60,61000,69000,77000,87000],
               "cStorage":[40],
               "bucket":[60],
               "targetGroup":[5]
            }
         },
         "IC6":{
            "page":3,
            "order":2,
            "resource":1228800,
            "time":24 * 60 * 60,
            "level":3,
            "name":"#m_grokus#",
            "description":"grokus",
            "stream":["mon_grokusstream","mon_grokusstreambody","quests/monster1.v2.png"],
            "trainingCosts":[[1228800,24 * 60 * 60],[2457600,2 * 24 * 60 * 60],[3686400,3 * 24 * 60 * 60],[4915200,4 * 24 * 60 * 60],[0x708000,6 * 24 * 60 * 60]],
            "props":{
               "speed":[0.9,1,1.1,1.2,1.3,1.4],
               "health":[1600,1750,1900,35 * 60,2300,2500],
               "damage":[400,425,450,475,500,550],
               "cTime":[100,100,100,100,90,90],
               "cResource":[40000,750 * 60,55000,75000,100000,125000],
               "cStorage":[50],
               "bucket":[60],
               "targetGroup":[3]
            }
         },
         "IC7":{
            "page":3,
            "order":3,
            "resource":2457600,
            "time":2 * 24 * 60 * 60,
            "level":3,
            "name":"#m_sabnox#",
            "description":"sabnox",
            "stream":["mon_sabnoxstream","mon_sabnoxstreambody","quests/monster1.v2.png"],
            "trainingCosts":[[2457600,2 * 24 * 60 * 60],[4915200,4 * 24 * 60 * 60],[0x708000,6 * 24 * 60 * 60],[9830400,8 * 24 * 60 * 60],[14745600,12 * 24 * 60 * 60]],
            "props":{
               "speed":[1.7,1.8,1.9,2,2.1,2.2],
               "health":[920,16 * 60,1000,1050,1100,20 * 60],
               "damage":[500,525,550,575,10 * 60,650],
               "cTime":[1384,1384,1384,1384,1384,1384],
               "cResource":[60 * 1000,70000,85000,110000,130000,150000],
               "cStorage":[80],
               "bucket":[90],
               "targetGroup":[4]
            }
         },
         "IC8":{
            "page":4,
            "order":1,
            "resource":4915200,
            "time":3 * 24 * 60 * 60,
            "level":4,
            "name":"#m_king_wormzer#",
            "description":"king_wormzer",
            "stream":["mon_king_wormzerstream","mon_king_wormzerstreambody","quests/monster1.v2.png"],
            "trainingCosts":[[4915200,3 * 24 * 60 * 60],[9830400,6 * 24 * 60 * 60],[14745600,9 * 24 * 60 * 60],[19660800,12 * 24 * 60 * 60],[29491200,18 * 24 * 60 * 60]],
            "movement":"burrow",
            "pathing":"direct",
            "props":{
               "speed":[2.5,2.6,2.7,2.8,2.9,3],
               "health":[2500,2600,45 * 60,2900,3100,3400],
               "damage":[15 * 60,16 * 60,1030,1120,1220,1350],
               "cTime":[1384,1384,1384,1384,1384,1384],
               "cResource":[425000,476000,580000,700000,910000,1204000],
               "cStorage":[100],
               "bucket":[100],
               "targetGroup":[1]
            }
         }
      };
      
      public function INFERNOCREATURES()
      {
         super();
      }
   }
}

