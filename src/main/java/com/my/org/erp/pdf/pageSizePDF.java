package com.my.org.erp.pdf;
import java.io.*;
 
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

public class pageSizePDF
{ 
	public static void main(String arg[])throws Exception
	{ 
		Document document=new Document(PageSize.A4,0,0,10,10);
		PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/pageSizePDF.pdf"));
		document.open();
		document.add(new Paragraph("A4 page Size--->>roseinia.net"));
		document.close();
	}
}