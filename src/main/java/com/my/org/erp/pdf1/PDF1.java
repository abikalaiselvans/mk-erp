package com.my.org.erp.pdf1;
import java.io.FileOutputStream;
import com.lowagie.text.pdf.PdfEncryptor;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.pdf.PdfWriter;
public class PDF1 
{
  public static void main(String[] args) throws Exception 
  {
    PdfReader reader = new PdfReader("C:/kalaipdf/ReadPdf.pdf");
    PdfStamper stamper = new PdfStamper(reader, new FileOutputStream("C:/kalaipdf/ReadPdf_Encrypted1.pdf"));
    stamper.setEncryption("Hello".getBytes(), "World".getBytes(), PdfWriter.AllowPrinting  | PdfWriter.AllowCopy, PdfWriter.STRENGTH40BITS);
    stamper.close();
    getEncryptionInformation("C:/kalaipdf/ReadPdf.pdf", null);
    getEncryptionInformation("C:/kalaipdf/ReadPdf_Encrypted1.pdf", "World");
  }


  public static void getEncryptionInformation(String filename, String ownerpassword)throws Exception 
  {
    PdfReader reader;
    if (ownerpassword == null)
      reader = new PdfReader(filename);
    else
      reader = new PdfReader(filename, ownerpassword.getBytes());
    System.out.println("Encrypted? " + reader.isEncrypted());
    if (reader.isEncrypted()) 
    {
      System.out.println("Permissions: "
          + PdfEncryptor.getPermissionsVerbose(reader.getPermissions()));
      System.out.println("128 bit? " + reader.is128Key());
    }
  }

}
