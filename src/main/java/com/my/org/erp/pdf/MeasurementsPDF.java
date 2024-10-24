package com.my.org.erp.pdf;


import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfWriter;
public class MeasurementsPDF {
    public static void main(String[] args)throws Exception {
     
        System.out.println("Measurements");      
     
        Rectangle pageSize = new Rectangle(288, 720);
        Document document = new Document(pageSize, 36, 18, 72, 72);
 
            PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/Measurements.pdf"));
            document.open();
            document.add(new Paragraph("The size of this page is="+ (288*720)));
            document.add(new Paragraph("288pt / 72 points per inch ="+(288/72)+" inch"));
            document.add(new Paragraph("720pt / 72 points per inch = "+(720/72)+" inch"));
            document.add(new Paragraph("The size of this page is 4x10 inch="+4*10));
            document.add(new Paragraph("4 inch x 2.54 = "+4*2.54));
            document.add(new Paragraph("10 inch x 2.54 = "+10*2.54));
            document.add(new Paragraph("The size of this page is 10.16x25.4 cm="+10.16*25.4));
            document.add(new Paragraph("The left border is= 36pt or 0.5 inch or 1.27 cm"));
            document.add(new Paragraph("The right border is =18pt or 0.25 inch or 0.63 cm."));
            document.add(new Paragraph("The top and bottom border are =72pt or 1 inch or 2.54 cm."));   
             document.close();
    }
}