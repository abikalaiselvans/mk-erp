package com.my.org.erp.Math;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;

import org.apache.commons.lang.NullArgumentException;



public class MathFunction   
{	
	
	//Round up to digit character
	public static double Round (double value) 
	{
		int num=2;
		double pow=Math.pow(10,num);
        double tmp=value*pow;
        int itmp=(int)tmp;
        tmp=itmp;
       tmp/=pow;
        return tmp;
    }
	
	
	//Round up to digit character
	public static String keep2Digit(double num) 
	{
		return ""+BigDecimal.valueOf( Math.round(num*100.0)/100.0).toPlainString();
    }

	public  static double  roundTwoDecimals(double d) 
	{ 
	      DecimalFormat twoDForm = new DecimalFormat("#.##"); 
	      return Double.valueOf(twoDForm.format(d));
	}  
	
	public static BigDecimal truncateDecimal(double x,int numberofDecimals)
	{
	    if ( x > 0) {
	        return new BigDecimal(String.valueOf(x)).setScale(numberofDecimals, BigDecimal.ROUND_FLOOR);
	    } else {
	        return new BigDecimal(String.valueOf(x)).setScale(numberofDecimals, BigDecimal.ROUND_CEILING);
	    }
	}
	public static double keep2Digits(double num) 
	{
		return Math.round(num*100.0)/100.0;
    }

	
	
	public static float Round(float Rval, int Rpl) 
	{
		  float p = (float)Math.pow(10,Rpl);
		  Rval = Rval * p;
		  float tmp = Math.round(Rval);
		  return (float)tmp/p;
	}
	
	
	public static long digit6RandomNumber() 
	{
		long random;
		
		final long MAX = 999999,MIN = 100000;
		random = (long)(Math.floor(Math.random() * (MAX - MIN + 1)) + MIN);
		return random;
	}
	
	
	@SuppressWarnings("deprecation")
	public static String randomstring(int lo, int hi)
    {
            int n = rand(lo, hi);
            byte b[] = new byte[n];
            for (int i = 0; i < n; i++)
                    b[i] = (byte)rand('a', 'z');
            return new String(b, 0);
    }

	
    private static int rand(int lo, int hi)
    {
            java.util.Random rn = new java.util.Random();
            int n = hi - lo + 1;
            int i = rn.nextInt() % n;
            if (i < 0)
                    i = -i;
            return lo + i;
    }

    public static String randomstring()
    {
            return randomstring(5, 25);
    }
    
	public static boolean ArrayEquals(String a[] , String b[]) 
	{
		boolean flag = false;
		try 
		{
			String s="";
			if(a.length == b.length)
			{	
				for(int u=0;u<a.length;u++)
				{
					if(a[u].equals(b[u]))
						s = s+"true"+",";
					else
						s = s+"false"+",";
				}
				if(s.indexOf("false") <0)
					flag =true;
				else
					flag = false;
			}
			else
				//System.out.println("Invalid Array Size...");
			return flag;
		} 
		catch (Exception e)
		{
			
		}
		 
		return flag;
	}

	
	
	//Remove Array Duplicate values String arguments in format of string  asdd,asd,ads,asd,dasdasd 
	public static String  ArrayDuplicate(String string) 
	{
		
		try 
		{
			String s = string;
			String array1[] = s.split(",");
			String array2[] = s.split(",");
			int arraylength = array1.length-1;
			int count=0;
			for(int u=0; u<arraylength; u++)
			{
				count=0;
				for(int v=0; v<arraylength; v++)
				{
					if(array2[u] == array1[v])
						count = count +1;
					if(count > 1)
						array1[v]="";
				}
			}
			String  hs2="";
			for(int v=0; v<arraylength; v++)
				if(array1[v]!="")
					hs2 = hs2 +	array1[v]+",";
			return hs2;
		} 
		catch (Exception e)
		{
			
		}
		return "";
	}

	
	public static String displayWord(String number) 
	{
		String stringValue = "";
		try 
		{
			int num; 
		    int nextdigit; 
		    int numdigits; 
		    int[] n = new int[20]; 
		    String [] digits = { "zero", "one", "two","three", "four", "five", "six", "seven", "eight","nine" }; 
		    num = Integer.parseInt(number); 
		    nextdigit = 0; 
		    numdigits = 0; 
		    do 
		    { 
		      nextdigit = num % 10; 
		      n[numdigits] = nextdigit; 
		      numdigits++; 
		      num = num / 10; 
		    } while(num > 0); 
		    numdigits--; 
		    for( ; numdigits >= 0; numdigits--) 
		    	stringValue=stringValue+(digits[n[numdigits]] + "  ");
		 return stringValue;
		}
		catch (Exception e) 
		{
			
		}
		return stringValue;
	}
	
	 
	
