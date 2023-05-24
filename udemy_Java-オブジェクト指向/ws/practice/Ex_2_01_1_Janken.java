
public class Ex_2_01_1_Janken {

    public static void main(String[] args) {
        
        final String Hand_G= "グー";
        final String Hand_C = "チョキ";
        final String Hand_P = "パー";
        
        
        String nameP1 = args[0];
        String nameP2 = args[1];
        
        Ex_2_01_1_Player pl1 = new Ex_2_01_1_Player(nameP1);
        Ex_2_01_1_Player pl2 = new Ex_2_01_1_Player(nameP2);
        
        System.out.println("じゃんけん・・・ぽん！！！！！");
        
        pl1.makeHandStatus();
        pl2.makeHandStatus();
        
        System.out.println(pl1.name + "さんの手 : " + pl1.handStatus);
        System.out.println(pl2.name + "さんの手 : " + pl2.handStatus);
        
        System.out.println("結果は・・・");
        
        if((pl1.handStatus).equals(pl2.handStatus)) {
            
            System.out.println("あいこ！勝負つかず！");
            
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

}
