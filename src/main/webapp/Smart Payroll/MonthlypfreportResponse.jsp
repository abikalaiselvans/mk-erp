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
	//request.getParameterValues("type");
	
	String repmon = DateUtil.getMonth(Integer.parseInt( Month));
	
	 

	 
	
	sql ="SELECT a.CHR_EMPID,a.CHR_EMPNAME ,d.CHR_COMPANYNAME,e.CHR_BRANCHNAME,c.CHR_OFFICENAME, ";
	sql = sql +" CONCAT(d.CHR_PFNUMBER,b.CHR_PFNO),ROUND(a.DOU_BASIC),ROUND(a.DOU_PENBASIC),ROUND(a.DOU_PF), ";
	sql = sql +" ROUND(a.DOU_COMPANYPF),ROUND(a.DOU_COMPANYPENSION), ";
	sql = sql +" ROUND(a.DOU_ADMINCHARGE),ROUND(a.DOU_EDLI),ROUND(a.DOU_ADMINCHARGE1),DATE_FORMAT(b.DAT_PFESIDATE,'%d-%b-%Y'),ROUND(DOU_WORKDAYS), ";
	sql = sql +" CONCAT('Type-',b.CHR_PFCALCULATIONTYPE)";
	sql = sql +" FROM pay_t_salary a ,com_m_staff b, com_m_office  c,com_m_company d,com_m_branch e ";
	sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID ";
	sql = sql +" AND b.INT_OFFICEID = c.INT_OFFICEID ";
	sql = sql +" AND b.INT_COMPANYID=d.INT_COMPANYID ";
	sql = sql +" AND b.INT_BRANCHID=e.INT_BRANCHID AND a.CHR_PF !='N'  ";
	 
	sql = sql +" AND b.INT_COMPANYID=  "+company;
	if(!"0".equals(branch))
		sql = sql +" AND b.INT_BRANCHID=  "+branch;
	if(!"0".equals(Office))
		sql = sql +" AND b.INT_OFFICEID=  "+Office;
	sql = sql +" AND a.INT_YEAR= "+Year;
	sql = sql +" AND a.CHR_MONTH='"+repmon+"' ";
	 
	sql = sql +" ORDER BY b.CHR_PFNO ";  
	 //out.println(sql);
  
	String data[][] =  CommonFunctions.QueryExecute(sql);
	String cpdata[][] =  CommonFunctions.QueryExecute("SELECT upper(CHR_COMPANYNAME) FROM com_m_company where INT_COMPANYID =" +company);
	
	
	Vector mn = new Vector();
	Vector child= null;
	
	double sum1=0;
	double sum2=0;
	double sum3=0;
	double sum4=0;
	double sum5=0;
	double sum6=0;
	double sum7=0;
	double sum8=0;
    if(data.length>0)
	{
		for(int u=0;u<data.length;u++)
		{
			
			child = new Vector();
			child.addElement((u+1));
								
			 
			child.addElement(data[u][0]);
			child.addElement(data[u][1]);
			child.addElement(data[u][3]);
			child.addElement(data[u][4]);
			child.addElement(data[u][14]);
			child.addElement(data[u][5]);
			
			child.addElement(data[u][15]);
			child.addElement(data[u][6]);
			child.addElement(data[u][7]);
			child.addElement(data[u][8]);
			child.addElement(data[u][9]);
			child.addElement(data[u][10]);
			child.addElement(data[u][11]);
			child.addElement(data[u][12]);
			child.addElement(data[u][13]);
			child.addElement(data[u][16]);
			
			
			sum1 = sum1+Double.parseDouble(data[u][6]);
			sum2 = sum2+Double.parseDouble(data[u][7]);
			sum3 = sum3+Double.parseDouble(data[u][8]);
			sum4 = sum4+Double.parseDouble(data[u][9]);
			sum5 = sum5+Double.parseDouble(data[u][10]);
			sum6 = sum6+Double.parseDouble(data[u][11]);
			sum7 = sum7+Double.parseDouble(data[u][12]);
			sum8 = sum8+Double.parseDouble(data[u][13]);
			mn.add(child); 
		}
		 
		child = new Vector();  
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("Total");
		child.addElement(CommonFunctions.Round(sum1));
		child.addElement(CommonFunctions.Round(sum2));
		child.addElement(CommonFunctions.Round(sum3));
		child.addElement(CommonFunctions.Round(sum4));
		child.addElement(CommonFunctions.Round(sum5));
		child.addElement(CommonFunctions.Round(sum6));
		child.addElement(CommonFunctions.Round(sum7));
		child.addElement(CommonFunctions.Round(sum8));
		child.addElement("");
		mn.add(child); 
	}
	
	
	
	request.setAttribute("table",mn);
	out.println("<br><center><h3>  "+cpdata[0][0]+"  -  PF REPORT FOR THE MONTH OF "+repmon+"-"+Year+"&nbsp;&nbsp;&nbsp;");
	out.println("<a href='../SmartLoginAuth?filename=PF&actionS=PAYPFMonthly&company="+company+"&branch="+branch+"&Office="+Office+"&Month="+Month+"&Year="+Year+"' target='_blank'><img border='0' src='../images/icon_pdf.gif' width='47' height='49' /></a>");
	out.println(" </h3></center><br>");

%>
 	 
			
	<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.N0" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="PF Date of Joinning " sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="PF Number" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="No of Working Days" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="PF Wages" sortable="true"><%=temp.elementAt(8)%></display:column>
					
					<display:column title="Pen Wages " sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Employee Contri(12%)" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Employer PF Contri(3.67%)" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Employer Pension Contri(8.33%)" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Admin Charges(1.1%)" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="EDLI Charges(0.5%)" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="ADMIN Charges(0.01%)" sortable="true"><%=temp.elementAt(15)%></display:column>
					 <display:column title="PF TYPE" sortable="true"><%=temp.elementAt(16)%></display:column>
				 
					
					<display:setProperty name="export.csv.filename" value="Rept_MonthlyPF.csv"/>
					<display:setProperty name="export.excel.filename" value="Rept_MonthlyPF.xls"/>
					<display:setProperty name="export.xml.filename" value="Rept_MonthlyPF.xml"/>
					<display:setProperty name="export.pdf.filename" value="Rept_MonthlyPF.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     

<br />	<br /><br /><center>	<a href='Monthlypfreport.jsp'> CLOSE</a></center>
 
<br />	<br /><br />	 		
			
			
		
</body>
</html>
<%
}
catch(Exception e)
{

}
%>