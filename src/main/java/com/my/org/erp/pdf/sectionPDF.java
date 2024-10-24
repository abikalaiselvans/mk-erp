package com.my.org.erp.pdf;

import java.io.*;
import java.awt.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

public class sectionPDF
{
	public static void main(String arg[])throws Exception
	{
		Document document=new Document();
		PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/sectionPDF.pdf"));
		document.open();
		Chapter chapter=new Chapter(new Paragraph("Chapter1"),1);
		Section section1=chapter.addSection(new Paragraph("Section1"));
		section1.add(new Paragraph("Rose India"));
		Section section2=chapter.addSection(new Paragraph("section2"));
		section2.add(new Paragraph("roseinia.net"));
		document.add(chapter);
		document.close();
	}
}