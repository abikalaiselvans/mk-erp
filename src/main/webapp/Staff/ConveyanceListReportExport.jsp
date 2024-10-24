<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>

 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<%@include file="Redirect.jsp" %>


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<title>:: STAFF ::</title>

 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>

<body  onpaste='return false;'>

 
 <%
try
{


			 
	   		 
  	 		
  	 			String empid=""+session.getAttribute("EMPID");
				String empname=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+empid+"'")[0][0];
				
				String fromdate=""+request.getParameter("fromdate");
				String todate=""+request.getParameter("todate");
				String fdt=fromdate;
				String tdt = todate;
				fromdate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate);
				todate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
				String sql="";
				sql ="SELECT INT_CONID,DAT_CONDATE,CHR_FROM,CHR_TO,CHR_CALLID,DOU_KM,DOU_TRAVEL,DOU_TRAIN,DOU_AUTO,DOU_LUNCH,";
				sql = sql+"	DOU_TELEPHONE,CHR_OTHERDESC, DOU_OTHERAMT,DOU_TOTAL,CHR_STATUS,CHR_DESC  FROM conveyance_t_conveyance ";
				sql = sql+" WHERE   (DAT_CONDATE)>='"+fromdate+"' AND (DAT_CONDATE)<='"+todate+"' ";
				sql = sql+" AND CHR_EMPID='"+empid+"'"; 
			 	//out.println(sql);

  		 	 String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 Vector mn = new Vector();
			 Vector child= null;
			 for(int u=0; u<data.length;u++)
			 {
					child = new Vector();
					child.addElement((u+1));
					child.addElement(empid);
					child.addElement(empname);
					child.addElement(data[u][1]);
					child.addElement(data[u][2]);
					child.addElement(data[u][3]);
					child.addElement(data[u][4]);
					child.addElement(data[u][5]);
					child.addElement(data[u][6]);
					child.addElement(data[u][7]);
					child.addElement(data[u][8]);
					child.addElement(data[u][9]);
					child.addElement(data[u][10]);
					child.addElement(data[u][11]);
					child.addElement(data[u][12]);
					child.addElement(data[u][13]);
					
					if("Y".equals(data[u][14]))
						child.addElement("Accepted");
					else if("R".equals(data[u][14]))
						child.addElement("Rejected");
					else
						child.addElement("Pending");
					child.addElement(data[u][15]);
					
					mn.add(child);
     		} 
   
	 
			request.setAttribute("table",mn);
			out.println("<br><center><h3> CONVEYANCE REPORT </h3></center><br>");
 
  %>
			
			
			
			
			
	<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Emp Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Emp Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Conveyance Date" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="From" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="To" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Call Number" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Km" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Travel" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Train" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Auto" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Lunch" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Telephone" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Other Desc" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Other Amount" sortable="true"><%=temp.elementAt(14)%></display:column>
					 <display:column title="Total" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Status" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="Description" sortable="true"><%=temp.elementAt(17)%></display:column>
					
					 
					<display:setProperty name="export.csv.filename" value="ConveyanceReport.csv"/>
					<display:setProperty name="export.excel.filename" value="ConveyanceReport.xls"/>
					<display:setProperty name="export.xml.filename" value="ConveyanceReport.xml"/>
					<display:setProperty name="export.pdf.filename" value="ConveyanceReport.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<!--<br />	<center>	<a href='ConveyanceReport.jsp'> CLOSE</a></center>
--><%
			
			
}
catch(Exception e)
{
	 
}
%>
 
  
</body>
</html>
