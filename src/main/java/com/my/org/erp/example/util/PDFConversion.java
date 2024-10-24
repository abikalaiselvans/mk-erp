package com.my.org.erp.example.util;

import com.lowagie.text.Document;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfWriter;
import java.io.File;
import java.io.FileOutputStream;
	/**
 *
	 * @author shunmuga
	 */
	public class PDFConversion
	{
	 /**
	 * This method is used to convert the given file to a PDF format
	 * @param inputFile - Name and the path of the file
	 * @param outputFile - Name and the path where the PDF file to be saved
	 * @param isPictureFile
	 */
	 private void createPdf(String inputFile, String outputFile, boolean isPictureFile)
	 {
	      /**
22	      * Set the page size for the image
23	      */
	      Rectangle pageSize = new Rectangle(2780, 2525);
	    Document pdfDocument = new Document(pageSize);
	     String pdfFilePath = outputFile;
	     try
	     {
	         FileOutputStream fileOutputStream = new FileOutputStream(pdfFilePath);
	         PdfWriter writer = null;
	         writer = PdfWriter.getInstance(pdfDocument, fileOutputStream);
	         writer.open();
	         pdfDocument.open();
	         /**
	         * Proceed if the file given is a picture file
	         */
	          if (isPictureFile)
	         {
	          pdfDocument.add(com.lowagie.text.Image.getInstance(inputFile));
	         }
	         /**
	         * Proceed if the file given is (.txt,.html,.doc etc)
	         */
	         else
	         {
	         File file = new File(inputFile);
	         pdfDocument.add(new Paragraph(org.apache.commons.io.FileUtils.readFileToString(file)));
	         }
	 
	         pdfDocument.close();
	         writer.close();
	     }
	     catch (Exception exception)
	     {
	      System.out.println("Document Exception!" + exception);
	     }
	  }
	 
	  public static void main(String args[])
	  {
	   PDFConversion pdfConversion = new PDFConversion();
	   pdfConversion.createPdf("C:/apple.jpg", "C:/apple.pdf", true);
	 
	   // For other files
	   pdfConversion.createPdf("C:/a.html","C:/a.pdf", false);
	   }
	}