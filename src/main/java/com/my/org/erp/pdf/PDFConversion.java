package com.my.org.erp.pdf;

 
 import com.lowagie.text.Document;
 import com.lowagie.text.Paragraph;
 import com.lowagie.text.pdf.PdfWriter;
 import java.io.File;
 import java.io.FileOutputStream;
 
 public class PDFConversion
 {
	  
	 private void createPdf(String inputFile, String outputFile, boolean isPictureFile)
	 {
	 /**
	 * Create a new instance for Document class
	 */
		 Document pdfDocument = new Document();
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
		 pdfConversion.createPdf("C:/kalaipdf/employee.doc", "C:/kalaipdf/employee.pdf", true);
		 
	}
 }