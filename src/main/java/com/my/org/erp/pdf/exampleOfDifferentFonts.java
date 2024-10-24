package com.my.org.erp.pdf;
import java.io.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
public class exampleOfDifferentFonts
    {
      public static void main(String[] args) throws Exception{
             	Document document = new Document();
                  PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/differentfontspdf.pdf"));          
            document.open();           
            Paragraph p = new Paragraph();
            p.add(new Chunk("This text is in Times Roman. ", new Font(Font.TIMES_ROMAN, 12)));
            p.add(new Chunk("This is ZapfDingbats: ", new Font(Font.ZAPFDINGBATS, 12)));
            p.add(new Chunk(". This is font Symbol: ", new Font(Font.TIMES_ROMAN, 12)));
            p.add(new Chunk("This text is in Times Roman.", new Font(Font.SYMBOL, 12)));
            document.add(new Paragraph(p));          
            document.close();
       
    }
}
