package com.my.org.erp.pdf1;

 
import java.io.FileOutputStream;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.pdf.PdfWriter;

public class Updated {

  public static void main(String[] args) throws Exception {
    Document.compress = false;
    Document document = new Document();
    PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/2.pdf"));
    document.open();
    document.add(new Paragraph("Hello World"));
    document.close();

 
    PdfReader reader = new PdfReader("C:/kalaipdf/2.pdf");
    PdfStamper stamper = new PdfStamper(reader, new FileOutputStream("C:/kalaipdf/updated.pdf"), '\0', true);
    PdfContentByte cb = stamper.getOverContent(1);
    cb.beginText();
    cb.endText();
    stamper.close();

  }
}