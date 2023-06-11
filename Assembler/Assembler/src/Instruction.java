public class Instruction {
    private static String machineCode = "";

    private static int main(String instruct) {
        instruct = instruct.trim();
        String type = R_type.callOrder(instruct.substring(0, 3));

        if (!type.equals(null)) { // R-type
            machineCode += "000" +
                    R_type.callOrder(instruct.substring(9, 12)) + // rs
                    R_type.callOrder(instruct.substring(14)) + // rt
                    R_type.callOrder(instruct.substring(4, 7)) + // rd
                    "00000000000000" + // Don't Care
                    type;

        } else { // V-type

        }
        return 0;
    }
}
