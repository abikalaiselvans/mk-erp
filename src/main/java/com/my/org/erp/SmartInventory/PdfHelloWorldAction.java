package com.my.org.erp.SmartInventory;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Date;

import com.lowagie.text.Document;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter; 

public class PdfHelloWorldAction extends HttpServlet 
{
   
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
/*
public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
  { 
	Document document = new Document(); 
	document.addAuthor("Kiran Hegde");
	document.addCreationDate();
	document.addCreator("iText library");
	document.addTitle("Hello World PDF");
	try
	{         
		response.setContentType("application/pdf");
		PdfWriter.getInstance(document, response.getOutputStream());
		document.open();
		document.add(new Paragraph("Hello Kiran"));
		document.addTitle("CARE PAY SLIP");
		String s =" <table width='296' border='1' align='center' cellpadding='0' cellspacing='0'> ";
		s= s+ " <tr> <td colspan='2'> <div align='center'>HI THIS IS KALAI </div></td> </tr> ";
		s= s+ " <tr> <td width='114'>NAME</td> <td width='176'>K KALAISELVAN </td> </tr> ";
		s= s+ " <tr> <td>DOB</td> <td>21/10/1978</td> </tr> ";
		s= s+ " </table> ";
		document.add(new Paragraph(s));
		
		document.add(new Paragraph(new Date().toString()));
	}
	catch(Exception e)
	{         
		 System.out.println(e.getMessage());
	}     
	document.close(); 
  }
*/
 
public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
{ 
	Document document = new Document(); 
	document.addAuthor("Kiran Hegde");
	document.addCreationDate();
	document.addCreator("iText library");
	document.addTitle("Hello World PDF");
	try
	{         
		response.setContentType("application/pdf");
		PdfWriter.getInstance(document, response.getOutputStream());
		document.open();
		document.add(new Paragraph("Hello Kiran"));
		document.addTitle("CARE PAY SLIP");
		String s =" <table width='296' border='1' align='center' cellpadding='0' cellspacing='0'> ";
		s= s+ " <tr> <td colspan='2'> <div align='center'>HI THIS IS KALAI </div></td> </tr> ";
		s= s+ " <tr> <td width='114'>NAME</td> <td width='176'>K KALAISELVAN </td> </tr> ";
		s= s+ " <tr> <td>DOB</td> <td>21/10/1978</td> </tr> ";
		s= s+ " </table> ";
		document.add(new Paragraph(s));
		
		document.add(new Paragraph(new Date().toString()));
	}
	catch(Exception e)
	{         
		 System.out.println(e.getMessage());
	}     
	document.close(); 
}


}