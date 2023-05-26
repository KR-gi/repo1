package churimon;

public class Hitokage1 extends Monster03 {
    
    Hitokage1(){
        super.setCharacter("ヒトカゲ");
    }
    
    Hitokage1(String tr,String nm){
        super(tr,nm);
        super.setCharacter("ヒトカゲ");
    }
    Hitokage1(String tr,String nm,int lev){
        super(tr,nm,lev);
        super.setCharacter("ヒトカゲ");
    }
    
    public void levelUp (int up) {
        setLv(getLv() + 1 * up);
        setHpMax
    }

}
