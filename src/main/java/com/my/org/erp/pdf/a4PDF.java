package com.my.org.erp.pdf;

import java.io.FileOutputStream;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

public class a4PDF
{
    public static void main(String arg[])throws Exception
    {
        Document document=new Document(PageSize.A4);
        PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/a4PDF.pdf"));
        document.open();
        document.add(new Paragraph("A4 page Size--->>roseinia.net"));
        document.close();
        }
}