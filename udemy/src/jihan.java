class jihan{
        public static void main(String[] args){
          
          
          

          int coinNum = args.length ;
          int coinChk = 0 ;
          int coinSum = 0 ;
          
          
          for (int i = 0 ; i < coinNum ; i++) {
             
              coinChk = Integer.parseInt(args[i]) ;
              
              if(coinChk == 10 || coinChk == 50 || coinChk ==100 || coinChk == 500) {
                  
                  coinSum += coinChk;
              }else if(coinChk == 1 || coinChk == 5) {
                  
                  System.out.println("警告 :" + coinChk+ "円玉は使えません");
              }else{
                  System.out.println("警告"+ coinChk +"は硬貨として適切な値ではありません");
              }
          }
      
          System.out.println("ただいまの投入金額は" + coinSum + "円です");    
         
          
        }
}