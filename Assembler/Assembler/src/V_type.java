import java.util.HashMap;
import java.util.Map;

public class V_type {
    private static Map <String,String> order = new HashMap<>();

    private static void addOrder() { // Specify machine code commands (Opcode)
        order.put("bnq", "111");
        order.put("lw", "001");
        order.put("sw", "010");
        order.put("andi", "100");
        order.put("ori", "101");
    }

    public static String callOrder(String name) {
        addOrder();
        return order.get(name);
    }
}
