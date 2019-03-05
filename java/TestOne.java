package A;
import java.util.Scanner;

public class TestOne{
    public static void main(String[] args) {
        System.out.println("请输入十进制的数据（按Enter执行）：");
        Scanner input = new Scanner(System.in);
        int num = input.nextInt();
        System.out.println("此十进制的二进制数据为：");
        tenToTwo(num);
    }
    /**
     * 十进制转化为二进制
     */
    public static void tenToTwo(int data) {
        if(data==1||data==0) {
            System.out.print(data);
        }else {
            tenToTwo(data/2);
            System.out.print(data%2);
        }
    }
    
}