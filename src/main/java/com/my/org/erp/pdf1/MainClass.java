package com.my.org.erp.pdf1;

import java.io.FileOutputStream;

import com.lowagie.text.Document;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfWriter;

public class MainClass {

  public static void main(String[] args) throws Exception {
    Document document = new Document(new Rectangle(792, 612));
    PdfWriter.getInstance(document, new FileOutputStream("c:/1.pdf"));
    document.open();
    document.add(new Paragraph("Hello World"));
    document.close();
  }
}
