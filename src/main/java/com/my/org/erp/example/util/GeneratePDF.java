package com.my.org.erp.example.util;
import java.io.File; 
import java.io.FileOutputStream; 
import java.io.OutputStream; 
import java.util.Date; 
import com.lowagie.text.Document; 
import com.lowagie.text.Paragraph; 
import com.lowagie.text.pdf.PdfWriter;   
public class GeneratePDF 
{       
	public static void main(String[] args) 
	{         
		try 
		{             
			System.out.println("Pdf start");
			OutputStream file = new FileOutputStream(new File("C:\\Test.pdf"));
			Document document = new Document();
			PdfWriter.getInstance(document, file);
			document.open();             
			document.add(new Paragraph("Hello Kiran and kalaiselvan K"));
			document.add(new Paragraph(new Date().toString())); 
			document.close(); 
			file.close();   
			System.out.println("Pdf end");
		
		} 
		catch (Exception e)
		{               
			 System.out.println(e.getMessage());
		}     
	} 
}