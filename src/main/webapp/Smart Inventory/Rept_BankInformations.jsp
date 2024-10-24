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
 <title>:: INVENTORY ::</title>

<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
  
   
</head>
<body >

<%
try
{
 		String reportheader="BANK INFORMATIONS"; 
		String sql =" SELECT  b.CHR_BANKGROUPNAME,a.CHR_BRANCH,a.CHR_BRANCHCODE,a.CHR_IFSCCODE,   ";
		sql = sql + " a.CHR_ADDRESS1,a.CHR_ADDRESS2,f.CHR_CITYNAME,e.CHR_DISTRICT,d.CHR_STATENAME,a.INT_PINCODE,   ";
		sql = sql + " a.CHR_MOBILE,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE   ";
		sql = sql + " FROM com_m_bank a  , com_m_bankgroup b,   ";
		sql = sql + " com_m_country c,com_m_state d,com_m_district e,  com_m_city f   ";
		sql = sql + " WHERE a.INT_BANKGROUPID=b.INT_BANKGROUPID   ";
		sql = sql + " AND a.INT_COUNTRYID = c.INT_COUNTRYID   ";
		sql = sql + " AND a.INT_STATEID =d.INT_STATEID      ";
		sql = sql + " AND a.INT_DISTRICTID= e.INT_DISTRICTID      ";
		sql = sql + " AND a.INT_CITYID =f.INT_CITYID    ";
		sql = sql + " ORDER BY a.CHR_BRANCH  ";

		Vector mn = new Vector();
	 	Vector child= null;
		String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				
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
				child.addElement(data[u][10]);
				child.addElement(data[u][11]);
				child.addElement(data[u][12]);
				child.addElement(data[u][13]);
				 mn.add(child); 
			}
		} 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="BANK BRANCH"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="BRANCH"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="BRANCH CODE"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="IFSC CODE"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="ADDRESS1"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="ADDRESS2"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="CITY"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="DISTRICT"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="STATE"   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="PINCODE"   sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="MOBILE"   sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="FAX"   sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="EMAIL"   sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="WEBSITE"   sortable="true"><%=temp.elementAt(14)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="Rept_Item.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Item.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Item.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>

