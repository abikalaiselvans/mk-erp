 <%@ page import="java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>

 
 
<%@page import="java.math.BigDecimal"%>
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
<%
try
{
%>
 
<body ><br> 
<%
 	 
	 	    String sql="";
	        String fromdate = request.getParameter("fromdate");
			String todate = request.getParameter("todate");
			fromdate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate);
	 		todate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
			String daterange= request.getParameter("daterange");
			String division = request.getParameter("division");
			String customer = request.getParameter("customer");
			String salesref = request.getParameter("ref");
			String salestype = request.getParameter("type");
			String Branch = request.getParameter("Branch");
			String reportheader=" Contribution Report   ";
			String empid [] = CommonFunctions.getReportingEmployeeIds(""+session.getAttribute("EMPID"));
			String empids ="";
			if(empid.length>0)
				for(int i=0;i<empid.length;i++)
					empids = empids +" '"+empid[i]+"' , ";
			 
			Vector mn = new Vector();
	 		Vector child= null;
	 
			if("1".equals(salestype) || "0".equals(salestype) )	
			{
				if("Y".equals(daterange))
					reportheader = reportheader + "  Direct Sales ( "+ fromdate +" - " + todate +" )";
				
				
				 sql = " SELECT a.CHR_SALESNO, FIND_A_EMPLOYEE_NAME_ONLY(a.CHR_EMPID),a.CHR_EMPID, FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID) , ";
				 sql = sql + " FUN_INV_DIVISION(c.INT_DIVIID), date_format(a.DAT_SALESDATE,'%e-%M-%Y'), c.CHR_DES, DOU_PAMOUNT PAMOUNT,  ";
				 sql = sql + " SUM(((d.INT_QUANTITY*d.DOU_UNITPRICE)) - (d.DOU_UNITDISCOUNT)) SAMOUNT , ";
				 sql = sql + "  a.DOU_CONTRIBUTION  CONTRIBUTION,  a.DOU_DEDUCTION DEDUCTION , ";
				 sql = sql + " (a.DOU_CONTRIBUTION-a.DOU_DEDUCTION) CONTRIBUTION ,a.CHR_DEDUCTION_DESC ,  ";
				 sql = sql + " A.DOU_SUPPORT SUPPORT, A.DOU_INSTALLATION INSTALLATION, A.DOU_TRANSPORT TRANSPORT, ";
				 sql = sql + " (DOU_SUPPORT+DOU_INSTALLATION+DOU_TRANSPORT) SUMEXTRACCHARGE,  ";
				 sql = sql + " ((a.DOU_CONTRIBUTION-a.DOU_DEDUCTION) - ( (DOU_SUPPORT+DOU_INSTALLATION+DOU_TRANSPORT)) ) ACTUALCONTRIBUTION ";
				 sql = sql + "  FROM inv_t_contribution a ,inv_t_directsales c, inv_t_swapsalesitem d  ";
				 sql = sql + " WHERE a.CHR_SALESNO = c.CHR_SALESNO AND c.CHR_SALESNO = d.CHR_SALESNO  ";
				 sql = sql + " AND c.CHR_CANCEL = 'N'   ";
				
				if(!"0".equals(division))
					sql = sql + " AND c.INT_DIVIID="+division;
				if(!"0".equals(salesref))
					 sql = sql + " AND a.CHR_EMPID='"+salesref+"' ";  
				if(!"0".equals(customer))
					sql = sql + " AND c.INT_CUSTOMERID="+customer;
				if(!"0".equals(Branch))
					sql = sql + " AND c.INT_BRANCHID="+Branch;
				if("Y".equals(daterange))
					sql = sql + " AND c.DAT_SALESDATE >='"+fromdate+"' AND c.DAT_SALESDATE<='"+todate+"' ";
				
				if("F".equals(""+session.getAttribute("USRTYPE"))|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_TURNOVERUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	 				sql = sql + " ";
				else 	
					sql = sql + "  AND c.CHR_REF IN("+empids+"'0') ";
				
 				sql = sql + "  GROUP BY a.CHR_SALESNO ORDER BY c.CHR_SALESNO  ";
				
				 
				//out.println(sql);
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length>0)
				{
					double sum=0,sum1=0,sum2=0,sum3=0,sum4=0, sum5=0;
					for(int u=0;u<data.length;u++)
					{
						
						child = new Vector();
						child.addElement((u+1));
						child.addElement(data[u][0]);
						child.addElement(data[u][1]) ; 
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
						child.addElement(data[u][15]);
						child.addElement(data[u][16]);
						child.addElement(data[u][17]);
						mn.add(child);
						
					}
						/*child = new Vector();
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement(BigDecimal.valueOf(Math.round(sum)).toPlainString());
						child.addElement(BigDecimal.valueOf(Math.round(sum1)).toPlainString());
						child.addElement(BigDecimal.valueOf(Math.round(sum2)).toPlainString());
						child.addElement(BigDecimal.valueOf(Math.round(sum3)).toPlainString());
						child.addElement(BigDecimal.valueOf(Math.round(sum5)).toPlainString());
						
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						mn.add(child);*/
				}
			}
		 
		 
   
	 
	request.setAttribute("table",mn); 
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");

  
  
 
%>

 
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="SALESNO" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="EMPLOYEE_NAME" sortable="true"  style="text-align:right"><%=temp.elementAt(2)%></display:column>
					<display:column title=" EMPLOYEE_ID"  style="text-align:right" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="CUSTOMER_NAME "  style="text-align:right" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="DIVISION"  style="text-align:right" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="SALESDATE"  style="text-align:right" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="DESCRIPTION"  style="text-align:right" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="PURCHASE_AMOUNT"  style="text-align:right" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="SALES_AMOUNT"  style="text-align:right" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="CONTRIBUTION"  style="text-align:right" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="DEDUCTION "  style="text-align:right" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="CONTRIBUTION "  style="text-align:right" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title=" CHR_DEDUCTION_DESC "  style="text-align:right" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title=" SUPPORT "  style="text-align:right" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title=" INSTALLATION "  style="text-align:right" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title=" TRANSPORT "  style="text-align:right" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title=" SUMEXTRACCHARGE "  style="text-align:right" sortable="true"><%=temp.elementAt(17)%></display:column>
 					<display:column title=" ACTUALCONTRIBUTION "  style="text-align:right" sortable="true"><%=temp.elementAt(18)%></display:column>
 					
					<display:setProperty name="export.excel.filename" value="Rep_Contribution.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rep_Contribution.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rep_Contribution.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table> 
			
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center>
			

 
</body>
<%
}
catch(Exception e)
{
}
%>
 
