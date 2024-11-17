package
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import gs.TweenLite;
   import gs.easing.Quad;
   
   public class QUESTS
   {
      public static var _global:Object;
      
      public static var _questGroups:Array;
      
      public static var _quests:Array;
      
      public static var _completed:Object;
      
      public static var _displayedInstructions:Boolean;
      
      public static var _mc:*;
      
      public static var _open:Boolean;
      
      public function QUESTS()
      {
         super();
      }
      
      public static function Setup() : *
      {
         var _loc2_:Object = null;
         _displayedInstructions = false;
         _global = {
            "blvl":0,
            "brlvl":0,
            "b1lvl":0,
            "b2lvl":0,
            "b3lvl":0,
            "b4lvl":0,
            "b5lvl":0,
            "b6lvl":0,
            "b7lvl":0,
            "b8lvl":0,
            "b9lvl":0,
            "b10lvl":0,
            "b11lvl":0,
            "b12lvl":0,
            "b13lvl":0,
            "b14lvl":0,
            "b15lvl":0,
            "b16lvl":0,
            "b17lvl":0,
            "b18lvl":0,
            "b19lvl":0,
            "b20lvl":0,
            "b21lvl":0,
            "b22lvl":0,
            "b23lvl":0,
            "b24lvl":0,
            "b25lvl":0,
            "b26lvl":0,
            "b51lvl":0,
            "kills":0,
            "bonus_bookmark":0,
            "bonus_fan":0,
            "bonus_invites":0,
            "bonus_gifts":0,
            "mushroomspicked":0,
            "goldmushroomspicked":0,
            "monstersblended":0,
            "monstersblendedgoo":0,
            "singleclickbank":0,
            "destroy_tribe1":0,
            "destroy_tribe2":0,
            "destroy_tribe3":0,
            "destroy_tribe4":0,
            "destroy_baseL":0,
            "worder_count":0,
            "hatch_champ1":0,
            "hatch_champ2":0,
            "hatch_champ3":0,
            "upgrade_champ1":0,
            "upgrade_champ2":0,
            "upgrade_champ3":0,
            "gift_accept":0
         };
         _questGroups = [{
            "id":0,
            "name":"q_construction"
         },{
            "id":1,
            "name":"q_monsters"
         },{
            "id":2,
            "name":"q_attacking"
         },{
            "id":3,
            "name":"q_good"
         },{
            "id":4,
            "name":"q_evil"
         }];
         _quests = [{
            "block":true,
            "list":false,
            "reward":[0,750,0,0,0],
            "id":"C0",
            "group":0,
            "name":"q_c0_name",
            "description":"q_c0_description",
            "hint":"q_c0_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c0_streamtitle",
            "streamDescription":"q_c0_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b14lvl":1}
         },{
            "block":true,
            "list":false,
            "reward":[1100,800,0,0,0],
            "id":"C1",
            "group":0,
            "name":"q_c1_name",
            "description":"q_c1_description",
            "hint":"q_c1_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c1_streamtitle",
            "streamDescription":"q_c1_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"brlvl":1}
         },{
            "block":true,
            "list":false,
            "reward":[500,25 * 60,500,500,1000],
            "id":"C8",
            "group":3,
            "name":"q_c8_name",
            "description":"q_c8_description",
            "hint":"q_c8_hint",
            "questimage":"openforbusiness.v2.png",
            "streamTitle":"q_c8_streamtitle",
            "streamDescription":"q_c8_streamdescription",
            "streamImage":"quests/openforbusiness.png",
            "rules":{"b12lvl":1}
         },{
            "list":true,
            "reward":[0xfa0,4600,500,0,0],
            "id":"U1",
            "group":0,
            "name":"q_u1_name",
            "description":"q_u1_description",
            "hint":"q_u1_hint",
            "questimage":"nextlevel.v2.png",
            "streamTitle":"q_u1_streamtitle",
            "streamDescription":"q_u1_streamdescription",
            "streamImage":"quests/nextlevel.png",
            "rules":{"blvl":2}
         },{
            "list":true,
            "reward":[2000,2000,0,0,0],
            "id":"T1",
            "group":0,
            "name":"q_t1_name",
            "description":"q_t1_description",
            "hint":"q_t1_hint",
            "questimage":"building-sniper.png",
            "streamTitle":"q_t1_streamtitle",
            "streamDescription":"q_t1_streamdescription",
            "streamImage":"quests/sniper.png",
            "rules":{"b21lvl":1}
         },{
            "list":true,
            "reward":[800,800,1000,1000,0],
            "id":"D1",
            "group":2,
            "name":"q_d1_name",
            "description":"q_d1_description",
            "hint":"q_d1_hint",
            "questimage":"firstblood.png",
            "streamTitle":"q_d1_streamtitle",
            "streamDescription":"q_d1_streamdescription",
            "streamImage":"quests/firstblood.png",
            "rules":{"kills":1}
         },{
            "list":true,
            "reward":[2000,2000,2000,2000,0],
            "id":"CR3",
            "group":1,
            "name":"q_cr3_name",
            "description":"q_cr3_description",
            "hint":"q_cr3_hint",
            "questimage":"building-housing.png",
            "streamTitle":"q_cr3_streamtitle",
            "streamDescription":"q_cr3_streamdescription",
            "streamImage":"quests/housing.png",
            "rules":{"b15lvl":1}
         },{
            "list":true,
            "reward":[0,0,0,1000,0],
            "id":"C18",
            "group":2,
            "name":"q_c18_name",
            "description":"q_c18_description",
            "hint":"q_c18_hint",
            "questimage":"building-flinger.png",
            "streamTitle":"q_c18_streamtitle",
            "streamDescription":"q_c18_streamdescription",
            "streamImage":"quests/flinger.png",
            "rules":{"b5lvl":1}
         },{
            "list":true,
            "reward":[0,0,0,1000,0],
            "id":"C17",
            "group":2,
            "name":"q_c17_name",
            "description":"q_c17_description",
            "hint":"q_c17_hint",
            "questimage":"building-map.png",
            "streamTitle":"q_c17_streamtitle",
            "streamDescription":"q_c17_streamdescription",
            "streamImage":"quests/maproom.png",
            "rules":{"b11lvl":1}
         },{
            "list":true,
            "reward":[6500,6500,500,25 * 60,0],
            "id":"WM1",
            "group":2,
            "name":"q_wm1_name",
            "description":"q_wm1_description",
            "hint":"q_wm1_hint",
            "questimage":"tribe_legionnaire.v2.png",
            "streamTitle":"q_wm1_streamtitle",
            "streamDescription":"q_wm1_streamdescription",
            "streamImage":"quests/tribe-legionnaire.v2.png",
            "rules":{"destroy_tribe1":1}
         },{
            "list":true,
            "reward":[1000,1000,0,1000,0],
            "id":"CR2",
            "group":1,
            "name":"q_cr2_name",
            "description":"q_cr2_description",
            "hint":"q_cr2_hint",
            "questimage":"building-hatchery.png",
            "rules":{"b13lvl":1}
         },{
            "list":true,
            "reward":[20000,0,0,0,0],
            "id":"C51",
            "group":2,
            "name":"q_c51_name",
            "description":"q_c51_description",
            "hint":"q_c51_hint",
            "questimage":"building-catapult.png",
            "streamTitle":"q_c51_streamtitle",
            "streamDescription":"q_c51_streamdescription",
            "streamImage":"quests/catapult.png",
            "rules":{"b51lvl":1}
         },{
            "list":true,
            "reward":[2000,2000,1000,1000,0],
            "id":"S1",
            "group":0,
            "name":"q_s1_name",
            "description":"q_s1_description",
            "hint":"q_s1_hint",
            "questimage":"building-storage.png",
            "streamTitle":"q_s1_streamtitle",
            "streamDescription":"q_s1_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b6lvl":1}
         },{
            "list":true,
            "reward":[1000,1000,500,500,0],
            "id":"M1",
            "group":3,
            "name":"q_m1_name",
            "description":"q_m1_description",
            "hint":"q_m1_hint",
            "questimage":"mushroomsoup.png",
            "streamTitle":"q_m1_streamtitle",
            "streamDescription":"q_m1_streamdescription",
            "streamImage":"mushroomsoup.png",
            "rules":{"mushroomspicked":5}
         },{
            "list":true,
            "reward":[1000,1000,5000,0,0],
            "id":"CR1",
            "group":1,
            "name":"q_cr1_name",
            "description":"q_cr1_description",
            "hint":"q_cr1_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_cr1_streamtitle",
            "streamDescription":"q_cr1_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b8lvl":1}
         },{
            "list":true,
            "reward":[0x1f40,0x1f40,0x1f40,0x1f40,0],
            "id":"C3",
            "group":0,
            "name":"q_c3_name",
            "description":"q_c3_description",
            "hint":"q_c3_hint",
            "questimage":"nextlevel2.v2.png",
            "streamTitle":"q_c3_streamtitle",
            "streamDescription":"q_c3_streamdescription",
            "streamImage":"quests/nextlevel2.png",
            "rules":{
               "b1lvl":2,
               "b2lvl":2,
               "b3lvl":2,
               "b4lvl":2
            }
         },{
            "list":true,
            "reward":[0xfa0,0xfa0,0,500,0],
            "id":"C13",
            "group":0,
            "name":"q_c13_name",
            "description":"q_c13_description",
            "hint":"q_c13_hint",
            "questimage":"building-townhall.png",
            "streamTitle":"q_c13_streamtitle",
            "streamDescription":"q_c13_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b14lvl":2}
         },{
            "list":true,
            "reward":[2000,2000,0,0,0],
            "id":"T2",
            "group":0,
            "name":"q_t2_name",
            "description":"q_t2_description",
            "hint":"q_t2_hint",
            "questimage":"building-cannon.png",
            "streamTitle":"q_t2_streamtitle",
            "streamDescription":"q_t2_streamdescription",
            "streamImage":"build-cannon.png",
            "rules":{"b20lvl":1}
         },{
            "list":true,
            "reward":[10000,10000,10000,0,0],
            "id":"T3",
            "group":0,
            "name":"q_t3_name",
            "description":"q_t3_description",
            "hint":"q_t3_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_t3_streamtitle",
            "streamDescription":"q_t3_streamdescription",
            "streamImage":"build-lightning.png",
            "rules":{"b25lvl":1}
         },{
            "list":true,
            "reward":[20000,0,0,0,0],
            "id":"C9",
            "group":0,
            "name":"q_c9_name",
            "description":"q_c9_description",
            "hint":"q_c9_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c9_streamtitle",
            "streamDescription":"q_c9_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b1lvl":3}
         },{
            "list":true,
            "reward":[0,10000,0,0,0],
            "id":"C10",
            "group":0,
            "name":"q_c10_name",
            "description":"q_c10_description",
            "hint":"q_c10_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c10_streamtitle",
            "streamDescription":"q_c10_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b2lvl":3}
         },{
            "list":true,
            "reward":[0,0,2500,0,0],
            "id":"C11",
            "group":0,
            "name":"q_c11_name",
            "description":"q_c11_description",
            "hint":"q_c11_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c11_streamtitle",
            "streamDescription":"q_c11_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b3lvl":3}
         },{
            "list":true,
            "reward":[0,0,0,2000,0],
            "id":"C12",
            "group":0,
            "name":"q_c12_name",
            "description":"q_c12_description",
            "hint":"q_c12_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c12_streamtitle",
            "streamDescription":"q_c12_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b4lvl":3}
         },{
            "list":true,
            "reward":[0xfa0,0xfa0,2000,2000,0],
            "id":"S2",
            "group":0,
            "name":"q_s2_name",
            "description":"q_s2_description",
            "hint":"q_s2_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_s2_streamtitle",
            "streamDescription":"q_s2_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b6lvl":2}
         },{
            "list":true,
            "reward":[0,0,0,0,50],
            "id":"FAN",
            "group":3,
            "name":"q_fan_name",
            "description":"q_fan_description",
            "hint":"q_fan_hint",
            "questimage":"fantastic.png",
            "streamTitle":"q_fan_streamtitle",
            "streamDescription":"q_fan_streamdescription",
            "streamImage":"quests/fantastic.png",
            "rules":{"bonus_fan":1}
         },{
            "list":true,
            "reward":[20000,0,0,0,0],
            "id":"C4",
            "group":0,
            "name":"q_c4_name",
            "description":"q_c4_description",
            "hint":"q_c4_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c4_streamtitle",
            "streamDescription":"q_c4_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b1lvl":4}
         },{
            "list":true,
            "reward":[1000,1000,500,500,0],
            "id":"M4",
            "group":3,
            "name":"q_m4_name",
            "description":"q_m4_description",
            "hint":"q_m4_hint",
            "questimage":"mushroombooty.png",
            "streamTitle":"q_m4_streamtitle",
            "streamDescription":"q_m4_streamdescription",
            "streamImage":"quests/mushroombooty.png",
            "rules":{"goldmushroomspicked":5}
         },{
            "list":true,
            "reward":[0,20000,0,0,0],
            "id":"C5",
            "group":0,
            "name":"q_c5_name",
            "description":"q_c5_description",
            "hint":"q_c5_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c5_streamtitle",
            "streamDescription":"q_c5_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b2lvl":4}
         },{
            "list":true,
            "reward":[0,0,10000,0,0],
            "id":"C6",
            "group":0,
            "name":"q_c6_name",
            "description":"q_c6_description",
            "hint":"q_c6_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c6_streamtitle",
            "streamDescription":"q_c6_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b3lvl":4}
         },{
            "list":true,
            "reward":[0,0,0,10000,0],
            "id":"C7",
            "group":0,
            "name":"q_c7_name",
            "description":"q_c7_description",
            "hint":"q_c7_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c7_streamtitle",
            "streamDescription":"q_c7_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b4lvl":4}
         },{
            "list":true,
            "reward":[5000,5000,2500,2500,0],
            "id":"C14",
            "group":0,
            "name":"q_c14_name",
            "description":"q_c14_description",
            "hint":"q_c14_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c14_streamtitle",
            "streamDescription":"q_c14_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b14lvl":3}
         },{
            "list":true,
            "reward":[0x1f40,0x1f40,0xfa0,0xfa0,0],
            "id":"S3",
            "group":0,
            "name":"q_s3_name",
            "description":"q_s3_description",
            "hint":"q_s3_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_s3_streamtitle",
            "streamDescription":"q_s3_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b6lvl":3}
         },{
            "list":true,
            "reward":[10000,10000,5000,5000,0],
            "id":"C15",
            "group":0,
            "name":"q_c15_name",
            "description":"q_c15_description",
            "hint":"q_c15_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c15_streamtitle",
            "streamDescription":"q_c15_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b14lvl":4}
         },{
            "list":true,
            "reward":[16000,16000,0x1f40,0x1f40,0],
            "id":"S4",
            "group":0,
            "name":"q_s4_name",
            "description":"q_s4_description",
            "hint":"q_s4_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_s4_streamtitle",
            "streamDescription":"q_s4_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b6lvl":4}
         },{
            "list":true,
            "reward":[20000,20000,10000,10000,0],
            "id":"C16",
            "group":0,
            "name":"q_c16_name",
            "description":"q_c16_description",
            "hint":"q_c16_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_c16_streamtitle",
            "streamDescription":"q_c16_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b14lvl":5}
         },{
            "list":true,
            "reward":[32000,32000,16000,16000,0],
            "id":"S5",
            "group":0,
            "name":"q_s5_name",
            "description":"q_s5_description",
            "hint":"q_s5_hint",
            "questimage":"completequest.png",
            "streamTitle":"q_s5_streamtitle",
            "streamDescription":"q_s5_streamdescription",
            "streamImage":"quests/generic.png",
            "rules":{"b6lvl":5}
         },{
            "list":true,
            "reward":[5000,5000,5000,5000,0],
            "id":"M2",
            "group":3,
            "name":"q_m2_name",
            "description":"q_m2_description",
            "hint":"q_m2_hint",
            "questimage":"mushroompizza.png",
            "streamTitle":"q_m2_streamtitle",
            "streamDescription":"q_m2_streamdescription",
            "streamImage":"mushroompizza.png",
            "rules":{"mushroomspicked":100}
         },{
            "list":true,
            "reward":[5000,5000,5000,5000,0],
            "id":"M5",
            "group":3,
            "name":"q_m5_name",
            "description":"q_m5_description",
            "hint":"q_m5_hint",
            "questimage":"mushroombling.png",
            "streamTitle":"q_m5_streamtitle",
            "streamDescription":"q_m5_streamdescription",
            "streamImage":"quests/mushroombling.png",
            "rules":{"goldmushroomspicked":20}
         },{
            "list":true,
            "reward":[50000,50000,50000,50000,0],
            "id":"M6",
            "group":3,
            "name":"q_m6_name",
            "description":"q_m6_description",
            "hint":"q_m6_hint",
            "questimage":"slotmachine.png",
            "streamTitle":"q_m6_streamtitle",
            "streamDescription":"q_m6_streamdescription",
            "streamImage":"quests/slotmachine.png",
            "rules":{"goldmushroomspicked":50}
         },{
            "list":true,
            "reward":[10000,10000,20000,20000,0],
            "id":"M3",
            "group":3,
            "name":"q_m3_name",
            "description":"q_m3_description",
            "hint":"q_m3_hint",
            "questimage":"burger.png",
            "streamTitle":"q_m3_streamtitle",
            "streamDescription":"q_m3_streamdescription",
            "streamImage":"quests/burger.png",
            "rules":{"mushroomspicked":200}
         },{
            "list":true,
            "reward":[0,0,1000,1000,0],
            "id":"BL1",
            "group":4,
            "name":"q_bl1_name",
            "description":"q_bl1_description",
            "hint":"q_bl1_hint",
            "questimage":"monsterjuice.png",
            "streamTitle":"q_bl1_streamtitle",
            "streamDescription":"q_bl1_streamdescription",
            "streamImage":"quests/monsterjuice.png",
            "rules":{"monstersblended":10}
         },{
            "list":true,
            "reward":[0,0,10000,10000,0],
            "id":"BL2",
            "group":4,
            "name":"q_bl2_name",
            "description":"q_bl2_description",
            "hint":"q_bl2_hint",
            "questimage":"smoothie.png",
            "streamTitle":"q_bl2_streamtitle",
            "streamDescription":"q_bl2_streamdescription",
            "streamImage":"quests/smoothie.png",
            "rules":{"monstersblended":100}
         },{
            "list":true,
            "reward":[0,0,100000,100000,0],
            "id":"BL3",
            "group":4,
            "name":"q_bl3_name",
            "description":"q_bl3_description",
            "hint":"q_bl3_hint",
            "questimage":"monstershake.png",
            "streamTitle":"q_bl3_streamtitle",
            "streamDescription":"q_bl3_streamdescription",
            "streamImage":"quests/monstershake.png",
            "rules":{"monstersblended":1000}
         },{
            "list":true,
            "reward":[0,0,1000000,1000000,0],
            "id":"BL4",
            "group":4,
            "name":"q_bl4_name",
            "description":"q_bl4_description",
            "hint":"q_bl4_hint",
            "questimage":"margarita.png",
            "streamTitle":"q_bl4_streamtitle",
            "streamDescription":"q_bl4_streamdescription",
            "streamImage":"quests/margarita.png",
            "rules":{"monstersblended":5000}
         },{
            "list":true,
            "reward":[1000,1000,1000,1000,0],
            "id":"BK1",
            "group":3,
            "name":"q_bk1_name",
            "description":"q_bk1_description",
            "hint":"q_bk1_hint",
            "questimage":"gatherer.png",
            "streamTitle":"q_bk1_streamtitle",
            "streamDescription":"q_bk1_streamdescription",
            "streamImage":"quests/gatherer.png",
            "rules":{"singleclickbank":1000}
         },{
            "list":true,
            "reward":[2000,2000,2000,2000,0],
            "id":"BK2",
            "group":3,
            "name":"q_bk2_name",
            "description":"q_bk2_description",
            "hint":"q_bk2_hint",
            "questimage":"trenchcoat.png",
            "streamTitle":"q_bk2_streamtitle",
            "streamDescription":"q_bk2_streamdescription",
            "streamImage":"quests/trenchcoat.png",
            "rules":{"singleclickbank":20000}
         },{
            "list":true,
            "reward":[10000,10000,10000,10000,0],
            "id":"BK3",
            "group":3,
            "name":"q_bk3_name",
            "description":"q_bk3_description",
            "hint":"q_bk3_hint",
            "questimage":"wallstreet.png",
            "streamTitle":"q_bk3_streamtitle",
            "streamDescription":"q_bk3_streamdescription",
            "streamImage":"quests/wallstreet.png",
            "rules":{"singleclickbank":100000}
         },{
            "list":true,
            "reward":[50000,50000,50000,50000,0],
            "id":"BK4",
            "group":3,
            "name":"q_bk4_name",
            "description":"q_bk4_description",
            "hint":"q_bk4_hint",
            "questimage":"mogul.png",
            "streamTitle":"q_bk4_streamtitle",
            "streamDescription":"q_bk4_streamdescription",
            "streamImage":"quests/mogul.png",
            "rules":{"singleclickbank":500000}
         },{
            "list":true,
            "reward":[10000,10000,10000,10000,0],
            "id":"WM2",
            "group":2,
            "name":"q_wm2_name",
            "description":"q_wm2_description",
            "hint":"q_wm2_hint",
            "questimage":"tribe_kozu.v2.png",
            "streamTitle":"q_wm2_streamtitle",
            "streamDescription":"q_wm2_streamdescription",
            "streamImage":"quests/tribe-kozu.v2.png",
            "rules":{"destroy_tribe2":1}
         },{
            "list":true,
            "reward":[20000,20000,20000,20000,0],
            "id":"WM3",
            "group":2,
            "name":"q_wm3_name",
            "description":"q_wm3_description",
            "hint":"q_wm3_hint",
            "questimage":"tribe_abunakki.v2.png",
            "streamTitle":"q_wm3_streamtitle",
            "streamDescription":"q_wm3_streamdescription",
            "streamImage":"quests/tribe-abunakki.v2.png",
            "rules":{"destroy_tribe3":1}
         },{
            "list":true,
            "reward":[40000,40000,40000,40000,0],
            "id":"WM4",
            "group":2,
            "name":"q_wm4_name",
            "description":"q_wm4_description",
            "hint":"q_wm4_hint",
            "questimage":"tribe_dreadnaut.v2.png",
            "streamTitle":"q_wm4_streamtitle",
            "streamDescription":"q_wm4_streamdescription",
            "streamImage":"quests/tribe-dreadnaut.v2.png",
            "rules":{"destroy_tribe4":1}
         },{
            "list":true,
            "reward":[0,0,0,10000,0],
            "id":"HG1",
            "group":1,
            "name":"q_cm1_name",
            "description":"q_cm1_description",
            "hint":"q_cm1_hint",
            "questimage":"G1_L1-150.png",
            "streamTitle":"q_cm1_streamtitle",
            "streamDescription":"q_cm1_streamdescription",
            "streamImage":"quests/champ_1_1.png",
            "rules":{"hatch_champ1":1}
         },{
            "list":true,
            "reward":[0,0,0,800000,0],
            "id":"UG1",
            "group":1,
            "name":"q_cm2_name",
            "description":"q_cm2_description",
            "hint":"q_cm2_hint",
            "questimage":"G1_L6-150.png",
            "streamTitle":"q_cm2_streamtitle",
            "streamDescription":"q_cm2_streamdescription",
            "streamImage":"quests/champ_1_6.png",
            "rules":{"upgrade_champ1":1}
         },{
            "list":true,
            "reward":[0,0,0,10000,0],
            "id":"HG2",
            "group":1,
            "name":"q_cm3_name",
            "description":"q_cm3_description",
            "hint":"q_cm3_hint",
            "questimage":"G2_L1-150.png",
            "streamTitle":"q_cm3_streamtitle",
            "streamDescription":"q_cm3_streamdescription",
            "streamImage":"quests/champ_2_1.png",
            "rules":{"hatch_champ2":1}
         },{
            "list":true,
            "reward":[0,0,0,800000,0],
            "id":"UG2",
            "group":1,
            "name":"q_cm4_name",
            "description":"q_cm4_description",
            "hint":"q_cm4_hint",
            "questimage":"G2_L6-150.png",
            "streamTitle":"q_cm4_streamtitle",
            "streamDescription":"q_cm4_streamdescription",
            "streamImage":"quests/champ_2_6.png",
            "rules":{"upgrade_champ2":1}
         },{
            "list":true,
            "reward":[0,0,0,10000,0],
            "id":"HG3",
            "group":1,
            "name":"q_cm5_name",
            "description":"q_cm5_description",
            "hint":"q_cm5_hint",
            "questimage":"G3_L1-150.png",
            "streamTitle":"q_cm5_streamtitle",
            "streamDescription":"q_cm5_streamdescription",
            "streamImage":"quests/champ_3_1.png",
            "rules":{"hatch_champ3":1}
         },{
            "list":true,
            "reward":[0,0,0,800000,0],
            "id":"UG3",
            "group":1,
            "name":"q_cm6_name",
            "description":"q_cm6_description",
            "hint":"q_cm6_hint",
            "questimage":"G3_L6-150.png",
            "streamTitle":"q_cm6_streamtitle",
            "streamDescription":"q_cm6_streamdescription",
            "streamImage":"quests/champ_3_6.png",
            "rules":{"upgrade_champ3":1}
         },{
            "list":true,
            "reward":[1000,1000,1000,1000,0],
            "id":"GA1",
            "group":3,
            "name":"q_ga1_name",
            "description":"q_ga1_description",
            "hint":"q_ga1_hint",
            "questimage":"brasscoin.png",
            "streamTitle":"q_ga1_streamtitle",
            "streamDescription":"q_ga1_streamdescription",
            "streamImage":"quests/brasscoin.png",
            "rules":{"gift_accept":5}
         },{
            "list":true,
            "reward":[10000,10000,10000,10000,0],
            "id":"GA2",
            "group":3,
            "name":"q_ga2_name",
            "description":"q_ga2_description",
            "hint":"q_ga2_hint",
            "questimage":"silvercoin.png",
            "streamTitle":"q_ga2_streamtitle",
            "streamDescription":"q_ga2_streamdescription",
            "streamImage":"quests/silvercoin.png",
            "rules":{"gift_accept":25}
         },{
            "list":true,
            "reward":[20000,20000,20000,20000,0],
            "id":"GA3",
            "group":3,
            "name":"q_ga3_name",
            "description":"q_ga3_description",
            "hint":"q_ga3_hint",
            "questimage":"goldcoin.png",
            "streamTitle":"q_ga3_streamtitle",
            "streamDescription":"q_ga3_streamdescription",
            "streamImage":"quests/goldcoin.png",
            "rules":{"gift_accept":50}
         }];
         if(!GLOBAL._flags.kongregate)
         {
            _quests.push({
               "list":true,
               "reward":[0,0,0,0,25],
               "id":"INVITE1",
               "group":3,
               "name":"q_invite1_name",
               "description":"q_invite1_description",
               "hint":"q_invite1_hint",
               "questimage":"friendlymonster.v2.png",
               "streamTitle":"q_invite1_streamtitle",
               "streamDescription":"q_invite1_streamdescription",
               "streamImage":"quests/friendlymonster.v2.png",
               "rules":{"bonus_invites":1}
            });
            _quests.push({
               "list":true,
               "reward":[0,0,0,0,45],
               "id":"INVITE5",
               "group":3,
               "name":"q_invite5_name",
               "description":"q_invite5_description",
               "hint":"q_invite5_hint",
               "questimage":"bandofmonsters.png",
               "streamTitle":"q_invite5_streamtitle",
               "streamDescription":"q_invite5_streamdescription",
               "streamImage":"quests/bandofmonsters.png",
               "rules":{"bonus_invites":5}
            });
            _quests.push({
               "list":true,
               "reward":[0,0,0,0,65],
               "id":"INVITE10",
               "group":3,
               "name":"q_invite10_name",
               "description":"q_invite10_description",
               "hint":"q_invite10_hint",
               "questimage":"monsterparty.png",
               "streamTitle":"q_invite10_streamtitle",
               "streamDescription":"q_invite10_streamdescription",
               "streamImage":"quests/monsterparty.png",
               "rules":{"bonus_invites":10}
            });
         }
         var _loc1_:int = 2;
         while(_loc1_ <= 13)
         {
            _loc2_ = CREATURELOCKER._creatures["C" + _loc1_];
            _quests.push({
               "list":true,
               "reward":[0,0,0,int(_loc2_.resource / 100) * 10,0],
               "id":"UC" + _loc1_,
               "group":1,
               "name":"q_unlock_name",
               "description":"q_unlock_description",
               "keyvars":{"v1":_loc2_.name},
               "hint":"q_unlock_hint",
               "creatureid":"C" + _loc1_,
               "questimage":"monster" + _loc1_ + ".v2.png",
               "rules":{"UNLOCK":"C" + _loc1_}
            });
            _loc1_++;
         }
         _completed = {};
      }
      
      public static function Data(param1:Object) : *
      {
         _completed = param1;
         if(_completed.UC100)
         {
            _completed.UC12 = _completed.UC100;
            delete _completed.UC100;
         }
      }
      
      public static function Check(param1:String = "", param2:int = 0) : *
      {
         var fail:Boolean = false;
         var i:int = 0;
         var q:* = undefined;
         var block:Boolean = false;
         var n:String = param1;
         var v:int = param2;
         try
         {
            if(GLOBAL._mode == "build")
            {
               if(Boolean(n) && _global[n] < v)
               {
                  _global[n] = v;
               }
               if(!_completed)
               {
                  _completed = {};
               }
               i = 0;
               while(i < _quests.length)
               {
                  q = _quests[i];
                  block = false;
                  if(q.id == "BOOKMARK" && !GLOBAL._flags.fanfriendbookmarkquests)
                  {
                     block = true;
                  }
                  if(q.id.substr(0,6) == "INVITE" && !GLOBAL._flags.fanfriendbookmarkquests)
                  {
                     block = true;
                  }
                  if(q.id == "FAN" && !GLOBAL._flags.fanfriendbookmarkquests)
                  {
                     block = true;
                  }
                  if(q.block)
                  {
                     block = true;
                  }
                  if(TUTORIAL._stage < 200 && (q.id == "BOOKMARK" || q.id == "FAN"))
                  {
                     block = true;
                  }
                  if(q.group != 99 && !block)
                  {
                     if(!_completed[q.id])
                     {
                        fail = false;
                        for(n in q.rules)
                        {
                           if(n == "UNLOCK")
                           {
                              if(!CREATURELOCKER._lockerData[q.rules.UNLOCK] || CREATURELOCKER._lockerData[q.rules.UNLOCK].t == 1)
                              {
                                 fail = true;
                              }
                           }
                           else if(q.rules[n] > _global[n])
                           {
                              fail = true;
                           }
                        }
                        if(Boolean(_completed[q.id]) && _completed[q.id] == 2)
                        {
                           fail = true;
                        }
                        if(!fail)
                        {
                           _completed[q.id] = 1;
                        }
                     }
                  }
                  i++;
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","Quests.Check: " + e.message + " | " + e.getStackTrace());
         }
      }
      
      public static function TutorialCheck() : *
      {
      }
      
      public static function GetQuestByID(param1:String) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in _quests)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function QuestPopup(param1:String, param2:String, param3:String, param4:String, param5:String) : *
      {
         var _loc6_:* = new popup_quest();
         _loc6_.tA.autoSize = TextFieldAutoSize.LEFT;
         _loc6_.tA.htmlText = KEYS.Get("pop_questcomplete_body",{
            "v1":param2,
            "v2":param3
         });
         _loc6_.bAction.SetupKey("pop_questcomplete_collect_btn");
         _loc6_.bAction.addEventListener(MouseEvent.CLICK,Collect(param1,true));
         _loc6_.bAction.Highlight = true;
         var _loc7_:int = _loc6_.tA.height + 60;
         if(param4 != "")
         {
            _loc7_ += 175;
            _loc6_.mcImage.y = _loc6_.tA.y + _loc6_.tA.height + 10;
         }
         _loc6_.mcBG.height = _loc7_;
         _loc6_.bAction.y = _loc6_.mcBG.y + _loc7_ - 40;
         if(TUTORIAL._stage < 200)
         {
            _loc6_.bClose.visible = false;
         }
         POPUPS.Push(_loc6_,null,null,null,param4);
      }
      
      public static function Collect(param1:String, param2:Boolean = false) : *
      {
         var questID:String = param1;
         var popup:Boolean = param2;
         return function(param1:MouseEvent = null):*
         {
            CollectB(questID,popup);
         };
      }
      
      public static function CollectB(param1:String, param2:Boolean = false) : Boolean
      {
         var Brag:Function;
         var questGroup:int = 0;
         var reward:Array = null;
         var title:String = null;
         var streamTitle:String = null;
         var streamDescription:String = null;
         var found:Boolean = false;
         var q:Object = null;
         var value:int = 0;
         var collectedArr:Array = null;
         var saveOK:Boolean = false;
         var r:int = 0;
         var popupMC:* = undefined;
         var h:int = 0;
         var questID:String = param1;
         var popup:Boolean = param2;
         if(BASE._pendingPurchase.length == 0)
         {
            found = false;
            for each(q in QUESTS._quests)
            {
               if(q.id == questID)
               {
                  if(_completed[questID] != 1)
                  {
                     return false;
                  }
                  questGroup = int(q.group);
                  reward = q.reward;
                  title = q.name;
                  streamTitle = q.streamTitle;
                  streamDescription = q.streamDescription;
                  found = true;
                  break;
               }
            }
            if(!found)
            {
               GLOBAL.Message(KEYS.Get("q_errorcollecting"));
               Hide();
               return false;
            }
            value = 0;
            collectedArr = [];
            saveOK = true;
            r = 0;
            while(r < reward.length)
            {
               if(reward[r] > 0)
               {
                  collectedArr.push([r,reward[r]]);
                  if(r < 4)
                  {
                     BASE.Fund(r + 1,reward[r],true);
                  }
                  else
                  {
                     _completed[questID] = 2;
                     BASE._credits.Add(reward[r]);
                     BASE._hpCredits += reward[r];
                     BASE.Purchase("Q" + questID,1,"quest");
                     saveOK = false;
                  }
                  value += reward[r];
               }
               r++;
            }
            _completed[questID] = 2;
            BASE.PointsAdd(Math.ceil(value / 50));
            if(questID == "C0")
            {
               BASE.PointsAdd(100);
            }
            if(saveOK)
            {
               BASE.Save();
            }
            Check();
            if(TUTORIAL._stage >= 200 && Boolean(q.streamTitle))
            {
               Brag = function():*
               {
                  var _loc1_:Array = [];
                  if(q.reward[0] > 0)
                  {
                     _loc1_.push([q.reward[0],KEYS.Get(GLOBAL._resourceNames[0])]);
                  }
                  if(q.reward[1] > 0)
                  {
                     _loc1_.push([q.reward[1],KEYS.Get(GLOBAL._resourceNames[1])]);
                  }
                  if(q.reward[2] > 0)
                  {
                     _loc1_.push([q.reward[2],KEYS.Get(GLOBAL._resourceNames[2])]);
                  }
                  if(q.reward[3] > 0)
                  {
                     _loc1_.push([q.reward[3],KEYS.Get(GLOBAL._resourceNames[3])]);
                  }
                  if(q.reward[4] > 0)
                  {
                     _loc1_.push([q.reward[4],KEYS.Get(GLOBAL._resourceNames[4])]);
                  }
                  var _loc2_:String = GLOBAL.Array2String(_loc1_);
                  var _loc3_:String = KEYS.Get(q.streamTitle).replace("#questname#",KEYS.Get(q.name)).replace("#collected#",_loc2_);
                  var _loc4_:String = KEYS.Get(q.streamDescription).replace("#questname#",KEYS.Get(q.name)).replace("#collected#",_loc2_);
                  var _loc5_:String = q.streamImage;
                  GLOBAL.CallJS("sendFeed",["quest-collected",_loc3_,_loc4_,_loc5_,0]);
                  POPUPS.Next();
               };
               popupMC = new popup_quest();
               popupMC.tA.htmlText = "<b>" + KEYS.Get("pop_questcollected_body",{"v1":KEYS.Get(q.name)}) + "</b>";
               popupMC.bAction.SetupKey("btn_brag");
               popupMC.bAction.addEventListener(MouseEvent.CLICK,Brag);
               popupMC.bAction.Highlight = true;
               h = popupMC.tA.height + 80;
               if(q.questimage != "")
               {
                  h += 190;
                  popupMC.mcImage.y = popupMC.tA.y + popupMC.tA.height + 20;
               }
               popupMC.mcBG.height = h;
               (popupMC.mcBG as frame2).Setup();
               popupMC.bAction.y = popupMC.mcBG.y + h - 45;
               POPUPS.Push(popupMC,null,null,null,q.questimage);
            }
         }
         return true;
      }
      
      public static function Show(param1:MouseEvent = null) : *
      {
         if(GLOBAL._mode == "build")
         {
            if(GLOBAL._newBuilding)
            {
               GLOBAL._newBuilding.Cancel();
            }
            if(!_open)
            {
               SOUNDS.Play("click1");
               _open = true;
               BASE.BuildingDeselect();
               GLOBAL.BlockerAdd();
               _mc = GLOBAL._layerWindows.addChild(new QUESTSPOPUP());
               _mc.x = 380;
               _mc.y = 260;
               _mc.scaleY = 0.9;
               _mc.scaleX = 0.9;
               TweenLite.to(_mc,0.2,{
                  "scaleX":1,
                  "scaleY":1,
                  "ease":Quad.easeOut
               });
            }
         }
      }
      
      public static function Hide(param1:MouseEvent = null) : *
      {
         if(_open)
         {
            GLOBAL.BlockerRemove();
            SOUNDS.Play("close");
            _open = false;
            GLOBAL._layerWindows.removeChild(_mc);
            _mc = null;
         }
      }
      
      public static function CheckB() : *
      {
         var tmpArray:Array = null;
         var Push:Function = function(param1:int):*
         {
            var _loc2_:Object = _quests[param1];
            tmpArray.push([_loc2_.reward,_loc2_.id,_loc2_.group]);
            var _loc3_:int = 1;
            while(_loc3_ <= 21)
            {
               if(_loc2_.rules["b" + _loc3_ + "lvl"])
               {
                  tmpArray.push(_loc2_.rules["b" + _loc3_ + "lvl"]);
               }
               _loc3_++;
            }
         };
         tmpArray = [];
         var i:* = 0;
         while(i < _quests.length)
         {
            Push(i);
            i++;
         }
         return MD5.hash(com.adobe.serialization.json.JSON.encode(tmpArray));
      }
      
      public static function Completed() : *
      {
      }
   }
}

