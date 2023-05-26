package sub;

import java.util.ArrayList;
import java.util.List;

public class Sample2_Z2_1sub {
    public void executeFizzBuzz(int endNum) {

        for(int i = 1 ; i <= endNum ; i++){


            if ( i % 3 == 0 && i % 5 == 0 ){

                System.out.println("Fizz Buzz");

            }else if( i % 3 == 0 ){

                System.out.println("Fizz");

            }else if ( i % 5 == 0 ){

                System.out.println("Buzz");

            }else{

                System.out.println(i);

            }
        }

        List<String> xxx = new ArrayList<String>();

    }
}
