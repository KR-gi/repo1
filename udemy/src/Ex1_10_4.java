/*-< 演習：Ex1_10_4 >---------------------------------
コメントに従って2次元配列からデータを抽出して画面に表示する
プログラムを作ってください。
----------------------------------------------------*/
package work ;
class Ex1_10_4 {
	public static void main (String[] args) {
		
		//出力元の2次元配列
		String[][] animals = {
		                       {"モコ" ,"トイプードル" ,"4歳" ,"メス"},
		                       {"ポチ" ,"シバイヌ　　" ,"6歳" ,"オス"},
		                       {"ムギ" ,"パピヨン　　" ,"2歳" ,"オス"},
		                       {"ブブ" ,"ブルドッグ　" ,"3歳" ,"メス"},
		                       {"シロ" ,"秋田犬　　　" ,"8歳" ,"オス"}
		                     };
		
		
		/*
		**以下の条件を満たす2次元配列のデータ抽出&表示する処理を書いてください。
		**  - for文を2つ組み合わせる
		**  - 「animals.length」「 animals[i].length」
		**  - 出力結果は以下になる
		**       モコ / トイプードル / 4歳 / メス
		**       ポチ / シバイヌ　　 / 6歳 / オス
		**       ムギ / パピヨン　　 / 2歳 / オス
		**       ブブ / ブルドッグ　 / 3歳 / メス
		**       シロ / 秋田犬　　　 / 8歳 / オス
		*/
		String display = ""; //出力データ格納用
		
		//for (i = 0 ; animals[i][].length < i ; i++) {
		for(int i = 0 ; i < animals.length ; i++) {	
			
			 display = "";
			
			for(int j = 0 ; j < animals[i].length ; j++) {
			//for (e = 0; animals[][e].length < e ; e++) {
			
				display = display + " / " + animals[i][j] ;
				//System.out.println(animals[i][j]);
			}
			
			System.out.println(display);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}
