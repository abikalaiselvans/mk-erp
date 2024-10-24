package examples;

import java.util.Scanner;

public class YourNumberMyWord {
   static String result="";
    public void pw(long n,String ch) {
       
        String one[]={" "," one"," two"," three"," four"," five"," six"," seven"," eight"," Nine"," ten"," eleven"," twelve"," thirteen"," fourteen","fifteen"," sixteen"," seventeen"," eighteen"," nineteen"};  
        String ten[]={" "," "," twenty"," thirty"," forty"," fifty"," sixty","seventy"," eighty"," ninety"}; 
        if(n>19)
        { 
            result=result+ten[(int)(n/10)];
            //System.out.print(ten[(int)(n/10)]);
            result=result+" "+one[(int)n%10];
             //System.out.print(" "+one[(int)n%10]);
        }
        else {
            result=result+one[(int)n];
            //System.out.print(one[(int)n]);
        }  
        if(n>0)
            result=result+ch;
            //System.out.print(ch); 
    }
    
    public static void main(String[] args){
        while(true){
            result="";
        long n=0;
        Scanner scanf = new Scanner(System.in);
        System.out.println("Enter an integer number: ");
        //n = scanf.nextInt();
        n=scanf.nextLong();
        if(n<=0){
            System.out.println("Enter numbers greater than 0"); 
        }
        else{
            YourNumberMyWord a = new YourNumberMyWord();
            Long number=(Long)n;
            if(n>=10000000){
       
                long val=Long.parseLong(number.toString().substring(0,number.toString().length()-7));
                int rema=Integer.parseInt(number.toString().substring(number.toString().length()-7,number.toString().length() ));
                a.pw(((val/100000)%100)," lakh");
                a.pw(((val/1000)%100)," thousand");
                a.pw(((val/100)%10)," hundred");
                a.pw((val%100)," ");
                result=result+"crore";
                //System.out.print("crore");
                a.pw(((n/100000)%100)," lakh");
                a.pw(((n/1000)%100)," thousand");
                a.pw(((n/100)%10)," hundred");
                a.pw((n%100)," ");
                result.trim();
                System.out.println(result);
                
            }
            else{
            a.pw(((n/100000)%100)," lakh");
            a.pw(((n/1000)%100)," thousand");
            a.pw(((n/100)%10)," hundred");
            a.pw((n%100)," ");
                result.trim();
                System.out.println(result);
        }}
        }
    }
}
