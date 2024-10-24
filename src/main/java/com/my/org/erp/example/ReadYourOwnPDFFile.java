package com.my.org.erp.example;

import java.io.FileOutputStream;

import com.lowagie.text.Document;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfImportedPage;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfWriter;
 
public class ReadYourOwnPDFFile {
    public static void main(String[] args) {
        try {
            PdfReader reader = new PdfReader("c:\\1.pdf");
            int n = reader.getNumberOfPages();
            // we retrieve the size of the first page
            Rectangle psize = reader.getPageSize(1);
            
        }
        catch (Exception de) {
            de.printStackTrace();
        }
    }
}