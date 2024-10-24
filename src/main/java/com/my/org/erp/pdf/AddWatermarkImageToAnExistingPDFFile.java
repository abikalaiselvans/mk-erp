package com.my.org.erp.pdf;

import java.io.FileOutputStream;
import java.util.HashMap;

import com.itextpdf.text.pdf.PdfPage;
import com.lowagie.text.Element;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;

public class AddWatermarkImageToAnExistingPDFFile {
    public static void main(String[] args) {
        try {
            PdfReader reader = new PdfReader("D:/Tomcat 5.0/webapps/SmartCampus/uploadfiles/Payslip_pdf/CISAUG2010003026_February_2011.pdf");
            int n = reader.getNumberOfPages();
            PdfStamper stamp = new PdfStamper(reader, new FileOutputStream("D:/Tomcat 5.0/webapps/SmartCampus/uploadfiles/Payslip_pdf/CISAUG2010003026_February_2011_2.pdf"));
            int i = 0;
            PdfContentByte under;
              
            
            
            Image img = Image.getInstance("D:/Tomcat 5.0/webapps/SmartCampus/images/watermark1.png");
            img.setAbsolutePosition(20, 40);
            while (i < n) {
              i++;
              under = stamp.getUnderContent(i);
              under.addImage(img);
            }
            stamp.close();
        }
        catch (Exception de) {
            System.out.println(de.getMessage());
        }
    }
}