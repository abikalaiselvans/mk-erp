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
<title>-</title>

<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
  
   
</head>
<body >

<%
try
{
 		
		 
		String division = request.getParameter("division");
		String year = request.getParameter("year");
		int fyear = Integer.parseInt( year); 
		String reportheader="SALARY FOR "+fyear+" - "+(fyear+1) ; 
		String sql ="";
		
		sql =" SELECT a.CHR_OFFICENAME, ";
		sql = sql + " FUN_PAY_SALARY_OFFICEWISE(a.INT_OFFICEID,'April','"+(fyear)+"') APR, ";
		sql = sql + " FUN_PAY_SALARY_OFFICEWISE(a.INT_OFFICEID,'May','"+(fyear)+"') MAY, ";
		sql = sql + " FUN_PAY_SALARY_OFFICEWISE(a.INT_OFFICEID,'June','"+(fyear)+"') JUN, ";
		sql = sql + " FUN_PAY_SALARY_OFFICEWISE(a.INT_OFFICEID,'July','"+(fyear)+"') JUL, ";
		sql = sql + " FUN_PAY_SALARY_OFFICEWISE(a.INT_OFFICEID,'August','"+(fyear)+"') AUG, ";
		sql = sql + " FUN_PAY_SALARY_OFFICEWISE(a.INT_OFFICEID,'September','"+(fyear)+"') SEP, ";
		sql = sql + " FUN_PAY_SALARY_OFFICEWISE(a.INT_OFFICEID,'October','"+(fyear)+"') OCTB, ";
		sql = sql + " FUN_PAY_SALARY_OFFICEWISE(a.INT_OFFICEID,'November','"+(fyear)+"') NOV, ";
		sql = sql + " FUN_PAY_SALARY_OFFICEWISE(a.INT_OFFICEID,'December','"+(fyear)+"') DECE, ";
		sql = sql + " FUN_PAY_SALARY_OFFICEWISE(a.INT_OFFICEID,'January','"+(fyear)+"') JAN, ";
		sql = sql + " FUN_PAY_SALARY_OFFICEWISE(a.INT_OFFICEID,'February','"+(fyear+1)+"') FEB, ";
		sql = sql + " FUN_PAY_SALARY_OFFICEWISE(a.INT_OFFICEID,'March','"+(fyear+1)+"') MAR,  ";
		sql = sql + " FUN_PAY_FINANCIAL_SALARY_OFFICEWISE(a.INT_OFFICEID, "+(fyear+1)+") APR_MAR ";
		sql = sql + " FROM com_m_office a ";
		sql = sql + " ORDER BY a.CHR_OFFICENAME ";
		//out.println(sql);
		Vector mn = new Vector();
	 	Vector child= null;
		String data[][] =  CommonFunctions.QueryExecute(sql);
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
				mn.add(child); 
			}
		}
			 
 		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25"  style="text-align:center" >
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="OFFICE" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="APR" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="MAY" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="JUN" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="JUL" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="AUG" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="SEP" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="OCT" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="NOV" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="DEC" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="JAN" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="FEB" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="MAR" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="APR-MAR" sortable="true"><%=temp.elementAt(14)%></display:column>
					   
					<display:setProperty name="export.excel.filename" value="SalaryOfficeWise.xls"/>
					<display:setProperty name="export.pdf.filename" value="SalaryOfficeWise.pdf"/>
					<display:setProperty name="export.csv.filename" value="SalaryOfficeWise.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
</display:table> 
    
<br />	<center>	<a style="text-align:right" href='SalaryOfficeWise.jsp'> CLOSE</a></center>
  <%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>		 
</body>
</html>

