package com.my.org.erp.pdf;

import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
 
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfGState;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
 
public class PDFWatermarkExample {
    public static void main(String[] args) throws IOException, DocumentException {
        // Read the existing PDF document
        PdfReader pdfReader = new PdfReader("D:/Tomcat 5.0/webapps/SmartCampus/uploadfiles/Payslip_pdf/CISAUG2010003026_February_2011.pdf");
        // Get the PdfStamper object
        PdfStamper pdfStamper = new PdfStamper(pdfReader, new FileOutputStream("D:/Tomcat 5.0/webapps/SmartCampus/uploadfiles/Payslip_pdf/CISAUG2010003026_February_2011_1.pdf"));
        // Get the PdfContentByte type by pdfStamper.
        PdfContentByte underContent = pdfStamper.getUnderContent(1);
 
        BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED);
        PdfGState gs = new PdfGState();
        gs.setFillOpacity(0.8f);
        underContent.setGState(gs);
        underContent.beginText();
        underContent.setFontAndSize(bf, 20);
        underContent.setColorFill(Color.LIGHT_GRAY);
        underContent.showTextAligned(Element.ALIGN_CENTER, "http://www.connect.careind.net", 100, 700, 0);
        underContent.endText();
 
        pdfStamper.close();
 
    }
}