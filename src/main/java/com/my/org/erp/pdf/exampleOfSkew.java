package com.my.org.erp.pdf;
import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;
public class exampleOfSkew {
	public static void main(String[] args)throws Exception
                {
		System.out.println("Example of Skew");
		Document document = new Document();
			PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/Skew.pdf"));
			document.open();
			Paragraph p = new Paragraph("Rose India.net");
			document.add(p);
			Chunk chunk = new Chunk("Rose India.net");
			chunk.setSkew(46f, 0f);
			document.add(chunk);
			document.add(Chunk.NEWLINE);
			chunk.setSkew(0f, 46f);
			document.add(chunk);
			document.add(Chunk.NEWLINE);
			chunk.setSkew(-46f, 0f);
			document.add(chunk);
			document.add(Chunk.NEWLINE);
			chunk.setSkew(0f, -46f);
			document.add(chunk);
			document.add(Chunk.NEWLINE);
			chunk.setSkew(16f, 35f);
			document.add(chunk);
			document.add(Chunk.NEWLINE);
			Chunk italic = new Chunk("This looks like Font.ITALIC");
			italic.setSkew(0f, 15f);
			document.add(italic);			
		document.close();
	}
}