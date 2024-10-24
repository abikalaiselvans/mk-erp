package com.my.org.erp.pdf;

import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.pdf.PdfReader;
public class ChaningVersionPDF {
    public static void main(String[] args)throws Exception {
       System.out.println("Example of  Changing the PDF version of a document");        
        Rectangle pageSize = new Rectangle(288, 720);
        Document document = new Document(pageSize, 36, 18, 72, 72);         
        PdfWriter writer=PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/changedVersionPDF.pdf"));
        writer.setPdfVersion(PdfWriter.VERSION_1_2);
        document.open();
        document.add(new Paragraph("Version Of PDF-->>Rose India"));
        document.add(new Paragraph("-->>RoseIndai.net"));
        document.close();
        PdfReader reader = new PdfReader("C:/kalaipdf/changedVersionPDF.pdf");
        System.out.println("Version of PDF:"+reader.getPdfVersion());
    }}