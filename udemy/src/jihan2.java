    public class jihan2{
        public static void main(String[] args){
          
          
          

          int coinNum = args.length ;
          int coinChk = 0 ;
          int coinSum = 0 ;
          int price = Integer.parseInt(args[args.length - 1]);
          int change = 0;
          
          for (int i = 0 ; i < coinNum ; i++) {
              coinChk =Integer.parseInt(args[i]);
              
              if(coinChk == 10 || coinChk == 50 || coinChk ==100 || coinChk == 500) {
                  
                  coinSum += coinChk;
              }else if(coinChk == 1 || coinChk == 5) {
                  
                  System.out.println("警告 :" + coinChk+ "円玉は使えません");
              }else{
                  System.out.println("警告"+ coinChk +"は硬貨として適切な値ではありません");
              }
          }
          
          change = coinSum - price ;
          
              if(change > 0 ){
                  System.out.println(change + "円のお釣りです。ありがとうございました。");
              }else if( change == 0 ){
                  System.out.println("ちょうどのお預かりです。ありがとうございました。");
              }else{
                  System.out.println("お金が足りないですね・・・"); 
              }
        }
     }