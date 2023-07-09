import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("*** Wellcome to Program to convert assembly language to machine code ***\n" +
                        "Please enter the assembly instructions : \n" +
                        "(Note: At the end of the commands, enter the word 'end')");
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

/*
You can enter the following commands as an example
test :
    ori $t8, $t7, 15
    bnq $a1, $t3, Hossein
    ori $t5, $t2, 15
    add $t1, $t2, $a1
    Hossein: ori $l1, $t2, 15
    end
 */