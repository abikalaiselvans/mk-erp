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
 <title>:: INVENTORY ::</title>

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
	 	String reportheader=" DIVISION ACHEIVE    "+fyear+" - " +(fyear+1)  +" " ; 
		String sql ="  ";
		
		Vector mn = new Vector();
	 	Vector child= null;
		  
		 
		sql = sql + "  SELECT a.CHR_DIVICODE,  ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('April','"+fyear+"',b.INT_APR,a.INT_DIVIID ) APR ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('May','"+fyear+"',b.INT_APR,a.INT_DIVIID ) MAY ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('June','"+fyear+"',b.INT_APR,a.INT_DIVIID ) JUN ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('July','"+fyear+"',b.INT_APR,a.INT_DIVIID ) JUL ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('August','"+fyear+"',b.INT_APR,a.INT_DIVIID ) AUG ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('September','"+fyear+"',b.INT_APR,a.INT_DIVIID ) SEP ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('October','"+fyear+"',b.INT_APR,a.INT_DIVIID ) sOCT ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('November','"+fyear+"',b.INT_APR,a.INT_DIVIID ) NOV ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('December','"+fyear+"',b.INT_APR,a.INT_DIVIID ) sDEC ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('January','"+(fyear+1)+"',b.INT_APR,a.INT_DIVIID ) JAN ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('February','"+(fyear+1)+"',b.INT_APR,a.INT_DIVIID ) FEB ,    ";
		sql = sql + "  FUN_GET_DIVISION_SALES_PERCENTAGE('March','"+(fyear+1)+"',b.INT_APR,a.INT_DIVIID ) MAR ,    ";
		sql = sql + "  a.INT_DIVIID ";
		sql = sql + " FROM inv_m_division a , inv_t_targetassign_division b    ";
		sql = sql + "  WHERE a.INT_DIVIID = b.INT_DIVIID  ";
		sql = sql + "  AND  b.INT_YEAR ="+fyear;
		sql = sql + "  ORDER BY a.CHR_DIVICODE   ";
		//out.println(sql); 
		 
		  
		String data[][] =  CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			 
			 
			
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement("<a target='_blank' href='Rept_divisionAchieveChart.jsp?division="+data[u][13]+"&year="+year+"'>View Chart</a>");
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
 		} 
			
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   varTotals="totals"  export="true" pagesize="25"  style="text-align:center" >
 
	<display:caption><%=reportheader.toUpperCase()%></display:caption>
	<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
	<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
	<display:column title="DIVISION NAME" sortable="true"><%=temp.elementAt(1)%></display:column>
	<display:column title="CHART" media="html" style="text-align:right"   sortable="true"><%=temp.elementAt(2)%></display:column>
	<display:column title="APRIL" style="text-align:right"   sortable="true"><%=temp.elementAt(3)%></display:column>
	<display:column title="MAY" style="text-align:right"   sortable="true"><%=temp.elementAt(4)%></display:column>
	<display:column title="JUNE" style="text-align:right"   sortable="true"><%=temp.elementAt(5)%></display:column>
	<display:column title="JULY" style="text-align:right"   sortable="true"><%=temp.elementAt(6)%></display:column>
	<display:column title="AUGUST" style="text-align:right"   sortable="true"><%=temp.elementAt(7)%></display:column>
	<display:column title="SEPTEMBER" style="text-align:right"   sortable="true"><%=temp.elementAt(8)%></display:column>
	<display:column title="OCTBER" style="text-align:right"   sortable="true"><%=temp.elementAt(9)%></display:column>
	<display:column title="NOVEMBER" style="text-align:right"   sortable="true"><%=temp.elementAt(10)%></display:column>
	<display:column title="DECEMBER" style="text-align:right"   sortable="true"><%=temp.elementAt(11)%></display:column>
	<display:column title="JANUARY" style="text-align:right"   sortable="true"><%=temp.elementAt(12)%></display:column>
	<display:column title="FEBRUARY" style="text-align:right"   sortable="true"><%=temp.elementAt(13)%></display:column>
	<display:column title="MARCH" style="text-align:right"   sortable="true"><%=temp.elementAt(14)%></display:column>
	  
	<display:setProperty name="export.excel.filename" value="Rept_divisionAchieve.xls"/>
	<display:setProperty name="export.pdf.filename" value="Rept_divisionAchieve.pdf"/>
	<display:setProperty name="export.csv.filename" value="Rept_divisionAchieve.csv"/>
	<display:setProperty name="export.pdf"  value="true" />
	 
	 
</display:table> 
<br />
<br />
<center><a target='_blank' href='Rept_MultidivisionAchieveChart.jsp?division=<%=division%>&year=<%=year%>'>  All Chart</a>
<br />
<br />    
<br />	<center>	<a style="text-align:right" href='Rept_divisionAchieve.jsp'> CLOSE</a>
</center>


 
 <%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>		 
</body>
</html>

