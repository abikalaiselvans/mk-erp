<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
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

<%
try
{

	String sql="";
	String company="";
	String branch="";
	String Office="";
	String cpy="";
	String bra="";
	String off="";
	String Month="";
	String Year="";
	company = ""+request.getParameter("company");
	branch = ""+request.getParameter("branch");
	 
	Month = ""+request.getParameter("month");
	Year = ""+request.getParameter("year");
	 
	
	String repmon = "";
sql = sql +" SELECT a.CHR_EMPID,a.CHR_STAFFFNAME,b.CHR_OFFICENAME,c.CHR_DEPARTNAME,  ";
sql = sql +" DATE_FORMAT(e.DAT_CREATIONTIME,'%d-%b-%Y %h:%m:%s'),DATE_FORMAT(e.DAT_INTERVIEWDATE,'%d-%b-%Y %h:%m:%s'),  ";
sql = sql +" datediff(e.DAT_INTERVIEWDATE,e.DAT_CREATIONTIME) exitage ,  ";
sql = sql +" DATE_FORMAT(d.DAT_STORE_DATE,'%d-%b-%Y %h:%m:%s'), datediff(d.DAT_CREATION_DATE,d.DAT_STORE_DATE) storeage,  ";
sql = sql +" DATE_FORMAT(d.DAT_ACCOUNTS_DATE,'%d-%b-%Y %h:%m:%s'),datediff(d.DAT_CREATION_DATE,d.DAT_ACCOUNTS_DATE) accountage,  ";
sql = sql +" DATE_FORMAT(d.DAT_GENERAL_DATE,'%d-%b-%Y %h:%m:%s'),datediff(d.DAT_CREATION_DATE,d.DAT_GENERAL_DATE)businessage,  ";
sql = sql +" DATE_FORMAT(d.DAT_FINAL_DATE,'%d-%b-%Y %h:%m:%s'),datediff(d.DAT_CREATION_DATE,d.DAT_FINAL_DATE) finalage   ";
sql = sql +" FROM com_m_staff a, com_m_office b, com_m_depart c, pay_t_emp_ndc d, ";
sql = sql +" pay_t_exitinterview e , pay_m_emp_termination f  ";
sql = sql +" WHERE a.INT_OFFICEID =b.INT_OFFICEID  ";
sql = sql +" AND a.INT_DEPARTID = c.INT_DEPARTID  ";
sql = sql +" AND a.CHR_EMPID = d.CHR_EMPID  ";
sql = sql +" AND a.CHR_EMPID = e.CHR_EMPID  ";
sql = sql +" AND a.CHR_EMPID = f.CHR_EMPID  ";
	sql = sql +" AND a.INT_COMPANYID=  "+company;
	if(!"0".equals(branch))
		sql = sql +" AND a.INT_BRANCHID=  "+branch;
	 
	sql = sql +" AND YEAR(f.DT_TERM_DATE) = "+Year;
	if(!"0".equals(Month))
	sql = sql +" AND MONTH(f.DT_TERM_DATE) = "+Month+"  ";
	 
	sql = sql +" ORDER BY a.CHR_STAFFFNAME ";  
	//out.println(sql);
  
	String data[][] =  CommonFunctions.QueryExecute(sql);
	String cpdata[][] =  CommonFunctions.QueryExecute("SELECT upper(CHR_COMPANYNAME) FROM com_m_company where INT_COMPANYID =" +company);
	
	
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
			child.addElement(data[u][10]);
			child.addElement(data[u][11]);
			child.addElement(data[u][12]);
			child.addElement(data[u][13]);
			child.addElement(data[u][14]);
			mn.add(child); 
		}
		 
		
	}
	
	
	
	request.setAttribute("table",mn);
	

%>
 	 
			
	<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.N0" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="ID " sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="NAME " sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="OFFICE" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="DEPARTMENT" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="CREATION " sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="EXIT INTERVIEW ATTENED" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="AGE" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="STORE ENTRY" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="STORE AGE" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="ACCOUNTS ENTRY" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="ACCOUNTS AGE" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="BUSINESS ENTRY" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="BUSINESS" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="FINAL" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="FINAL AGE" sortable="true"><%=temp.elementAt(15)%></display:column>
					 
					<display:setProperty name="export.csv.filename" value="NDC_Age.csv"/>
					<display:setProperty name="export.excel.filename" value="NDC_Age.xls"/>
					<display:setProperty name="export.xml.filename" value="NDC_Age.xml"/>
					<display:setProperty name="export.pdf.filename" value="NDC_Age.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     

<br />	<br /><br /><center>	<a href='NDC_Age.jsp'> CLOSE</a></center>
 
<br />	<br /><br />	 		
			
			
		
</body>
</html>
<%
}
catch(Exception e)
{

}
%>