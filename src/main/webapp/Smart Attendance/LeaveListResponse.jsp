<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
   
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
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
<title> :: ATTENDANCE ::</title>
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
 <body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%
try
{
%>
 
<%
	 
String company = request.getParameter("company");
String branch = request.getParameter("branch");
String Office = request.getParameter("Office");
String dept = request.getParameter("dept");
String year = request.getParameter("year");

String reportheader="";
   if(!"0".equals(company))
		reportheader=reportheader+" <b>Company ::</b> "+CommonFunctions.QueryExecute("SELECT CHR_COMPANYNAME FROM  com_m_company  WHERE INT_COMPANYID="+company)[0][0];
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
	
	 
 	
String sql = "";

sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME, DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y'),  n.CHR_OFFICENAME,o.CHR_DEPARTNAME, ";
sql = sql + " ( SELECT SUM(b.DOU_VALUE)  FROM att_t_leave b    WHERE  a.CHR_EMPID = b.CHR_EMPID AND YEAR(b.DT_LDATE) = "+year+" AND MONTHNAME(b.DT_LDATE)='January' GROUP BY MONTHNAME(b.DT_LDATE)), ";

sql = sql + " ( SELECT SUM(c.DOU_VALUE)  FROM att_t_leave c    WHERE  a.CHR_EMPID = c.CHR_EMPID AND YEAR(c.DT_LDATE) =  "+year+"  AND MONTHNAME(c.DT_LDATE)='February' GROUP BY MONTHNAME(c.DT_LDATE)), ";

sql = sql + " ( SELECT SUM(d.DOU_VALUE)  FROM att_t_leave d    WHERE  a.CHR_EMPID = d.CHR_EMPID AND YEAR(d.DT_LDATE) =  "+year+"  AND MONTHNAME(d.DT_LDATE)='March' GROUP BY MONTHNAME(d.DT_LDATE)), ";

sql = sql + " ( SELECT SUM(e.DOU_VALUE)  FROM att_t_leave e    WHERE  a.CHR_EMPID = e.CHR_EMPID AND YEAR(e.DT_LDATE) =  "+year+"  AND MONTHNAME(e.DT_LDATE)='April' GROUP BY MONTHNAME(e.DT_LDATE)), ";

sql = sql + " ( SELECT SUM(f.DOU_VALUE)  FROM att_t_leave f   WHERE  a.CHR_EMPID = f.CHR_EMPID AND YEAR(f.DT_LDATE) =  "+year+"  AND MONTHNAME(f.DT_LDATE)='May' GROUP BY MONTHNAME(f.DT_LDATE)),  ";
 
sql = sql + " ( SELECT SUM(g.DOU_VALUE)  FROM att_t_leave g    WHERE  a.CHR_EMPID = g.CHR_EMPID AND YEAR(g.DT_LDATE) =  "+year+"  AND MONTHNAME(g.DT_LDATE)='June' GROUP BY MONTHNAME(g.DT_LDATE)),  ";
 
sql = sql + " ( SELECT SUM(h.DOU_VALUE)  FROM att_t_leave h    WHERE  a.CHR_EMPID = h.CHR_EMPID AND YEAR(h.DT_LDATE) =  "+year+"  AND MONTHNAME(h.DT_LDATE)='July' GROUP BY MONTHNAME(h.DT_LDATE)),  ";
  
sql = sql + " ( SELECT SUM(i.DOU_VALUE)  FROM att_t_leave i   WHERE  a.CHR_EMPID = i.CHR_EMPID AND YEAR(i.DT_LDATE) =  "+year+"  AND MONTHNAME(i.DT_LDATE)='August' GROUP BY MONTHNAME(i.DT_LDATE)),  ";
  
  
sql = sql + " ( SELECT SUM(j.DOU_VALUE)  FROM att_t_leave j   WHERE  a.CHR_EMPID = j.CHR_EMPID AND YEAR(j.DT_LDATE) =  "+year+"  AND MONTHNAME(j.DT_LDATE)='September' GROUP BY MONTHNAME(j.DT_LDATE)),  ";
  
    
sql = sql + " ( SELECT SUM(k.DOU_VALUE)  FROM att_t_leave k   WHERE  a.CHR_EMPID = k.CHR_EMPID AND YEAR(k.DT_LDATE) =  "+year+"  AND MONTHNAME(k.DT_LDATE)='October' GROUP BY MONTHNAME(k.DT_LDATE)),  ";
  
  
sql = sql + " ( SELECT SUM(l.DOU_VALUE)  FROM att_t_leave l   WHERE  a.CHR_EMPID = l.CHR_EMPID AND YEAR(l.DT_LDATE) =  "+year+"  AND MONTHNAME(l.DT_LDATE)='November' GROUP BY MONTHNAME(l.DT_LDATE)), "; 
  
   
sql = sql + " ( SELECT SUM(m.DOU_VALUE)  FROM att_t_leave m   WHERE  a.CHR_EMPID = m.CHR_EMPID AND YEAR(m.DT_LDATE) =  "+year+"  AND MONTHNAME(m.DT_LDATE)='December' GROUP BY MONTHNAME(m.DT_LDATE))  , "; 

sql = sql + "  SUM(p.INT_NOD1+p.INT_NOD2+p.INT_NOD3+p.INT_NOD4+p.INT_NOD5+p.INT_NOD6+p.INT_NOD7+p.INT_NOD8+p.INT_NOD9), ";
 
sql = sql + "  ( SELECT SUM(q.DOU_VALUE)  FROM att_t_leave q WHERE  a.CHR_EMPID = q.CHR_EMPID AND YEAR(q.DT_LDATE) = "+year+"  GROUP BY YEAR(q.DT_LDATE))  ,  ";

sql = sql + "  (  ";
sql = sql + "  ( SUM(p.INT_NOD1+p.INT_NOD2+p.INT_NOD3+p.INT_NOD4+p.INT_NOD5+p.INT_NOD6+p.INT_NOD7+p.INT_NOD8+p.INT_NOD9))   ";
sql = sql + "   -  ";
sql = sql + "  ( SELECT SUM(s.DOU_VALUE)  FROM att_t_leave s  ";
sql = sql + "  WHERE  a.CHR_EMPID = s.CHR_EMPID AND YEAR(s.DT_LDATE) = "+year+"  GROUP BY YEAR(s.DT_LDATE)  ";
sql = sql + "   )     ";
sql = sql + "  )   "; 
  
	  
sql = sql + " FROM com_m_staff a ,com_m_office   n ,com_m_depart o ,att_m_leave p ";
sql = sql + " WHERE a.INT_OFFICEID = n.INT_OFFICEID AND a.INT_DEPARTID = o.INT_DEPARTID ";
sql = sql + " AND a.CHR_EMPID=p.CHR_EMPID AND p.INT_YEAR="+year+" GROUP BY p.CHR_EMPID ORDER BY a.CHR_STAFFNAME ";

if(!"-1".equals(company))
	sql = sql + " AND a.INT_COMPANYID  = "+company;
			
if(!"-1".equals(branch))
	sql = sql + " AND a.INT_OFFICEID ="+branch;
	
if(!"0".equals(Office))
	sql = sql + " AND a.INT_OFFICEID="+Office;


 
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
			child.addElement(data[u][13]);
			child.addElement(data[u][14]);
			child.addElement(data[u][15]);
			child.addElement(data[u][16]);
			child.addElement(data[u][17]);
			child.addElement(data[u][18]);
			child.addElement(data[u][19]);
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
					<display:column title="DOJ" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="OFFICE" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="DEPT" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="JAN" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="FEB" sortable="true"><%=temp.elementAt(7)%></display:column>
					 <display:column title="MAR" sortable="true"><%=temp.elementAt(8)%></display:column>
					
					 <display:column title="APR" sortable="true"><%=temp.elementAt(9)%></display:column>
					 <display:column title="MAY" sortable="true"><%=temp.elementAt(10)%></display:column>
					 <display:column title="JUN" sortable="true"><%=temp.elementAt(11)%></display:column>
					 <display:column title="JUL" sortable="true"><%=temp.elementAt(12)%></display:column>
					 <display:column title="AUG" sortable="true"><%=temp.elementAt(13)%></display:column>
					 <display:column title="SEP" sortable="true"><%=temp.elementAt(14)%></display:column>
					 <display:column title="OCT" sortable="true"><%=temp.elementAt(15)%></display:column>
					 <display:column title="NOV" sortable="true"><%=temp.elementAt(16)%></display:column>
					 <display:column title="DEC" sortable="true"><%=temp.elementAt(17)%></display:column>
					 <display:column title="TOTAL" sortable="true"><%=temp.elementAt(18)%></display:column>
					 <display:column title="LEAVE TAKEN" sortable="true"><%=temp.elementAt(19)%></display:column>
					 <display:column title="LEAVE ELIGIBILTY" sortable="true"><%=temp.elementAt(20)%></display:column>
					 
					
					<display:setProperty name="export.csv.filename" value="LeaveList.csv"/>
					<display:setProperty name="export.excel.filename" value="LeaveList.xls"/>
					<display:setProperty name="export.xml.filename" value="LeaveList.xml"/>
					<display:setProperty name="export.pdf.filename" value="LeaveList.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<br />	<center>	<a href='LeaveList.jsp'> CLOSE</a></center>
 
	  
   
 
  
 
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</body>