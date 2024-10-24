package com.my.org.erp.pdf;
import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfWriter;
public class VersionPDF {
    public static void main(String[] args)throws Exception {
            System.out.println("Example of a Find version of iText");        
            Rectangle pageSize = new Rectangle(288, 720);
            Document document = new Document(pageSize, 36, 18, 72, 72);        
            PdfWriter writer=PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/VersionPDF.pdf"));
            document.open();
            document.add(new Paragraph("Version Of iText-->>Rose India"));
            document.add(new Paragraph("This page was made using " + Document.getVersion()));     
            document.add(new Paragraph("-->>RoseIndai.net"));      
            document.close();
    }
}