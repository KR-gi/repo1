
public class Ex_2_02_2_Janken {

    public static void main(String[] args) {
        
        final String Hand_G= "グー";
        final String Hand_C = "チョキ";
        final String Hand_P = "パー";
        
        
        String nameP1 = args[0];
        String nameP2 = args[1];
        String nameref = args[2];
        
        Ex_2_02_2_Player pl1 = new Ex_2_02_2_Player(nameP1);
        Ex_2_02_2_Player pl2 = new Ex_2_02_2_Player(nameP2);
        Ex_2_02_2_Referee ref = new Ex_2_02_2_Referee(nameref);
        
        ref.startJanken();
        
        pl1.makeHandStatus();
        pl2.makeHandStatus();
        
        ref.checkHand(pl1);
        ref.checkHand(pl2);
        
        
        ref.judgeJanken(pl1, pl2);
        
        
        
        
    }

}
