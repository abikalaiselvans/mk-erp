package com.my.org.erp.pdf;
import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;
public class changeChunkColor {
	public static void main(String[] args) throws Exception
               {
		System.out.println("FontColor");
		Document document = new Document();
		PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/changeChunkColor.pdf"));
		document.open();
	       	Paragraph paragraph;
		paragraph = new Paragraph("Roses");
		paragraph.add(new Chunk("india", FontFactory.getFont(FontFactory.HELVETICA, Font.DEFAULTSIZE, Font.BOLD, new Color(0xFF, 0x00, 0x00)))); document.add(paragraph);
		paragraph = new Paragraph("India");
		paragraph.add(new Chunk(".net", FontFactory.getFont(FontFactory.HELVETICA, Font.DEFAULTSIZE, Font.ITALIC, new Color(0x00, 0x00, 0xFF))));
		document.add(paragraph);	
		document.close();
	}
}