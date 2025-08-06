package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol63")]
   public class DOMissionRankingModal extends MovieClip
   {
      
      private static const EVENT_PLAY_UNLOCK_SOUND:String = "DailyOps::PlayUnlockSound";
      
      private static const EVENT_ACTIVATE_RANKS:String = "DailyOps::ActivateRanks";
      
      public var MissionRankingGraphic_mc:MovieClip;
      
      private var RankEntryLeft_mc:DORankEntry;
      
      private var RankEntryMid_mc:DORankEntry;
      
      private var RankEntryRight_mc:DORankEntry;
      
      private var ModeInfo_mc:MovieClip;
      
      private var CompletionTime_mc:MovieClip;
      
      private var RankEntryList:Vector.<DORankEntry>;
      
      public function DOMissionRankingModal()
      {
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11);
         this.RankEntryLeft_mc = this.MissionRankingGraphic_mc.RankEntryLeft_mc;
         this.RankEntryMid_mc = this.MissionRankingGraphic_mc.RankEntryMid_mc;
         this.RankEntryRight_mc = this.MissionRankingGraphic_mc.RankEntryRight_mc;
         this.ModeInfo_mc = this.MissionRankingGraphic_mc.ModeInfo_mc;
         this.CompletionTime_mc = this.MissionRankingGraphic_mc.CompletionTime_mc;
         this.RankEntryList = new Vector.<DORankEntry>();
         this.RankEntryList.push(this.RankEntryLeft_mc);
         this.RankEntryList.push(this.RankEntryMid_mc);
         this.RankEntryList.push(this.RankEntryRight_mc);
         stage.addEventListener(EVENT_PLAY_UNLOCK_SOUND,this.onPlayRankUnlockSound);
         stage.addEventListener(EVENT_ACTIVATE_RANKS,this.onActivateRanks);
      }
      
      public function populateRankData(param1:Array, param2:uint) : void
      {
         var _loc3_:uint = param2 / 60;
         var _loc4_:uint = param2 % 60;
         this.CompletionTime_mc.CompletionTimeClock_tf.text = GlobalFunc.LocalizeFormattedString("$DO_TIME",_loc3_,_loc4_);
         var _loc5_:Boolean = false;
         var _loc6_:int = int(param1.length - 1);
         while(_loc6_ > -1)
         {
            if(_loc6_ < this.RankEntryList.length && _loc6_ >= 0)
            {
               if(!_loc5_ && Boolean(param1[_loc6_].currentRankAchieved))
               {
                  _loc5_ = true;
               }
               this.RankEntryList[_loc6_].populateRankData(_loc6_,param1[_loc6_].rankAchieved,_loc5_ ? _loc5_ : Boolean(param1[_loc6_].currentRankAchieved),param1[_loc6_].rankTime);
            }
            _loc6_--;
         }
      }
      
      public function populateDOData(param1:String, param2:String, param3:String, param4:String) : void
      {
         TextFieldEx.setTextAutoSize(this.ModeInfo_mc.LocationInfo_mc.InfoDescription_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.ModeInfo_mc.LocationInfo_mc.InfoName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.ModeInfo_mc.EnemyInfo_mc.InfoDescription_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.ModeInfo_mc.EnemyInfo_mc.InfoName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.ModeInfo_mc.GameModeInfo_mc.InfoDescription_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.ModeInfo_mc.GameModeInfo_mc.InfoName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.ModeInfo_mc.MutatorInfo_mc.InfoDescription_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.ModeInfo_mc.MutatorInfo_mc.InfoName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.ModeInfo_mc.LocationInfo_mc.InfoDescription_tf.text = param1;
         this.ModeInfo_mc.GameModeInfo_mc.InfoDescription_tf.text = param2.toLowerCase();
         this.ModeInfo_mc.EnemyInfo_mc.InfoDescription_tf.text = param3;
         this.ModeInfo_mc.MutatorInfo_mc.InfoDescription_tf.text = param4;
      }
      
      public function show() : void
      {
         gotoAndPlay("rollOn");
      }
      
      public function hide() : void
      {
         gotoAndPlay("rollOff");
         var _loc1_:int = 0;
         while(_loc1_ < this.RankEntryList.length)
         {
            this.RankEntryList[_loc1_].cancelActivation();
            _loc1_++;
         }
      }
      
      private function onActivateRanks(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         if(currentLabel == "rollOn" && this.MissionRankingGraphic_mc.currentLabel == "on")
         {
            _loc2_ = 0;
            _loc3_ = 0;
            while(_loc3_ < this.RankEntryList.length)
            {
               if(!this.RankEntryList[_loc3_].rankAchieved)
               {
                  this.RankEntryList[_loc3_].activate(_loc2_);
                  _loc2_++;
               }
               _loc3_++;
            }
         }
         if(param1)
         {
            param1.stopPropagation();
         }
      }
      
      private function onPlayRankUnlockSound(param1:Event) : void
      {
         if(currentLabel == "rollOn" && this.MissionRankingGraphic_mc.currentLabel == "on")
         {
            GlobalFunc.PlayMenuSound("UIDailyOpsRankUnlock");
         }
         if(param1)
         {
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
         this.MissionRankingGraphic_mc.gotoAndPlay("rollOn");
      }
      
      internal function frame11() : *
      {
         stop();
      }
   }
}

