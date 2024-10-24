package com.my.org.erp.pdf;
import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfWriter;
public class Lines
 {
	public static void main(String[] args)throws Exception
               {
		System.out.println("Underline, Strike through,...");		
		Document document = new Document();			
		PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/Linespdf.pdf"));
			document.open();
         		Chunk underlined = new Chunk("Rose India-->>underlined");
			underlined.setUnderline(0.2f, -2f);
			Paragraph p = new Paragraph("The following chunk is ");
			p.add(underlined);
			document.add(p);
			Chunk strikethru = new Chunk("Rose India-->>Strike");
			strikethru.setUnderline(0.5f, 3f);	
			document.add(strikethru);
			document.add(Chunk.NEWLINE);
			document.add(Chunk.NEWLINE);
			document.add(Chunk.NEWLINE);
			Chunk c;
			c = new Chunk("rose India-->>Multiple lines");
			c.setUnderline(new Color(0xFF, 0x0f, 0x0f), 0.0f, 0.3f, 0.0f, 0.4f, PdfContentByte.LINE_CAP_ROUND);
			c.setUnderline(new Color(0x0f, 0xFF, 0x0f), 5.0f, 0.0f, 0.0f, -0.5f, PdfContentByte.LINE_CAP_PROJECTING_SQUARE);
               		c.setUnderline(new Color(0x00, 0x0f, 0xFF), 0.0f, 0.2f, 15.0f, 0.0f, PdfContentByte.LINE_CAP_BUTT);
			document.add(c);
			document.add(Chunk.NEWLINE);
			document.add(Chunk.NEWLINE);
			document.add(Chunk.NEWLINE);
			c = new Chunk("Multiple lines", FontFactory.getFont(FontFactory.HELVETICA, 24));
			c.setUnderline(new Color(0xFF, 0x0f, 0x00), 0.0f, 0.3f, 0.0f, 0.4f, PdfContentByte.LINE_CAP_ROUND);
			c.setUnderline(new Color(0x0f, 0xF0, 0x00), 5.0f, 0.0f, 0.0f, -0.5f, PdfContentByte.LINE_CAP_PROJECTING_SQUARE);
			c.setUnderline(new Color(0x0f, 0x0f, 0xFF), 0.0f, 0.2f, 15.0f, 0.0f, PdfContentByte.LINE_CAP_BUTT);
			document.add(c);
		        document.close();
	}
}