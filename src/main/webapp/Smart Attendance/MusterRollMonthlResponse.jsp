<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
   
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%><head>
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
<title> :: ATTENDANCE ::</title>


  


  
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<%
 
	String reportheader="";
	String cmpy=request.getParameter("company");
	String Office = request.getParameter("Office");
	String dept = request.getParameter("dept");
	String month = request.getParameter("month");
	String year = request.getParameter("year");
	String umonth=DateUtil.getMonth(Integer.parseInt(month));
	reportheader=reportheader+" <b> Muster Roll Report For </b> "+umonth+"-"+year;
	String sorting = request.getParameter("sorting");
	String ss = request.getParameter("ss");
	
	String sql="SELECT  a.CHR_EMPID ,b.CHR_STAFFNAME, ";
	sql = sql+" a.DOU_PRESENT ,"  ;
	sql = sql+" a.DOU_ONDUTY ,"  ;
	sql = sql+" a.DOU_SUNDAY ,"  ;
	sql = sql+" a.DOU_HOLIDAY ,"  ;
	sql = sql+" a.DOU_LEAVE ,"  ;
	sql = sql+" a.DOU_ABSENT ,"  ;
	sql = sql+" a.INT_LATE ,"  ;
	sql = sql+" a.INT_PERMISSION ,"  ;
	sql = sql+" a.DOU_EXTRADAYS ,"  ;
	sql = sql+" a.DOU_EXTRAHOURS ,"  ;
	sql = sql+" a.DOU_TOTALDAYS  "  ;
	
	sql = sql+" From att_t_register a, com_m_staff b ";
	 sql = sql+" WHERE a.INT_YEAR="+year+" AND a.CHR_EMPID = b.CHR_EMPID  ";
	    
	 if(!"0".equals(cmpy))
		sql=sql+" AND b.INT_COMPANYID= "+cmpy;
	
	if(!"0".equals(Office))	
		sql=sql+"  AND b.INT_OFFICEID= "+Office;
	
	if(!"0".equals(dept))
		sql=sql+"   AND b.INT_DEPARTID= "+dept;
		
	 
	 
	 
	 sql = sql+" AND a.CHR_MONTH ='"+umonth+"' ORDER BY "+ sorting +" "+ss;
	
	
	if(!"0".equals(cmpy))
		reportheader=reportheader+" <b>Company ::</b> "+CommonFunctions.QueryExecute("SELECT CHR_COMPANYNAME FROM  com_m_company  WHERE INT_COMPANYID="+cmpy)[0][0];
	else
		reportheader=reportheader+" <b>Company ::</b> ALL ";
	
	if(!"0".equals(Office))
		reportheader=reportheader+" <b>Office ::</b> "+CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME FROM   com_m_office   WHERE INT_OFFICEID="+Office)[0][0];
	else
		reportheader=reportheader+" <b>Office ::</b> ALL ";
	
	
	if(!"0".equals(dept))
		reportheader=reportheader+" <b>Department ::</b> "+CommonFunctions.QueryExecute("SELECT CHR_DEPARTNAME FROM  com_m_depart  WHERE INT_DEPARTID="+dept)[0][0];
	else
		reportheader=reportheader+" <b>Department ::</b> ALL ";
	
	
	
 
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
			child.addElement(data[u][9]);
			child.addElement(data[u][10]);
			child.addElement(data[u][11]);
			child.addElement(data[u][12]);
			mn.add(child);
     } 
   
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center><br>");	 
		  
%>
	 
 <display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="ID" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="NAME" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="PRESENT" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="ONDUTY" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="SUNDAY" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="HOLIDAY" sortable="true"><%=temp.elementAt(6)%></display:column>
					 <display:column title="LEAVE" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="ABSENT" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="LATE " sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="PERMISSION" sortable="true"><%=temp.elementAt(10)%></display:column>
					 <display:column title="EXTRADAYS" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="EXTRAHOURS" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="TOTALS" sortable="true"><%=temp.elementAt(13)%></display:column>  
					
					 
					
					<display:setProperty name="export.csv.filename" value="MusterRollMonth.csv"/>
					<display:setProperty name="export.excel.filename" value="MusterRollMonth.xls"/>
					<display:setProperty name="export.xml.filename" value="MusterRollMonth.xml"/>
					<display:setProperty name="export.pdf.filename" value="MusterRollMonth.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>      

<br />
 
									<center>	<a href='MusterRollMonth.jsp'> CLOSE</a></center>