	public static  void fileCopy(File src, File dst) throws IOException 
	{
        InputStream in = new FileInputStream(src);
        OutputStream out = new FileOutputStream(dst);
        byte[] buf = new byte[1024];
        int len;
        while ((len = in.read(buf)) > 0) 
        {
            out.write(buf, 0, len);
        }
        in.close();
        out.close();
    }

	
	public static byte[] getBytesFromFile(File file) throws IOException 
	{
        InputStream is = new FileInputStream(file);
        long length = file.length();
        byte[] bytes = new byte[(int)length];
        int offset = 0;
        int numRead = 0;
        while (offset < bytes.length
               && (numRead=is.read(bytes, offset, bytes.length-offset)) >= 0) {
            offset += numRead;
        }
        if (offset < bytes.length) 
        {
            throw new IOException("Could not completely read file "+file.getName());
        }
        is.close();
        return bytes;
    }

   
	public static String numberWord(String num) 
	{
 		String tmp = "";
		try 
		{
			 
			String beforeadd="";
			for(int i=0;i<(10-num.length());i++)
				beforeadd=beforeadd+"0";
			num = beforeadd+num;
			int crore = Integer.parseInt(num.substring(0,3));
			int lakh = Integer.parseInt(num.substring(3,5));
			int thousand = Integer.parseInt(num.substring(5,7));
			int base = Integer.parseInt(num.substring(7,10));
			String s="Rupees. ";
			if(crore >=1)
			  s = s+numberWords(crore)+" Crore "; 
			if(lakh >=1)
			  s = s+numberWords(lakh)+" Lakhs "; 
			if(thousand >=1)
			  s = s+numberWords(thousand)+" Thousands "; 
			if(base >=1)
			  s = s+numberWords(base) ;
			s= s+" Only";  
			s = "( "+s+ ")";   
			tmp = s;
			return tmp;
 		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
				
		}
		return tmp;
	}
		
	 	
	public static String numberWords(int num) 
	{
 		String tmp = "";
		try 
		{
			String numArray[] =  {"","One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten"};
			String tensArray[] = {"","Ten","Twenty","Thirty","Forty","Fifty","Sixty","Seventy","Eighty","Ninety"};
			String teensArray[] = {"Ten","Eleven","Twelve","Thirteen","Fourteen","Fifteen","Sixteen","Seventeen","Eighteen","Nineteen"};
			int hundreds = num/100;
			int tens = (num-(hundreds * 100))/10;
			int ones = num - ((hundreds*100) + (tens*10));
			if (num==0) return "zero";
			else if (hundreds >= 1)
			{
				if(tens == 1)
				{
					tmp = numArray[hundreds] + " Hundred " + teensArray[ones];
				}
		    	else tmp = numArray[hundreds] + " Hundred " + tensArray[tens] +' '+ numArray[ones];
			}
			else if (tens >= 1) 
			{
				if(tens == 1)
				{
					tmp = teensArray[ones];
				}
				else tmp = tensArray[tens] +' '+ numArray[ones];
			}
			else tmp = numArray[ones];
			return tmp;
 		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		return tmp;
	}
	
	
	
	public static boolean isIntNumber(String num)
	{    
		try
		{        
			Integer.parseInt(num);    
		} 
		catch(NumberFormatException nfe) 
		{        
			return false;    
		}    
			
		return true;
	}
	
	public static boolean isDoubleNumber(String num)
	{    
		try
		{        
			Double.parseDouble(num);
			 
		} 
		catch(NullArgumentException  nfe) 
		{        
			return false;    
		}
		catch(NullPointerException  nfe) 
		{        
			return false;    
		}
		catch(NumberFormatException nfe) 
		{        
			return false;    
		}    
		catch(Exception nfe) 
		{        
			return false;    
		} 	
		return true;
	}
	
	public static boolean isNumb(String str)
	{
		String s=str;
		for (int i = 0; i < s.length(); i++) 
		{
				//	If we find a non-digit character we return false.
			if (!Character.isDigit(s.charAt(i)) )
				return false;
		}
		return true;
	}


	
	
	public static boolean validatePhone( String phone )
	   {
	      return phone.matches( "[1-9]\\d{2}-[1-9]\\d{2}-\\d{4}" );
	   } 
	
	
	// validate address
	   public static boolean validateAddress( String address )
	   {
	      return address.matches( 
	         "\\d+\\s+([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)" );
	   } // end method validateAddress

	
	
	
	
	   public static String YourNumberMyWord( int  n )
	   {
		   String words="";
		   try
		   {
			   
			    
			   if(n<=0) 
				   words = "Zero "; 
			   else 
			   { 
				    
				   words = words + pw((n/1000000000)," Hundred"); 
				   words = words + pw((n/10000000)%100," crore"); 
				   words = words + pw(((n/100000)%100)," lakh"); 
				   words = words + pw(((n/1000)%100)," thousand"); 
				   words = words + pw(((n/100)%10)," hundred"); 
				   words = words + pw((n%100)," "); 
				} 
				   
			   return words;
		   }
		   catch(Exception e)
		   {
			   System.out.println(e.getMessage());
		   }
		   return words;
		   
	   } 
	   
	   
	   
	   public static String pw(int n,String ch) 
	   { 
		   String words="";
		   try
		   {
			   String one[]={" "," one"," two"," three"," four"," five"," six"," seven"," eight"," Nine"," ten"," eleven"," twelve"," thirteen"," fourteen","fifteen"," sixteen"," seventeen"," eighteen"," nineteen"};   
			   String ten[]={" "," "," twenty"," thirty"," forty"," fifty"," sixty","seventy"," eighty"," ninety"};   
			   if(n>19) 
			   { 
				   words = ten[n/10]+" "+one[n%10];
			   } 
			   else 
			   { 
				   words = one[n];
			   } 
			   if(n>0)
				   words = ch; 
			   return words;
		   }
		   catch(Exception e)
		   {
			   System.out.println(e.getMessage());
		   }
		   return words;
		   
		   
		} 
	   

	   public static String pw(long n,String ch)
	   {
		   String result="";	
		   try 
	       {
				String one[]={" "," one"," two"," three"," four"," five"," six"," seven"," eight"," Nine"," ten"," eleven"," twelve"," thirteen"," fourteen","fifteen"," sixteen"," seventeen"," eighteen"," nineteen"};  
				String ten[]={" "," "," twenty"," thirty"," forty"," fifty"," sixty","seventy"," eighty"," ninety"}; 
				if(n>19)
				{ 
				    result=result+ten[(int)(n/10)];
				    result=result+" "+one[(int)n%10];
				}
				else
				{
				    result=result+one[(int)n];
				}  
				if(n>0)
				    result=result+ch;
				return result;
			} 
	       	catch (Exception e) 
	       	{
				e.printStackTrace();
			}
			return null;
	    }

	   
	   
	   /*
	    * 
	    * 
	    
	    	long n=0;
        	Scanner scanf = new Scanner(System.in);
        	System.out.println("Enter an integer number: ");
    
       		n=scanf.nextLong();
          	String ob= Converter(n);
          	System.out.println(ob);


	    * 
	    */
	   public static String Converter(long n)
	   {
	         String result=""; 
	         try 
	         {
				if(n<=0)
					return "Enter numbers greater than 0";
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
	         catch (NumberFormatException e) 
	         {
				e.printStackTrace();
			}
			return result;
	    }
	      
	
	
 }



	
	

