package com.my.org.erp.pdf1;
 
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.geom.Ellipse2D;
import java.io.FileOutputStream;

import com.lowagie.text.Document;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfWriter;

public class PdfDraw {
  public static void main(String[] args) throws Exception {
    int w, h;
    w = 150;
    h = 150;
    Ellipse2D.Double circle = new Ellipse2D.Double(12, 12, 12, 12);

    Document document = new Document(new Rectangle(w, h));

    PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/sun_tutorial.pdf"));
    document.open();
    PdfContentByte cb = writer.getDirectContent();
    Graphics2D g2 = cb.createGraphics(w, h);

    g2.setColor(Color.green);

    g2.fill(circle);

    g2.dispose();

    document.close();
  }
}