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
				sql =" SELECT a.CHR_SALESNO, ";
				sql = sql + " (SELECT b.CHR_STAFFNAME FROM com_m_staff b WHERE b.CHR_EMPID=a.CHR_EMPID),a.CHR_EMPID, ";
				sql = sql + " (SELECT FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID) FROM inv_m_customerinfo d WHERE d.INT_CUSTOMERID=c.INT_CUSTOMERID), ";
				sql = sql + " (SELECT e.CHR_DIVICODE FROM inv_m_division e WHERE e.INT_DIVIID=c.INT_DIVIID), ";
				sql = sql + " date_format(a.DAT_SALESDATE,'%e-%M-%Y'), ";
				sql = sql + " c.CHR_DES,c.DOU_AMOUNT,DOU_TOTALAMOUNT, ";
				sql = sql + " a.DOU_CONTRIBUTION ";
				sql = sql + " FROM  inv_t_contribution a ,inv_t_directsales c ";
				sql = sql + " WHERE a.CHR_SALESNO = c.CHR_SALESNO  AND c.CHR_CANCEL = 'N' ";
				if(!"0".equals(division))
					sql = sql + " AND c.INT_DIVIID="+division;
				sql = sql +" AND c.CHR_REF='"+session.getAttribute("EMPID")+"'";	
				if(!"0".equals(customer))
					sql = sql + " AND c.INT_CUSTOMERID="+customer;
				if(!"0".equals(Branch))
					sql = sql + " AND c.INT_BRANCHID="+Branch;
				if("Y".equals(daterange))
					sql = sql + " AND c.DAT_SALESDATE >='"+fromdate+"' AND c.DAT_SALESDATE<='"+todate+"' ";
				
				if("F".equals(""+session.getAttribute("USRTYPE"))|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_TURNOVERUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	 				sql = sql + "  AND c.CHR_REF IN("+empids+"'0') ";
				
				sql = sql + " GROUP BY a.CHR_SALESNO ORDER BY c.CHR_SALESNO";
				 //out.println(sql);
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length>0)
				{
					double sum=0,sum1=0,sum2=0;
					for(int u=0;u<data.length;u++)
					{
						
						child = new Vector();
						child.addElement((u+1));
						child.addElement(data[u][0]);
						child.addElement(data[u][1] +" / "+data[u][2]);
						child.addElement(data[u][3]);
						child.addElement(data[u][4]);
						child.addElement(data[u][5]);
						child.addElement(data[u][6]);
						child.addElement(data[u][7]);
						child.addElement(data[u][8]);
						child.addElement(data[u][9]);
						sum = sum+Double.parseDouble(data[u][7]);
						sum1 = sum1+Double.parseDouble(data[u][8]);
						sum2 = sum2+Double.parseDouble(data[u][9]);
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
						child.addElement(BigDecimal.valueOf(Math.round(sum)).toPlainString());
						child.addElement(BigDecimal.valueOf(Math.round(sum1)).toPlainString());
						child.addElement(BigDecimal.valueOf(Math.round(sum2)).toPlainString());
						mn.add(child);
				}
			}
		 
		 
		 
		 if("2".equals(salestype) || "0".equals(salestype) )	
			{
				if("Y".equals(daterange))
					reportheader = reportheader + "  Direct Billing ( "+ fromdate +" - " + todate +" )";
				sql =" SELECT a.CHR_SALESNO, ";
				sql = sql + " (SELECT b.CHR_STAFFNAME FROM com_m_staff b WHERE b.CHR_EMPID=a.CHR_REF),a.CHR_REF, ";
				sql = sql + " (SELECT FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID) FROM inv_m_customerinfo d WHERE d.INT_CUSTOMERID=a.INT_CUSTOMERID), ";
				sql = sql + "  ";
				sql = sql + " (SELECT e.CHR_DIVICODE FROM inv_m_division e WHERE e.INT_DIVIID=a.INT_DIVIID), ";
				sql = sql + " date_format(a.DAT_SALESDATE,'%e-%M-%Y'), ";
				sql = sql + " a.CHR_DES,a.DOU_AMOUNT,DOU_NETAMOUNT, ";
				sql = sql + " a.DOU_CONTRIBUTION ";
				sql = sql + " FROM  inv_t_directbilling a   ";
				sql = sql + " WHERE a.CHR_SALESNO is not null   AND a.CHR_CANCEL = 'N' ";
				if(!"0".equals(division))
					sql = sql + " AND a.INT_DIVIID="+division;
				 
				if(!"0".equals(customer))
					sql = sql + " AND a.INT_CUSTOMERID="+customer;
				if("Y".equals(daterange))
					sql = sql + " AND a.DAT_SALESDATE >='"+fromdate+"' AND a.DAT_SALESDATE<='"+todate+"' ";
				
				sql = sql +" AND a.CHR_REF='"+session.getAttribute("EMPID")+"'";	
					
				sql = sql + " GROUP BY a.CHR_SALESNO  ORDER BY a.CHR_SALESNO";
				// out.println(sql);
				String data[][] = CommonFunctions.QueryExecute(sql);
				
				 
				if(data.length>0)
				{
					double sum=0,sum1=0,sum2=0;
					for(int u=0;u<data.length;u++)
					{
						child = new Vector();
						child.addElement((u+1));
						child.addElement(data[u][0]);
						child.addElement(data[u][1] +" / "+data[u][2]);
						child.addElement(data[u][3]);
						child.addElement(data[u][4]);
						child.addElement(data[u][5]);
						child.addElement(data[u][6]);
						child.addElement(data[u][7]);
						child.addElement(data[u][8]);
						child.addElement(data[u][9]);
						sum = sum+Double.parseDouble(data[u][7]);
						sum1 = sum1+Double.parseDouble(data[u][8]);
						sum2 = sum2+Double.parseDouble(data[u][9]);
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
						child.addElement(BigDecimal.valueOf(Math.round(sum)).toPlainString());
						child.addElement(BigDecimal.valueOf(Math.round(sum1)).toPlainString());
						child.addElement(BigDecimal.valueOf(Math.round(sum2)).toPlainString());
						mn.add(child);
				}
				
			}
			
			//out.println(sql);
	 
 	 
   
	 
	request.setAttribute("table",mn); 
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");

  
  
 
%>

 
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Sales No " sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Emp id / EmpName" sortable="true"  style="text-align:right"><%=temp.elementAt(2)%></display:column>
					<display:column title=" Customer"  style="text-align:right" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Division "  style="text-align:right" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Sales Date "  style="text-align:right" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Description"  style="text-align:right" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Amount"  style="text-align:right" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Amount + Tax "  style="text-align:right" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Contribution "  style="text-align:right" sortable="true"><%=temp.elementAt(9)%></display:column>
					
					<display:setProperty name="export.excel.filename" value="Rep_MyContribution.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rep_MyContribution.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rep_MyContribution.csv"/>
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
 
