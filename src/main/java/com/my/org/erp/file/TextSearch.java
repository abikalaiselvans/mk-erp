package com.my.org.erp.file;

import java.io.File;  
import java.io.FileNotFoundException;  
import java.util.Scanner;  
import java.util.regex.Matcher;  
import java.util.regex.Pattern;  
import java.util.ArrayList;  
import java.io.IOException;  
public class TextSearch
{  
    public ArrayList<Integer> searchString(String fileName, String phrase) throws IOException
    {  
      Scanner fileScanner = new Scanner(new File(fileName));  
    
      int lineID = 0;  
      ArrayList<Integer> lineNumbers = new ArrayList<Integer>();  
      Pattern pattern =  Pattern.compile(phrase);//,Pattern.CASE_INSENSITIVE);  
      Matcher matcher = null;  
      while(fileScanner.hasNextLine())
      {  
            String line = fileScanner.nextLine();  
            System.out.println(line);
            lineID++;  
            matcher = pattern.matcher(line);  
            if(matcher.find())
            {  
                lineNumbers.add(lineID);  
                System.out.println("True...................");
            }  
            
        }  
        return lineNumbers;  
    }  
}  

  