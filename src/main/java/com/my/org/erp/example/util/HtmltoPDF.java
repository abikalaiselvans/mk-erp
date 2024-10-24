package com.my.org.erp.example.util;

import java.io.FileOutputStream;
import java.io.FileReader;
import java.util.ArrayList;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.html.HtmlParser;
import com.lowagie.text.html.simpleparser.HTMLWorker;
import com.lowagie.text.html.simpleparser.StyleSheet;
import com.lowagie.text.pdf.PdfWriter;

public class HtmltoPDF {
  public static void main(String[] args) throws Exception {
    /*Document document = new Document();
    StyleSheet st = new StyleSheet();
    st.loadTagStyle("body", "leading", "16,0");
    PdfWriter.getInstance(document, new FileOutputStream("C:/a.pdf"));
    document.open();
    ArrayList p = HTMLWorker.parseToList(new FileReader("C:/a.html"), st);
    for (int k = 0; k < p.size(); ++k)
      document.add((Element) p.get(k));
    document.close();*/
    
   /* 
    Document document1 = new Document();
    PdfWriter.getInstance(document1, new FileOutputStream("C:/html1.pdf"));
    HtmlParser.parse(document1, "c:/a.html");*/
	  
	  Document document = new Document();
	    StyleSheet styles = new StyleSheet();
	    styles.loadTagStyle("ol", "leading", "16,0");
	    PdfWriter.getInstance(document, new FileOutputStream("C:/html3.pdf"));
	    document.open();
	    ArrayList objects;
	    objects = HTMLWorker.parseToList(new FileReader("C:/a.html"), styles);
	    for (int k = 0; k < objects.size(); ++k)
	      document.add((Element) objects.get(k));
	    document.close();
  }
}