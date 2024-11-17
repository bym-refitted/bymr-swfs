package com.monsters.monsters.creeps.rebalance
{
   import com.monsters.monsters.creeps.Brain;
   import com.monsters.monsters.creeps.Eyera;
   import com.monsters.monsters.creeps.Fang;
   import com.monsters.monsters.creeps.Fink;
   import com.monsters.monsters.creeps.Slimeattikus;
   import com.monsters.monsters.creeps.Wormzer;
   import com.monsters.monsters.creeps.inferno.Balthazar;
   import com.monsters.monsters.creeps.inferno.KingWormzer;
   import com.monsters.monsters.creeps.inferno.Spurtz;
   
   public class RebalancedCreatures
   {
      public static const REBALANCED_CREATURES:Object = {
         "C1":{
            "index":1,
            "page":1,
            "order":1,
            "resource":0xfa0,
            "time":600,
            "level":1,
            "name":"#m_pokey#",
            "classType":Pokeyv2,
            "description":"mon_pokeydesc",
            "stream":["mon_pokeystream","mon_pokeystreambody","quests/monster1.v2.png"],
            "unlock":[""],
            "trainingCosts":[[0xfa0,7200],[0x1f40,10800],[200 * 60,18000],[16000,28800],[22000,43200]],
            "props":{
               "speed":[1.2],
               "health":[5 * 60,330,6 * 60,390,7 * 60,450],
               "damage":[90,105,2 * 60,135,150,165],
               "cTime":[15,10,8,7,6,5],
               "cResource":[250,450,675,800,1000,1250],
               "cStorage":[10,10,10,9,8,7],
               "bucket":[20],
               "targetGroup":[1]
            }
         },
         "C2":{
            "index":2,
            "page":1,
            "order":2,
            "resource":0x1f40,
            "time":3600,
            "level":1,
            "name":"#m_octoooze#",
            "classType":Octooozev2,
            "description":"mon_octooozedesc",
            "stream":["mon_octooozestream","mon_octooozestreambody","quests/monster2.v2.png"],
            "trainingCosts":[[0x1f40,14400],[16000,21600],[400 * 60,36000],[800 * 60,57600],[64000,86400]],
            "props":{
               "speed":[1.4],
               "health":[1000,1100,1300,1450,1600,30 * 60],
               "damage":[30,30,40,50,60,70],
               "cTime":[15,16],
               "cResource":[500,15 * 60,1350,30 * 60,35 * 60,2500],
               "cStorage":[10],
               "bucket":[20],
               "targetGroup":[4]
            }
         },
         "C3":{
            "index":3,
            "page":1,
            "order":3,
            "resource":16000,
            "time":7200,
            "level":1,
            "name":"#m_bolt#",
            "classType":Boltv2,
            "description":"mon_boltdesc",
            "stream":["mon_boltstream","mon_boltstreambody","quests/monster3.v2.png"],
            "trainingCosts":[[16000,14400],[32000,21600],[800 * 60,28800],[96000,43200],[40 * 60 * 60,57600]],
            "props":{
               "speed":[2.5,2.55,2.6,2.8,3,3.2],
               "health":[10 * 60,11 * 60,12 * 60,13 * 60,14 * 60,15 * 60],
               "damage":[45,60,75,105,135,165],
               "cTime":[23],
               "cResource":[350,675,1015,1400,30 * 60,40 * 60],
               "cStorage":[15],
               "bucket":[30],
               "targetGroup":[3]
            }
         },
         "C4":{
            "index":4,
            "page":1,
            "order":4,
            "resource":32000,
            "time":14400,
            "level":1,
            "name":"#m_fink#",
            "classType":Fink,
            "description":"mon_finkdesc",
            "stream":["mon_finkstream","mon_finkstreambody","quests/monster4.v2.png"],
            "trainingCosts":[[32000,28800],[64000,43200],[96000,64800],[128000,86400],[160000,108000]],
            "props":{
               "speed":[1.3],
               "health":[350,400,450,500,550,10 * 60],
               "damage":[450,495,570,645,705,13 * 60],
               "cTime":[100,100,100,100,90,90],
               "cResource":[25 * 60,2250,3375,80 * 60,2 * 60 * 60,10000],
               "cStorage":[20],
               "bucket":[30],
               "targetGroup":[1]
            }
         },
         "C5":{
            "index":5,
            "page":2,
            "order":1,
            "resource":64000,
            "time":28800,
            "level":2,
            "name":"#m_eyera#",
            "classType":Eyera,
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
            "index":6,
            "page":2,
            "order":2,
            "resource":128000,
            "time":57600,
            "level":2,
            "name":"#m_ichi#",
            "classType":Ichiv2,
            "description":"mon_ichidesc",
            "stream":["mon_ichistream","mon_ichistreambody","quests/monster6.v2.png"],
            "trainingCosts":[[128000,43200],[256000,64800],[409600,86400],[640000,172800],[820000,259200]],
            "props":{
               "speed":[1.2],
               "health":[2000,35 * 60,2200,2300,40 * 60,2500],
               "damage":[75,90,105,2 * 60,143,165],
               "cTime":[100,100,90],
               "cResource":[5000,5625,8440,11200,16000,400 * 60],
               "cStorage":[20],
               "bucket":[20],
               "targetGroup":[4]
            }
         },
         "C7":{
            "index":7,
            "page":2,
            "order":3,
            "resource":256000,
            "time":100800,
            "level":2,
            "name":"#m_bandito#",
            "classType":Banditov2,
            "description":"mon_banditodesc",
            "stream":["mon_banditostream","mon_banditostreambody","quests/monster7.v2.png"],
            "trainingCosts":[[256000,43200],[512000,57600],[210 * 60 * 60,86400],[0xfa000,129600],[400 * 60 * 60,172800]],
            "props":{
               "speed":[1],
               "health":[750,825,15 * 60,975,1125,20 * 60],
               "damage":[5 * 60,375,450,525,10 * 60,675],
               "cTime":[225,225,225,225,3 * 60,3 * 60],
               "cResource":[2500,75 * 60,6750,8750,11200,4 * 60 * 60],
               "cStorage":[20],
               "bucket":[20],
               "targetGroup":[1]
            }
         },
         "C8":{
            "index":8,
            "page":2,
            "order":4,
            "resource":512000,
            "time":144000,
            "level":2,
            "name":"#m_fang#",
            "classType":Fang,
            "description":"mon_fangdesc",
            "stream":["mon_fangstream","mon_fangstreambody","quests/monster8.v2.png"],
            "trainingCosts":[[512000,43200],[512000,57600],[210 * 60 * 60,86400],[0xfa000,129600],[400 * 60 * 60,172800]],
            "props":{
               "speed":[1.1,1.2,1.3,1.4,1.5,1.6],
               "health":[10 * 60,630,11 * 60,12 * 60,750,13 * 60],
               "damage":[20 * 60,1280,1360,24 * 60,1520,1600],
               "cTime":[450,350,250,225,195,195],
               "cResource":[5 * 60 * 60,450 * 60,675 * 60,60500,80000,100000],
               "cStorage":[30],
               "bucket":[30],
               "targetGroup":[1]
            }
         },
         "C9":{
            "index":10,
            "page":3,
            "order":1,
            "resource":0xfa000,
            "time":187200,
            "level":3,
            "name":"#m_brain#",
            "classType":Brain,
            "description":"mon_braindesc",
            "stream":["mon_brainstream","mon_brainstreambody","quests/monster9.v2.png"],
            "trainingCosts":[[0xfa000,43200],[0x1f5f40,57600],[2870000,72000],[4500000,144000],[100 * 60 * 1000,216000]],
            "props":{
               "speed":[2,2,2,2,2.1,2.2],
               "health":[1300,1400,25 * 60,1600,1700,30 * 60],
               "damage":[340,380,7 * 60,460,500,9 * 60],
               "cTime":[342],
               "cResource":[200 * 60,20250,30375,35000,50000,75000],
               "cStorage":[30],
               "bucket":[30],
               "targetGroup":[3]
            }
         },
         "C10":{
            "index":11,
            "page":3,
            "order":3,
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
               "damage":[200,4 * 60,260,280,5 * 60,340],
               "cTime":[750],
               "cResource":[500 * 60,750 * 60,67500,75000,25 * 60 * 60,2 * 60 * 1000],
               "cStorage":[40],
               "bucket":[40],
               "targetGroup":[4]
            }
         },
         "C11":{
            "index":12,
            "page":3,
            "order":4,
            "resource":4096000,
            "time":223200,
            "level":3,
            "name":"#m_projectx#",
            "classType":ProjectXv2,
            "description":"mon_projectxdesc",
            "stream":["mon_projectxstream","mon_projectxstreambody","quests/monster11.v2.png"],
            "trainingCosts":[[4096000,86400],[7000000,129600],[200 * 60 * 1000,172800],[5 * 60 * 60 * 1000,345600],[400 * 60 * 1000,460800]],
            "props":{
               "speed":[0.9,0.9,1,1.2,1.2,1.3],
               "health":[20 * 60,1350,1425,25 * 60,1650,30 * 60],
               "damage":[20 * 60,1400,1600,30 * 60,2000,2200],
               "cTime":[1384],
               "cResource":[60 * 1000,25 * 60 * 60,135000,50 * 60 * 60,65 * 60 * 60,280000],
               "cStorage":[70],
               "bucket":[70],
               "targetGroup":[4]
            }
         },
         "C12":{
            "index":16,
            "page":4,
            "order":3,
            "resource":8192000,
            "time":259200,
            "level":4,
            "name":"#m_dave#",
            "classType":DAVEv2,
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
            "index":15,
            "page":4,
            "order":2,
            "resource":4096000,
            "time":223200,
            "level":4,
            "name":"#m_wormzer#",
            "classType":Wormzer,
            "description":"mon_wormzerdesc",
            "stream":["mon_wormzerstream","mon_wormzerstreambody","quests/monster13.v2.png"],
            "trainingCosts":[[4096000,86400],[8192000,172800],[8192000,259200],[8192000,345600],[12800000,460800]],
            "movement":"burrow",
            "pathing":"direct",
            "props":{
               "speed":[3,4],
               "health":[15 * 60,20 * 60,1650,1950,2250,2550],
               "damage":[10 * 60,800,1100,20 * 60,1300,1400],
               "cTime":[1384],
               "cResource":[20000,25000,500 * 60,35000,40000,47500],
               "cStorage":[70],
               "bucket":[70],
               "targetGroup":[1]
            }
         },
         "C14":{
            "index":14,
            "page":4,
            "order":1,
            "resource":4096000,
            "time":216000,
            "level":4,
            "name":"#m_teratorn#",
            "classType":Teratornv2,
            "description":"mon_teratorndesc",
            "stream":["mon_teratornstream","mon_teratornstreambody","quests/monster14.v3.png"],
            "trainingCosts":[[4096000,129600],[7000000,194400],[10000000,288000],[16000000,489600],[400 * 60 * 1000,648000]],
            "movement":"fly",
            "pathing":"direct",
            "props":{
               "range":[150],
               "attackDelay":[90],
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
            "index":13,
            "page":3,
            "order":5,
            "resource":6192000,
            "time":216000,
            "level":3,
            "name":"#m_zafreeti#",
            "classType":Zafreetiv2,
            "description":"mon_zafreetidesc",
            "stream":["mon_zafreetistream","mon_zafreetistreambody","quests/monster15.v2.png"],
            "trainingCosts":[[6192000,129600],[130 * 60 * 1000,194400],[200 * 60 * 1000,288000],[5 * 60 * 60 * 1000,489600]],
            "movement":"fly",
            "pathing":"direct",
            "antiHeal":true,
            "props":{
               "range":[10],
               "attackDelay":[30],
               "speed":[0.75,0.8,0.85,0.9,0.95],
               "health":[0x1f40],
               "damage":[-800,-1100,-1400,-1700,-2100],
               "cTime":[40 * 60],
               "cResource":[2 * 60 * 1000,50 * 60 * 60,256000,90 * 60 * 60,130 * 60 * 60],
               "cStorage":[200],
               "bucket":[200],
               "targetGroup":[5]
            }
         },
         "C16":{
            "index":9,
            "page":2,
            "order":5,
            "resource":384000,
            "time":129600,
            "level":2,
            "name":"#m_vorg#",
            "blocked":true,
            "classType":Vorgv2,
            "description":"mon_vorgdesc",
            "trainingCosts":[[384000,86400],[384000,129600],[512000,172800],[768000,216000],[0xfa000,259200]],
            "movement":"fly",
            "stream":["","","quests/monster16.png"],
            "pathing":"direct",
            "antiHeal":true,
            "blocked":true,
            "props":{
               "altitude":[61],
               "range":[200],
               "attackDelay":[10],
               "speed":[2.5,2.75,3,3.25,3.5],
               "health":[750],
               "damage":[-30,-35,-40,-45,-50,-55],
               "cTime":[20 * 60],
               "cResource":[16000,25000,38500,62500,75000,25 * 60 * 60],
               "cStorage":[60],
               "bucket":[60],
               "targetGroup":[5]
            }
         },
         "C17":{
            "index":10,
            "page":3,
            "order":2,
            "resource":0x1f4000,
            "time":129600,
            "level":3,
            "name":"#m_slimeattikus#",
            "classType":Slimeattikus,
            "description":"mon_slimeattikusdesc",
            "trainingCosts":[[2560000,86400],[64 * 60 * 1000,129600],[4096000,172800],[6250000,216000],[8500000,288000]],
            "stream":["","","quests/monster17.png"],
            "blocked":true,
            "props":{
               "speed":[1,1.1,1.2,1.3,1.4,1.5],
               "health":[700,725,750,800,15 * 60,1000],
               "damage":[850,850,15 * 60,1000,20 * 60,1400],
               "cTime":[500,450,400,350,5 * 60,250],
               "cResource":[450 * 60,675 * 60,60750,25 * 60 * 60,125000,150000],
               "cStorage":[40],
               "bucket":[40],
               "targetGroup":[1],
               "splits":[2,2,3,3,4,5]
            }
         },
         "C18":{
            "index":18,
            "page":3,
            "order":2,
            "resource":0x1f4000,
            "time":129600,
            "level":3,
            "name":"#m_slimeattikusmini#",
            "blocked":true,
            "description":"mon_slimeattikusminidesc",
            "trainingCosts":[[2560000,86400],[64 * 60 * 1000,129600],[4096000,172800],[6250000,216000],[8500000,288000]],
            "stream":["","",""],
            "blocked":true,
            "fake":true,
            "dependent":"C17",
            "props":{
               "speed":[1.5,1.6,1.7,1.8,1.9,2],
               "health":[250],
               "damage":[310,320,330,340,350],
               "cTime":[500,450,400,350,5 * 60,250],
               "cResource":[450 * 60,675 * 60,60750,25 * 60 * 60,125000,150000],
               "cStorage":[40],
               "bucket":[40],
               "targetGroup":[1]
            }
         },
         "IC1":{
            "index":1,
            "page":1,
            "order":1,
            "resource":40 * 60,
            "time":60 * 60,
            "level":1,
            "name":"#m_spurtz#",
            "classType":Spurtz,
            "description":"mi_Spurtz_desc",
            "stream":["mi_Spurtz_stream","mi_Spurtz_streambody","quests/inferno_monster1.png"],
            "trainingCosts":[[40 * 60,60 * 60],[80 * 60,2 * 60 * 60],[2 * 60 * 60,3 * 60 * 60],[160 * 60,4 * 60 * 60],[4 * 60 * 60,6 * 60 * 60]],
            "props":{
               "speed":[1.2],
               "health":[400,425,450,475,510,550],
               "damage":[160,200,200,250,5 * 60,350],
               "cTime":[15,10,8,7,6,5],
               "cResource":[500,1000,2000,0xfa0,100 * 60,10000],
               "cStorage":[15],
               "bucket":[20],
               "targetGroup":[1]
            }
         },
         "IC2":{
            "index":2,
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
               "health":[25 * 60,1820,2300,2800,3350,60 * 60],
               "damage":[80,85,90,95,100,110],
               "cTime":[15,16,16,16,16,16],
               "cResource":[2500,0xfa0,0x1f40,200 * 60,16000,20000],
               "cStorage":[15],
               "bucket":[20],
               "targetGroup":[4]
            }
         },
         "IC4":{
            "index":3,
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
               "health":[2000,40 * 60,2800,3200,60 * 60,0xfa0],
               "damage":[490,530,580,645,700,775],
               "cTime":[450,350,250,225,195,195],
               "cResource":[31000,35000,650 * 60,44000,50000,55000],
               "cStorage":[30],
               "bucket":[20],
               "targetGroup":[2]
            }
         },
         "IC3":{
            "index":4,
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
            "index":5,
            "page":3,
            "order":1,
            "resource":614400,
            "time":24 * 60 * 60,
            "level":3,
            "name":"#m_balthazar#",
            "classType":Balthazar,
            "description":"mi_Balthazar_desc",
            "stream":["mi_Balthazar_stream","mi_Balthazar_streambody","quests/balthazar.png"],
            "trainingCosts":[[614400,24 * 60 * 60],[1228800,2 * 24 * 60 * 60],[512 * 60 * 60,3 * 24 * 60 * 60],[2457600,4 * 24 * 60 * 60],[3686400,6 * 24 * 60 * 60]],
            "movement":"fly",
            "pathing":"direct",
            "props":{
               "speed":[4.5],
               "health":[3200,60 * 60,0xfa0,75 * 60,5000,5600],
               "damage":[10 * 60,665,730,795,860,930],
               "cTime":[30 * 60,32 * 60,34 * 60,36 * 60,38 * 60,40 * 60],
               "cResource":[88000,104000,161000,249000,327000,487000],
               "cStorage":[40],
               "bucket":[60],
               "targetGroup":[6]
            }
         },
         "IC6":{
            "index":6,
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
               "health":[7600,8750,165 * 60,10100,11300,12500],
               "damage":[400,425,450,475,500,550],
               "cTime":[30 * 60,30 * 60,30 * 60,30 * 60,30 * 60,30 * 60],
               "cResource":[80000,105000,135000,175000,210000,325000],
               "cStorage":[50],
               "bucket":[60],
               "targetGroup":[3]
            }
         },
         "IC7":{
            "index":7,
            "page":3,
            "order":3,
            "resource":2457600,
            "time":2 * 24 * 60 * 60,
            "level":3,
            "name":"#m_sabnox#",
            "classType":Sabnoxv2,
            "description":"mi_Sabnox_desc",
            "stream":["mi_Sabnox_stream","mi_Sabnox_streambody","quests/sabnox.png"],
            "trainingCosts":[[2457600,2 * 24 * 60 * 60],[4915200,4 * 24 * 60 * 60],[0x708000,6 * 24 * 60 * 60],[9830400,8 * 24 * 60 * 60],[14745600,12 * 24 * 60 * 60]],
            "props":{
               "range":[4 * 60],
               "speed":[1.7,1.8,1.9,2,2.1,2.2],
               "health":[1120,21 * 60,1400,1650,1900,2200],
               "damage":[700,825,950,1075,20 * 60,1350],
               "cTime":[1384,1384,1384,1384,1384,1384],
               "cResource":[60 * 1000,25 * 60 * 60,145000,200000,330000,125 * 60 * 60],
               "cStorage":[80],
               "bucket":[90],
               "targetGroup":[4]
            }
         },
         "IC8":{
            "index":8,
            "page":4,
            "order":1,
            "resource":4915200,
            "time":3 * 24 * 60 * 60,
            "level":4,
            "name":"#m_king_wormzer#",
            "shortName":"#m_k_wormzer#",
            "classType":KingWormzer,
            "description":"mi_King_Wormzer_desc",
            "stream":["mi_King_Wormzer_stream","mi_King_Wormzer_streambody","quests/king_wormzer.png"],
            "trainingCosts":[[4915200,3 * 24 * 60 * 60],[7268000,6 * 24 * 60 * 60],[9296000,9 * 24 * 60 * 60],[13624000,12 * 24 * 60 * 60],[19248000,18 * 24 * 60 * 60]],
            "movement":"burrow",
            "pathing":"direct",
            "props":{
               "speed":[2.5,2.6,2.7,2.8,2.9,3],
               "health":[6200,7600,145 * 60,10900,13100,16000],
               "damage":[20 * 60,1360,1630,32 * 60,37 * 60,2500],
               "cTime":[45 * 60],
               "cResource":[425000,476000,580000,700000,910000,1204000],
               "cStorage":[100],
               "bucket":[100],
               "targetGroup":[1]
            }
         },
         "C200":{
            "name":"AILooter1",
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
      
      public function RebalancedCreatures()
      {
         super();
      }
   }
}

