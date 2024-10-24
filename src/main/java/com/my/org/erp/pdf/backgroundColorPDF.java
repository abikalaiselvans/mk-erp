package com.my.org.erp.pdf;

import java.io.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

public class backgroundColorPDF
{     
    public static void main(String arg[])throws Exception
    {                   
        Rectangle pageSize = new Rectangle(400, 400);
		pageSize.setBackgroundColor
			(new java.awt.Color(0xDF, 0xFF, 0xDE));
        Document document = new Document(pageSize);
        PdfWriter.getInstance(document,
			new FileOutputStream("C:/kalaipdf/backgroundColorPDF.pdf"));
        document.open();
        Paragraph para=new Paragraph("Page Size and Background color");
        document.add(para);
        document.add(new Paragraph("Background color--->>roseinia.net"));
        document.close();
    }
}
