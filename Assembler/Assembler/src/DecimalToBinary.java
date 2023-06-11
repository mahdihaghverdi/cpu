public class DecimalToBinary {

    public static String computing(String result) {
        int number = Integer.parseInt(result);
        result = "";

        while(number > 0) {
            result = (number % 2) + result;
            number /= 2;
        }

        return result;
    }
}
