package churimon;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class Monster03 {
    
    private String character;
    private String trainer ;
    private String name;
    private int lv;
    private int hp;
    private int atk;
    private int def;
    private int spd;
    private int hpMax;
    private String wazaNm;
    private String wazaDmgRate;
    
    final String WAZA_DMG_RATE_REGEXP = "^[0-9]+\\.[0-9]$"  ;  //バリデーションチェックで使用する正規表現
    final String DMG_CORRECTION_120 = "120" ;                     //ダメージ計算の補正で使う数字
    final String DMG_CORRECTION_1   = "1"   ;                     //ダメージ計算の補正で使う数字
    
    Monster03(){
        this.character = "(unknown)";
        this.trainer = "(wild)";
        this.name = "(noname)";
        this.lv = 1;
        this.hp = 80;
        this.atk = 15;
        this. def = 10;
        this.spd = 10;
        this.hpMax = 80;
        this.wazaNm = "たいあたり";
        this.wazaDmgRate = "1.0";
        
    }
    
    Monster03(String tr,String nm){
        this();
        this.trainer = tr;
        this.name = nm;
    }
    
    Monster03(String tr,String nm,int lev){
        this(tr,nm);
        if(lev > 1) {
            levelUp(lev - 1);
        }
    }
    
    public String toString() {
        String status = "[ " +  name  + " lv" + lv  + " HP" + hp + "/" + hpMax
                + " ] (status) character:" + character + " trainer:" + trainer
                + " atk:" + atk + " def:" + def + " spd:" + spd + " wazaNm:"
                + wazaNm + " wazaDmgRate:" + wazaDmgRate ;
        return status;
    }
    
    public void levelUp(int up) {
        lv = lv + 1 *up ;
        hpMax = hpMax + 30 * up;
        atk = atk + 5 * up;
        def = def + 5 * up ;
        spd = spd + 5 * up ;
        hp = hpMax;
    }
    
    public void setWaza(String nm,String dmr) {
        
        if(dmr.matches(WAZA_DMG_RATE_REGEXP)) {
            wazaNm = nm;
            wazaDmgRate = dmr;
        }else {
            System.out.println("[ERROR]技の設定に失敗しました");
        }
    }
    
    public String getStatus() {
        String status = "[ " +  name  + " lv" + lv  + " HP" + hp + "/" + hpMax + " ]";
        return status;
    }
    
    public int damaged(int orgDm) {
        BigDecimal bdOrgDm = new BigDecimal(orgDm);
        BigDecimal bdDmCr120 = new BigDecimal(DMG_CORRECTION_120);
        BigDecimal bdDmCr1 = new BigDecimal(DMG_CORRECTION_1);
        BigDecimal bdDef = new BigDecimal(def);
        
        BigDecimal dmRate = bdDmCr1.divide(bdDmCr1.add( bdDef.divide(bdDmCr120,2,RoundingMode.DOWN)),2,RoundingMode.DOWN);
        
        int dmg = (bdOrgDm.multiply(dmRate)).intValue();
        
        if(hp > dmg) {
            hp = hp -dmg ;
        }else {
            hp = 0;
        }
        return dmg;
        }

    public String getCharacter() {
        return character;
    }

    public void setCharacter(String character) {
        this.character = character;
    }

    public String getTrainer() {
        return trainer;
    }

    public void setTrainer(String trainer) {
        this.trainer = trainer;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getLv() {
        return lv;
    }

    public void setLv(int lv) {
        this.lv = lv;
    }

    public int getHp() {
        return hp;
    }

    public void setHp(int hp) {
        this.hp = hp;
    }

    public int getAtk() {
        return atk;
    }

    public void setAtk(int atk) {
        this.atk = atk;
    }

    public int getDef() {
        return def;
    }

    public void setDef(int def) {
        this.def = def;
    }

    public int getSpd() {
        return spd;
    }

    public void setSpd(int spd) {
        this.spd = spd;
    }

    public int getHpMax() {
        return hpMax;
    }

    public void setHpMax(int hpMax) {
        this.hpMax = hpMax;
    }

    public String getWazaNm() {
        return wazaNm;
    }

    public void setWazaNm(String wazaNm) {
        this.wazaNm = wazaNm;
    }

    public String getWazaDmgRate() {
        return wazaDmgRate;
    }

    public void setWazaDmgRate(String wazaDmgRate) {
        this.wazaDmgRate = wazaDmgRate;
    }
    
    
    }





