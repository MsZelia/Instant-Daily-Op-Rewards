package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol11")]
   public class DOBaseRewardsEntry extends MovieClip
   {
      
      public static const EVENT_SHOW_DOUBLE_MUTATION_REWARD:String = "DailyOps::ShowDoubleMutationReward";
      
      private static const STAR_STRING:* = "¬";
       
      
      public var BaseRewardsListEntry_Internal_mc:MovieClip;
      
      private var DoubleMutationAnim_mc:MovieClip;
      
      private var m_IsDoubleMutationReward:Boolean = false;
      
      private var m_RewardCount:uint = 0;
      
      private var m_RewardName:String = "";
      
      public function DOBaseRewardsEntry()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,10,this.frame11);
         this.DoubleMutationAnim_mc = this.BaseRewardsListEntry_Internal_mc.DoubleMutationAnim_mc;
         this.DoubleMutationAnim_mc.visible = false;
         TextFieldEx.setTextAutoSize(this.BaseRewardsListEntry_Internal_mc.Name_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.BaseRewardsListEntry_Internal_mc.Stars_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.BaseRewardsListEntry_Internal_mc.Stars_tf.visible = false;
         this.DoubleMutationAnim_mc.addEventListener(EVENT_SHOW_DOUBLE_MUTATION_REWARD,this.onShowDoubleMutationReward);
      }
      
      public function get isDoubleMutationReward() : Boolean
      {
         return this.m_IsDoubleMutationReward;
      }
      
      public function set isDoubleMutationReward(param1:Boolean) : void
      {
         this.m_IsDoubleMutationReward = param1;
         this.DoubleMutationAnim_mc.visible = this.m_IsDoubleMutationReward;
      }
      
      public function get rewardCount() : uint
      {
         return this.m_RewardCount;
      }
      
      public function set rewardCount(param1:uint) : void
      {
         this.m_RewardCount = param1;
      }
      
      public function get rewardName() : String
      {
         return this.m_RewardName;
      }
      
      public function set rewardName(param1:String) : void
      {
         this.m_RewardName = param1;
      }
      
      public function setName(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1)
         {
            _loc2_ = int(param1.indexOf(STAR_STRING));
            if(_loc2_ != -1)
            {
               _loc3_ = param1.substr(0,_loc2_);
               _loc4_ = param1.substring(_loc2_ - 1);
               this.BaseRewardsListEntry_Internal_mc.Name_tf.text = _loc3_.toUpperCase();
               this.BaseRewardsListEntry_Internal_mc.Stars_tf.text = _loc4_;
               this.BaseRewardsListEntry_Internal_mc.Stars_tf.visible = true;
               this.BaseRewardsListEntry_Internal_mc.Stars_tf.x = this.BaseRewardsListEntry_Internal_mc.Name_tf.textWidth;
            }
            else
            {
               this.BaseRewardsListEntry_Internal_mc.Name_tf.text = param1.toUpperCase();
            }
         }
      }
      
      public function playDoubleMutationAnim() : void
      {
         if(this.isDoubleMutationReward && this.DoubleMutationAnim_mc.visible && this.DoubleMutationAnim_mc.currentLabel != "rollOn")
         {
            this.DoubleMutationAnim_mc.gotoAndPlay("rollOn");
         }
      }
      
      private function onShowDoubleMutationReward(param1:Event) : void
      {
         if(this.isDoubleMutationReward)
         {
            param1.stopPropagation();
            this.setName(DOShared.buildRewardName(this.m_RewardName,this.m_RewardCount));
         }
      }
      
      internal function frame1() : *
      {
         stop();
         stage.dispatchEvent(new Event("DailyOps::ShowNextReward"));
      }
      
      internal function frame2() : *
      {
         stage.dispatchEvent(new Event("DailyOps::PlayBaseRewardFadeSound"));
      }
      
      internal function frame11() : *
      {
         stop();
      }
   }
}
