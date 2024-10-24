
package com.my.org.erp.pdf;
import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfWriter;
public class exampleOFRendering 
          {
	public static void main(String[] args)throws Exception
              {
		System.out.println("Example of Rendering");

		
		Document document = new Document();
		PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/Rendering.pdf"));
			document.open();
			Paragraph p = new Paragraph("Rose Text Rendering:");
			document.add(p);
			Chunk chunk = new Chunk("Rendering Test");
			chunk.setTextRenderMode(PdfContentByte.TEXT_RENDER_MODE_FILL, 100f, new Color(0xc0, 0x00, 0x0f));
			document.add(chunk);
			document.add(Chunk.NEWLINE);
			chunk.setTextRenderMode(PdfContentByte.TEXT_RENDER_MODE_FILL_STROKE, 0.3f, new Color(0xFc, 0x00, 0x00));
			document.add(chunk);
			document.add(Chunk.NEWLINE);
			chunk.setTextRenderMode(PdfContentByte.TEXT_RENDER_MODE_INVISIBLE, 100f, new Color(0x0c, 0xF0, 0x00));
			document.add(chunk);
			document.add(Chunk.NEWLINE);
			chunk.setTextRenderMode(PdfContentByte.TEXT_RENDER_MODE_FILL_STROKE, 0.3f, new Color(0x0c, 0x00, 0xF0));
			document.add(chunk);
			document.add(Chunk.NEWLINE);
			Chunk bold = new Chunk("This looks like STROKE for Bold look");
			bold.setTextRenderMode(PdfContentByte.TEXT_RENDER_MODE_FILL_STROKE, 0.5f, new Color(0x0c, 0x00, 0x00));
		        document.add(bold);
		        document.close();
	}
}