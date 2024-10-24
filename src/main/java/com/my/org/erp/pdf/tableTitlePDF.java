package com.my.org.erp.pdf;

import java.io.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import java.awt.*;

public class tableTitlePDF
{     
	public static void main(String arg[])throws Exception
	{
		Document document=new Document();
		PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/tableTilePDF.pdf"));
		document.open();
		PdfPTable table=new PdfPTable(2);
		PdfPCell cell = new PdfPCell (new Paragraph ("Rose India"));
		cell.setColspan (2);
		cell.setHorizontalAlignment (Element.ALIGN_CENTER);
		cell.setBackgroundColor (new Color (128, 200, 128));
		cell.setPadding (10.0f);
		table.addCell (cell); 
		cell = new PdfPCell (new Paragraph ("Name"));
		cell.setHorizontalAlignment (Element.ALIGN_CENTER);
		cell.setBackgroundColor (new Color (255, 200, 0));
		cell.setPadding (10.0f);
		table.addCell (cell);
		cell = new PdfPCell (new Paragraph ("Place"));
		cell.setHorizontalAlignment (Element.ALIGN_CENTER);
		cell.setBackgroundColor (new Color (255, 200, 0));
		cell.setPadding (10.0f);
		table.addCell (cell);
		table.addCell("NewsTrack");
		table.addCell("Delhi");
		table.addCell("RoseIndia");
		table.addCell("Delhi");
		document.add(table);
		document.close();
	}
}