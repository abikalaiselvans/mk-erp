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
 		
		 
		 
		String type = request.getParameter("type");
		String month = request.getParameter("month");
		String years = request.getParameter("year");
		
		int mth = Integer.parseInt( month); 
		int year = Integer.parseInt( years); 
	 	String monthname = DateUtil.getMonth(mth);
		String reportheader=" MPC   "+monthname+" - " +year  +" " ; 
		String sql ="  ";
		String mon="";
		
		int fyear = year;
		int dbyear =year;
		if(monthname.equalsIgnoreCase("January"))
            dbyear =fyear+1;
        else if(monthname.equalsIgnoreCase("February"))
            dbyear =fyear+1;
        else if(monthname.equalsIgnoreCase("March"))
            dbyear =fyear+1;
        
		
		
		if(monthname.equalsIgnoreCase("January"))
            mon = "b.INT_JAN ";
        else if(monthname.equalsIgnoreCase("February"))
            mon = "b.INT_FEB ";
        else if(monthname.equalsIgnoreCase("March"))
            mon = "b.INT_MAR ";
        else if(monthname.equalsIgnoreCase("April"))
            mon = "b.INT_APR ";
        else if(monthname.equalsIgnoreCase("May"))
            mon = "b.INT_MAY ";
        else if(monthname.equalsIgnoreCase("June"))
           mon = "b.INT_JUN ";
        else if(monthname.equalsIgnoreCase("July"))
            mon = "b.INT_JUL ";
        else if(monthname.equalsIgnoreCase("August"))
            mon = "b.INT_AUG ";
        else if(monthname.equalsIgnoreCase("September"))
            mon = "b.INT_SEP ";
        else if(monthname.equalsIgnoreCase("October"))
            mon = "b.INT_OCT ";
        else if(monthname.equalsIgnoreCase("November"))
            mon = "b.INT_NOV ";
        else if(monthname.equalsIgnoreCase("December"))
            mon = "b.INT_DEC ";
			
		Vector mn = new Vector();
	 	Vector child= null;
		 
		 
		 
		if("1".equals(type)   )
		{
			 
			sql = "SELECT  ";
			sql = sql +" a.CHR_REF,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF) ME,MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE), ";
			sql = sql +" SUM(a.DOU_AMOUNT) amount , "+mon+" , ";
			sql = sql +" c.A0013 MPC , ROUND(( SUM(a.DOU_AMOUNT) /( ( "+mon+")*100000 )*100 ),2) Achieve, ";
			sql = sql +" if( ROUND(( SUM(a.DOU_AMOUNT) /( ( "+mon+")*100000 )*100 ),2) >80 ,'ELGIBLE','NOT ELGIBLE' ) MPLC ";
			sql = sql +" FROM inv_t_directsales a , inv_t_targetassign b, pay_t_allowance c ";
			sql = sql +" WHERE  ";
			sql = sql +" MONTHNAME(a.DAT_SALESDATE) IN ('"+monthname+"')  ";
			sql = sql +" AND YEAR(a.DAT_SALESDATE) =  "+dbyear ;
			sql = sql +" AND b.INT_YEAR =  "+fyear;
			sql = sql +" AND a.CHR_CANCEL ='N' ";
			sql = sql +" AND a.INT_SALESSTATUS=1 ";
			sql = sql +" AND  a.CHR_REF = b.CHR_EMPID    ";
			sql = sql +" AND  a.CHR_REF = c.CHR_EMPID  ";
			sql = sql +" GROUP BY a.CHR_REF ";
			sql = sql +" ORDER BY FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF) ";
			
		}
		 
		 //out.println(sql); 
		 
		String data[][] =  CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			 
			 
			
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]); 
				child.addElement(data[u][5]);  
				child.addElement(data[u][6]);  
				child.addElement(data[u][7]); 
				child.addElement(data[u][8]);
				child.addElement("<a target='_blank' href='Rept_EmployeeAchieveChart.jsp?empid="+data[u][0]+"&year="+fyear+"'>View Chart</a>"); 
				mn.add(child); 
			}
 		} 
			
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25"  style="text-align:center" >
 
	<display:caption><%=reportheader.toUpperCase()%></display:caption>
	<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
	<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
	<display:column title="ME NAME" sortable="true"><%=temp.elementAt(1)%></display:column>
	<display:column title="MONTH" style="text-align:right"   sortable="true"><%=temp.elementAt(2)%></display:column>
	<display:column title="YEAR" style="text-align:right"   sortable="true"><%=temp.elementAt(3)%></display:column>
	<display:column title="AMOUNT" style="text-align:right"   sortable="true"><%=temp.elementAt(4)%></display:column>
	<display:column title="TARGET [ IN LAKHS ]" style="text-align:right"   sortable="true"><%=temp.elementAt(5)%></display:column>
	<display:column title="ACHEIVE [ % ]" style="text-align:right"   sortable="true"><%=temp.elementAt(7)%></display:column>
	<display:column title="MPLC" style="text-align:right"   sortable="true"><%=temp.elementAt(6)%></display:column>
	<display:column title="ELGIBLE" style="text-align:right"   sortable="true"><%=temp.elementAt(8)%></display:column>
	 <display:column title="Chart" media ='html' style="text-align:right"   sortable="true"><%=temp.elementAt(9)%></display:column>
	
	<display:setProperty name="export.excel.filename" value="Rept_MPLCResponse.xls"/>
	<display:setProperty name="export.pdf.filename" value="Rept_MPLCResponse.pdf"/>
	<display:setProperty name="export.csv.filename" value="Rept_MPLCResponse.csv"/>
	<display:setProperty name="export.pdf"  value="true" />
	 
	 
</display:table> 
<br />
<br />
<center><a target='_blank' href='Rept_MultiemployeeAchieveChart.jsp?year=<%=fyear%>'>  All Chart</a>
<br />
<br />    
    
<br />	<center>	<a style="text-align:right" href='Rept_MPLCResponse.jsp'> CLOSE</a>
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

