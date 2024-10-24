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
		String year = request.getParameter("year");
		String quarter = request.getParameter("quarter");
		String branch = request.getParameter("Branch");
		String division = request.getParameter("division");
		
		int fyear = Integer.parseInt( year); 
	 	int dbyear =fyear;
		if("4".equals(quarter))
				dbyear =fyear+1;				  
		String reportheader=" QPLC   "+fyear+" - " +(fyear+1)  +" " ; 
		if("1".equals(quarter))
			reportheader =reportheader+ "First Quarter [ APR -JUN ]";
		else if("2".equals(quarter))
			reportheader =reportheader+ "Second Quarter[ JUL - SEP ]";
		else if("3".equals(quarter))
			reportheader =reportheader+ "Third Quarter[ OCT - DEC ]";
		else  if("4".equals(quarter))
		 	reportheader =reportheader+ "Fourth Quarter [JAN  - MAR ]";
		 	
		String sql ="  ";
		
		Vector mn = new Vector();
	 	Vector child= null;
		 
		if("1".equals(type)   )
		{
			if("1".equals(quarter))
			{
			
				 sql = sql + " SELECT a.CHR_DIVICODE , b.INT_APR APR, b.INT_MAY MAY, ";   
				 sql = sql + " b.INT_JUN JUN,(b.INT_APR+b.INT_MAY+b.INT_JUN) APR_JUN , SUM(c.DOU_AMOUNT) amount,  ";  
				 sql = sql + " ROUND(( SUM(c.DOU_AMOUNT) /( (b.INT_APR+b.INT_MAY+b.INT_JUN)*100000 )*100 ),2) percentage ";
				 sql = sql + " FROM inv_m_division a , inv_t_targetassign_division b , inv_t_directsales c ";
				 sql = sql + " WHERE a.INT_DIVIID = b.INT_DIVIID ";
				 sql = sql + " AND a.INT_DIVIID = c.INT_DIVIID ";
				 sql = sql + " AND MONTHNAME(c.DAT_SALESDATE) IN ('April','May','June') ";  
				 sql = sql + " AND YEAR(c.DAT_SALESDATE) =  "+fyear;
				 sql = sql + "  AND c.CHR_CANCEL ='N'  "; 
				 if(!"0".equals(branch))
				 	sql = sql + "  AND c.INT_BRANCHID = "+ branch;
				 if(!"0".equals(division))
				 	sql = sql + "  AND c.INT_DIVIID = "+ division;
				 sql = sql + " AND c.INT_SALESSTATUS=1   ";
				 sql = sql + "  GROUP BY a.INT_DIVIID ";
				 sql = sql + " ORDER BY a.CHR_DIVICODE ";
			}
			else if("2".equals(quarter))
			{
				 sql = sql + " SELECT a.CHR_DIVICODE , b.INT_JUL JUL, b.INT_AUG AUG, ";   
				 sql = sql + " b.INT_SEP SEP,(b.INT_JUL+b.INT_AUG+b.INT_SEP) JUL_AUG, SUM(c.DOU_AMOUNT) amount,  ";  
				 sql = sql + " ROUND(( SUM(c.DOU_AMOUNT) /( (b.INT_JUL+b.INT_AUG+b.INT_SEP)*100000 )*100 ),2) percentage ";
				 sql = sql + " FROM inv_m_division a , inv_t_targetassign_division b , inv_t_directsales c ";
				 sql = sql + " WHERE a.INT_DIVIID = b.INT_DIVIID ";
				 sql = sql + " AND a.INT_DIVIID = c.INT_DIVIID ";
				 sql = sql + " AND MONTHNAME(c.DAT_SALESDATE) IN ('July','August','September') ";  
				 sql = sql + " AND YEAR(c.DAT_SALESDATE) =  "+fyear;
				 sql = sql + "  AND c.CHR_CANCEL ='N'  "; 
				 if(!"0".equals(branch))
				 	sql = sql + "  AND c.INT_BRANCHID = "+ branch;
				 if(!"0".equals(division))
				 	sql = sql + "  AND c.INT_DIVIID = "+ division;
				 sql = sql + " AND c.INT_SALESSTATUS=1   ";
				 sql = sql + "  GROUP BY a.INT_DIVIID ";
				 sql = sql + " ORDER BY a.CHR_DIVICODE ";
			 
				 		 
			}
			else if("3".equals(quarter))
			{
				 sql = sql + " SELECT a.CHR_DIVICODE , b.INT_OCT OCT, b.INT_NOV NOV, ";   
				 sql = sql + " b.INT_DEC DEC,(b.INT_OCT+b.INT_NOV+b.INT_DEC) OCT_DEC, SUM(c.DOU_AMOUNT) amount,  ";  
				 sql = sql + " ROUND(( SUM(c.DOU_AMOUNT) /( (b.INT_OCT+b.INT_NOV+b.INT_DEC)*100000 )*100 ),2) percentage ";
				 sql = sql + " FROM inv_m_division a , inv_t_targetassign_division b , inv_t_directsales c ";
				 sql = sql + " WHERE a.INT_DIVIID = b.INT_DIVIID ";
				 sql = sql + " AND a.INT_DIVIID = c.INT_DIVIID ";
				 sql = sql + " AND MONTHNAME(c.DAT_SALESDATE) IN ('October','November','December') ";  
				 sql = sql + " AND YEAR(c.DAT_SALESDATE) =  "+fyear;
				 sql = sql + "  AND c.CHR_CANCEL ='N'  "; 
				 if(!"0".equals(branch))
				 	sql = sql + "  AND c.INT_BRANCHID = "+ branch;
				 if(!"0".equals(division))
				 	sql = sql + "  AND c.INT_DIVIID = "+ division;
				 sql = sql + " AND c.INT_SALESSTATUS=1   ";
				 sql = sql + "  GROUP BY a.INT_DIVIID ";
				 sql = sql + " ORDER BY a.CHR_DIVICODE ";
				 
			}
			else if("4".equals(quarter))
			{
				 sql = sql + " SELECT a.CHR_DIVICODE , b.INT_JAN JAN, b.INT_FEB FEB,  ";   
				 sql = sql + " b.INT_MAR MAR,(b.INT_JAN+b.INT_FEB+b.INT_MAR) JAN_FEB, SUM(c.DOU_AMOUNT) amount,  ";  
				 sql = sql + " ROUND(( SUM(c.DOU_AMOUNT) /( (b.INT_JAN+b.INT_FEB+b.INT_MAR)*100000 )*100 ),2) percentage ";
				 sql = sql + " FROM inv_m_division a , inv_t_targetassign_division b , inv_t_directsales c ";
				 sql = sql + " WHERE a.INT_DIVIID = b.INT_DIVIID ";
				 sql = sql + " AND a.INT_DIVIID = c.INT_DIVIID ";
				 sql = sql + " AND MONTHNAME(c.DAT_SALESDATE) IN ('January','February','March') ";  
				 sql = sql + " AND YEAR(c.DAT_SALESDATE) =  "+(fyear+1);
				 sql = sql + "  AND c.CHR_CANCEL ='N'  "; 
				 if(!"0".equals(branch))
				 	sql = sql + "  AND c.INT_BRANCHID = "+ branch;
				 if(!"0".equals(division))
				 	sql = sql + "  AND c.INT_DIVIID = "+ division;
				 sql = sql + " AND c.INT_SALESSTATUS=1   ";
				 sql = sql + "  GROUP BY a.INT_DIVIID ";
				 sql = sql + " ORDER BY a.CHR_DIVICODE ";
			}
			 
		}
		 
		//out.println(sql); 
		 
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
	
	<%
	if("1".equals(quarter))
	{
		%>
	<display:column title="APR" style="text-align:right"   sortable="true"><%=temp.elementAt(2)%></display:column>
	<display:column title="MAY" style="text-align:right"   sortable="true"><%=temp.elementAt(3)%></display:column>
	<display:column title="JUN" style="text-align:right"   sortable="true"><%=temp.elementAt(4)%></display:column>
	<display:column title="APR -JUN  [ IN LAKHS ]" style="text-align:right"   sortable="true"><%=temp.elementAt(5)%></display:column>
		<%
	 
	}
	else if("2".equals(quarter))
	{
		 
		%>
	<display:column title="JUL" style="text-align:right"   sortable="true"><%=temp.elementAt(2)%></display:column>
	<display:column title="AUG" style="text-align:right"   sortable="true"><%=temp.elementAt(3)%></display:column>
	<display:column title="SEP" style="text-align:right"   sortable="true"><%=temp.elementAt(4)%></display:column>
	<display:column title="JUL - SEP [ IN LAKHS ]" style="text-align:right"   sortable="true"><%=temp.elementAt(5)%></display:column>
		<%
	}
	else if("3".equals(quarter))
	{
		 
		%>
	<display:column title="OCT" style="text-align:right"   sortable="true"><%=temp.elementAt(2)%></display:column>
	<display:column title="NOV" style="text-align:right"   sortable="true"><%=temp.elementAt(3)%></display:column>
	<display:column title="DEC" style="text-align:right"   sortable="true"><%=temp.elementAt(4)%></display:column>
	<display:column title="OCT - DEC [ IN LAKHS ]" style="text-align:right"   sortable="true"><%=temp.elementAt(5)%></display:column>
		<%
	}
	else if("4".equals(quarter))
	{
		 
		%>
	<display:column title="JAN" style="text-align:right"   sortable="true"><%=temp.elementAt(2)%></display:column>
	<display:column title="FEB" style="text-align:right"   sortable="true"><%=temp.elementAt(3)%></display:column>
	<display:column title="MARCH" style="text-align:right"   sortable="true"><%=temp.elementAt(4)%></display:column>
	<display:column title="JAN-MAR [ IN LAKHS ]" style="text-align:right"   sortable="true"><%=temp.elementAt(5)%></display:column>
		<%
		
	}
	 %>
	 
	<display:column title="NET AMOUNT" style="text-align:right"   sortable="true"><%=temp.elementAt(6)%></display:column>
	<display:column title="ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(7)%></display:column>
	  
	<display:setProperty name="export.excel.filename" value="Rept_DivisionQPLCQuarter.xls"/>
	<display:setProperty name="export.pdf.filename" value="Rept_DivisionQPLCQuarter.pdf"/>
	<display:setProperty name="export.csv.filename" value="Rept_DivisionQPLCQuarter.csv"/>
	<display:setProperty name="export.pdf"  value="true" />
	 
	 
</display:table> 
    
<br />	<center>	<a style="text-align:right" href='Rept_DivisionQPLCQuarter.jsp'> CLOSE</a>
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

