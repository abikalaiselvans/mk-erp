 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<title> :: MANAGEMENT ::</title>



<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
  
   
</head>
<%
try
{
%>
 
<body  onpaste='return false;'><br> 
<%
 

 	String reportheader="VISITORS INFORMATIONS "; 
	String fromdate= request.getParameter("fromdate");
	String todate= request.getParameter("todate");
	String building= request.getParameter("building");
	String floor= request.getParameter("floor");
	String purpose= request.getParameter("purpose");
	
 	String sql="";
	sql = "";
	sql = sql + " SELECT a.CHR_VISITORNO,  a.CHR_VISITORNAME,a.CHR_ADDRESS, ";
	sql = sql + " b.CHR_BUILDINGNAME, c.CHR_FLOOR, d.CHR_PURPOSE,  a.CHR_WHOMTOMEET,  ";
	sql = sql + " DATE_FORMAT(a.DT_TIMEIN,'%d-%b-%Y') datein, DATE_FORMAT(a.DT_TIMEIN,' %h:%i:%s %p') timein,  ";
	sql = sql + " DATE_FORMAT(a.DT_TIMEOUT,'%d-%b-%Y') dateout, DATE_FORMAT(a.DT_TIMEOUT,' %h:%i:%s %p') timeout, ";
	sql = sql + " a.CHR_VECHILENO, IF(a.CHR_NOTIFICATION='S','SMS','E-Mail'), ";
	sql = sql + " a.INT_MOBILE,a.CHR_EMAILID,DATE_FORMAT(NOW(),'%d-%b-%d %h:%i:%s %p') ctime ";
	sql = sql + "  FROM mgt_m_visitor a, mgt_m_buildingname b, mgt_m_floor c, mgt_m_purpose d ";
	sql = sql + "  WHERE a.INT_BUILDINGID = b.INT_BUILDINGID ";
	sql = sql + "  AND a.INT_FLOORID = c.INT_FLOORID ";
	sql = sql + "  AND a.INT_PURPOSEID = d.INT_PURPOSEID ";
	sql = sql + "  AND a.CHR_STATUS = 'Y' ";
	sql = sql + "  AND a.DT_TIMEIN >= '"+DateUtil.FormateDateSQL(fromdate)+"' ";
	sql = sql + "  AND a.DT_TIMEOUT <= '"+DateUtil.FormateDateSQL(todate)+"' ";
	
	if(!"0".equals(building))
		sql = sql + "  AND a.INT_BUILDINGID = "+building;
	if(!"0".equals(floor))
		sql = sql + "  AND a.INT_FLOORID = "+floor;
	if(!"0".equals(purpose))
		sql = sql + "  AND a.INT_PURPOSEID = "+purpose;
	sql = sql + " ORDER BY a.CHR_VISITORNAME ";
	String data[][] = CommonFunctions.QueryExecute(sql);
    Vector mn = new Vector();
	Vector child= null;
    for(int u=0; u<data.length;u++)
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
			child.addElement(data[u][10]);
			child.addElement(data[u][11]);
			child.addElement(data[u][12]);
			child.addElement(data[u][13]);
			child.addElement(data[u][14]);
			child.addElement(data[u][15]);
			mn.add(child);
     } 
   
	 
	request.setAttribute("table",mn);
	
  
  
 
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Ref No "   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Name" sortable="true" ><%=temp.elementAt(2)%></display:column>
                    <display:column title="Address" sortable="true" ><%=temp.elementAt(3)%></display:column>
                    <display:column title="Building" sortable="true" ><%=temp.elementAt(4)%></display:column>
                    <display:column title="Floor" sortable="true" ><%=temp.elementAt(5)%></display:column>
                    <display:column title="Purpose" sortable="true" ><%=temp.elementAt(6)%></display:column>
                    <display:column title="Whom to meet" sortable="true" ><%=temp.elementAt(7)%></display:column>
                    <display:column title="Date IN" sortable="true" ><%=temp.elementAt(8)%></display:column>
                    <display:column title="Time IN" sortable="true" ><%=temp.elementAt(9)%></display:column>
                    <display:column title="Date OUT" sortable="true" ><%=temp.elementAt(10)%></display:column>
                    <display:column title="Time OUT" sortable="true" ><%=temp.elementAt(11)%></display:column>
                    <display:column title="Vechile No" sortable="true" ><%=temp.elementAt(12)%></display:column>
                    <display:column title="Notification" sortable="true" ><%=temp.elementAt(13)%></display:column>
                    <display:column title="Mobile" sortable="true" ><%=temp.elementAt(14)%></display:column>
                    <display:column title="E-mail" sortable="true" ><%=temp.elementAt(15)%></display:column>
                    <display:column title="Creation date &amp; time" sortable="true" ><%=temp.elementAt(16)%></display:column>
                     
					<display:setProperty name="export.excel.filename" value="Rept_Visitor.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Visitor.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Visitor.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table>     
<br />	<center>	<a href='ManagementMain.jsp'> CLOSE</a>
</center>
 
	 		
			
			

 
</body>
<%
}
catch(Exception e)
{
}
%>
</html>
