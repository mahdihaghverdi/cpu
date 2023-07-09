import java.util.HashMap;
import java.util.Map;

public class RegisterFile {
    private static Map<String,String> register = new HashMap<>();

    private static void addRegister() {
        register.put("$zero", "0000");
        register.put("$at", "0001");
        register.put("$a1", "0010");
        register.put("$a2", "0011");
        register.put("$a3", "0100");
        register.put("$l1", "0101");
        register.put("$l2", "0110");
        register.put("$l3", "0111");
        register.put("$t1", "1000");
        register.put("$t2", "1001");
        register.put("$t3", "1010");
        register.put("$t4", "1011");
        register.put("$t5", "1100");
        register.put("$t6", "1101");
        register.put("$t7", "1110");
        register.put("$t8", "1111");
    }

    public static String callRegister(String name) {
        addRegister();
        return register.get(name);
    }
}
