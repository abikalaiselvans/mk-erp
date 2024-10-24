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
<title> :: PAYROLL ::</title>


 
  

 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <body  onpaste='return false;'>
<p>
  
  <br><br><br><br><br>

<%
try
{


		String company =""+request.getParameter("company");
		String branch=""+request.getParameter("branch");
		String Office=""+request.getParameter("Office");
		String dept=""+request.getParameter("dept");
		String Report = ""+request.getParameter("Report");
		String year = ""+request.getParameter("year");
		if("null".equals(year))
			year="0";
		 
		
		int yr= Integer.parseInt(year);
		String sql =""; 
		sql = " SELECT b.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_COMPANYNAME,d.CHR_BRANCHNAME, ";
		sql = sql + " e.CHR_DEPARTNAME,f.CHR_OFFICENAME,g.CHR_CATEGORYNAME    ";
		sql = sql + " FROM com_m_staff b ,com_m_company c,com_m_branch d ,com_m_depart e , com_m_office  f, com_m_employeecategory  g  ";
		sql = sql + "WHERE b.INT_COMPANYID =c.INT_COMPANYID AND b.INT_BRANCHID=d.INT_BRANCHID AND b.INT_DEPARTID=e.INT_DEPARTID";
		sql = sql + " AND b.INT_OFFICEID= f.INT_OFFICEID   AND b.CHR_CATEGORY = g.INT_EMPLOYEECATEGORYID";
		  
		
		if(!"-1".equals(company))
			sql = sql+" AND b.INT_COMPANYID ="+ company;
			
		if(!"-1".equals(branch))
			sql = sql+" AND b.INT_BRANCHID ="+ branch;
			
		if(!"0".equals(dept))
			sql = sql+" AND b.INT_DEPARTID ="+ dept;
			
		if(!"0".equals(Office))
			sql = sql+" AND b.INT_OFFICEID ="+ Office;
			
		sql = sql + " ORDER BY b.CHR_STAFFNAME  ";	
	
	
	
		 
 
		//out.println(sql);
		String empdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		String month="";
		if("A".equals(Report))
			month="April,May,June,July,August, September";
		else
			month="October,November,December,January,February, March";	
			
		String monthname[] = month.split(",");
		
		
		
		
		double  sum=0;
		double sum1=0;
	
		
		 Vector mn = new Vector();
	 Vector child= null;
		
		for(int u=0;u<empdata.length;u++) 
			{
				
				child = new Vector();
				child.addElement((u+1));
			     sum=0;
				child.addElement(empdata[u][0]);
				child.addElement(empdata[u][1]);
				child.addElement(empdata[u][2]);
				child.addElement(empdata[u][3]);
				child.addElement(empdata[u][4]);
				child.addElement(empdata[u][5]);
				child.addElement(empdata[u][6]);
				sql="";
				if("A".equals(Report))
				{
						sql = " SELECT ";
						sql=sql+"(SELECT DOU_PAYTAX FROM pay_t_salary WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='April' AND INT_YEAR="+year+"), ";
						sql=sql+"(SELECT DOU_PAYTAX FROM pay_t_salary WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='May' AND INT_YEAR="+year+"), ";
						sql=sql+"(SELECT DOU_PAYTAX FROM pay_t_salary WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='June' AND INT_YEAR="+year+"), ";
						sql=sql+"(SELECT DOU_PAYTAX FROM pay_t_salary WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='July' AND INT_YEAR="+year+"), ";
						sql=sql+"(SELECT DOU_PAYTAX FROM pay_t_salary WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='August' AND INT_YEAR="+year+"), ";
						sql=sql+"(SELECT DOU_PAYTAX FROM pay_t_salary WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='September' AND INT_YEAR="+year+") ";

				}
				else
				{
  
						sql = " SELECT ";
						sql=sql+"(SELECT DOU_PAYTAX FROM pay_t_salary WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='October' AND INT_YEAR="+year+"), ";
						sql=sql+"(SELECT DOU_PAYTAX FROM pay_t_salary WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='November' AND INT_YEAR="+year+"), ";
						sql=sql+"(SELECT DOU_PAYTAX FROM pay_t_salary WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='December' AND INT_YEAR="+year+"), ";
						sql=sql+"(SELECT DOU_PAYTAX FROM pay_t_salary WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='January' AND INT_YEAR="+(yr+1)+"), ";
						sql=sql+"(SELECT DOU_PAYTAX FROM pay_t_salary WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='February' AND INT_YEAR="+(yr+1)+"), ";
						sql=sql+"(SELECT DOU_PAYTAX FROM pay_t_salary WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='March' AND INT_YEAR="+(yr+1)+") ";
						
											
				}
				
				String ptdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				for(int m=0;m<1;m++)
				{
					child.addElement(ptdata[m][0]);
					child.addElement(ptdata[m][1]);
					child.addElement(ptdata[m][2]);
					child.addElement(ptdata[m][3]);
					child.addElement(ptdata[m][4]);
					child.addElement(ptdata[m][5]);
					
					if(!"-".equals(ptdata[m][0]))  	
						sum = sum+Double.parseDouble(ptdata[m][0]); 
					
					if(!"-".equals(ptdata[m][1]))  	
						sum = sum+Double.parseDouble(ptdata[m][1]); 
						
					if(!"-".equals(ptdata[m][2]))  	
						sum = sum+Double.parseDouble(ptdata[m][2]); 
						
					if(!"-".equals(ptdata[m][3]))  	
						sum = sum+Double.parseDouble(ptdata[m][3]); 
						
					if(!"-".equals(ptdata[m][4]))  	
						sum = sum+Double.parseDouble(ptdata[m][4]); 
					
					if(!"-".equals(ptdata[m][5]))  	
						sum = sum+Double.parseDouble(ptdata[m][5]); 
					
					child.addElement(sum); 
					child.addElement(sum); 
					
				}	
				sum1 = sum1+sum;
				mn.add(child);
				
				
			}
		
		
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> PROFESSIONAL TAX REPORT    </h3></center><br>");
 
 
		 
		 
		 
		 
		 
		 
%>


<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Company" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Department" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Category" sortable="true"><%=temp.elementAt(7)%></display:column>
					<%
					
					for(int m=0;m<monthname.length;m++)
					{
					%>
					<display:column title="<%=monthname[m]%>" sortable="true"><%=temp.elementAt((m+1)+7)%></display:column>
					<%
					}
					%>
					
					 <display:column title="Total" sortable="true"><%=temp.elementAt(monthname.length+8)%></display:column>
					<display:column title="P.T. Amount" sortable="true"><%=temp.elementAt(monthname.length+9)%></display:column>
					 
				 
					
					<display:setProperty name="export.csv.filename" value="PTReport.csv"/>
					<display:setProperty name="export.excel.filename" value="PTReport.xls"/>
					<display:setProperty name="export.xml.filename" value="PTReport.xml"/>
					<display:setProperty name="export.pdf.filename" value="PTReport.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<br />	<center>	<a href='PTReport.jsp'> CLOSE</a></center>
 
	 		
<%		 
}
catch(Exception e)
{

	out.println(e.getMessage());
}
%>
</body>
</html>
