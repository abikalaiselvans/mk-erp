package com.my.org.erp.pdf1;

 

import java.io.FileOutputStream;

import com.lowagie.text.Document;
import com.lowagie.text.PageSize;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PRIndirectReference;
import com.lowagie.text.pdf.PRStream;
import com.lowagie.text.pdf.PRTokeniser;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfDictionary;
import com.lowagie.text.pdf.PdfName;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfTemplate;
import com.lowagie.text.pdf.PdfWriter;

public class PdfDictionarys {
  public static void main(String[] args) throws Exception {
    Document document = new Document(PageSize.A6);
    PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/1.pdf"));
    document.open();
    PdfContentByte cb = writer.getDirectContent();
    BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
    cb.beginText();
    cb.setFontAndSize(bf, 12);
    cb.moveText(88.66f, 367);
    cb.showText("ld");
    cb.endText();
    PdfTemplate tmp = cb.createTemplate(250, 25);
    tmp.beginText();
    tmp.setFontAndSize(bf, 12);
    tmp.moveText(0, 7);
    tmp.showText("Hello People");
    tmp.endText();
    cb.addTemplate(tmp, 36, 343);
    document.close();

    PdfReader reader = new PdfReader("C:/kalaipdf/2.pdf");
    PdfDictionary page = reader.getPageN(1);
    PRIndirectReference objectReference = (PRIndirectReference) page.get(PdfName.CONTENTS);
    PRStream stream = (PRStream) PdfReader.getPdfObject(objectReference);
    byte[] streamBytes = PdfReader.getStreamBytes(stream);
    PRTokeniser tokenizer = new PRTokeniser(streamBytes);
    while (tokenizer.nextToken()) {
      if (tokenizer.getTokenType() == PRTokeniser.TK_STRING) {
        System.out.println(tokenizer.getStringValue());
      }
    }
  }
}