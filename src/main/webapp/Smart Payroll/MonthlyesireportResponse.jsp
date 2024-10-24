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
	company = request.getParameter("company");
	branch = request.getParameter("branch");
	Office = request.getParameter("Office");
	Month = request.getParameter("Month");
	Year = request.getParameter("Year");
	String repmon = DateUtil.getMonth(Integer.parseInt( Month));
	
	
	sql ="SELECT a.CHR_EMPID,a.CHR_EMPNAME ,d.CHR_COMPANYNAME,e.CHR_BRANCHNAME,c.CHR_OFFICENAME, b.CHR_ESINO, ";
	sql = sql +" ROUND(a.DOU_GROSSPAY),ROUND(a.DOU_ESI),ROUND(a.DOU_CPYESI),FLOOR(a.DOU_WORKDAYS) ";
	sql = sql +" FROM pay_t_salary a ,com_m_staff b, com_m_office  c,com_m_company d,com_m_branch e ";
	sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID ";
	sql = sql +" AND b.INT_OFFICEID = c.INT_OFFICEID ";
	sql = sql +" AND b.INT_COMPANYID=d.INT_COMPANYID ";
	sql = sql +" AND b.INT_BRANCHID=e.INT_BRANCHID   AND b.CHR_ESI='C' ";
	if(!"0".equals(company))
		sql = sql +"  AND b.INT_COMPANYID=  "+company;
	if(!"0".equals(branch))
		sql = sql +"  AND b.INT_BRANCHID=  "+branch;
	if(!"0".equals(Office))
		sql = sql +"  AND b.INT_OFFICEID=  "+Office;
	
	 
	sql = sql +" AND a.INT_YEAR= "+Year;
	sql = sql +" AND a.CHR_MONTH='"+repmon+"' ";
	sql = sql +" ORDER BY a.CHR_EMPNAME ";
	//out.println(sql);
	String data[][] = CommonFunctions.QueryExecute(sql);
	String cpdata[][] = CommonFunctions.QueryExecute("SELECT upper(CHR_COMPANYNAME) FROM com_m_company where INT_COMPANYID =" +company);
	
	Vector mn = new Vector();
	Vector child= null;
	if(data.length>0)
	{
		double sum1=0;
		double sum2=0;
		double sum3=0;
		double x=0.0;
		for(int u=0;u<data.length;u++)
		{
			x=Double.parseDouble(data[u][7]);
			child = new Vector();
			child.addElement((u+1));
			child.addElement(data[u][0]);
			child.addElement(data[u][1]);
			child.addElement(data[u][3]);
			child.addElement(data[u][4]);
			child.addElement(data[u][5]);
			child.addElement(data[u][9]);
			child.addElement(data[u][6]);
			child.addElement(data[u][7]);
			child.addElement(data[u][8]);
			sum1 = sum1+Double.parseDouble(data[u][6]);
			sum2 = sum2+Double.parseDouble(data[u][7]);
			sum3 = sum3+Double.parseDouble(data[u][8]);
			mn.add(child); 
		}	
		 
		child = new Vector();  
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("Total");
		child.addElement(((long)(sum1)));
		child.addElement( ( (long)(sum2)));
		child.addElement(((long) (sum3)));
	 	mn.add(child);  
	}	
	request.setAttribute("table",mn);
	out.println("<br><center><h3>  "+cpdata[0][0]+"  -   ESI REPORT FOR THE MONTH OF "+repmon+"-"+Year+" </h3></center><br>");
%>
 			
	<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.N0" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title=" ESI Number " sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column  style="text-align:right" title="No of Working Days" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column  style="text-align:right" title="Wages" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column  style="text-align:right" title="Employee ESI(1.75%)" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column  style="text-align:right" title="Employer ESI(4.75%)" sortable="true"><%=temp.elementAt(9)%></display:column>
					  
			 
					
					<display:setProperty name="export.csv.filename" value="Reot_MonthlyESIreport.csv"/>
					<display:setProperty name="export.excel.filename" value="Reot_MonthlyESIreport.xls"/>
					<display:setProperty name="export.xml.filename" value="Reot_MonthlyESIreport.xml"/>
					<display:setProperty name="export.pdf.filename" value="Reot_MonthlyESIreport.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     

<br />	<br /><br /><center>	<a href='MonthlyESIreport.jsp'> CLOSE</a></center>
 
<br />	<br /><br />	 		
			
			
		
</body>
</html>
<%
	
}
catch(Exception e)
{
	out.println(e.getMessage());
}	
%>
 
</body>
</html>
