<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.MessagingException"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="com.my.org.erp.setting.*"%> 
 

<html>
<head>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<title>Untitled Document</title>
</head>

<body  onpaste='return false;'>
<%
try
    	{
			String newempid ="CISSEP2005000691";
			String to ="mjr@careind.net";
    		
    		
    		String ssql =" SELECT  a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, d.CHR_DEPARTNAME,e.CHR_DESIGNAME,f.CHR_OFFICENAME,DATE_FORMAT(DT_DOB,'%d-%b-%Y'),a.CHR_GENDER,a.CHR_MARITALSTATUS,DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y'), a.CHR_EMAILID,a.CHR_PERMAILID ,a.CHR_MOBILE,g.CHR_QUALIFICATIONNAME   FROM   com_m_staff a ,  com_m_company b,  com_m_branch c,com_m_depart d,com_m_desig e, com_m_office  f,com_m_qualification g WHERE a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID = c.INT_BRANCHID AND a.INT_DEPARTID = d.INT_DEPARTID  AND a.INT_DESIGID = e.INT_DESIGID 	AND a.INT_OFFICEID = f.INT_OFFICEID AND a.CHR_QUALIFICATION = g.INT_QUALIFICATIONID AND a.CHR_EMPID='"+newempid+"' ";
    		String pdatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
			
    		String content ="   ";
    		content=content+"<html> ";
    		content=content+"<head>";
    		content=content+"<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'> ";
    		content=content+"<title>:: SMARTCAMPUS ::</title> ";
    		content=content+"<style type='text/css'> ";
    		content=content+"<!-- ";
    		content=content+" .style12 { ";
    		content=content+"	FONT-WEIGHT: normal; ";
    		content=content+"	FONT-SIZE: 10px; ";
    		content=content+"	COLOR: #000000; ";
    		content=content+"	LINE-HEIGHT: 15px; ";
    		content=content+"	FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
    		content=content+"	TEXT-DECORATION: none ";
    		content=content+"}	 ";
    		content=content+".style15 {FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; } ";
    		content=content+"--> ";
    		content=content+"</style> ";
    		content=content+"</head> ";

    		content=content+"<body  onpaste='return false;'> ";
    		content=content+"<table width='607' border='1' align='center' cellpadding='0' cellspacing='0' bordercolor='#0099FF'> ";
    		content=content+"  <tr> ";
    		content=content+"    <td bgcolor='#0099FF'><h3><font color='#ffffff'>DEAR ALL, Lets Welcome a new member in Mythra Family </font></h3></td> ";
    		content=content+"  </tr> ";
    		content=content+"  <tr> ";
    		content=content+"    <td><table width='400' border='0' align='center' cellpadding='4' cellspacing='2'> ";
    		content=content+"      <tr> ";
    		content=content+"       <td width='178'><span class='style15'>Emp Id </span></td> ";
    		content=content+"        <td width='222'><span class='style12'>"+pdatas[0][0]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Name</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][1]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"        <td><span class='style15'>Father Name </span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][2]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Company</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][3]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"     <tr> ";
    		content=content+"        <td><span class='style15'>Branch</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][4]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"        <td><span class='style15'>Department</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][5]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Designation</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][6]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Office</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][7]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"<td><span class='style15'>Date of Birth </span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][8]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"     <tr> ";
    		content=content+"        <td><span class='style15'>Gender</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][9]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Married Status </span></td> ";
    		if("M".equals(pdatas[0][10]))
				content=content+"       <td><span class='style12'>Married</span></td> ";
			else
				content=content+"       <td><span class='style12'>Unmarried</span></td> ";
    		content=content+"     </tr> ";
    		content=content+"      <tr> ";
			if("M".equals(pdatas[0][10]))
			{
    			content=content+"       <td><span class='style15'>Wedding Date </span></td> ";
    			content=content+"       <td><span class='style12'>"+pdatas[0][11]+"</span></td> ";
    			content=content+"      </tr> ";
			}	
    		content=content+"     <tr> ";
    		content=content+"        <td><span class='style15'>Office - Email</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][12]+"</span></td> ";
    		content=content+"    </tr> ";
    		content=content+"    <tr> ";
    		content=content+"       <td><span class='style15'>Per - Email </span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][13]+"</span></td> ";
    		content=content+"     </tr> ";
    		content=content+"     <tr> ";
    		content=content+"      <td><span class='style15'>Mobile</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][14]+"</span></td> ";
    		content=content+"    </tr> ";
			content=content+"     <tr> ";
    		content=content+"      <td><span class='style15'>Qualification</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][15]+"</span></td> ";
    		content=content+"    </tr> ";
			content=content+"     <tr> ";
    		content=content+"      <td><span class='style15'>Previous Details</span></td> ";
    		content=content+"       <td><span class='style12'>&nbsp;</span></td> ";
    		content=content+"    </tr> ";
    		content=content+"   </table></td> ";
    		content=content+" </tr> ";
			content=content+"  <tr> ";
    		content=content+"    <td bgcolor='#0099FF'><h4><font color='#ffffff'> Lets congratualate & wish her/him success for a good beginning towards the long jounrney with the team @ Mythra.... </font></h4></td> ";
    		content=content+"  </tr> ";
    		content=content+"</table> ";
    		content=content+"</body> ";
    		content=content+"</html> ";
    		
    		Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MAILHOST FROM m_institution WHERE  INT_ID=1")[0][0]);
  	        props.setProperty("mail.user", "connect");
  	        props.setProperty("mail.password", "connect");

  	        Session mailSession = Session.getDefaultInstance(props, null);
  	        mailSession.setDebug(true);
  	        Transport transport = mailSession.getTransport();
  	        MimeMessage message = new MimeMessage(mailSession);
  	        message.setSubject("****** Lets All Join Hands In Welcoming them into the Mythra Family *****");
  	        message.setFrom(new InternetAddress(""+CommonData.mailid));
  	        message.setContent(content, "text/html");
  	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
  	        transport.connect();
  	        transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
  	        transport.close();
  	        
    	      
    	}
    	 
    	catch (Exception mex) 
    	{
    		mex.printStackTrace();
    		 out.println(mex.getMessage());
    		 
    	}
%>
<applet class="com.my.org.erp.calculator.Cal" width=300 height=300>
</applet>
</body>
</html>
