package com.my.org.erp.pdf1;

 
import java.io.FileOutputStream;

import com.lowagie.text.pdf.PdfEncryptor;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.pdf.PdfWriter;

public class PDF2 {

  public static void main(String[] args) throws Exception {

    PdfEncryptor
        .encrypt(new PdfReader("C:/kalaipdf/ReadPdf.pdf"), new FileOutputStream("C:/kalaipdf/ReadPdf_Encrypted2.pdf"),
            "Hello".getBytes(), "World".getBytes(), PdfWriter.AllowDegradedPrinting,
            PdfWriter.STRENGTH128BITS);

    getEncryptionInformation("C:/kalaipdf/ReadPdf.pdf", null);
    getEncryptionInformation("C:/kalaipdf/ReadPdf_Encrypted2.pdf", "World");
  }

  public static void getEncryptionInformation(String filename, String ownerpassword)
      throws Exception {
    PdfReader reader;
    if (ownerpassword == null)
      reader = new PdfReader(filename);
    else
      reader = new PdfReader(filename, ownerpassword.getBytes());
    System.out.println("Encrypted? " + reader.isEncrypted());
    if (reader.isEncrypted()) {
      System.out.println("Permissions: "
          + PdfEncryptor.getPermissionsVerbose(reader.getPermissions()));
      System.out.println("128 bit? " + reader.is128Key());
    }
  }

}