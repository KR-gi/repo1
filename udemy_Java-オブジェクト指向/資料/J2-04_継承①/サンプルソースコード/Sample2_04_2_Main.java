class Sample2_04_2_Main {
	public static void main (String[] args) {
		
		//シナリオ�@：車を場に登場させる（Sample2_01_1_carクラスのインスタンス化）
		Sample2_04_2_Moco moco = new Sample2_04_2_Moco();
		
		
		//シナリオ�A：「Sample2_04_2_Dog」クラスのメソッド（printAllInfo、executeAllAction）の実行
		System.out.println("▼シナリオ�A：「Sample2_04_2_Moco」クラスのメンバの使用-----------------") ;
		moco.printAllInfo() ;
		moco.executeAllAction() ;
		
		
	}
}
