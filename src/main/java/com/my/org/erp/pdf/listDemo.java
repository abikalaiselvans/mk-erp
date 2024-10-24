package com.my.org.erp.pdf;

import java.io.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

public class listDemo
{
	public static void main(String a[])throws Exception 
	{
		Document doc=new Document();
		PdfWriter.getInstance(doc,new FileOutputStream("C:/kalaipdf/listDemo.pdf"));
		doc.open();       
		//Create a numbered List with  30-point field for the numbers. 
		List list=new List(true,30);
		list.add(new ListItem("First List"));
		list.add(new ListItem("Second List"));
		list.add(new ListItem("Third List"));
		doc.add(list);
		//Add a separator.
		doc.add(Chunk.NEWLINE);
		//Create a symboled List with a 30-point field for the symbols.          
		list=new List(false,30);
		list.add (new ListItem ("Orange"));
		list.add (new ListItem ("Apple"));
		list.add (new ListItem ("Cherry"));
		list.add (new ListItem ("Banana"));
		// Add the list to the document.
		doc.add (list);
		doc.close ();
	}
}