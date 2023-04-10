public class cakesum {

    public static void main (String[] args) {
        
        String orderProduct = ""; //注文品
        int orderQuantity = 0; //注文数
        int productSum = 0; //商品の合計
        double totalAmount = 0;//合計金額
        
        int    checkCakeCount  = 0    ;
 
        for (int i = 0 ; i < args.length ; i += 2) {
            
          
      
            
            switch (args[i]) {
            case "ショートケーキ" :
                i++;                
                productSum += productSum + (Integer.parseInt(args[i]) * 320);
                
                break;
                
            case "モンブラン" :
                i++;
                productSum += productSum + (Integer.parseInt(args[i]) * 350);
                
                break;
                
            case "チョコレートケーキ" :
                i++;
                productSum += productSum + (Integer.parseInt(args[i]) * 370);
                
                break;
                
            case "いちごのタルト" :
                i++;
                productSum += productSum + (Integer.parseInt(args[i]) * 400);
                break;
                
            case "チーズケーキ" :
                i++;
                productSum += productSum + (Integer.parseInt(args[i]) * 300);
                
                break;
        }
        }      
        
        if (productSum > 1000) {
            double discountAmount = productSum*0.2;//割引額
            totalAmount = (productSum - discountAmount)*1.08;//合計金額
          
            System.out.println((int)totalAmount+ "円になります。");
          
        }else {
            totalAmount = productSum *1.08;
            System.out.println("合計金額は" +(int)totalAmount+ "円になります。");
        }
        //name1.equals(name2)
    }
}


//商品は以下の5種類とす
//- ショートケーキ ：320円
//- モンブラン ：350円
//- チョコレートケーキ：370円
//- いちごのタルト ：400円
//- チーズケーキ ：300円

//・「ケーキ名」「個数」を注文情報とし、これをコマンドライン引数として受け取って会計額の計算を行う。
//・特売期間のため、合計金額が1000円以上である場合は2割り引きとする。
//・消費税は8パーセントとし、小数点以下切り捨てで会計額を算出する。
