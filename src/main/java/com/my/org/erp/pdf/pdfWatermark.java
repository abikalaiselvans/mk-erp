package com.my.org.erp.pdf;

import com.lowagie.text.*;
import java.io.*;
import com.lowagie.text.pdf.*;
 

class  pdfWatermark
{
  public static void main(String args[])
  {  
    try 
    {
      PdfReader reader = new PdfReader("D:/Tomcat 5.0/webapps/SmartCampus/uploadfiles/Payslip_pdf/CISAUG2010003026_February_2011.pdf");
      int n = reader.getNumberOfPages();

      // Create a stamper that will copy the document to a new file
      PdfStamper stamp = new PdfStamper(reader, 
        new FileOutputStream("D:/Tomcat 5.0/webapps/SmartCampus/uploadfiles/Payslip_pdf/CISAUG2010003026_February_2011_1.pdf"));
      int i = 1;
      PdfContentByte under;
      PdfContentByte over;

      Image img = Image.getInstance("D:/Tomcat 5.0/webapps/SmartCampus/images/logo.jpg");
      BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, 
        BaseFont.WINANSI, BaseFont.EMBEDDED);

      img.setAbsolutePosition(200, 400);

      while (i < n) 
      {
        // Watermark under the existing page
        under = stamp.getUnderContent(i);
        under.addImage(img);
      
        // Text over the existing page
        over = stamp.getOverContent(i);
        over.beginText();
        over.setFontAndSize(bf, 18);
        over.showText("page " + i);
        over.endText();
    
        i++;
      }
    
      stamp.close();

    }
    catch (Exception de) 
    {}
  }
}