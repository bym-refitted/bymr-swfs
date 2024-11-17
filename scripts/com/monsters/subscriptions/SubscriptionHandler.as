package com.monsters.subscriptions
{
   import com.monsters.baseplanner.BasePlanner;
   import com.monsters.frontPage.FrontPageLibrary;
   import com.monsters.frontPage.messages.promotions.Promo01DaveClub;
   import com.monsters.interfaces.IHandler;
   import com.monsters.rewarding.Reward;
   import com.monsters.rewarding.RewardHandler;
   import com.monsters.subscriptions.rewards.DAVEStatueReward;
   import com.monsters.subscriptions.rewards.ExtraTilesReward;
   import com.monsters.subscriptions.rewards.GoldenDAVEReward;
   import com.monsters.subscriptions.rewards.ImprovedHCCReward;
   import com.monsters.subscriptions.rewards.YardPlannerExtraSlotsReward;
   import com.monsters.subscriptions.ui.SubscriptionJoinPopup;
   import com.monsters.subscriptions.ui.SubscriptionResourceIcon;
   import com.monsters.subscriptions.ui.controlPanel.SubscriptionControlPanelPopup;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SubscriptionHandler implements IHandler
   {
      private static var _instance:SubscriptionHandler;
      
      public static const JOIN:String = "startSubscription";
      
      public static const CANCEL:String = "cancelSubscription";
      
      public static const CHANGE:String = "changeSubscription";
      
      public static const REACTIVATE:String = "reactiveSubscription";
      
      private var _rewardIDs:Vector.<String> = Vector.<String>([ImprovedHCCReward.ID,DAVEStatueReward.ID,GoldenDAVEReward.ID,ExtraTilesReward.ID,YardPlannerExtraSlotsReward.ID]);
      
      private var _renewalDate:uint;
      
      private var _expirationDate:uint;
      
      private var _icon:SubscriptionResourceIcon;
      
      private var _service:SubscriptionService;
      
      private var _subscriptionID:Number;
      
      public function SubscriptionHandler()
      {
         super();
      }
      
      public static function get instance() : SubscriptionHandler
      {
         if(!_instance)
         {
            _instance = new SubscriptionHandler();
            _instance._service = new SubscriptionService();
         }
         return _instance;
      }
      
      public static function setRenewalDateDEBUG(param1:uint) : void
      {
         _instance._renewalDate = param1;
         _instance.updateSubscriptionStatus();
      }
      
      public static function setExpirationDateDEBUG(param1:uint) : void
      {
         _instance._expirationDate = param1;
         _instance.updateSubscriptionStatus();
      }
      
      public function get name() : String
      {
         return "subscriptions";
      }
      
      public function get isSubscriptionActive() : Boolean
      {
         return this._renewalDate;
      }
      
      public function get renewalDate() : uint
      {
         return this._renewalDate;
      }
      
      public function get expirationDate() : uint
      {
         return this._expirationDate;
      }
      
      public function initialize(param1:Object = null) : void
      {
      }
      
      protected function recievedSubscriptionData(param1:SubscriptionStatusEvent) : void
      {
         this._subscriptionID = param1.subscriptionID;
         this._renewalDate = param1.expirationDate;
         this._expirationDate = param1.expirationDate;
         this.updateSubscriptionStatus();
      }
      
      private function updateSubscriptionStatus() : void
      {
         this.updateRewards();
         this._icon.update(this.isSubscriptionActive);
      }
      
      private function unlockTeaserInformation() : void
      {
         FrontPageLibrary.PROMOTIONS.addMessage(new Promo01DaveClub());
         DAVEStatueReward.makeVisibleInStore(this.showPromoPopup);
         BasePlanner.maxNumberOfSlots = 10;
      }
      
      private function addIcon() : void
      {
         this._icon = new SubscriptionResourceIcon(this.isSubscriptionActive);
         UI2._top.addResourceBar(this._icon);
         this._icon.addEventListener(MouseEvent.CLICK,this.clickedIcon,false,0,true);
      }
      
      protected function clickedIcon(param1:Event) : void
      {
         if(this.isSubscriptionActive)
         {
            this.showControlPanel();
         }
         else
         {
            this.showPromoPopup();
         }
      }
      
      private function showControlPanel() : void
      {
         var _loc1_:SubscriptionControlPanelPopup = new SubscriptionControlPanelPopup();
         POPUPS.Push(_loc1_);
         _loc1_.addEventListener(Event.CLOSE,this.clickedClosePanel);
         _loc1_.addEventListener(CHANGE,this.clickedChange);
         _loc1_.addEventListener(CANCEL,this.clickedCancel);
         _loc1_.addEventListener(SubscriptionControlPanelPopup.PLACE_DAVE_STATUE,this.clickedPlace);
         _loc1_.addEventListener(SubscriptionControlPanelPopup.SAVE,this.clickedSave);
      }
      
      protected function clickedClosePanel(param1:Event) : void
      {
         var _loc2_:SubscriptionControlPanelPopup = param1.target as SubscriptionControlPanelPopup;
         _loc2_.removeEventListener(Event.CLOSE,this.clickedClosePanel);
         _loc2_.removeEventListener(CHANGE,this.clickedChange);
         _loc2_.removeEventListener(CANCEL,this.clickedCancel);
         _loc2_.removeEventListener(SubscriptionControlPanelPopup.PLACE_DAVE_STATUE,this.clickedPlace);
         _loc2_.removeEventListener(SubscriptionControlPanelPopup.SAVE,this.clickedSave);
         POPUPS.Next();
      }
      
      protected function clickedChange(param1:Event) : void
      {
         this._service.changeSubscription(this._subscriptionID);
      }
      
      protected function clickedCancel(param1:Event) : void
      {
         this._service.cancelSubscription(this._subscriptionID);
      }
      
      protected function clickedPlace(param1:Event) : void
      {
         BASE.addBuildingB(DAVEStatueReward.DAVE_STATUE_TYPE_ID,true);
      }
      
      protected function clickedSave(param1:Event) : void
      {
         var _loc2_:SubscriptionControlPanelPopup = param1.target as SubscriptionControlPanelPopup;
         var _loc3_:Reward = RewardHandler.instance.getRewardByID(GoldenDAVEReward.ID);
         this.updateRewardValue(_loc3_,_loc2_.goldDavesToggle);
         _loc3_ = RewardHandler.instance.getRewardByID(ExtraTilesReward.ID);
         this.updateRewardValue(_loc3_,_loc2_.bgTileSelected);
         POPUPS.Next();
         BASE.Save();
      }
      
      private function updateRewardValue(param1:Reward, param2:Number) : void
      {
         if(param1.value == param2)
         {
            return;
         }
         param1.value = param2;
         RewardHandler.instance.applyReward(param1);
      }
      
      public function showPromoPopup() : void
      {
         var _loc1_:SubscriptionJoinPopup = new SubscriptionJoinPopup();
         POPUPS.Push(_loc1_);
         _loc1_.addEventListener(JOIN,this.clickedJoin);
         _loc1_.addEventListener(Event.CLOSE,this.clickedClose);
      }
      
      protected function clickedJoin(param1:Event) : void
      {
         this._service.startSubscription();
         this.clickedClose(param1);
      }
      
      protected function clickedClose(param1:Event) : void
      {
         var _loc2_:SubscriptionJoinPopup = param1.target as SubscriptionJoinPopup;
         _loc2_.removeEventListener(JOIN,this.clickedJoin);
         _loc2_.removeEventListener(Event.CLOSE,this.clickedClose);
         POPUPS.Next();
      }
      
      private function updateRewards() : void
      {
         var _loc2_:Reward = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._rewardIDs.length)
         {
            if(this.isSubscriptionActive)
            {
               _loc2_ = RewardHandler.instance.updateExistingOrAddNewReward(this._rewardIDs[_loc1_]);
               if(!_loc2_.hasBeenApplied)
               {
                  RewardHandler.instance.applyReward(_loc2_);
               }
            }
            else
            {
               RewardHandler.instance.removeRewardByID(this._rewardIDs[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      public function importData(param1:Object) : void
      {
      }
      
      public function exportData() : Object
      {
         return null;
      }
   }
}

