package com.my.org.erp.pdf;
import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;
public class changeBackgroundColor {
 public static void main(String[] args)throws Exception {
		System.out.println("Background color");
         	Document document = new Document();
		PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/cahngeBackgroundColor.pdf"));
			document.open();
			Chunk chunk =new Chunk("RoseIndia.net"); 
			chunk.setBackground(new Color(0xFF, 0xFF, 0x00));
			Paragraph paragraph = new Paragraph("The following chunk is ");
			paragraph.add(chunk);
			document.add(paragraph);
			Chunk chunk2,chunk3;
			chunk2 = new Chunk("RoseIndia.net");
			chunk2.setBackground(new Color(0xb0, 0xb0, 0xb0));
			document.add(chunk2);
			chunk3 = new Chunk("RoseIndia.net");
			chunk3.setTextRise(8);
			chunk3.setBackground(new Color(0xFF, 0xDE, 0xAD));
                        document.add(chunk3);			
	                document.add(paragraph);
		        document.close();
	}
}