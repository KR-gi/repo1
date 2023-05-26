package churimon;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class Monster01 {
    
    
    String character = "(unknown)";
    String trainer     = "(wild)";
    String name       = "(noname)";
    
    int lv     = 1;
    int hp    = 80;
    int atk   = 15;
    int def   = 10;
    int spd  = 10;
    int hpMax = 80;
    
    String wazaNm = "たいあたり";
    String wazaDmgRate = "1.0";
    
    final String WAZA_DMG_RATE_REGEXP = "^[0-9]+\\.[0-9]$"  ;  //バリデーションチェックで使用する正規表現
    final String DMG_CORRECTION_120 = "120" ;                     //ダメージ計算の補正で使う数字
    final String DMG_CORRECTION_1   = "1"   ;                     //ダメージ計算の補正で使う数字

    
    public String toString() {
        String status = "[ " +  name  + " lv" + lv  + " HP" + hp + "/" + hpMax
                + " ] (status) character:" + character + " trainer:" + trainer
                + " atk:" + atk + " def:" + def + " spd:" + spd + " wazaNm:"
                + wazaNm + " wazaDmgRate:" + wazaDmgRate ;
        return status;
    }
    
    void levelUp(int up) {
        lv = lv + 1*up;
        hpMax = hpMax + 30 * up;
        atk = atk + 5 * up;
        def = def + 5 * up;
        spd = spd + 5 * up;
        hp = hpMax;
    }
    
    void setWaza(String nm,String dmr) {
        if(dmr.matches(WAZA_DMG_RATE_REGEXP)) {
            wazaNm = nm;
            wazaDmgRate = dmr;
        }else {
            System.out.println("[ERROR]わざの設定に失敗しました");
        }
    }
    
    String getStatus() {
        String status = "[ " +  name  + " lv" + lv  + " HP" + hp + "/" + hpMax + " ]";
        return status;
    }
    
    int useWaza() {
        BigDecimal bdAtk = new BigDecimal(atk);
        BigDecimal bdDmrt = new BigDecimal(wazaDmgRate);
        int dmg = (bdAtk.multiply(bdDmrt)).intValue();
        
        return dmg;
    }
    
    
    int damaged(int orgDm) {
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
    }


