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

<%
try
{
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"	import="java.sql.*" errorPage=""%>
<html>
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


<title> :: PAYROLL ::</title>


 
<script language="javascript" src="../JavaScript/comfunction.js"></script>

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
  
<style type="text/css">
<!--
.style3 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
</head>

<body  onpaste='return false;'>
 
		<%
		String ename = request.getParameter("ename");
		String staffids[] = request.getParameterValues("ename");
		String frmdate = request.getParameter("frmdate");
		String todate =  request.getParameter("todate");
		frmdate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(frmdate);
		todate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
		String monthname[]= com.my.org.erp.common.CommonFunctions.getMonthNamebetweenTwoDates(frmdate , todate).split("~"); 
		String yearname[]= com.my.org.erp.common.CommonFunctions.getYearbetweenTwoDates(frmdate , todate).split("~"); 
		
		String AllowanceData[][] = CommonFunctions.QueryExecute("SELECT INT_ALLOWANCEID,CHR_ACODE,CHR_ANAME FROM  pay_m_allowance  ORDER BY INT_ALLOWANCEID");
		String recoveryData[][] = CommonFunctions.QueryExecute("  SELECT INT_RECOVERYID,CHR_RCODE,CHR_RNAME FROM pay_m_recovery  ORDER BY  INT_RECOVERYID ");
		
		String AllowanFiled="";
		String AllowanName="";
		for(int u=0; u<AllowanceData.length;u++)
		{
			AllowanFiled = AllowanFiled+ "a."+AllowanceData[u][1] +" ,  "; 
			AllowanName = AllowanName+  AllowanceData[u][2] +" , "; 
		}	
		 
		 
		String RecoveryFiled="";
		String RecoveryName="";
		for(int u=0; u<recoveryData.length;u++)
		{
			RecoveryFiled = RecoveryFiled+  recoveryData[u][1] +" , "; 
			RecoveryName = RecoveryName+  recoveryData[u][2] +" , "; 
		}	
		 
		 
		 
		String GrossData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  INT_ALLOWANCEID,CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
		String GrossAllowance="   ";
		for(int u=0; u<GrossData.length;u++)
			GrossAllowance = GrossAllowance+"  a."+GrossData[u][1]+"+ "; 
		GrossAllowance=GrossAllowance.trim();
		GrossAllowance = GrossAllowance.substring(0,GrossAllowance.length()-1);		
		String monthData[] = (com.my.org.erp.Date.Day.getMonthandYearBetweenTwoDateInSQLFormat(frmdate,todate)).split("~");
		
		String sql ="";
		
		
		
		
		
		
		
		
		
		
		Vector mn = new Vector();
	 	Vector child= null;
		
		if(monthData.length>0)
		{
			String staffid="";
			String monthsql="";
			for(int g=0;g<staffids.length;g++)
			{
				ename = staffids[g];
				
				for(int u=0;u<monthData.length;u++)
				{
					sql = " SELECT a.CHR_EMPID,a.CHR_EMPNAME,a.CHR_MONTH,a.INT_YEAR ,a.DOU_WORKDAYS,a.DOU_BASIC ,";
					sql = sql +AllowanFiled;
					sql = sql +" a.DOU_ATOTAL1,a.DOU_ATOTAL2,a.DOU_GROSSPAY," ;
					sql = sql +RecoveryFiled;
					sql = sql +"   a.RTOTAL,a.DOU_PF,a.DOU_ESI,a.DOU_ADVANCE,a.DOU_PAYTAX,a.DOU_TOTALRECOVERY,a.DOU_NETSAL,a.DOU_MONTHSAL," ;
					sql = sql +"   a.DOU_CPYPF1,a.DOU_CPYPF2,a.DOU_CPYESI,a.DOU_SUM,a.DOU_CTC,a.DOU_ORIGINALCTC," ;
					sql = sql +"   a.DOU_PENBASIC,a.DOU_COMPANYPF,a.DOU_COMPANYPENSION,a.DOU_ADMINCHARGE,a.DOU_EDLI,a.DOU_ADMINCHARGE1" ;
					sql = sql +" FROM  pay_t_salary a  WHERE a.CHR_MONTH='"+monthData[u].split(",")[0]+"' AND a.INT_YEAR="+monthData[u].split(",")[1];
					sql = sql + " AND a.CHR_EMPID ='"+ename+"'";
					 
					   //WHERE   ((a.CHR_MONTH in ('April','May','June','July','August','September','October','November','December' ) 
 //and a.INT_YEAR=(2011)) or (a.CHR_MONTH in ('January') and a.INT_YEAR=(2012)))
 
 
					 //out.println(sql + monthsql +"<br><br><br>");
					String SalaryData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
					 if(SalaryData.length>0)
					 {
						 child = new Vector();
						 child.addElement((u+1));
						 for(int y=0;y<52;y++)
							child.addElement(SalaryData[0][y]);
						
						
						 mn.add(child); 
					 }
				}	
			}	
			 
		}	 
		 
		/* */
		  
	request.setAttribute("table",mn);
	out.println("<br><center><h3>CONSOLIDATE PAYROLL </h3></center><br>");
 
		 
		
		
		
		
		
		
		
		
		
		 
		
		int count=0;
		%>
			
			
			
	<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No"  sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Empid"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Name"  sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Month"  sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Year"  sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Working Days"  sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Basic"  sortable="true"><%=temp.elementAt(6)%></display:column>
					
					<%
					
					 for(int v=0;v<AllowanceData.length;v++)
					 {
					 %>
					 
					 	<display:column title="<%=AllowanceData[v][2]%>" sortable="true"><%=temp.elementAt(v+7)%></display:column>
					 <%
					 }
				     %>
					 
					 
					 <%
					 
					count = AllowanceData.length+6;
					count = count+1;
					%>	
				    
					<display:column title="Gross Allowance"  sortable="true"><%=temp.elementAt(count)%></display:column>
					<% count = count+1;%>
					<display:column title="Other Allowance"  sortable="true"><%=temp.elementAt(count)%></display:column>
					<% count = count+1;%>
					<display:column title="GROSS PAY"  sortable="true"><%=temp.elementAt(count)%></display:column>
					
					 
					<%
					 count = count+1; 
					for(int u=0; u<recoveryData.length;u++)
					{
					%>
						<display:column title="<%=recoveryData[u][2]%>"  sortable="true"><%=temp.elementAt(count)%></display:column>
				    <%
						count = count+1;
					}
					%>
					
					
					
					<display:column title="Recovery Total"  sortable="true"><%=temp.elementAt((count+0))%></display:column>
					<display:column title="EMPLOYEE PF"  sortable="true"><%=temp.elementAt((count+1))%></display:column>
					<display:column title="EMPLOYEE ESI"  sortable="true"><%=temp.elementAt((count+2))%></display:column>
					<display:column title="ADVANCE"  sortable="true"><%=temp.elementAt((count+3))%></display:column>
					<display:column title="PAY TAX"  sortable="true"><%=temp.elementAt((count+4))%></display:column>
					<display:column title="TOTAL RECOVERY"  sortable="true"><%=temp.elementAt((count+5))%></display:column>
					<display:column title="NETSALARY"  sortable="true"><%=temp.elementAt((count+6))%></display:column>
					<display:column title="MONTH SALARY"  sortable="true"><%=temp.elementAt((count+7))%></display:column>
					<display:column title="EMPLOYER (COMPANY) PF"  sortable="true"><%=temp.elementAt((count+8))%></display:column>
					<display:column title="EMPLOYER (COMPANY) PENSION"  sortable="true"><%=temp.elementAt((count+9))%></display:column>
					<display:column title="EMPLOYER (COMPANY) ESI"  sortable="true"><%=temp.elementAt((count+10))%></display:column>
					<display:column title="EMPLOYER (COMPANY) SUM"  sortable="true"><%=temp.elementAt((count+11))%></display:column>
					<display:column title="MONTH CTC"  sortable="true"><%=temp.elementAt((count+12))%></display:column>
					<display:column title="ORIGINAL CTC"  sortable="true"><%=temp.elementAt((count+13))%></display:column>
					<display:column title="PEN BASIC "  sortable="true"><%=temp.elementAt((count+14))%></display:column>
					<display:column title="COMAPNY PF"  sortable="true"><%=temp.elementAt((count+15))%></display:column>
					<display:column title="COMPANY PESION"  sortable="true"><%=temp.elementAt((count+16))%></display:column>
					<display:column title="ADMIN CHARGE"  sortable="true"><%=temp.elementAt((count+17))%></display:column>
					<display:column title="EDLI"  sortable="true"><%=temp.elementAt((count+18))%></display:column>
					<display:column title="ADMIN CHARGE"  sortable="true"><%=temp.elementAt((count+19))%></display:column>
					
 					
					<display:setProperty name="export.csv.filename" value="Rept_Payrollconsolidation.csv"/>
					<display:setProperty name="export.excel.filename" value="Rept_Payrollconsolidation.xls"/>
					<display:setProperty name="export.xml.filename" value="Rept_Payrollconsolidation.xml"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Payrollconsolidation.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<br />	<center>	<a href='PayRollConsolidationemp.jsp'> CLOSE</a></center>
 
	 		
			 
  

<%

}
catch(Exception e)
{
}
%>
</body>
</html>
