package
{
   import Shared.AS3.Events.CustomEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.setTimeout;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol123")]
   public class DOMissionRewardsModal extends MovieClip
   {
      
      private static const MAX_REWARDS_COUNT:uint = 12;
      
      private static const REWARDS_Y_OFFSET:Number = 2;
      
      private static const DAILY_UNLOCKS_WAIT_TIME_MS:Number = 100;
      
      private static const DOUBLE_MUTATION_REWARDS_WAIT_TIME_MS:Number = 100;
      
      private static const DAILY_UNLOCKS_WAIT_TIME_EXTENDED_MS:Number = 150;
      
      private static const EVENT_PLAY_BASE_REWARD_FADE_SOUND:String = "DailyOps::PlayBaseRewardFadeSound";
      
      private static const EVENT_PLAY_DAILY_UNLOCK_FADE_SOUND:String = "DailyOps::PlayDailyUnlockFadeSound";
      
      private static const EVENT_PLAY_DAILY_UNLOCK_UNLOCKED_SOUND:String = "DailyOps::PlayDailyUnlockUnlockedSound";
      
      private static const EVENT_SHOW_DAILY_UNLOCK_REWARD:String = "DailyOps::ShowDailyUnlockReward";
      
      private static const EVENT_SHOW_NEXT_REWARD:String = "DailyOps::ShowNextReward";
      
      private static const EVENT_FINAL_DAILY_UNLOCK_SHOWN:String = "DailyOps::FinalDailyUnlockShown";
      
      private static const EVENT_UNLOCK_DAILY_UNLOCK:String = "DailyOps::UnlockDailyUnlock";
       
      
      public var MissionRewardsGraphic_mc:MovieClip;
      
      private var Rewards_mc:MovieClip;
      
      private var RewardsList_mc:MovieClip;
      
      private var UniqueRewards_mc:MovieClip;
      
      private var UniqueRewardsList_mc:MovieClip;
      
      private var DailyUnlocks_mc:MovieClip;
      
      private var InitiateUnlocks_mc:DODailyUnlocksEntry;
      
      private var PaladinUnlocks_mc:DODailyUnlocksEntry;
      
      private var ElderUnlocks_mc:DODailyUnlocksEntry;
      
      private var ToolTip_mc:MovieClip;
      
      private var m_DailyUnlocksList:Vector.<DODailyUnlocksEntry>;
      
      private var m_DailyUnlocksRewards:Array;
      
      private var m_RankData:Array;
      
      private var m_RewardsEntriesVector:Vector.<DOBaseRewardsEntry>;
      
      private var m_UniqueRewardsEntriesVector:Vector.<DOBaseRewardsEntry>;
      
      private var m_ShownRewardsCount:uint = 0;
      
      private var m_HasDoubleMutationRewards:Boolean = false;
      
      private var m_DoubleMutationRewardsShown:Boolean = false;
      
      public function DOMissionRewardsModal()
      {
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11);
         this.ToolTip_mc = this.MissionRewardsGraphic_mc.Tooltip_mc;
         this.Rewards_mc = this.MissionRewardsGraphic_mc.Rewards_mc;
         this.RewardsList_mc = this.Rewards_mc.RewardsList_mc;
         this.UniqueRewards_mc = this.MissionRewardsGraphic_mc.UniqueRewards_mc;
         this.UniqueRewardsList_mc = this.UniqueRewards_mc.RewardsList_mc;
         this.DailyUnlocks_mc = this.MissionRewardsGraphic_mc.DailyUnlocks_mc;
         this.InitiateUnlocks_mc = this.DailyUnlocks_mc.InitiateUnlocks_mc;
         this.PaladinUnlocks_mc = this.DailyUnlocks_mc.PaladinUnlocks_mc;
         this.ElderUnlocks_mc = this.DailyUnlocks_mc.ElderUnlocks_mc;
         this.m_DailyUnlocksList = new Vector.<DODailyUnlocksEntry>();
         this.m_DailyUnlocksList.push(this.InitiateUnlocks_mc);
         this.m_DailyUnlocksList.push(this.PaladinUnlocks_mc);
         this.m_DailyUnlocksList.push(this.ElderUnlocks_mc);
         this.m_RewardsEntriesVector = new Vector.<DOBaseRewardsEntry>();
         this.m_UniqueRewardsEntriesVector = new Vector.<DOBaseRewardsEntry>();
         this.m_DailyUnlocksRewards = new Array();
         this.m_RankData = new Array();
         this.UniqueRewards_mc.Title_tf.text = "$DO_RAREREWARDS";
         TextFieldEx.setTextAutoSize(this.ToolTip_mc.Tooltip_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.DailyUnlocks_mc.Title_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.Rewards_mc.Title_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.UniqueRewards_mc.Title_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         stage.addEventListener(EVENT_PLAY_BASE_REWARD_FADE_SOUND,this.onPlayBaseRewardFadeSound);
         stage.addEventListener(EVENT_PLAY_DAILY_UNLOCK_FADE_SOUND,this.onPlayDailyUnlockFadeSound);
         stage.addEventListener(EVENT_PLAY_DAILY_UNLOCK_UNLOCKED_SOUND,this.onPlayDailyUnlockUnlockedSound);
         stage.addEventListener(EVENT_SHOW_DAILY_UNLOCK_REWARD,this.onShowDailyUnlockReward);
         stage.addEventListener(EVENT_SHOW_NEXT_REWARD,this.onShowNextReward);
         stage.addEventListener(EVENT_FINAL_DAILY_UNLOCK_SHOWN,this.onFinalDailyUnlockShown);
         stage.addEventListener(EVENT_UNLOCK_DAILY_UNLOCK,this.onUnlockDailyUnlock);
      }
      
      public function setRewardsData(param1:Array, param2:Object, param3:uint) : void
      {
         var _loc6_:Boolean = false;
         var _loc7_:Array = null;
         var _loc4_:Boolean = false;
         var _loc5_:int = int(param1.length - 1);
         while(_loc5_ > -1)
         {
            if(_loc5_ < this.m_DailyUnlocksList.length && _loc5_ >= 0)
            {
               if(!_loc4_ && Boolean(param1[_loc5_].currentRankAchieved))
               {
                  _loc4_ = true;
               }
               _loc6_ = _loc4_ ? _loc4_ : Boolean(param1[_loc5_].currentRankAchieved);
               this.m_DailyUnlocksList[_loc5_].populateUnlockData(param1[_loc5_].rankAchieved,_loc6_);
            }
            _loc5_--;
         }
         this.m_RankData = param1;
         if(Boolean(param2) && Boolean(param2.dailyUnlocks))
         {
            this.m_DailyUnlocksRewards = param2.dailyUnlocks;
         }
         else
         {
            this.m_DailyUnlocksRewards = new Array();
         }
         if(param2 && param2.rewards && currentLabel != "rollOn")
         {
            _loc7_ = param2.rewards.concat();
            if(param3 == DOShared.MUTATION_MODE_DOUBLE)
            {
               _loc7_.sort(this.sortDailyOpsRewardsDoubleMutation);
            }
            this.setupRewardsEntries(_loc7_);
         }
      }
      
      public function setTooltip(param1:uint) : void
      {
         switch(param1)
         {
            case DOShared.MUTATION_MODE_DOUBLE:
               this.ToolTip_mc.Tooltip_tf.text = "$DO_TOOLTIP_DOUBLE";
               break;
            case DOShared.MUTATION_MODE_SINGLE:
            default:
               this.ToolTip_mc.Tooltip_tf.text = "$DO_TOOLTIP";
         }
      }
      
      public function show() : void
      {
         gotoAndPlay("rollOn");
      }
      
      private function setupRewardsEntries(param1:Array) : void
      {
         var _loc2_:uint = 0;
         this.clearRewardEntries();
         if(param1)
         {
            while(_loc2_ < param1.length)
            {
               if(_loc2_ < MAX_REWARDS_COUNT)
               {
                  this.addRewardEntry(this.RewardsList_mc,this.m_RewardsEntriesVector,param1[_loc2_].name,param1[_loc2_].count,param1[_loc2_].isDoubleMutationReward);
               }
               _loc2_++;
            }
         }
      }
      
      private function addRewardEntry(param1:MovieClip, param2:Vector.<DOBaseRewardsEntry>, param3:String, param4:uint = 1, param5:Boolean = false) : DOBaseRewardsEntry
      {
         var _loc6_:DOBaseRewardsEntry = null;
         if(param1 && param2 && param3 && param3.length > 0 && param4 > 0)
         {
            if((_loc6_ = new DOBaseRewardsEntry()) != null)
            {
               param1.addChild(_loc6_);
               param2.push(_loc6_);
               _loc6_.rewardName = param3;
               _loc6_.rewardCount = param4;
               _loc6_.isDoubleMutationReward = param5;
               _loc6_.setName(DOShared.buildRewardName(param3,param4));
               _loc6_.y = _loc6_.height * (param2.length - 1) + REWARDS_Y_OFFSET * (param2.length - 1);
            }
         }
         return _loc6_;
      }
      
      private function clearRewardEntries() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.m_RewardsEntriesVector.length)
         {
            this.RewardsList_mc.removeChildAt(this.RewardsList_mc.getChildIndex(this.m_RewardsEntriesVector[_loc1_]));
            _loc1_++;
         }
         this.m_RewardsEntriesVector = new Vector.<DOBaseRewardsEntry>();
      }
      
      private function showRareRewardsNone() : Boolean
      {
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc1_:Boolean = true;
         var _loc2_:* = this.m_UniqueRewardsEntriesVector.length == 0;
         var _loc3_:DOBaseRewardsEntry = null;
         while(_loc4_ < this.m_DailyUnlocksRewards.length)
         {
            if(Boolean(this.m_DailyUnlocksRewards[_loc4_].name) && this.m_DailyUnlocksRewards[_loc4_].name.length > 0)
            {
               _loc1_ = false;
               if(_loc2_)
               {
                  _loc3_ = this.addRewardEntry(this.UniqueRewardsList_mc,this.m_UniqueRewardsEntriesVector,this.m_DailyUnlocksRewards[_loc4_].name);
                  if(_loc3_)
                  {
                     _loc3_.gotoAndPlay("rollOn");
                  }
               }
            }
            _loc4_++;
         }
         if(_loc1_)
         {
            _loc5_ = "$NONE";
            if(this.m_RankData && this.m_RankData.length > 0 && Boolean(this.m_RankData[this.m_RankData.length - 1].rankAchieved))
            {
               _loc5_ = "$DO_NO_DAILY_CHANCES";
            }
            _loc3_ = this.addRewardEntry(this.UniqueRewardsList_mc,this.m_UniqueRewardsEntriesVector,_loc5_);
            if(_loc3_)
            {
               _loc3_.gotoAndPlay("rollOn");
            }
         }
         return _loc1_;
      }
      
      private function sortDailyOpsRewardsDoubleMutation(param1:Object, param2:Object) : int
      {
         var _loc3_:int = 0;
         if(param1.name == "$$XP")
         {
            _loc3_ = -1;
         }
         else if(param2.name == "$$XP")
         {
            _loc3_ = 1;
         }
         if(_loc3_ == 0)
         {
            if(Boolean(param1.isDoubleMutationReward) && !param2.isDoubleMutationReward)
            {
               _loc3_ = -1;
            }
            else if(!param1.isDoubleMutationReward && Boolean(param2.isDoubleMutationReward))
            {
               _loc3_ = 1;
            }
         }
         if(_loc3_ == 0)
         {
            if(Boolean(param1.isLegendary) && !param2.isLegendary)
            {
               _loc3_ = -1;
            }
            else if(!param1.isLegendary && Boolean(param2.isLegendary))
            {
               _loc3_ = 1;
            }
         }
         return _loc3_;
      }
      
      private function onDailyUnlocksTimeout() : void
      {
         this.DailyUnlocks_mc.gotoAndPlay("rollOn");
      }
      
      private function onDoubleMutationRewardsTimeout() : void
      {
         var _loc1_:DOBaseRewardsEntry = null;
         if(!this.m_DoubleMutationRewardsShown)
         {
            this.m_DoubleMutationRewardsShown = true;
            GlobalFunc.PlayMenuSound("UIDailyOpsRewardDouble");
            for each(_loc1_ in this.m_RewardsEntriesVector)
            {
               if(_loc1_.isDoubleMutationReward)
               {
                  _loc1_.playDoubleMutationAnim();
               }
            }
            if(this.DailyUnlocks_mc.currentLabel != "rollOn")
            {
               setTimeout(this.onDailyUnlocksTimeout,DAILY_UNLOCKS_WAIT_TIME_EXTENDED_MS);
            }
         }
      }
      
      private function onPlayBaseRewardFadeSound(param1:Event) : void
      {
         if(currentLabel == "rollOn")
         {
            GlobalFunc.PlayMenuSound("UIDailyOpsBaseRewardsFade");
         }
         if(param1)
         {
            param1.stopPropagation();
         }
      }
      
      private function onPlayDailyUnlockFadeSound(param1:Event) : void
      {
         if(currentLabel == "rollOn")
         {
            GlobalFunc.PlayMenuSound("UIDailyOpsDailyUnlockRewardFade");
         }
         if(param1)
         {
            param1.stopPropagation();
         }
      }
      
      private function onPlayDailyUnlockUnlockedSound(param1:Event) : void
      {
         if(currentLabel == "rollOn")
         {
            GlobalFunc.PlayMenuSound("UIDailyOpsDailyUnlockRewardUnlocked");
         }
         if(param1)
         {
            param1.stopPropagation();
         }
      }
      
      private function onShowDailyUnlockReward(param1:CustomEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:DOBaseRewardsEntry = null;
         if(param1 && param1.params && param1.params.index != null && Boolean(this.m_DailyUnlocksRewards))
         {
            if(this.m_DailyUnlocksRewards.length > param1.params.index)
            {
               _loc2_ = DOShared.buildRewardName(this.m_DailyUnlocksRewards[param1.params.index].name,this.m_DailyUnlocksRewards[param1.params.index].count);
               if(Boolean(_loc2_) && _loc2_.length > 0)
               {
                  _loc3_ = this.addRewardEntry(this.UniqueRewardsList_mc,this.m_UniqueRewardsEntriesVector,_loc2_);
                  if(_loc3_)
                  {
                     _loc3_.gotoAndPlay("rollOn");
                  }
               }
               else if(param1.params.index == this.m_DailyUnlocksRewards.length - 1)
               {
                  this.showRareRewardsNone();
               }
            }
         }
         if(param1)
         {
            param1.stopPropagation();
         }
      }
      
      private function onShowNextReward(param1:Event) : void
      {
         if(Boolean(this.m_RewardsEntriesVector) && this.m_ShownRewardsCount < this.m_RewardsEntriesVector.length)
         {
            if(this.m_RewardsEntriesVector[this.m_ShownRewardsCount].isDoubleMutationReward)
            {
               this.m_HasDoubleMutationRewards = true;
            }
            this.m_RewardsEntriesVector[this.m_ShownRewardsCount++].gotoAndPlay("rollOn");
         }
         else if(this.m_HasDoubleMutationRewards)
         {
            setTimeout(this.onDoubleMutationRewardsTimeout,DOUBLE_MUTATION_REWARDS_WAIT_TIME_MS);
         }
         else if(this.DailyUnlocks_mc.currentLabel != "rollOn")
         {
            setTimeout(this.onDailyUnlocksTimeout,DAILY_UNLOCKS_WAIT_TIME_MS);
         }
         if(param1)
         {
            param1.stopPropagation();
         }
      }
      
      private function onFinalDailyUnlockShown(param1:Event) : void
      {
         if(this.m_RankData.length > 0 && (!this.m_RankData[this.m_RankData.length - 1].currentRankAchieved || this.m_RankData[this.m_RankData.length - 1].rankAchieved))
         {
            this.showRareRewardsNone();
         }
         if(param1)
         {
            param1.stopPropagation();
         }
      }
      
      private function onUnlockDailyUnlock(param1:CustomEvent) : void
      {
         if(param1)
         {
            if(param1.params && param1.params.index > -1 && param1.params.index < this.m_DailyUnlocksList.length)
            {
               this.m_DailyUnlocksList[param1.params.index].playUnlockAnimationIfValid();
            }
            param1.stopPropagation();
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame6() : *
      {
         stop();
      }
      
      internal function frame11() : *
      {
         stop();
      }
   }
}
