
public class Ex_2_03_1_Referee {
    
    final String Hand_G= "グー";
    final String Hand_C = "チョキ";
    final String Hand_P = "パー";
    
    private String name ;
    
    Ex_2_03_1_Referee(String nm){
        this.name = nm;
    }
    
    void startJanken() {
        messageReferee("じゃんけん・・・ぽん！！！！！");
    }
    
    
    void checkHand (Ex_2_03_1_Player p) {
        
        if ((p.getHandStatus()).equals(Hand_G)) {
            messageReferee(p.getName() + "さんの手はグーでした！");
        }else if ((p.getHandStatus()).equals(Hand_C)) {
            messageReferee(p.getName() + "さんの手はチョキでした！");
        }else if ((p.getHandStatus()).equals(Hand_P)) {
            messageReferee(p.getName() + "さんの手はパーでした！");
        } else {
            System.out.println("[ERROR]ジャンケンの判定が不正です。");
        }
    }
    
    void judgeJanken(Ex_2_03_1_Player pl1,Ex_2_03_1_Player pl2) {
        
        messageReferee("結果は・・・");
        
        if((pl1.getHandStatus()).equals(pl2.getHandStatus())) {
            
            messageReferee("あいこ！勝負つかず！");
            
        } else if ( (pl1.getHandStatus().equals(Hand_G) && pl2.getHandStatus().equals(Hand_C))
                || (pl1.getHandStatus().equals(Hand_C) && pl2.getHandStatus().equals(Hand_P))
                || (pl1.getHandStatus().equals(Hand_P) && pl2.getHandStatus().equals(Hand_G)) ){
                    
           System.out.println(pl1.getName() + "さんの勝利！");
          
         }else if ( (pl2.getHandStatus().equals(Hand_G) && pl1.getHandStatus().equals(Hand_C))
                 || (pl2.getHandStatus().equals(Hand_C) && pl1.getHandStatus().equals(Hand_P))
                 || (pl2.getHandStatus().equals(Hand_P) && pl1.getHandStatus().equals(Hand_G)) ){
                     
            System.out.println(pl2.getName() + "さんの勝利！");
            
         }else {
             
             System.out.println("[ERROR]ジャンケンの判定が不正です。");
         }
    }
    
    void messageReferee(String msg) {
        System.out.println(this.name + "「"+ msg + "」");
    }
}
