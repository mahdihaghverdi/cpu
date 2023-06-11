public class Instruction {
    private static String machineCode = "";

    private static int main(String instruct) {
        instruct = "add $t1, $t2, $a1";
        instruct = instruct.trim();
        String[] type = instruct.split(" ", 2); // Command Type Separation
        String typeValidation = R_type.callOrder(type[0]); // To help with validation

        if (!type.equals(null)) { // R-type
            String[] register = type[1].split(", ");
            machineCode += "000" +
                    R_type.callOrder(type[1]) + // rs
                    R_type.callOrder(type[2]) + // rt
                    R_type.callOrder(type[0]) + // rd
                    "00000000000000" + // Don't Care
                    type;

        } else { // V-type
            machineCode += V_type.callOrder(instruct.substring(0, 3));
        }
        return 0;
    }
}
