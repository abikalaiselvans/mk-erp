package com.my.org.erp.pdf;
import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;
public class ParagraphAttributes 
                  {
		public static void main(String[] args)throws Exception 
                  {
		        System.out.println("The Paragraph object");
                        Document document = new Document();
		        PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/ParagraphAttributes.pdf"));
			document.open();
			Paragraph[] p = new Paragraph[5];
                        p[0] = new Paragraph("RoseIndia.net");
                        p[1] = new Paragraph("RoseIndia.net");
                        p[2] = new Paragraph("RoseIndia.net");
                        p[3] = new Paragraph("RoseIndia.net");
                        p[4] = new Paragraph("RoseIndia.net");
            
            for (int i = 0; i < 5; i++)
              {
            	p[i].setAlignment(Element.ALIGN_JUSTIFIED);
            	document.add(p[i]);
              }
                document.close();
	}
}