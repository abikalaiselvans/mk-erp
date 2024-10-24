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
 
<title> :: COMMON ::</title>




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
 

 	 String reportheader="SERVICE CARD COUNT LIST ";
	 String company = request.getParameter("company");
	 String branch = request.getParameter("branch");
	 String Office = request.getParameter("Office");
	 String dept = request.getParameter("dept");
	 String fdate = request.getParameter("fdate");
	 String tdate = request.getParameter("tdate");
	 String category = request.getParameter("category");
	 String resigned = request.getParameter("resigned");
	 
 	 String sql="";
 	 sql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'), b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, d.CHR_OFFICENAME, e.CHR_DEPARTNAME,f.CHR_DESIGNAME,a.CHR_GENDER,  ";
	 sql = sql +" DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), g.CHR_CATEGORYNAME, ";
	 sql = sql + " IF(a.CHR_TYPE ='T','RESIGNED','LIVE'), DATE_FORMAT(a.DT_CREATION_DATE,'%d-%b-%Y %h:%m:%s %p'),";
	 sql = sql + " IF(a.INT_MODIFICATION_COUNT = '0','No','Yes') ";
	 sql = sql +" FROM  com_m_staff a,com_m_company b,com_m_branch c,com_m_office d,com_m_depart e,com_m_desig f , com_m_employeecategory g  ";
	
	 sql = sql +" WHERE a.INT_COMPANYID= b.INT_COMPANYID  ";
	 sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID  ";
	 sql = sql +" AND a.INT_OFFICEID=d.INT_OFFICEID  ";
	 sql = sql +" AND a.INT_DEPARTID= e.INT_DEPARTID  ";
     sql = sql +" AND a.CHR_CATEGORY = g.INT_EMPLOYEECATEGORYID ";
	 sql = sql +" AND a.INT_DESIGID = f.INT_DESIGID   ";
	 if(!"0".equals(company))
	 	sql = sql +" AND a.INT_COMPANYID="+company;
	 if(!"0".equals(branch))
	 	sql = sql +" AND a.INT_BRANCHID="+branch;
	 if(!"0".equals(Office))
	 	sql = sql +" AND a.INT_OFFICEID="+Office;
	 if(!"0".equals(dept))
	 	sql = sql +" AND a.INT_DEPARTID="+dept;
	 if(!"0".equals(category))
		 	sql = sql +" AND a.a.CHR_GATEGORY ="+category;

	 if(!"0".equals(resigned))
	 	if("N".equals(resigned))
		 	sql = sql +" AND  a.CHR_TYPE !='T'  ";
		
   	 sql = sql +" AND a.DT_CREATION_DATE >= '"+DateUtil.FormateDateSQL(fdate)+"'";
	 sql = sql +" AND a.DT_CREATION_DATE <= '"+DateUtil.FormateDateSQL(tdate)+"'";
	 sql = sql +" ORDER BY a.DT_CREATION_DATE ";
	 //out.println(sql); 
 	 
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
			mn.add(child);
     } 
	request.setAttribute("table",mn);
%>
 
<display:table   id="_table" name="table"   export="true" pagesize="25">
        <display:caption><%=reportheader.toUpperCase()%></display:caption>
        <display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
        <display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
        <display:column title="EMP ID" sortable="true"><%=temp.elementAt(1)%></display:column>
        <display:column title="EMP NAME" sortable="true"><%=temp.elementAt(2)%></display:column>
        <display:column title="FATHER NAME" sortable="true"><%=temp.elementAt(3)%></display:column>
        <display:column title="DOB" sortable="true"><%=temp.elementAt(4)%></display:column>
        <display:column title="COMPANY" sortable="true"><%=temp.elementAt(5)%></display:column>
        <display:column title="BRANCH" sortable="true"><%=temp.elementAt(6)%></display:column>
        <display:column title="OFFICE" sortable="true"><%=temp.elementAt(7)%></display:column>
        <display:column title="DEPARTMENT" sortable="true"><%=temp.elementAt(8)%></display:column>
        <display:column title="DESIGNATION" sortable="true"><%=temp.elementAt(9)%></display:column>
        <display:column title="GENDER" sortable="true"><%=temp.elementAt(10)%></display:column>
        <display:column title="CATEGORY" sortable="true"><%=temp.elementAt(12)%></display:column>
        <display:column title="LIVE" sortable="true"><%=temp.elementAt(13)%></display:column>
        <display:column title="DOJ" sortable="true"><%=temp.elementAt(11)%></display:column>
        <display:column title="CREATION DATE" sortable="true"><%=temp.elementAt(14)%></display:column>
        <display:column title="Modification" sortable="true"><%=temp.elementAt(15)%></display:column>
        
        <display:setProperty name="export.excel.filename" value="Rept_Servicecardcount.xls"/>
        <display:setProperty name="export.pdf.filename" value="Rept_Servicecardcount.pdf"/>
        <display:setProperty name="export.csv.filename" value="Rept_Servicecardcount.csv"/>
        <display:setProperty name="export.pdf"  value="true" />
         
</display:table>     
<br />	<center>	<a href='Rept_Staff.jsp'> CLOSE</a></center>
 
	 		
			
			

 
</body>
<%
}
catch(Exception e)
{
}
%>
 
