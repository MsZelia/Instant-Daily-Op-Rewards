package
{
   public class DOShared
   {
      
      public static const MUTATION_MODE_SINGLE:uint = 0;
      
      public static const MUTATION_MODE_DOUBLE:uint = 1;
      
      public function DOShared()
      {
         super();
      }
      
      public static function buildRewardName(param1:String, param2:uint) : String
      {
         var _loc3_:String = "";
         if(Boolean(param1) && Boolean(param2))
         {
            _loc3_ = param2 > 1 ? "(" + param2 + ") " + param1 : param1;
         }
         return _loc3_;
      }
   }
}

