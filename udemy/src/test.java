

public class test {

	public static void main (String[] args) {
		System.out.println("Progate の実機練習");
		
		//switch 文
		
		int age = 27 ;
		String firstName = "竜之介" ;
		String lastName = "鎌田";
		String birthPlace = "稚内市";
		String[] hobby = {"筋トレ","釣り","お酒",} ;
		
		System.out.println(hobby[2]);
		
		if (age > 27) {
			System.out.println("年取ったな");
			} else if (age >= 30) {
				System.out.println("三十路");
			} else {
				System.out.println("0 ～ 27 なら出力される");
		 }
		
		switch (age) {
			case 24 :
				System.out.println("お若いですね");
				break;
			case 27 :
				System.out.println("正しい");
				break;
			default :
				System.out.println("どれにも当てはまらない elese に似てる");
				break ;
		}
		
		//while 文
		int n = 1 ;
		
		while (n <= 5) {
			System.out.println(n + "回目");
			n ++;
		}
		
		while (n > 0) {
			System.out.println(n);
			n --;
		}
		
		//for 文
		// 変数の初期化 → 条件指定 → 繰り返し処理の指定 → 変数の更新
		for (int a = 1 ; a <= 5 ; a ++) {
			System.out.println(a);
		}
	
	}
}
