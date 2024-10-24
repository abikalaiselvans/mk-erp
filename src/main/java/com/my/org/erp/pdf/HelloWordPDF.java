package com.my.org.erp.pdf;

import java.io.*;
import com.lowagie.text.pdf.*;
import com.lowagie.text.*;
public class HelloWordPDF
   {
    public static void main(String arg[])throws Exception
      {
       Document document=new Document();
       PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/hello.pdf"));
       document.open();  
       document.add(new Paragraph("Hello Pdf"));
       document.close(); 
      }
}
