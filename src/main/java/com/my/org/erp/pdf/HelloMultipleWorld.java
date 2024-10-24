package com.my.org.erp.pdf;

import java.io.FileOutputStream;
import java.io.IOException;

import com.lowagie.text.Anchor;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.html.HtmlWriter;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.rtf.RtfWriter2;


public class HelloMultipleWorld 
{
  public static void main(String[] args) 
  {
	  System.out.println("Hello World in PDF, RTF and HTML");
	  Document document = new Document();
	  try 
	  {
		  PdfWriter pdf = PdfWriter.getInstance(document,
		  new FileOutputStream("C:/kalaipdf/differentWritersdPdf.pdf"));
		  RtfWriter2 rtf = RtfWriter2.getInstance(document,
		  new FileOutputStream("C:/kalaipdf/differentWritersRtf.rtf"));
		  HtmlWriter html = HtmlWriter.getInstance(document,
		  new FileOutputStream("C:/kalaipdf/differentWritersdHtml.html"));
		  document.open();
		  document.add(new Paragraph("Hello World"));
		  Anchor pdfRef = new Anchor("see Hello World in PDF.");
		  pdfRef.setReference("./HelloWorldPdf.pdf");
		  Anchor rtfRef = new Anchor("see Hello World in RTF.");
		  rtfRef.setReference("./HelloWorldRtf.rtf");
		  pdf.pause();
		  rtf.pause();
		  document.add(pdfRef);
		  document.add(Chunk.NEWLINE);
		  document.add(rtfRef);
		  pdf.resume();
		  rtf.resume();
	  } 
	  catch (DocumentException de) 
	  {
		  System.err.println(de.getMessage());
	  } 
	  catch (IOException ioe)
	  {
		  System.err.println(ioe.getMessage());
	  }

  
	  document.close();
  }
}