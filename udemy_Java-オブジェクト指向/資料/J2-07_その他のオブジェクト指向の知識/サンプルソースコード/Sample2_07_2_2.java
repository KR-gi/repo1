class Sample2_07_2_2 {
	public static void main (String[] args) {
		
		try{
			int x = Integer.parseInt(args[0]) ;            //コマンドライン引数1が数字でない→�B
			int y = Integer.parseInt(args[1]) ;            //コマンドライン引数が1つ→�A、コマンドライン引数2が数字でない→�B
			
			System.out.println( x / y ) ;                  //コマンドライン引数2が0→�@
			
		}catch(ArithmeticException e){                      //�@ゼロ割が発生した場合の対処
			System.out.println("[ゼロ割]" + e + "が発生しました") ;
		}catch(ArrayIndexOutOfBoundsException e){           //�A存在しない配列のインデックスが指定された場合の対処
			System.out.println("[インデックス範囲外指定]" + e + "が発生しました") ;
		}catch(NumberFormatException e){                    //�B数字の形式でない文字列が入力された場合の対処
			System.out.println("[入力値不正（数字でない）]" + e + "が発生しました") ;
		}
		
		System.out.println("最後まで処理しました") ;
	}
}

