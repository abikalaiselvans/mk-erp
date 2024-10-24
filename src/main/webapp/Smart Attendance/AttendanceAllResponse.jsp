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
 
String Office = request.getParameter("Office");
String dept = request.getParameter("dept");
String month = request.getParameter("month");
String year = request.getParameter("year");
String umonth=DateUtil.getMonth(Integer.parseInt(month));
String Present = request.getParameter("Present");
String Onduty = request.getParameter("Onduty");
String Sunday = request.getParameter("Sunday");
String Holiday = request.getParameter("Holiday");
String Leave = request.getParameter("Leave");
String Absent = request.getParameter("Absent");
String Late = request.getParameter("Late");
String Permission = request.getParameter("Permission");
String Extraday = request.getParameter("Extraday");
String Extrahours = request.getParameter("Extraday");
String totaldays = request.getParameter("Extraday");
String Allday = request.getParameter("Allday");
String sorting = request.getParameter("sorting");
String ss = request.getParameter("ss");
 
 
 
String sql="SELECT  a.CHR_EMPID ,b.CHR_STAFFNAME, a.DOU_PRESENT ,a.DOU_ONDUTY ,a.DOU_SUNDAY , a.DOU_HOLIDAY , a.DOU_LEAVE ,a.DOU_ABSENT ,a.INT_LATE ,a.INT_PERMISSION ,a.DOU_EXTRADAYS ,a.DOU_EXTRAHOURS ,a.DOU_TOTALDAYS  ";
 
 sql = sql+" From att_t_register a, com_m_staff b ";
 sql = sql+" WHERE a.INT_YEAR="+year+" AND a.CHR_EMPID = b.CHR_EMPID  " ;
 if(!"0".equals(Office))
	 sql = sql+"   AND b.INT_OFFICEID= "+Office;
if(!"0".equals(dept))
	sql = sql+"   AND b.INT_DEPARTID= "+dept;	
 sql = sql+" AND a.CHR_MONTH ='"+umonth+"' ORDER BY "+ sorting +" "+ss;
 
  
 
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
	out.println("<br><center><h3> ATTENDANCE </h3></center><br>");	 
		  
%>
	 
 <display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="ID" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="NAME" sortable="true"><%=temp.elementAt(2)%></display:column>
					<%
					if("on".equals(Present))
					{
					%>
					<display:column title="PRESENT" sortable="true"><%=temp.elementAt(3)%></display:column>
					<%
					}
					%>
					
					
					
					<%
					if("on".equals(Onduty))
					{
					%>
					 <display:column title="ONDUTY" sortable="true"><%=temp.elementAt(4)%></display:column>
					<%
					}
					%>
					
					<%
					if("on".equals(Sunday))
					{
					%>
					 <display:column title="SUNDAY" sortable="true"><%=temp.elementAt(5)%></display:column>
					<%
					}
					%>
					
					
					<%
					if("on".equals(Holiday))
					{
					%>
					 <display:column title="HOLIDAY" sortable="true"><%=temp.elementAt(6)%></display:column>
					<%
					}
					%>
					
					
					<%
					if("on".equals(Leave))
					{
					%>
					 <display:column title="LEAVE" sortable="true"><%=temp.elementAt(7)%></display:column>
					<%
					}
					%>
					
					
					<%
					if("on".equals(Absent))
					{
					%>
					 <display:column title="ABSENT" sortable="true"><%=temp.elementAt(8)%></display:column>
					<%
					}
					%>
					
					
					<%
					if("on".equals(Late))
					{
					%>
					 <display:column title="LATE " sortable="true"><%=temp.elementAt(9)%></display:column>
					<%
					}
					%>
					
					<%
					if("on".equals(Permission))
					{
					%>
					 <display:column title="PERMISSION" sortable="true"><%=temp.elementAt(10)%></display:column>
					<%
					}
					%>
					
					
					<%
					if("on".equals(Extraday))
					{
					%>
					 <display:column title="EXTRADAYS" sortable="true"><%=temp.elementAt(11)%></display:column>
					<%
					}
					%>
					
					
					<%
					if("on".equals(Extrahours))
					{
					%>
					 <display:column title="EXTRAHOURS" sortable="true"><%=temp.elementAt(12)%></display:column>
					<%
					}
					%>
					
					<%
					if("on".equals(totaldays))
					{
					%>
					 <display:column title="TOTALS" sortable="true"><%=temp.elementAt(13)%></display:column>  
					<%
					}
					%>
					
					 
					
					<display:setProperty name="export.csv.filename" value="AttendanceAll.csv"/>
					<display:setProperty name="export.excel.filename" value="AttendanceAll.xls"/>
					<display:setProperty name="export.xml.filename" value="AttendanceAll.xml"/>
					<display:setProperty name="export.pdf.filename" value="AttendanceAll.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>      

<br />
 
									<center>	<a href='AttendanceAll.jsp'> CLOSE</a></center>