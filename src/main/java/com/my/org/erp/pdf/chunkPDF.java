package com.my.org.erp.pdf;
import java.io.*;
import java.awt.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

public class chunkPDF
{
  public static void main(String arg[])throws Exception{
  Document document=new Document();
  PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/chunkPDF.pdf"));
  document.open();
  Chunk chunk=new Chunk("Welecome To RoseIndia.");
  chunk.setUnderline(+1f,-2f);
  Chunk chunk1=new Chunk("RoseIndia.net");
  chunk1.setUnderline(+4f,-2f);
  chunk1.setBackground(Color.red);
  document.add(chunk);
  document.add(chunk1);
  document.close();
}
}