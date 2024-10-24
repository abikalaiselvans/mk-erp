package com.my.org.erp.pdf;

import java.io.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

public class imagesPDF
{
	public static void main(String arg[])throws Exception
	{
	  Document document=new Document(PageSize.A4,0,0,10,10);
	  PdfWriter.getInstance(document,new FileOutputStream("C:/kalaipdf/care4.pdf"));
	  document.open();
	  Paragraph p=  new Paragraph("Enjoy this festival with our bundle offers\n");
	  p.setAlignment(Element.ALIGN_CENTER);
	  document.add(p);
	 
	  Image image3 = Image.getInstance ("D:/sa/7.jpg");
	  document.add(image3);
	  document.add(new Paragraph("For Details Contact: Arun Kumar. P @ ( +91 ) - 9176997575. Email : arunkumar.p@careind.net"));
	  document.add(new Paragraph("For Details Contact: Sasidharan. M @ ( +91 ) - 9894804205. Email : sasidharan.m@careind.net"));
	  document.add(new Paragraph("For Details Contact: ( +91 ) - 44 - 64541118 "));
	  
	  String s= "CARE IT Solutions Pvt. Ltd. " ;
	  s= s+" 2nd Floor | No. 481 Anna Salai | Nandanam |Chennai - 600 035 ";
	  s= s+"\nPhone : 044-24340906 - Extn : 4601 " ;
	  s= s+" Fax : 044-24340835      " ; 
	  document.add(new Paragraph(s));
	  document.close();
	}
}