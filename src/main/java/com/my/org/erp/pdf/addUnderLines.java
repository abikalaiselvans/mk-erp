package com.my.org.erp.pdf;

import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;
public class addUnderLines
      {
	public static void main(String[] args) throws Exception 
             {
        	System.out.println("Underline, Strike through,...");
		Document document = new Document();
		PdfWriter.getInstance(document,	new FileOutputStream("C:/kalaipdf/underLinesPdf.pdf"));
			document.open();
			Chunk chunk = new Chunk("RoseIndia.net");
			chunk.setUnderline(0.2f, -2f);
			Paragraph paragraph = new Paragraph("The following chunk is ");
			paragraph.add(chunk);
			document.add(paragraph);
			Chunk chunk1 = new Chunk("roseindia.net");
			chunk1.setUnderline(0.5f, 3f);	
			document.add(chunk1);		
		        document.close();
	}
}