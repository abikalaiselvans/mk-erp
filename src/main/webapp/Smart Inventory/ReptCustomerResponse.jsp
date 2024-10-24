<%@ page import="java.io.*,java.util.*,java.text.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />



<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <body >
  <%
	try
	{
		  
			  	String customergroupid[]= request.getParameterValues("customergroupid");
			  	String usertype=""+session.getAttribute("USRTYPE");
				String branchid = ""+session.getAttribute("BRANCHID");
				String branch="";
				if(!"F".equals(usertype))
					branch = " AND INT_BRANCHID = "+branchid;
				
			
				String Live = request.getParameter("Live");
				String id="";
				for(int u=0;u<customergroupid.length;u++)
					id = id+customergroupid[u]+",";
				id = id.substring(0,id.length()-1);
				String sql="";
			
				sql=" SELECT upper(a.CHR_CUSTOMERNAME),upper(a.CHR_STREET),upper(a.CHR_CITY),upper(a.CHR_STATE), ";
				sql= sql+" (SELECT concat('',a.CHR_POSTAL) ), ";
				sql= sql+" (SELECT concat('',a.CHR_PHONE) ), ";
				sql= sql+" (SELECT concat('',a.CHR_MOBILE) ), ";
				sql= sql+" (SELECT concat('',a.CHR_FAX) ), ";
				sql= sql+" (SELECT concat('',a.CHR_EMAIL) ), ";
				sql= sql+" (SELECT concat('',a.CHR_WEBSITE) ) ";
				sql= sql+" from inv_m_customerinfo a ";
				sql= sql+" WHERE a.INT_CUSTOMERGROUPID in("+id+")  "+branch;
			//if(!"Y".equals(Live))
				//sql= sql+" AND a.INT_ACTIVE=1";
				String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				String reportheader=" Customer Personal Informations  "; 
	 			Vector mn = new Vector();
	 			Vector child= null; 
	
	 	if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				child.addElement(data[u][7]);
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				mn.add(child); 
				
				 
			}
		}
		 
		
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
  
		 
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S. No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Name" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Street" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="City" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="State" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Pin" sortable="true"><%=temp.elementAt(5)%></display:column>  
					<display:column title="Phone" sortable="true"><%=temp.elementAt(6)%></display:column>  
					<display:column title="Mobile" sortable="true"><%=temp.elementAt(7)%></display:column>  
					<display:column title="Fax" sortable="true"><%=temp.elementAt(8)%></display:column>  
					<display:column title="Email" sortable="true"><%=temp.elementAt(9)%></display:column>  
					<display:column title="Website" sortable="true"><%=temp.elementAt(10)%></display:column>  
					
					
					<display:setProperty name="export.excel.filename" value="Rept_Customer.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Customer.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Customer.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
			 
					 
</display:table>     
<br />	<center>	<a href='ReptCustomer.jsp'> CLOSE</a></center><br /><br />


 
<%		 			
	 
	 }
	 catch(Exception e)
	 {
	 }	
	  %>
	  
</body>
</html>