import java.util.Optional;

public class Test {

    public static void main(String[] args) {
        
        String str = null;
//        System.out.println(str.length());
        
        Optional<String> strOpt= Optional.ofNullable(str);
        
        if(strOpt.isPresent()) {
                String message = strOpt.get();
                System.out.println(message.length());
        }
        
        strOpt.ifPresent(v -> System.out.println(v.length()));
    }

}
