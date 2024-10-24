<%@ page import="java.io.*,java.util.*,java.text.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
  
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <body >
 <%
try
{
		String reportheader="PAYMENT PENDING "; 
		String branchid=""+session.getAttribute("INVBRANCH"); 
		String Branch=request.getParameter("Branch");
		String division=request.getParameter("divis");
		String payType=request.getParameter("payType");
		String ref=request.getParameter("ref");
		String From=request.getParameter("From");
		String To=request.getParameter("To");
		String Chequedt=request.getParameter("Chequedt");
		String order = request.getParameter("order");
		
		
		String sql = "";
		String dd="";
		String me="";
		if(!"0".equals(division))
			dd="  AND a.INT_DIVIID="+division;
		
		if(!"0".equals(ref))	
			me = " AND a.CHR_REF='"+ref+"'";	
			
		 Vector mn = new Vector();
	 	Vector child= null;
		
	
			
		double sum=0.0;	
		//coding for direct sales payment
		if("Direct".equals(payType) || "ALL".equals(payType))
		{
		
			sql =" SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),datediff(now(),a.DAT_SALESDATE),a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS ";
			sql = sql+" ,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,c.CHR_STAFFNAME,d.CHR_DIVICODE,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME ,a.CHR_DES   from inv_t_directsales a ,inv_m_customerinfo b ,com_m_staff c ,inv_m_division d, com_m_branch e,com_m_company f WHERE a.CHR_PAYMENTSTATUS !='Y' ";
			sql = sql+" AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID";
			sql = sql+" AND a.INT_DIVIID=d.INT_DIVIID  AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID" ;
			
			if(!"0".equals(Branch))	
				sql = sql+" AND a.INT_BRANCHID="+Branch;	
			
			sql = sql+dd;
			sql = sql+" AND datediff(now(),a.DAT_SALESDATE)>="+From;
			sql = sql+" AND datediff(now(),a.DAT_SALESDATE)<="+To;
			sql = sql+" "+me+" ";
			sql = sql+" ORDER BY  "+order; // SUBSTRING_INDEX(a.CHR_SALESNO, '/',1) ,
			//out.println(sql);
			String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
			double pamount=0;
			if(data.length>0)
			{
				 
				
				for(int y=0;y<data.length;y++)
				{
					pamount=0;
					child = new Vector();
					child.addElement((y+1));
					child.addElement("CUSTOMER SALES");
					child.addElement(data[y][0]);
					child.addElement(data[y][8]);
					child.addElement(data[y][9]);
					child.addElement(data[y][1]);
					child.addElement(data[y][5]);
					 
					if("P".equals(data[y][4]))
					{
						
						sql="SELECT COUNT(*) FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO='"+data[y][0]+"'";
						boolean f=com.my.org.erp.common.CommonFunction.RecordExist(sql);
						if(f)
						{
						  sql="SELECT SUM(DOU_PAIDAMOUNT) FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO='"+data[y][0]+"'";
						  String pdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
						  if(pdata.length>0)
							 pamount= Math.round(Double.parseDouble(pdata[0][0]));
						  else
							pamount=0;
						}
						
						
						child.addElement("Partialy Paid ("+Math.round(Double.parseDouble(data[y][3]))+"-"+pamount+" ) ");
						child.addElement(Math.round(Double.parseDouble(data[y][3])-pamount)	);
						 
						 
					}	
					else
					{
						child.addElement("");
						child.addElement(data[y][3]	);
						 
					}
					child.addElement(data[y][2]);
					child.addElement(data[y][6]);
					child.addElement(data[y][7]);
					child.addElement(data[y][10]);
					mn.add(child);
				}
			}
			 
		}	
	 
	 
	 
	 
	 	//Payment pending for Direct Billing
		if("DirectBilling".equals(payType)|| "ALL".equals(payType))
		{
		
			sql =" SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),datediff(now(),a.DAT_SALESDATE),a.DOU_AMOUNT,a.CHR_PAYMENTSTATUS ";
			sql = sql+" ,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,c.CHR_STAFFNAME,d.CHR_DIVICODE,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME,a.CHR_DES  from inv_t_directbilling a , inv_m_customerinfo b ,";
			sql = sql + "com_m_staff c ,inv_m_division d ,com_m_branch e,com_m_company f WHERE a.CHR_PAYMENTSTATUS !='Y' ";
			sql = sql+" AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID";
			sql = sql+" AND a.INT_DIVIID=d.INT_DIVIID AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID " ;
			
			if(!"0".equals(Branch))	
				sql = sql+" AND a.INT_BRANCHID="+Branch;	
			
			sql = sql+dd;
			sql = sql+" AND datediff(now(),a.DAT_SALESDATE)>="+From;
			sql = sql+" AND datediff(now(),a.DAT_SALESDATE)<="+To;
			sql = sql+" "+me+" ";
			sql = sql+" ORDER BY  "+order; //  SUBSTRING_INDEX(a.CHR_SALESNO, '/',1) , 
			String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
			double pamount=0;
			if(data.length>0)
			{
			    for(int y=0;y<data.length;y++)
				{
					pamount=0;
					child = new Vector();
					child.addElement((y+1));
					child.addElement("DIRECT BILLING");
					child.addElement(data[y][0]);
					child.addElement(data[y][8]);
					child.addElement(data[y][9]);
					child.addElement(data[y][1]);
					child.addElement(data[y][5]);
					
					if("P".equals(data[y][4]))
					{
						
						sql="SELECT COUNT(*) FROM inv_t_directbillingpayment WHERE CHR_SALESNO='"+data[y][0]+"'";
						boolean f=com.my.org.erp.common.CommonFunction.RecordExist(sql);
						if(f)
						{
							sql="SELECT SUM(DOU_PAIDAMOUNT) FROM inv_t_directbillingpayment WHERE CHR_SALESNO='"+data[y][0]+"'";
							String pdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
							if(pdata.length>0)
								pamount= Math.round(Double.parseDouble(pdata[0][0]));
							else
								pamount=0;
						}		
						child.addElement("Partialy Paid ("+Math.round(Double.parseDouble(data[y][3]))+"-"+pamount+" )");
						child.addElement(Math.round(Double.parseDouble(data[y][3])-pamount));
						 
						 
					}	
					else
					{
						child.addElement("");
						child.addElement(data[y][3]);
						
						 
					}
					child.addElement(data[y][2]);
					child.addElement(data[y][6]);
					child.addElement(data[y][7]);
					child.addElement(data[y][10]);
					mn.add(child);
				}
				
			}
			 
			
		}	
		
		
		//Payment pending for Service Billing
		if("ServiceBilling".equals(payType)|| "ALL".equals(payType))
		{
		
			sql =" SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),datediff(now(),a.DAT_SALESDATE),a.DOU_NETAMOUNT,a.CHR_PAYMENTSTATUS ";
			sql = sql+" ,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,c.CHR_STAFFNAME,d.CHR_DIVICODE,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME,a.CHR_DES  from inv_t_servicebilling a , inv_m_customerinfo b ,";
			sql = sql + "com_m_staff c ,inv_m_division d,com_m_branch e,com_m_company f WHERE a.CHR_PAYMENTSTATUS !='Y' ";
			sql = sql+" AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID";
			sql = sql+" AND a.INT_DIVIID=d.INT_DIVIID AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID";
			
			if(!"0".equals(Branch))	
				sql = sql+" AND a.INT_BRANCHID="+Branch;	
			
			sql = sql+dd;
			sql = sql+" AND datediff(now(),a.DAT_SALESDATE)>="+From;
			sql = sql+" AND datediff(now(),a.DAT_SALESDATE)<="+To;
			sql = sql+" "+me+" ";
			sql = sql+" ORDER BY  "+order; //SUBSTRING_INDEX(a.CHR_SALESNO, '/',1) , 
			String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
			double pamount=0;
			if(data.length>0)
			{
			    for(int y=0;y<data.length;y++)
				{
					pamount=0;
					child = new Vector();
					child.addElement((y+1));
					child.addElement("SERVICE BILLING");
					child.addElement(data[y][0]);
					child.addElement(data[y][8]);
					child.addElement(data[y][9]);
					child.addElement(data[y][1]);
					child.addElement(data[y][5]);
					 
					if("P".equals(data[y][4]))
					{
						
						sql="SELECT COUNT(*) FROM inv_t_servicebillingpayment WHERE CHR_SALESNO='"+data[y][0]+"'";
						boolean f=com.my.org.erp.common.CommonFunction.RecordExist(sql);
						if(f)
						{
							sql="SELECT SUM(DOU_PAIDAMOUNT) FROM inv_t_servicebillingpayment WHERE CHR_SALESNO='"+data[y][0]+"'";
							String pdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
							if(pdata.length>0)
								pamount= Math.round(Double.parseDouble(pdata[0][0]));
							else
								pamount=0;
						}
						child.addElement("Partialy Paid ("+Math.round(Double.parseDouble(data[y][3]))+"-"+pamount+" )");
						child.addElement(Math.round(Double.parseDouble(data[y][3])-pamount));
						 		
						 
					}	
					else
					{
						child.addElement("");
						child.addElement(data[y][3]);
						
						 
					}
					child.addElement(data[y][2]);
					child.addElement(data[y][6]);
					child.addElement(data[y][7]);
					child.addElement(data[y][10]);
					mn.add(child);
				}
				
			}
			 
			
		}	
	
	
		request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
 	 
 %>
  
  
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="INVOICE TYPE" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="INVOICE NUMBER" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="COMPANY" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="BRANCH" sortable="true"><%=temp.elementAt(4)%></display:column>
					
					<display:column title="SALE DATE" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="CUSTOMER NAME" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="INVOICE STATUS" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="TOTAL AMOUNT" sortable="true" style="text-align:right"><%=temp.elementAt(8)%></display:column>
					<display:column title="NO OF DAYS" sortable="true" style="text-align:right"><%=temp.elementAt(9)%></display:column>
					<display:column title="M.E. NAME" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="DIVISION" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="DESCRIPTION" sortable="true" style="width:300"><%=temp.elementAt(12)%></display:column>
					  
					<display:setProperty name="export.excel.filename" value="Rept_Paymentpending.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Paymentpending.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Paymentpending.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='PaymentPending.jsp'> CLOSE</a></center><br /><br />


 
	 		
  
  <%
}
catch(Exception e)
{
 		out.println(e.getMessage());
}
%>
 
</body>
</html>
