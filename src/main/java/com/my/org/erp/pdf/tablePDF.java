package com.my.org.erp.pdf;
import java.io.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
public class tablePDF
{
 public static void main(String arg[])throws Exception
 {
	 Document document=new Document();
	 PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/tablePDF.pdf"));
	 document.open();
	 PdfPTable table=new PdfPTable(2);
	 table.addCell("Name");
	 table.addCell("Place");
	 table.addCell("RoseIndia");
	 table.addCell("Delhi");
	 document.add(table);
	 document.close();
   }
}