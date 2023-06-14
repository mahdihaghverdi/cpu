public class DecimalToBinary {

    public static String computing(String result) { // Decimal to Binary
        int number = Integer.parseInt(result);
        result = "";

        while(number > 0) {
            result = (number % 2) + result;
            number /= 2;
        }

        return result;
    }

    public static String extend(String result) { // extend to 21 bit
        result = computing(result);
        int siza = result.length();
        for (int i = 0; i < 21 - siza; i++) {
            result = "0" + result;
        }

        return result;
    }
}
