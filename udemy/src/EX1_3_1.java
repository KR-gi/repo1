import java.sql.Time;
public class EX1_3_1 {

    public static void main(String[] args) {
        // TODO 自動生成されたメソッド・スタブ
        final int   HOURLY_WAGE = 900; //時給
        final int   MINUTES_WAGE = HOURLY_WAGE / 60; //分給 : 追加
        final int ONE_HOUR_BY_MILLI_SEC = 1000 * 60 * 60; // 1時間のミリ秒換算 : int に変更
        final int ONE_MIN_BY_MILLI_SEC  = 1000 * 60;      // 1分のミリ秒換算   : int に変更
        final int  ONE_HOUR_BY_MIN       = 60;             // 1時間の分換算
        
        //労働時間による分岐条件を回答参考に追加
        final long   WORK_TIME_TYPE1_END      = 6  * ONE_HOUR_BY_MILLI_SEC   ; //労働時間タイプ①（ミリ秒）（労働時間～6時間以下） - 終了時間
        final long   WORK_TIME_TYPE2_START    = 6  * ONE_HOUR_BY_MILLI_SEC   ; //労働時間タイプ②（ミリ秒）（労働時間6時間超～8時間以下） - 開始時間
        final long   WORK_TIME_TYPE2_END      = 8  * ONE_HOUR_BY_MILLI_SEC   ; //労働時間タイプ②（ミリ秒）（労働時間6時間超～8時間以下） - 終了時間
        final long   WORK_TIME_TYPE3_START    = 8  * ONE_HOUR_BY_MILLI_SEC   ; //労働時間タイプ③（ミリ秒）（労働時間8時間超～） - 開始時間
        final int    ACTUAL_WORK_TIME_OVERTIME_OCCUR_MIN = 8  * ONE_HOUR_BY_MIN ; //残業が発生する実労働時間（分）（実労働時間8時間）
        //ここまで追加
        
        final long  EIGHT_TIME_WORKING_HOURS_OVER  = ONE_MIN_BY_MILLI_SEC * 60; //休憩時間
        final long  EIGHT_TIME_WORKING_HOURS_UNDER = ONE_MIN_BY_MILLI_SEC * 45; //休憩時間
        final double  OVER_TIME_WORK_FARE_LATE = 1.25; //残業代の倍率
        //不要だったもの final long  REGULAR_WORKING_HOURS = 1000 * 60 * 60 * 8;
               
        // バイトの開始時間と終了時間をコマンドライン引数から受け取る
        Time startTime  = Time.valueOf(args[0]);
        Time finishTime = Time.valueOf(args[1]);
        
        // getTimeメソッドを使って労働時間をミリ秒（0.001秒単位）で取得する
        // ※getTime()メソッドの戻り値はlong型であることに注意
        long workingTime = finishTime.getTime() - startTime.getTime();      
        int actualTime = 0; //実働時間 分
        int salay = 0; //給与

       
        if (workingTime > WORK_TIME_TYPE3_START) {             
             
             actualTime = (int)( (workingTime - EIGHT_TIME_WORKING_HOURS_OVER) / ONE_MIN_BY_MILLI_SEC);
                                                 
        }else if (workingTime > WORK_TIME_TYPE2_START && workingTime >= WORK_TIME_TYPE2_END) {    
            
             actualTime = (int)((workingTime - EIGHT_TIME_WORKING_HOURS_UNDER) / ONE_MIN_BY_MILLI_SEC);
             
             
        }else if (workingTime <= WORK_TIME_TYPE1_END){
            
            actualTime = (int)(workingTime / ONE_MIN_BY_MILLI_SEC);
             
        }
        
        if (actualTime > ACTUAL_WORK_TIME_OVERTIME_OCCUR_MIN) {
            
            salay = (MINUTES_WAGE * ACTUAL_WORK_TIME_OVERTIME_OCCUR_MIN) 
                    + (int)(MINUTES_WAGE * OVER_TIME_WORK_FARE_LATE * (actualTime - ACTUAL_WORK_TIME_OVERTIME_OCCUR_MIN));


        }else{

            salay = MINUTES_WAGE * actualTime;
        }
            
        System.out.println("本日の給与は" + salay + "円です。");
    }

}
