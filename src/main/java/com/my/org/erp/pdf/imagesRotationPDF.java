package com.my.org.erp.pdf;


import java.io.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
public class imagesRotationPDF
         {
    public static void main(String arg[])throws Exception
              {                   
               Document document=new Document();
               PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/imagesRotationPDF.pdf"));
               document.open();
               Image image = Image.getInstance ("devi.gif");
               document.add(new Paragraph("Original:"));
               document.add(image);
               image.scalePercent (20.0f);
               image.setRotationDegrees (30.0f);  
               document.add(new Paragraph("After Scalable and Rotation"));          
               document.add(image);
               document.close();
        }
}
