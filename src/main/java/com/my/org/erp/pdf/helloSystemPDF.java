package com.my.org.erp.pdf;

import java.io.*;
import java.awt.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

public class helloSystemPDF
{
	public static void main(String arg[])throws Exception
	{ 
		System.out.println("Hello RoseIndia");
		Paragraph paragraph=new Paragraph();  
		Document document = new Document(PageSize.A4, 36, 72, 108, 180);
		PdfWriter.getInstance(document,System.out);
		PdfWriter.getInstance(document,
		new FileOutputStream("C:/kalaipdf/helloSystemPDF.pdf"));
		document.open();  
		document.add(new Paragraph("Margin--->>roseinia.net"));
		document.setMargins(180,108,71,10);
		document.add(new Paragraph("You can visit  roseindia.net for more java tutorials"));
		paragraph.add("Hello roseindia.net, Hello roseindia.net,Hello roseindia.net, Hello roseindia.net,Hello roseindia.net,Hello roseindia.net,Hello  roseindia.net,Hello roseindia.net.");  
		document.setMarginMirroring(true);
		document.add(new Paragraph("Starting on  the next page, the margins will be mirrored."));  
		document.add(paragraph);
		document.close();
	}
}