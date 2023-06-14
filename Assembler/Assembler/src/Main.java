import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String order = "";
        while (scanner.hasNextLine()) {
            String line = scanner.nextLine();
            if (!line.equals("end"))
                order += line + "\n";
            else
                break;
        }
        System.out.print(Instruction.main(order));
    }
}
//ori $t1, $t2, 15
//bnq $a1, $t2, Hossein
//ori $t1, $t2, 15
//Hossein: ori $t1, $t2, 15