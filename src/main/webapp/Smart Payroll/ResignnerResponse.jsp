<%
try
{
%>
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
<title> :: PAYROLL ::</title>


 
  


  
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>

<br>
<br>

<%
	String addsql="";
	String repName="";
	String repHeader="";
	String bankcondition="";
	String Office= request.getParameter("Office");
	String Dept= request.getParameter("dept");
	
	String fmdate= request.getParameter("frmdate");
	fmdate=DateUtil.FormateDateSQL(fmdate);
	String todate= request.getParameter("todate");
	todate=DateUtil.FormateDateSQL(todate);
	String orderby= request.getParameter("orderby");
	
		
	 String sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), ";
	 sql = sql +" DATE_FORMAT(b.DT_TERM_DATE,'%d-%b-%Y'),c.CHR_OFFICENAME,d.CHR_DESIGNAME,e.CHR_CATEGORYNAME,b.CHR_TER_TYPE,g.CHR_REASON1,g.CHR_REASON1, ";//ROUND(f.DOU_ORIGINALCTC) 
	  sql = sql +" CONCAT('Mythra/REL/',YEAR(b.DT_TERM_DATE),if(month(b.DT_TERM_DATE)<10,'0','')  ,  MONTH(DATE(b.DT_TERM_DATE)),'/',RIGHT(CONCAT('000000',b.INT_RESIGNID),6) )  refno , "  ;
	  
	  sql = sql + " CONCAT( ";
	sql = sql + " 		FLOOR(PERIOD_DIFF(DATE_FORMAT(b.DT_TERM_DATE,'%y%m') , DATE_FORMAT(a.DT_DOJCOLLEGE,'%y%m'))/12 ), ' - Years  / ' , ";
	sql = sql + " 		MOD(PERIOD_DIFF(DATE_FORMAT(b.DT_TERM_DATE,'%y%m') , DATE_FORMAT(a.DT_DOJCOLLEGE,'%y%m') ), 12) , ' - Months' ";
	sql = sql + " 		)  exper";
 

	 
	  sql = sql +" FROM   com_m_staff a, pay_m_emp_termination b ,  com_m_office  c ,com_m_desig d , com_m_employeecategory  e , pay_t_exitinterview g ";
	 sql = sql +" WHERE  a.INT_OFFICEID = c.INT_OFFICEID AND a.INT_DESIGID = d.INT_DESIGID AND a.CHR_CATEGORY = e.INT_EMPLOYEECATEGORYID  AND a.CHR_EMPID = b.CHR_EMPID  AND a.CHR_EMPID = g.CHR_EMPID ";
	// sql = sql +" pay_t_salary f ,AND a.CHR_EMPID = f.CHR_EMPID ";
	 //sql = sql +" AND f.CHR_MONTH = (select  MONTHNAME(DATE_FORMAT(DATE_SUB(b.DT_TERM_DATE, INTERVAL 1 MONTH),'%Y-%m-%d')) ) ";
	// sql = sql +" AND f.INT_YEAR = (select  YEAR(DATE_FORMAT(DATE_SUB(b.DT_TERM_DATE, INTERVAL 1 MONTH),'%Y-%m-%d')) ) ";
     sql = sql+" AND b.DT_TERM_DATE >= '"+fmdate+"' ";
	 sql = sql+" AND b.DT_TERM_DATE <= '"+todate+"' ";
	 
	 if(!"0".equals(Office))
		sql = sql+" AND a.INT_OFFICEID="+Office;
	 if(!"0".equals(Dept))
		sql = sql+" AND a.INT_DEPARTID= "+Dept;
	 sql = sql + " GROUP BY a.CHR_EMPID  ORDER BY "+orderby;
	//out.println(sql);
	
	 
    String data[][] =CommonFunctions.QueryExecute(sql);
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
			mn.add(child);
     } 
   
	repName =" RESIGNED LIST FROM :: "+DateUtil.FormateDateSys(fmdate)  + " TO ::"+DateUtil.FormateDateSys(todate);
	  
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+repName+" </h3></center><br>");
 
  
  
	 
	 
	 
	
	 
%>
 <display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Tag Number" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Category" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Designation" sortable="true"><%=temp.elementAt(6)%></display:column>
					
					<display:column title="Date of Joinning" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Resigned Date" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Experience" sortable="true"><%=temp.elementAt(12)%></display:column>
					
					<display:column title="RESIGNED TYPE" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="REASON" sortable="true"><%=temp.elementAt(10)%></display:column>
				     
					
					  
					
					<display:setProperty name="export.csv.filename" value="Resignner.csv"/>
					<display:setProperty name="export.excel.filename" value="Resignner.xls"/>
					<display:setProperty name="export.xml.filename" value="Resignner.xml"/>
					<display:setProperty name="export.pdf.filename" value="Resignner.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<br />	<center>	<a href='Resignner.jsp'> CLOSE</a></center>
 
	 		
			
 
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>