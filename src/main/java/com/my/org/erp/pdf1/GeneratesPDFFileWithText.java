package com.my.org.erp.pdf1;

import java.io.FileOutputStream;

import com.lowagie.text.Document;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;

public class GeneratesPDFFileWithText {

  public static void main(String[] args) throws Exception {
    Document document = new Document();
    PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/HelloWorld.pdf"));
    document.open();
    document.add(new Paragraph("Hello World"));
    document.close();
  }
}