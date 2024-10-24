package examples;

import java.util.Scanner;

/**
 *
 * @author Administrator
 */
public class Counting {
    
 
    public static String pw(long n,String ch)
   {
       String result="";
        String one[]={" "," one"," two"," three"," four"," five"," six"," seven"," eight"," Nine"," ten"," eleven"," twelve"," thirteen"," fourteen","fifteen"," sixteen"," seventeen"," eighteen"," nineteen"};  
        String ten[]={" "," "," twenty"," thirty"," forty"," fifty"," sixty","seventy"," eighty"," ninety"}; 
        if(n>19)
        { 
            result=result+ten[(int)(n/10)];             result=result+" "+one[(int)n%10];

        }
        else
       {
            result=result+one[(int)n];
            
       }  
        if(n>0)
            result=result+ch;
           
        
        return result;
    }
    public static String Converter(long n)
    {
         String result=""; 
         if(n<=0)
        {
        	return "Enter numbers greater than 0";
            
        }
        else
        {
          
        	Long number=(Long)n;
                if(n>=10000000)
	{
       
                	long val=Long.parseLong(number.toString().substring(0,number.toString().length()-7));
                	int rema=Integer.parseInt(number.toString().substring(number.toString().length()-7,number.toString().length() ));
                	result=result+ pw(((val/100000)%100)," lakh");
                	result=result+pw(((val/1000)%100)," thousand");
                	result=result+pw(((val/100)%10)," hundred");
               		result=result+ pw((val%100)," ");
                	result=result+"crore ";
                
              		 result=result+ pw(((rema/100000)%100)," lakh");
                	 result=result+pw(((rema/1000)%100)," thousand");
              		 result=result+ pw(((rema/100)%10)," hundred");
               		 result=result+pw((rema%100)," ");
                	 result.trim();
                	 return result;
              }
              else
             {
            		result=result+pw(((n/100000)%100)," lakh");
            		result=result+pw(((n/1000)%100)," thousand");
           		result=result+(pw(((n/100)%10)," hundred"));
            		result=result+(pw((n%100)," "));
 
	                result.trim();
                	return result;
             }
      }
        
  }
  public static void main(String[] args)
  {
        while(true)
        {
          
        		long n=0;
        		Scanner scanf = new Scanner(System.in);
        		System.out.println("Enter an integer number: ");
    
       		 n=scanf.nextLong();
          		 String ob= Converter(n);
          		  System.out.println(ob);
        
      
        }
    }
}
