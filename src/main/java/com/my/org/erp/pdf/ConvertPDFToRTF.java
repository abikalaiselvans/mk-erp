package com.my.org.erp.pdf;

import java.io.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

public class ConvertPDFToRTF 
{
        public static void main(String[] args) throws IOException 
        {
	        try 
	        {
		        Document document = new Document();
		        document.open();
		        PdfReader reader = new PdfReader("C:/kalaipdf/employee.pdf");
		        PdfDictionary dictionary = reader.getPageN(1);
		        PRIndirectReference reference = (PRIndirectReference) dictionary.get(PdfName.CONTENTS);
		        PRStream stream = (PRStream) PdfReader.getPdfObject(reference);
		        byte[] bytes = PdfReader.getStreamBytes(stream);
		        PRTokeniser tokenizer = new PRTokeniser(bytes);
		        FileOutputStream fos=new FileOutputStream("C:/kalaipdf/employee.doc");
		        StringBuffer buffer = new StringBuffer();
		        while (tokenizer.nextToken()) 
		        {
		        	if (tokenizer.getTokenType() == PRTokeniser.TK_STRING) 
		        	{
		        		buffer.append(tokenizer.getStringValue());
		        	}
		         }
		        String test=buffer.toString();
		        StringReader stReader = new StringReader(test);
		        int t;
		        while((t=stReader.read())>0)
		        fos.write(t);
		        document.close();
		        System.out.println("Converted Successfully");
	    }
         catch (Exception e) 
         {
        	 System.out.println(e.getMessage());
         }
     }

        
         
}

