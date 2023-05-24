
public class Ex_2_02_2_Player {
    final String Hand_G= "グー";
    final String Hand_C = "チョキ";
    final String Hand_P = "パー";
    
    String name ;
    String handStatus;
    
    Ex_2_02_2_Player(String nm){
        this.name = nm;
    }
    
    
    void makeHandStatus() {
        int random1to3 = 1 + (int)(Math.random() * 3.0);
        
        switch(random1to3) {
        case 1 :
            this.handStatus = Hand_G;
            break;
            
        case 2 :
            this.handStatus = Hand_C;
            break;
        case 3 :
            this.handStatus = Hand_P;
            break;
            
        }
    }

}
