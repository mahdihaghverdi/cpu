import java.util.HashMap;
import java.util.Map;

public class R_type {
    private static Map <String,String> order = new HashMap<>();

    private static void addOrder() { // Specify machine code commands (Function)
        order.put("add", "001");
        order.put("sub", "010");
        order.put("mul", "011");
        order.put("and", "100");
        order.put("or", "101");
        order.put("nor", "110");
        order.put("nand", "111");
    }

    public static String callOrder(String name) {
        addOrder();
        return order.get(name);
    }
}
