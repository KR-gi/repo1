class Sample2_05_3_Main {
	public static void main (String[] args) {
		
		//シナリオ�@：インスタンス化（Sample2_05_3_ToyPoodleクラス、Sample2_05_3_GoldenRetrieverクラス）
		Sample2_05_3_ToyPoodle       moco  = new Sample2_05_3_ToyPoodle("MOCO" , "かわいくストレッチ" );
		Sample2_05_3_GoldenRetriever pochi = new Sample2_05_3_GoldenRetriever("POCHI" , "大食い");
		
		
		//シナリオ�A：toStringメソッドの動作確認（Sample2_05_3_ToyPoodleクラス）
		System.out.println("▼シナリオ�A：toStringメソッドの動作確認（Sample2_05_3_ToyPoodleクラス）-----------------") ;
		System.out.println( moco ) ;
		
		
		//シナリオ�B：toStringメソッドの動作確認（Sample2_05_3_GoldenRetrieverクラス）
		System.out.println() ;
		System.out.println("▼シナリオ�B：toStringメソッドの動作確認（Sample2_05_3_GoldenRetrieverクラス）-----------") ;
		System.out.println( pochi ) ;
		
	}
}

