 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<html>
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
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='ATT' ")[0][0]%></title>
  
 </head>




  
</head>
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
<body  onpaste='return false;'>
<%
String company= request.getParameter("company");
String branch= request.getParameter("branch");
String Office = request.getParameter("Office");
String dept= request.getParameter("dept");
String sorting = request.getParameter("sorting");
String ss = request.getParameter("ss");
 
String cpy="";
String bid="";
String off="";
String dep="";
String sql="";

 
sql=" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,c.CHR_DEPARTNAME,b.CHR_OFFICENAME , f.CHR_BRANCHNAME,g.CHR_COMPANYNAME, a.CHR_MOBILE,a.CHR_EMAILID,round(datediff(now(),a.DT_DOJCOLLEGE)/365) FROM com_m_staff a ,  com_m_office  b ,com_m_depart c , com_m_branch f , com_m_company g, com_m_staffaddressproof h  ";
sql = sql + " where a.CHR_HOLD!='Y'  ";
sql = sql + " AND a.CHR_TYPE!='T' ";
sql = sql + " AND a.INT_DEPARTID = c.INT_DEPARTID  ";
sql = sql + " AND a.INT_OFFICEID= b.INT_OFFICEID ";
sql = sql + " AND a.INT_BRANCHID =f.INT_BRANCHID ";
sql = sql + " AND a.INT_COMPANYID =g.INT_COMPANYID  AND a.CHR_EMPID = h.CHR_EMPID";
sql = sql + " AND h.IMG_IMAGE is null "  ;
if(!"0".equals(company))
	sql = sql + " AND a.INT_COMPANYID="+company;
	
if(!"0".equals(branch))
	sql = sql + " AND a.INT_BRANCHID="+branch;	
	
if(!"0".equals(Office))
	sql = sql + " AND a.INT_OFFICEID ="+Office;
	
if(!"0".equals(dept))
	sql = sql + "  AND a.INT_DEPARTID ="+dept;
	
sql = sql + " ORDER BY  "+ sorting +" "+ss;

	String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
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
			mn.add(child);
     } 
   
	 
	request.setAttribute("table",mn);
 	 
%>


   

<display:table   id="_table" name="table"    export="true">
	 
	 				<display:caption><%="PHOTO NOT AVAILABLE"%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Empid" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Department" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Company" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Mobile" sortable="true"><%=temp.elementAt(7)%></display:column>
					
				 
					
					<display:setProperty name="export.csv.filename" value="Rept_Photonotavailable.csv"/>
					<display:setProperty name="export.excel.filename" value="Rept_Photonotavailable.xls"/>
					<display:setProperty name="export.xml.filename" value="Rept_Photonotavailable.xml"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Photonotavailable.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table> 
	

  
 
			 


<br />
 
									<center>	<a href='Rept_Photonotavailable.jsp'> CLOSE</a></center>
</body>
</html>
