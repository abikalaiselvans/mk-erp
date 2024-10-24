package com.my.org.erp.pdf;

import java.io.*;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;


public class landscapeportraitPDF
{

	public static void main(String arg[])throws Exception
	{
		Document document = new 
		Document(PageSize.A4.rotate());
		PdfWriter.getInstance(document,new 
		FileOutputStream("C:/kalaipdf/landscapeportraitPDF.pdf"));
		document.open();
		document.add(new Paragraph("landscape format, just make the height smaller than the width."));
		document.setPageSize(PageSize.A4);
		document.newPage();
		document.add(new Paragraph("This is portrait again"));
		
		document.close();
	}
}