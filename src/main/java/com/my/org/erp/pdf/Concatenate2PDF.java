package com.my.org.erp.pdf;


import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.pdf.PdfCopyFields;
import com.lowagie.text.pdf.PdfReader;
public class Concatenate2PDF {
    public static void main(String[] args)throws Exception {
         System.out.println("Concatenate Two PDF");        
           PdfReader reader1 = new PdfReader("C:/kalaipdf/employee.pdf");
			PdfReader reader2 = new PdfReader("C:/kalaipdf/employee1.pdf");
			PdfCopyFields copy = new PdfCopyFields(new FileOutputStream("C:/kalaipdf/employeedocument.pdf"));
			copy.addDocument(reader1);
			copy.addDocument(reader2);
			copy.close();
    }
}