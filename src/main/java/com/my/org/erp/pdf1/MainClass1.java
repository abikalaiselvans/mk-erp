package com.my.org.erp.pdf1;

import java.io.FileOutputStream;

import com.lowagie.text.Document;
import com.lowagie.text.PageSize;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.AcroFields;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.GrayColor;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.pdf.TextField;

public class MainClass1 {

  public static void main(String[] args) throws Exception {

    Document document = new Document(PageSize.A4);
    PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(
        "c:/HelloWorldForm.pdf"));
    document.open();
    BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI,
        BaseFont.NOT_EMBEDDED);
    PdfContentByte cb = writer.getDirectContent();
    cb.beginText();
    cb.setFontAndSize(bf, 12);
    cb.moveText(36f, 788);
    cb.showText("Hello");
    cb.endText();

    TextField tf = new TextField(writer, new Rectangle(67, 785, 340, 800),
        "Who");
    tf.setFontSize(12);
    tf.setFont(bf);
    tf.setText("Who?");
    tf.setTextColor(new GrayColor(0.5f));
    writer.addAnnotation(tf.getTextField());

    document.close();

    PdfReader reader;
    PdfStamper stamper;
    AcroFields form;
    reader = new PdfReader("c:/HelloWorldForm.pdf");
    stamper = new PdfStamper(reader, new FileOutputStream(
        "c:/HelloWorldFilledInForm.pdf"));
    form = stamper.getAcroFields();
    form.setField("Who", "World");
    stamper.close();
    reader = new PdfReader("c:/HelloWorldForm.pdf");
    stamper = new PdfStamper(reader, new FileOutputStream(
        "c:/HelloWorldFilledInFlattened.pdf"));
    form = stamper.getAcroFields();
    form.setField("Who", "People");
    stamper.setFormFlattening(true);
    stamper.close();
  }

}