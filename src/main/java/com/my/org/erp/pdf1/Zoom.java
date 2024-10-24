package com.my.org.erp.pdf1;

 

import java.io.FileOutputStream;
import java.util.ArrayList;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.ColumnText;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfLayer;
import com.lowagie.text.pdf.PdfWriter;

public class Zoom {
  public static void main(String[] args) throws Exception {
    Document document = new Document();
    PdfWriter writer = PdfWriter
        .getInstance(document, new FileOutputStream("C:/kalaipdf/2.pdf"));
    writer.setPdfVersion(PdfWriter.VERSION_1_5);

    document.open();

    PdfContentByte cb = writer.getDirectContent();

    PdfLayer zoom = new PdfLayer("Zoom 0.75-1.25", writer);
    zoom.setOnPanel(false);
    zoom.setZoom(0.75f, 1.25f);
    cb.beginLayer(zoom);
    ColumnText.showTextAligned(cb, Element.ALIGN_LEFT, new Phrase(
        "Only visible if the zoomfactor is between 75 and 125%"), 30, 530, 90);
    cb.endLayer();
    document.close();
  }
}
