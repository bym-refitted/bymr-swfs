package
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class CREATURELOCKER
   {
      public static var _lockerData:Object;
      
      public static var _open:Boolean;
      
      public static var _mc:CREATURELOCKERPOPUP;
      
      public static var _mainCreatures:Object;
      
      public static var _page:int;
      
      public static var _unlocking:String;
      
      public static var _popupCreatureID:String;
      
      public function CREATURELOCKER()
      {
         super();
      }
      
      public static function get _creatures() : Object
      {
         return _mainCreatures;
      }
      
      public static function getFirstCreatureID() : String
      {
         return BASE.isInferno() ? "IC1" : "C1";
      }
      
      public static function Data(param1:Object) : void
      {
         var _loc2_:int = 0;
         _lockerData = param1;
         _lockerData[getFirstCreatureID()] = {"t":2};
         if(_lockerData.C100)
         {
            _lockerData.C12 = _lockerData.C100;
            delete _lockerData.C100;
         }
         if(GLOBAL._mode == "build" && !BASE.isInferno())
         {
            _loc2_ = 2;
            while(_loc2_ <= 15)
            {
               if(Boolean(_lockerData["C" + _loc2_]) && _lockerData["C" + _loc2_].t == 2)
               {
                  ACHIEVEMENTS.Check("unlock_monster",1);
                  break;
               }
               _loc2_++;
            }
         }
      }
      
      public static function Setup() : *
      {
         _page = 1;
         _popupCreatureID = getFirstCreatureID();
         _lockerData = {};
         _open = false;
         _mainCreatures = {
            "C1":{
               "page":1,
               "order":1,
               "resource":0xfa0,
               "time":600,
               "level":1,
               "name":"#m_pokey#",
               "description":"mon_pokeydesc",
               "stream":["mon_pokeystream","mon_pokeystreambody","quests/monster1.v2.png"],
               "unlock":[""],
               "trainingCosts":[[0xfa0,7200],[0x1f40,10800],[200 * 60,18000],[16000,28800],[22000,43200]],
               "props":{
                  "speed":[1.2],
                  "health":[200,220,4 * 60,260,280,5 * 60],
                  "damage":[60,65,70,75,80,85],
                  "cTime":[15,10,8,7,6,5],
                  "cResource":[250,450,675,800,1000,1250],
                  "cStorage":[10,10,10,9,8,7],
                  "bucket":[20],
                  "targetGroup":[1]
               }
            },
            "C2":{
               "page":1,
               "order":2,
               "resource":0x1f40,
               "time":3600,
               "level":1,
               "name":"#m_octoooze#",
               "description":"mon_octooozedesc",
               "stream":["mon_octooozestream","mon_octooozestreambody","quests/monster2.v2.png"],
               "trainingCosts":[[0x1f40,14400],[16000,21600],[400 * 60,36000],[800 * 60,57600],[64000,86400]],
               "props":{
                  "speed":[1.4],
                  "health":[1000,1100,1300,1450,1600,30 * 60],
                  "damage":[15,15,20,25,30,35],
                  "cTime":[15,16],
                  "cResource":[500,15 * 60,1350,30 * 60,35 * 60,2500],
                  "cStorage":[10],
                  "bucket":[20],
                  "targetGroup":[4]
               }
            },
            "C3":{
               "page":1,
               "order":3,
               "resource":16000,
               "time":7200,
               "level":1,
               "name":"#m_bolt#",
               "description":"mon_boltdesc",
               "stream":["mon_boltstream","mon_boltstreambody","quests/monster3.v2.png"],
               "trainingCosts":[[16000,14400],[32000,21600],[800 * 60,28800],[96000,43200],[40 * 60 * 60,57600]],
               "props":{
                  "speed":[2.5,2.55,2.6,2.8,3,3.2],
                  "health":[150],
                  "damage":[15,20,25,35,45,55],
                  "cTime":[23],
                  "cResource":[350,675,1015,1400,30 * 60,40 * 60],
                  "cStorage":[15],
                  "bucket":[30],
                  "targetGroup":[3]
               }
            },
            "C4":{
               "page":1,
               "order":4,
               "resource":32000,
               "time":14400,
               "level":1,
               "name":"#m_fink#",
               "description":"mon_finkdesc",
               "stream":["mon_finkstream","mon_finkstreambody","quests/monster4.v2.png"],
               "trainingCosts":[[32000,28800],[64000,43200],[96000,64800],[128000,86400],[160000,108000]],
               "props":{
                  "speed":[1.3],
                  "health":[200,200,200,200,220,4 * 60],
                  "damage":[5 * 60,330,380,430,470,520],
                  "cTime":[100,100,100,100,90,90],
                  "cResource":[25 * 60,2250,3375,80 * 60,2 * 60 * 60,10000],
                  "cStorage":[20],
                  "bucket":[30],
                  "targetGroup":[1]
               }
            },
            "C5":{
               "page":2,
               "order":1,
               "resource":64000,
               "time":28800,
               "level":2,
               "name":"#m_eyera#",
               "description":"mon_eyeradesc",
               "stream":["mon_eyerastream","mon_eyerastreambody","quests/monster5.v2.png"],
               "trainingCosts":[[64000,18000],[128000,25200],[192000,43200],[384000,86400],[512000,129600]],
               "props":{
                  "speed":[2,2.2,2.4,2.6,2.8,3],
                  "health":[10 * 60,15 * 60,20 * 60,1600,2000,40 * 60],
                  "damage":[0xfa0,0x1f40,200 * 60,16000,20000,400 * 60],
                  "cTime":[25 * 60],
                  "cResource":[5000,250 * 60,500 * 60,750 * 60,60 * 1000,80000],
                  "cStorage":[60],
                  "bucket":[100],
                  "targetGroup":[2],
                  "explode":[1]
               }
            },
            "C6":{
               "page":2,
               "order":2,
               "resource":128000,
               "time":57600,
               "level":2,
               "name":"#m_ichi#",
               "description":"mon_ichidesc",
               "stream":["mon_ichistream","mon_ichistreambody","quests/monster6.v2.png"],
               "trainingCosts":[[128000,43200],[256000,64800],[409600,86400],[640000,172800],[820000,259200]],
               "props":{
                  "speed":[1.2],
                  "health":[2000,35 * 60,2200,2300,2500,2800],
                  "damage":[50,60,70,80,95,110],
                  "cTime":[100,100,90],
                  "cResource":[5000,5625,8440,11200,16000,400 * 60],
                  "cStorage":[20],
                  "bucket":[20],
                  "targetGroup":[4]
               }
            },
            "C7":{
               "page":2,
               "order":3,
               "resource":256000,
               "time":100800,
               "level":2,
               "name":"#m_bandito#",
               "description":"mon_banditodesc",
               "stream":["mon_banditostream","mon_banditostreambody","quests/monster7.v2.png"],
               "trainingCosts":[[256000,43200],[512000,57600],[210 * 60 * 60,86400],[0xfa000,129600],[400 * 60 * 60,172800]],
               "props":{
                  "speed":[1],
                  "health":[500,550,10 * 60,650,750,15 * 60],
                  "damage":[200,250,5 * 60,350,400,450],
                  "cTime":[225,225,225,225,3 * 60,3 * 60],
                  "cResource":[2500,75 * 60,6750,8750,11200,4 * 60 * 60],
                  "cStorage":[20],
                  "bucket":[20],
                  "targetGroup":[1]
               }
            },
            "C8":{
               "page":2,
               "order":4,
               "resource":512000,
               "time":144000,
               "level":2,
               "name":"#m_fang#",
               "description":"mon_fangdesc",
               "stream":["mon_fangstream","mon_fangstreambody","quests/monster8.v2.png"],
               "trainingCosts":[[512000,43200],[512000,57600],[210 * 60 * 60,86400],[0xfa000,129600],[400 * 60 * 60,172800]],
               "props":{
                  "speed":[1.1,1.2,1.3,1.4,1.5,1.6],
                  "health":[400],
                  "damage":[10 * 60,10 * 60,620,11 * 60,12 * 60,800],
                  "cTime":[450,350,250,225,195,195],
                  "cResource":[5 * 60 * 60,450 * 60,675 * 60,60500,80000,100000],
                  "cStorage":[30],
                  "bucket":[30],
                  "targetGroup":[1]
               }
            },
            "C9":{
               "page":3,
               "order":1,
               "resource":0xfa000,
               "time":187200,
               "level":3,
               "name":"#m_brain#",
               "description":"mon_braindesc",
               "stream":["mon_brainstream","mon_brainstreambody","quests/monster9.v2.png"],
               "trainingCosts":[[0xfa000,43200],[0x1f5f40,57600],[2870000,72000],[4500000,144000],[100 * 60 * 1000,216000]],
               "props":{
                  "speed":[2,2,2,2,2.1,2.2],
                  "health":[10 * 60,700,750,800,1100,1400],
                  "damage":[100,100,200,250,5 * 60,350],
                  "cTime":[342],
                  "cResource":[200 * 60,20250,30375,35000,50000,75000],
                  "cStorage":[30],
                  "bucket":[30],
                  "targetGroup":[3]
               }
            },
            "C10":{
               "page":3,
               "order":2,
               "resource":0x1f4000,
               "time":208800,
               "level":3,
               "name":"#m_crabatron#",
               "description":"mon_crabatrondesc",
               "stream":["mon_crabatronstream","mon_crabatronstreambody","quests/monster10.v2.png"],
               "trainingCosts":[[0x1f4000,43200],[50 * 60 * 1000,64800],[4400000,86400],[100 * 60 * 1000,172800],[125 * 60 * 1000,259200]],
               "props":{
                  "speed":[1,1,1,1.2,1.4,1.5],
                  "health":[0xfa0,0xfa0,4300,4400,4600,80 * 60],
                  "damage":[100,2 * 60,130,140,150,170],
                  "cTime":[750],
                  "cResource":[500 * 60,750 * 60,67500,75000,25 * 60 * 60,2 * 60 * 1000],
                  "cStorage":[40],
                  "bucket":[40],
                  "targetGroup":[4]
               }
            },
            "C11":{
               "page":3,
               "order":3,
               "resource":4096000,
               "time":223200,
               "level":3,
               "name":"#m_projectx#",
               "description":"mon_projectxdesc",
               "stream":["mon_projectxstream","mon_projectxstreambody","quests/monster11.v2.png"],
               "trainingCosts":[[4096000,86400],[7000000,129600],[200 * 60 * 1000,172800],[5 * 60 * 60 * 1000,345600],[400 * 60 * 1000,460800]],
               "props":{
                  "speed":[0.9,0.9,1,1.2,1.2,1.3],
                  "health":[800,15 * 60,950,1000,1100,20 * 60],
                  "damage":[20 * 60,1400,1600,30 * 60,2000,2200],
                  "cTime":[1384],
                  "cResource":[60 * 1000,25 * 60 * 60,135000,50 * 60 * 60,65 * 60 * 60,280000],
                  "cStorage":[70],
                  "bucket":[70],
                  "targetGroup":[4]
               }
            },
            "C12":{
               "page":4,
               "order":3,
               "resource":8192000,
               "time":259200,
               "level":4,
               "name":"#m_dave#",
               "description":"mon_davedesc",
               "stream":["mon_davestream","mon_davestreambody","quests/monster12.v2.png"],
               "trainingCosts":[[8192000,172800],[10000000,259200],[12200000,345600],[320 * 60 * 1000,518400],[28000000,691200]],
               "props":{
                  "speed":[0.8,0.85,0.9,1,1.1,1.2],
                  "health":[0x1f40,9100,10000,200 * 60,275 * 60,350 * 60],
                  "damage":[25 * 60,25 * 60,1600,1700,30 * 60,1900],
                  "cTime":[60 * 60],
                  "cResource":[150000,225000,337500,440000,10 * 60 * 1000,800000],
                  "cStorage":[160],
                  "bucket":[160],
                  "targetGroup":[1]
               }
            },
            "C13":{
               "page":4,
               "order":2,
               "resource":4096000,
               "time":223200,
               "level":4,
               "name":"#m_wormzer#",
               "description":"mon_wormzerdesc",
               "stream":["mon_wormzerstream","mon_wormzerstreambody","quests/monster13.v2.png"],
               "trainingCosts":[[4096000,86400],[8192000,172800],[8192000,259200],[8192000,345600],[12800000,460800]],
               "movement":"burrow",
               "pathing":"direct",
               "props":{
                  "speed":[3,4],
                  "health":[10 * 60,800,1100,1300,25 * 60,1700],
                  "damage":[5 * 60,400,550,10 * 60,650,700],
                  "cTime":[1384],
                  "cResource":[20000,25000,500 * 60,35000,40000,47500],
                  "cStorage":[70],
                  "bucket":[70],
                  "targetGroup":[1]
               }
            },
            "C14":{
               "page":4,
               "order":1,
               "resource":4096000,
               "time":216000,
               "level":4,
               "name":"#m_teratorn#",
               "description":"mon_teratorndesc",
               "stream":["mon_teratornstream","mon_teratornstreambody","quests/monster14.v3.png"],
               "trainingCosts":[[4096000,129600],[7000000,194400],[10000000,288000],[16000000,489600],[400 * 60 * 1000,648000]],
               "movement":"fly",
               "pathing":"direct",
               "props":{
                  "speed":[2.5,2.75,3,3.25,3.5],
                  "health":[1600,1900,40 * 60,50 * 60,60 * 60,70 * 60],
                  "damage":[5 * 60,350,400,500,10 * 60,700],
                  "cTime":[30 * 60,32 * 60,34 * 60,36 * 60,38 * 60,40 * 60],
                  "cResource":[70000,95000,145000,200000,5 * 60 * 1000,400000],
                  "cStorage":[70],
                  "bucket":[70],
                  "targetGroup":[1]
               }
            },
            "C15":{
               "page":3,
               "order":4,
               "resource":6192000,
               "time":216000,
               "level":3,
               "name":"#m_zafreeti#",
               "description":"mon_zafreetidesc",
               "stream":["mon_zafreetistream","mon_zafreetistreambody","quests/monster15.v2.png"],
               "trainingCosts":[[6192000,129600],[130 * 60 * 1000,194400],[200 * 60 * 1000,288000],[5 * 60 * 60 * 1000,489600]],
               "movement":"fly",
               "pathing":"direct",
               "props":{
                  "speed":[0.75,0.8,0.85,0.9,0.95],
                  "health":[0x1f40],
                  "damage":[-400,-550,-700,-850,-1000],
                  "cTime":[40 * 60],
                  "cResource":[2 * 60 * 1000,50 * 60 * 60,256000,90 * 60 * 60,130 * 60 * 60],
                  "cStorage":[200],
                  "bucket":[200],
                  "targetGroup":[5]
               }
            },
            "IC1":{
               "page":1,
               "order":1,
               "resource":40 * 60,
               "time":60 * 60,
               "level":1,
               "name":"#m_spurtz#",
               "description":"mi_Spurtz_desc",
               "stream":["mi_Spurtz_stream","mi_Spurtz_streambody","quests/inferno_monster1.png"],
               "trainingCosts":[[40 * 60,60 * 60],[80 * 60,2 * 60 * 60],[2 * 60 * 60,3 * 60 * 60],[160 * 60,4 * 60 * 60],[4 * 60 * 60,6 * 60 * 60]],
               "props":{
                  "speed":[1.2],
                  "health":[400,425,450,475,510,550],
                  "damage":[2 * 60,130,140,150,160,175],
                  "cTime":[15,10,8,7,6,5],
                  "cResource":[500,1000,2000,0xfa0,100 * 60,10000],
                  "cStorage":[15],
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
               "description":"mi_Zagnoid_desc",
               "stream":["mi_Zagnoid_stream","mi_Zagnoid_streambody","quests/zagnoid.v3.png"],
               "trainingCosts":[[80 * 60,4 * 60 * 60],[160 * 60,0x7080],[4 * 60 * 60,12 * 60 * 60],[320 * 60,16 * 60 * 60],[0x7080,24 * 60 * 60]],
               "props":{
                  "speed":[1.8],
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
               "description":"mi_Valgos_desc",
               "stream":["mi_Valgos_stream","mi_Valgos_streambody","quests/valgos.png"],
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
               "description":"mi_Malphus_desc",
               "stream":["mi_Malphus_stream","mi_Malphus_streambody","quests/malphus.png"],
               "trainingCosts":[[76800,18 * 60 * 60],[153600,36 * 60 * 60],[64 * 60 * 60,54 * 60 * 60],[307200,3 * 24 * 60 * 60],[128 * 60 * 60,108 * 60 * 60]],
               "movement":"jump",
               "props":{
                  "speed":[3.2],
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
               "description":"mi_Balthazar_desc",
               "stream":["mi_Balthazar_stream","mi_Balthazar_streambody","quests/balthazar.png"],
               "trainingCosts":[[614400,24 * 60 * 60],[1228800,2 * 24 * 60 * 60],[512 * 60 * 60,3 * 24 * 60 * 60],[2457600,4 * 24 * 60 * 60],[3686400,6 * 24 * 60 * 60]],
               "movement":"fly",
               "pathing":"direct",
               "props":{
                  "speed":[4.5],
                  "health":[800,14 * 60,880,920,965,1125],
                  "damage":[400,430,460,490,520,560],
                  "cTime":[30 * 60,32 * 60,34 * 60,36 * 60,38 * 60,40 * 60],
                  "cResource":[800 * 60,15 * 60 * 60,61000,69000,77000,87000],
                  "cStorage":[40],
                  "bucket":[60],
                  "targetGroup":[6]
               }
            },
            "IC6":{
               "page":3,
               "order":2,
               "resource":1228800,
               "time":24 * 60 * 60,
               "level":3,
               "name":"#m_grokus#",
               "description":"mi_Grokus_desc",
               "stream":["mi_Grokus_stream","mi_Grokus_streambody","quests/grokus.png"],
               "trainingCosts":[[1228800,24 * 60 * 60],[2457600,2 * 24 * 60 * 60],[3686400,3 * 24 * 60 * 60],[4915200,4 * 24 * 60 * 60],[0x708000,6 * 24 * 60 * 60]],
               "props":{
                  "speed":[1.3,1.3,1.4,1.4,1.5,1.6],
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
               "description":"mi_Sabnox_desc",
               "stream":["mi_Sabnox_stream","mi_Sabnox_streambody","quests/sabnox.png"],
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
               "description":"mi_King_Wormzer_desc",
               "stream":["mi_King_Wormzer_stream","mi_King_Wormzer_streambody","quests/king_wormzer.png"],
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
            },
            "C200":{
               "name":"AI Looter 1",
               "blocked":true,
               "props":{
                  "speed":[3],
                  "health":[200],
                  "damage":[20],
                  "cTime":[10],
                  "cResource":[10],
                  "cStorage":[10],
                  "bucket":[50],
                  "size":[32],
                  "targetGroup":[3]
               }
            }
         };
      }
      
      public static function Tick() : *
      {
         var StreamPost:Function;
         var i:String = null;
         var creature:Object = null;
         var img:String = null;
         var mc:popup_monster = null;
         var _body:String = null;
         try
         {
            _unlocking = null;
            for(i in _lockerData)
            {
               if(_lockerData[i].t == 1)
               {
                  _unlocking = i;
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","CreatureLocker.Tick A: " + _unlocking + " | " + e.message + " | " + e.getStackTrace());
         }
         try
         {
            if(_unlocking != null)
            {
               if(GLOBAL._lockerOverdrive > 0)
               {
                  _lockerData[_unlocking].e -= 4;
               }
               if(_lockerData[_unlocking].e - GLOBAL.Timestamp() <= 0)
               {
                  _lockerData[_unlocking].t = 2;
                  ACADEMY._upgrades[_unlocking] = {"level":1};
                  GLOBAL._playerCreatureUpgrades[_unlocking] = {"level":1};
                  ACHIEVEMENTS.Check("unlock_monster",1);
                  delete _lockerData[_unlocking].s;
                  delete _lockerData[_unlocking].e;
                  creature = _creatures[_unlocking];
                  img = "quests/monster" + _unlocking.substr(1) + ".v2.png";
                  if(creature.stream.length > 1)
                  {
                     img = creature.stream[2];
                  }
                  LOGGER.Stat([10,int(_unlocking.substr(1))]);
                  if(GLOBAL._mode == "build")
                  {
                     StreamPost = function(param1:String, param2:String, param3:String):*
                     {
                        var st:String = param1;
                        var sd:String = param2;
                        var im:String = param3;
                        return function(param1:MouseEvent = null):*
                        {
                           GLOBAL.CallJS("sendFeed",["unlock-end",st,sd,im,0]);
                           POPUPS.Next();
                        };
                     };
                     mc = new popup_monster();
                     mc.bSpeedup.SetupKey("btn_warnyourfriends");
                     _body = "";
                     if(creature.stream.length > 1)
                     {
                        _body = KEYS.Get(creature.stream[1]);
                     }
                     mc.bSpeedup.addEventListener(MouseEvent.CLICK,StreamPost(KEYS.Get(creature.stream[0]),_body,img));
                     mc.bSpeedup.Highlight = true;
                     mc.bAction.visible = false;
                     mc.tText.htmlText = KEYS.Get("pop_unlock_complete",{
                        "v1":KEYS.Get(CREATURELOCKER._creatures[_unlocking].name),
                        "v2":GLOBAL._bHatchery._buildingProps.name
                     });
                     POPUPS.Push(mc,null,null,null,_unlocking + "-150.png");
                  }
                  if(_mc)
                  {
                     _mc.Update();
                  }
                  _unlocking = null;
                  QUESTS.Check();
               }
            }
            if(_mc)
            {
               _mc.Tick();
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","CreatureLocker.Tick B: " + _unlocking + " | " + e.message + " | " + e.getStackTrace());
         }
      }
      
      public static function Start(param1:String) : Boolean
      {
         var StreamPost:Function;
         var SpeedUp:Function;
         var creature:Object = null;
         var popupMC:MovieClip = null;
         var creatureID:String = param1;
         if(_lockerData[creatureID])
         {
            return false;
         }
         if(_unlocking != null)
         {
            GLOBAL.Message(KEYS.Get("mon_alreadyunlocking"),KEYS.Get("btn_speedup"),STORE.ShowB,[3,0,["SP1","SP2","SP3","SP4"]]);
            return false;
         }
         creature = _creatures[creatureID];
         if(GLOBAL._bLocker._lvl.Get() < creature.level)
         {
            GLOBAL.Message(KEYS.Get("mon_upgradelocker",{
               "v1":KEYS.Get(GLOBAL._bLocker._buildingProps.name),
               "v2":creature.level
            }));
            return false;
         }
         if(BASE.Charge(3,creature.resource))
         {
            StreamPost = function(param1:MouseEvent = null):*
            {
               GLOBAL.CallJS("sendFeed",["unlock-start",KEYS.Get("mon_unlockstart",{
                  "v1":KEYS.Get(creature.name),
                  "v2":KEYS.Get(creature.name)
               }),KEYS.Get("mon_unlockstart_streambody",{"v1":KEYS.Get(creature.name)}),CREATURELOCKER._creatures[creatureID].stream[2],0]);
               POPUPS.Next();
            };
            SpeedUp = function(param1:MouseEvent = null):*
            {
               POPUPS.Next();
               STORE.SpeedUp("SP4");
            };
            _lockerData[creatureID] = {
               "t":1,
               "s":GLOBAL.Timestamp(),
               "e":GLOBAL.Timestamp() + creature.time
            };
            _unlocking = creatureID;
            BASE.Save();
            LOGGER.Stat([9,int(creatureID.substr(1))]);
            popupMC = new popup_monster();
            popupMC.bAction.SetupKey("btn_warnyourfriends");
            popupMC.bAction.addEventListener(MouseEvent.CLICK,StreamPost);
            popupMC.bSpeedup.SetupKey("btn_speedup");
            popupMC.bSpeedup.addEventListener(MouseEvent.CLICK,SpeedUp);
            popupMC.bSpeedup.Highlight = true;
            popupMC.tText.htmlText = KEYS.Get("pop_unlock_start",{
               "v1":KEYS.Get(CREATURELOCKER._creatures[creatureID].name),
               "v2":GLOBAL.ToTime(CREATURELOCKER._creatures[creatureID].time,false,false,true)
            });
            POPUPS.Push(popupMC,null,null,null,creatureID + "-150.png");
            return true;
         }
         if(!BASE.isInferno())
         {
            GLOBAL.Message(KEYS.Get("mon_needputty"),KEYS.Get("btn_openstore"),STORE.ShowB,[2,0.8,["BR31","BR32","BR33"]]);
         }
         else
         {
            GLOBAL.Message(KEYS.Get("mon_needsulfur"),KEYS.Get("btn_openstore"),STORE.ShowB,[2,0.8,["BR31I","BR32I","BR33I"]]);
         }
         return false;
      }
      
      public static function Cancel() : *
      {
         if(_unlocking)
         {
            delete _lockerData[_unlocking];
            BASE.Fund(3,_creatures[_unlocking].resource);
            _unlocking = null;
         }
         Update();
         BASE.Save();
      }
      
      public static function Show() : *
      {
         if(Boolean(GLOBAL._bLocker) && GLOBAL._bLocker._lvl.Get() >= 1)
         {
            if(!_open)
            {
               _open = true;
               GLOBAL.BlockerAdd();
               _mc = GLOBAL._layerWindows.addChild(new CREATURELOCKERPOPUP());
               _mc.Center();
               _mc.ScaleUp();
            }
         }
         else
         {
            GLOBAL.Message(KEYS.Get("msg_nomonsterlocker"));
         }
      }
      
      public static function Hide(param1:MouseEvent = null) : *
      {
         if(_open)
         {
            GLOBAL.BlockerRemove();
            SOUNDS.Play("close");
            BASE.BuildingDeselect();
            _open = false;
            GLOBAL._layerWindows.removeChild(_mc);
            _mc = null;
         }
      }
      
      public static function Update() : *
      {
         if(_mc)
         {
            _mc.Update();
         }
      }
      
      public static function Check() : *
      {
         var tmpArray:Array = null;
         var Push:Function = function(param1:String):*
         {
            var _loc2_:Object = _creatures[param1];
            var _loc3_:Object = _loc2_.props;
            tmpArray.push([_loc2_.page,_loc2_.resource,_loc2_.time,_loc2_.level,_loc2_.trainingCosts,_loc3_.speed,_loc3_.health,_loc3_.damage,_loc3_.armor,_loc3_.accuracy,_loc3_.cTime,_loc3_.cResource,_loc3_.cStorage,_loc3_.bucket,_loc3_.size]);
         };
         tmpArray = [];
         var i:* = 1;
         while(i <= 15)
         {
            Push("C" + i);
            i++;
         }
         i = 1;
         while(i <= 8)
         {
            Push("IC" + i);
            i++;
         }
         return MD5.hash(com.adobe.serialization.json.JSON.encode(tmpArray));
      }
      
      public static function GetAppropriateCreatures() : Object
      {
         var _loc3_:String = null;
         var _loc1_:Object = CREATURELOCKER._creatures;
         var _loc2_:Object = {};
         for(_loc3_ in _loc1_)
         {
            if(!(_loc3_.substr(0,1) == "C" && BASE.isInferno() || _loc3_.substr(0,1) == "I" && !BASE.isInferno() || _loc3_ == "C200"))
            {
               _loc2_[_loc3_] = _loc1_[_loc3_];
            }
         }
         return _loc2_;
      }
   }
}

