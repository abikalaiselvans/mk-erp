package com.my.org.erp.pdf;
import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfWriter;
public class exampleOfEndOfLine {
	public static void main(String[] args)throws Exception {
		System.out.println("Example of End of Line");
		Document document = new Document();
		PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/EndOfLinepdf.pdf"));
                 	document.open();
			Chunk chunk = new Chunk("Rose India .Net-->Rose India .Net ");
			for (int i = 0; i < 5; i++) {
			chunk.setTextRenderMode(PdfContentByte.TEXT_RENDER_MODE_STROKE, 0.5f, new Color(i * 35, i * 30, i * 35));
				document.add(chunk);
			}
			document.newPage();
			Phrase p = new Phrase(16f);
			for (int i = 0; i < 5; i++) {
				chunk = new Chunk("Rose India .Net-->>Rose India .Net ");
				chunk.setTextRenderMode(PdfContentByte.TEXT_RENDER_MODE_STROKE, 0.5f, new Color(i * 35, i * 30, i * 35));
				p.add(chunk);
			}
			document.add(p);
			document.close();
	}
}