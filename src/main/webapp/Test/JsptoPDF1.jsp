<%@page import="java.io.*"%>
<%@page import="java.awt.*"%>
<%@page import="com.lowagie.text.*"%>
<%@page import="com.lowagie.text.pdf.*"%>
<%
	Document document = new Document(); 
	document.addAuthor("Kiran Hegde");
	document.addCreationDate();
	document.addCreator("iText library");
	document.addTitle("Hello World PDF");
	try
	{         
		 
		 
		document.open();
		document.add(new Paragraph("Hello Kiran"));
		document.addTitle("Mythra PAY SLIP");
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
		e.printStackTrace();
	}     
	document.close(); 
%>