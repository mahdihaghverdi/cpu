import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class Instruction {
    private static String machineCode;
    private static Map<String, String> lable = new HashMap<>();

    public static String main(String instructs) {
        instructs = lable(instructs);
        String result = "";
        Scanner scanner = new Scanner(instructs);
        while (scanner.hasNextLine()) {
            result += instruct(scanner.nextLine()) + "\n";
        }

        return result;
    }
    private static String instruct(String instruct) {
        machineCode = "";
        instruct = instruct.trim();
        String[] type = instruct.split(" ", 2); // Command Type Separation
        String typeValidation = R_type.callOrder(type[0]); // To help with validation

        if (typeValidation != null) { // R-type
            String[] register = type[1].split(", ");
            machineCode += "000" + // OpCode
                    RegisterFile.callRegister(register[1]) + // rs
                    RegisterFile.callRegister(register[2]) + // rt
                    RegisterFile.callRegister(register[0]) + // rd
                    "00000000000000" + // Don't Care
                    typeValidation; // Function

        } else { // V-type
            machineCode += V_type.callOrder(type[0]);

            if (type[0].equals("lw") || type[0].equals("sw")) { // sw & lw commands
                String[] register = type[1].split(", ");
                machineCode += RegisterFile.callRegister(register[1].substring(register[1].indexOf('(') + 1, register[1].indexOf(')'))) + // rs
                        RegisterFile.callRegister(register[0].substring(0, 3)) + // rt
                        DecimalToBinary.extend(register[1].substring(0, register[1].indexOf('('))); // immediate

            } else {
                String[] register = type[1].split(", ");
                if (type[0].equals("bnq")) { // bnq commands
                    machineCode += RegisterFile.callRegister(register[1]) + // rs
                            RegisterFile.callRegister(register[0]) + // rt bvcxzrewq    09821`
                            DecimalToBinary.extend(lable.get(register[2].trim())); // immediate

                } else { // other commands
                    machineCode += RegisterFile.callRegister(register[1]) + // rs
                            RegisterFile.callRegister(register[0]) + // rt
                            DecimalToBinary.extend(register[2]); // immediate

                }
            }
        }
        return machineCode;
    }

    private static String lable(String instructs) {
        Scanner scanner = new Scanner(instructs);
        String instruct = "";
        int count = 0;

        while (scanner.hasNextLine()) {
            String place = scanner.nextLine();

            if (place.indexOf(':') != -1) {
                lable.put(place.substring(0, place.indexOf(':')).trim(), Integer.toString(count)); // lables
                instruct += place.substring(place.indexOf(':') + 1) + "\n";
            } else {
                instruct += place + "\n";
            }

            count++;
        }

        return instruct;
    }
}
