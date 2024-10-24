package com.my.org.erp.pdf;
import com.lowagie.text.Document; 
import com.lowagie.text.Paragraph; 
import com.lowagie.text.pdf.PdfWriter; 
import java.io.File; 
import java.io.FileOutputStream; 


public class PdfConverter 
{

    private void createPdf(String inputFile, String outputFile)//, boolean isPictureFile) 
    {
        Document pdfDocument = new Document(); 
        String pdfFilePath = outputFile; 
        try
        {
            FileOutputStream fileOutputStream = new FileOutputStream(pdfFilePath); 
            PdfWriter writer = null; 
            writer = PdfWriter.getInstance(pdfDocument, fileOutputStream); 
            writer.open(); 
            pdfDocument.open(); 
           File file = new File(inputFile); 
           pdfDocument.add(new Paragraph(org.apache.commons.io.FileUtils.readFileToString(file))); 
                
            pdfDocument.close(); 
            writer.close(); 
            System.out.println("PDF has been generted"); 
            } 
            catch (Exception exception) 
            { 
            System.out.println("Document Exception!" + exception); 
            } 
            } 

    public static void main(String args[]) 
    { 
    PdfConverter pdfConversion = new PdfConverter(); 
    pdfConversion.createPdf("C:/kalaipdf/employee.doc", "C:/kalaipdf/employee.pdf");//, true); 

        }

    }