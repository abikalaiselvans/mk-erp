package com.my.org.erp.pdf;

import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

public class MetaData {
	public static void main(String[] args) throws Exception{
	System.out.println("Meta data");	
	Document document = new Document();			
	PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/metaDataPdf.pdf"));				document.addTitle("Meta Data");
        document.addSubject("This example explains how to add metadata.");
        document.addKeywords("Rose India");
        document.addCreator("My program using iText");
        document.addAuthor("Rajesh Kumar");
        document.open();
        document.add(new Paragraph("Rose india"));
	document.close();
	}
}