
public class Ex_2_02_2_Referee {
    final String Hand_G= "グー";
    final String Hand_C = "チョキ";
    final String Hand_P = "パー";
    
    String name ;
    
    Ex_2_02_2_Referee(String nm){
        this.name = nm;
    }
    
    void startJanken() {
        messageReferee("じゃんけん・・・ぽん！！！！！");
    }
    
    
    void checkHand (Ex_2_02_2_Player p) {
        
        if ((p.handStatus).equals(Hand_G)) {
            messageReferee(p.name + "さんの手はグーでした！");
        }else if ((p.handStatus).equals(Hand_C)) {
            messageReferee(p.name + "さんの手はチョキでした！");
        }else if ((p.handStatus).equals(Hand_P)) {
            messageReferee(p.name + "さんの手はパーでした！");
        } else {
            System.out.println("[ERROR]ジャンケンの判定が不正です。");
        }
    }
    
    void judgeJanken(Ex_2_02_2_Player pl1,Ex_2_02_2_Player pl2) {
        
        messageReferee("結果は・・・");
        
        if((pl1.handStatus).equals(pl2.handStatus)) {
            
            messageReferee("あいこ！勝負つかず！");
            
        } else if ( (pl1.handStatus.equals(Hand_G) && pl2.handStatus.equals(Hand_C))
                || (pl1.handStatus.equals(Hand_C) && pl2.handStatus.equals(Hand_P))
                || (pl1.handStatus.equals(Hand_P) && pl2.handStatus.equals(Hand_G)) ){
                    
           System.out.println(pl1.name + "さんの勝利！");
          
         }else if ( (pl2.handStatus.equals(Hand_G) && pl1.handStatus.equals(Hand_C))
                 || (pl2.handStatus.equals(Hand_C) && pl1.handStatus.equals(Hand_P))
                 || (pl2.handStatus.equals(Hand_P) && pl1.handStatus.equals(Hand_G)) ){
                     
            System.out.println(pl2.name + "さんの勝利！");
            
         }else {
             
             System.out.println("[ERROR]ジャンケンの判定が不正です。");
         }
    }
    
    void messageReferee(String msg) {
        System.out.println(this.name + "「"+ msg + "」");
    }
}
