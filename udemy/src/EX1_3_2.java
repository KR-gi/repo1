import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

public class EX1_3_2 {

    public static void main(String[] args) {
        // TODO 自動生成されたメソッド・スタブ
        
        //  WorkingResult.csvのパス ※「C:\WorkSpace」直下に配置していない場合は適宜変更してください。
        final String WORKING_RESULT_FILE_PATH = "C:\\Users\\MIK02\\Documents\\git\\repo1\\udemy\\src\\WorkingResult.csv";
        // コンマ
        final String COMMA = ","; 
        
        
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
        
        
        List<String> workingResults = new ArrayList<String>(); //ファイルから読み込んだデータの格納用
        
        //  WorkingResult.csvを読み込む
        try {
            // WorkingResult.csvの読み込み準備
            File workingResultFile = new File(WORKING_RESULT_FILE_PATH);
            BufferedReader br = new BufferedReader(new FileReader(workingResultFile));
            
            // WorkingResult.csvを1行ずつ読み込んでArrayListに格納する
            String recode = br.readLine();
            while (recode != null) {
                workingResults.add(recode);
                recode = br.readLine();
            }
            br.close();
        } catch (IOException e) {
            System.out.println(e);
        }
         
        for (int i = 0; i < workingResults.size() ; i++) {
            
            String workingRecode    = workingResults.get(i);      // 1行ずつ文字列を取り出す
            String[] forSplitRecode = workingRecode.split(COMMA); // splitメソッドを用いてカンマ区切りで文字列を分解＆配列にそれぞれ格納
            
            Date workingDate = Date.valueOf(forSplitRecode[0]); // 出勤日
            Time startTime   = Time.valueOf(forSplitRecode[1]); // 出勤時間
            Time finishTime  = Time.valueOf(forSplitRecode[2]); // 退勤時間
            
            // getTimeメソッドを使って労働時間をミリ秒（0.001秒単位）で取得する
            long workingTime = finishTime.getTime() - startTime.getTime();
            int actualTime = 0; //実働時間 分
            int salay = 0; //給与
            int monthlySalay = 0; //月給
            
            // ミリ秒で取得した労働時間を○時間△分の形式に直す
            int workingHour = (int)( workingTime / ONE_HOUR_BY_MILLI_SEC );                      // 時間に換算
            int workingMin  = (int)( ( workingTime / ONE_MIN_BY_MILLI_SEC ) % ONE_HOUR_BY_MIN ); // 分に換算
        
            //ここから回す？
            
            
            
            //8時間超過
            if (workingTime > WORK_TIME_TYPE3_START) {             
             
             actualTime = (int)( (workingTime - EIGHT_TIME_WORKING_HOURS_OVER) / ONE_MIN_BY_MILLI_SEC);
             //6時間以上8時間未満                                         
            }else if (workingTime > WORK_TIME_TYPE2_START && workingTime >= WORK_TIME_TYPE2_END) {    
            
                actualTime = (int)((workingTime - EIGHT_TIME_WORKING_HOURS_UNDER) / ONE_MIN_BY_MILLI_SEC);
             
                //6時間未満     
            }else if (workingTime <= WORK_TIME_TYPE1_END){
            
                actualTime = (int)(workingTime / ONE_MIN_BY_MILLI_SEC);
             
            }
        
            if (actualTime > ACTUAL_WORK_TIME_OVERTIME_OCCUR_MIN) {
            
                salay = (MINUTES_WAGE * ACTUAL_WORK_TIME_OVERTIME_OCCUR_MIN) 
                    + (int)(MINUTES_WAGE * OVER_TIME_WORK_FARE_LATE * (actualTime - ACTUAL_WORK_TIME_OVERTIME_OCCUR_MIN));
                
                monthlySalay += salay;

            }else{

                salay = MINUTES_WAGE * actualTime;
                monthlySalay += salay;
            }
            
         }   
            
            System.out.println("今月の給与の合計は" + monthlySalay + "円です。");
         
    }
}
