package com.my.org.erp.pdf;

import java.io.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

public class defaultSizePDF
{
	public static void main(String arg[])throws Exception
	{
		Document document = new Document();
		PdfWriter.getInstance(document, 
		new FileOutputStream("C:/kalaipdf/DefaultPageSize.pdf"));
		document.open();
		document.add(new Paragraph("The default PageSize==>>RoseIndia"));
		document.setPageSize(PageSize.A3);
		document.newPage();
		document.add(new Paragraph("This PageSize is DIN A3."));
		document.setPageSize(PageSize.A2);
		document.newPage();
		document.add(new Paragraph("This PageSize is DIN A2."));
		document.setPageSize(PageSize.A1);
		document.newPage();
		document.add(new Paragraph("This PageSize is DIN A1."));
		document.setPageSize(PageSize.A0);
		document.newPage();
		document.add(new Paragraph("This PageSize is DIN A0."));
		document.setPageSize(PageSize.A5);
		document.newPage();
		document.add(new Paragraph("This PageSize is DIN A5."));
		document.setPageSize(PageSize.A6);
		document.newPage();
		document.add(new Paragraph("This PageSize is DIN A6."));
		document.setPageSize(PageSize.A7);
		document.newPage();
		document.add(new Paragraph("This PageSize is DIN A7."));
		document.setPageSize(PageSize.A8);
		document.newPage();
		document.add(new Paragraph("This PageSize is DIN A8."));
		document.setPageSize(PageSize.LETTER);
		document.newPage();
		document.add(new Paragraph("This PageSize is LETTER."));
		document.close();
	}
}