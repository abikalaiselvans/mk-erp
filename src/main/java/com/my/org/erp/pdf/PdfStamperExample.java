package com.my.org.erp.pdf;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;

import java.io.FileOutputStream;
import java.io.IOException;

public class PdfStamperExample {

  public static void main(String[] args) {
    try {
      PdfReader pdfReader = new PdfReader("D:/Tomcat 5.0/webapps/SmartCampus/uploadfiles/Payslip_pdf/CISAUG2010003026_February_2011.pdf");

      PdfStamper pdfStamper = new PdfStamper(pdfReader,
            new FileOutputStream("D:/Tomcat 5.0/webapps/SmartCampus/uploadfiles/Payslip_pdf/CISAUG2010003026_February_20112222.pdf"));

      Image image = Image.getInstance("D:/Tomcat 5.0/webapps/SmartCampus/images/watermark1.png");

      for(int i=1; i<= pdfReader.getNumberOfPages(); i++){

          PdfContentByte content = pdfStamper.getUnderContent(i);

          image.setAbsolutePosition(100f, 100f);

          content.addImage(image);
      }

      pdfStamper.close();

    } catch (IOException e) {
       System.out.println(e.getMessage());
    } catch (DocumentException e) {
       System.out.println(e.getMessage());
    }
  }
  
  
  
}
