package com.my.org.erp.pdf;

import java.io.*;
import java.awt.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
public class rectangleSizePDF
{
	public static void main(String arg[])throws Exception
	{
		Document document=new Document(PageSize.A4,0,0,10,10);
		PdfWriter.getInstance(document,new
		FileOutputStream("C:/kalaipdf/rectangleSizePDF.pdf"));
		document.open();
		document.add(
		new Paragraph("A4 page Size--->>roseinia.net"));
		document.close();
	}
}