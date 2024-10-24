package com.my.org.erp.pdf;

import com.lowagie.text.Document;   
import com.lowagie.text.Paragraph;    
import com.lowagie.text.pdf.PdfWriter;    
import java.io.File;
import java.io.FileOutputStream;    
public class Doc2Pdf2 {    
    /**
     * This method is used to convert the given file to a PDF format
     * 
     * @param inputFile
     *            - Name and the path of the file
     * @param outputFile
     *            - Name and the path where the PDF file to be saved
     * @param isPictureFile
     */
    public static void createPdf(String inputFile, String outputFile,
            boolean isPictureFile) {
        Document pdfDocument = new Document();
        String pdfFilePath = outputFile;
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(
                    pdfFilePath);
            PdfWriter writer = null;
            writer = PdfWriter.getInstance(pdfDocument, fileOutputStream);
            writer.open();
            pdfDocument.open();    
            if (isPictureFile) {                    pdfDocument.add(com.lowagie.text.Image.getInstance(inputFile));
            } else {
                File file = new File(inputFile);
                pdfDocument.add(new Paragraph(org.apache.commons.io.FileUtils
                        .readFileToString(file)));
            }
            pdfDocument.close();
            writer.close();
        } catch (Exception exception) {
            System.out.println("Document Exception!" + exception);
        }
    }    
    public static void main(String args[]) {
        PDFConversion pdfConversion = new PDFConversion();
        createPdf("C:/1.doc", "C:/demopdf.pdf", true);    
    }    
}