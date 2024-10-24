package com.my.org.erp.pdf;
import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfWriter;
public class NewpageInsetingPDF {
     public static void main(String[] args)throws Exception {
           System.out.println("Example of a PDF File  to blank pages and new page");    
        Rectangle pageSize = new Rectangle(288, 720);
        Document document = new Document(pageSize, 36, 18, 72, 72);
             PdfWriter writer=PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/NewPagePDF.pdf"));
              document.open();
              document.add(new Paragraph("First Page-->>Rose India"));
            document.add(new Paragraph("Next Two blank Pages"));
            document.newPage();
             writer.setPageEmpty(false);
            document.newPage();
             writer.setPageEmpty(false);
            document.newPage();
            document.add(new Paragraph("Last Page with some data-->>RoseIndai.net"));                 document.close();
    }
}