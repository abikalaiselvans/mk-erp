<%@ page import="java.io.*,java.util.*,java.text.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*,java.util.*"%>

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
	  String link="";
	  	try
			{
	  			
				String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate");
				String bank = request.getParameter("Bank");
				String customer = request.getParameter("customer");
				String Branch = request.getParameter("Branch");
				String Chequedt=request.getParameter("Chequedt");
				String division=request.getParameter("division");
				String Direct=request.getParameter("payType");
				String ref = request.getParameter("ref");
				String refsql="";
				if(!"0".equals(ref))
					refsql=" AND a.CHR_PAYEMENTCOLLECTEDBY='"+ref+"' ";
					 		
				String divsql="";
				if(!"0".equals(division))
					divsql=" AND d.INT_DIVIID="+division+" ";
				 
				String sql="";
				String fdt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate);
				String tdt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
				String mode="";
				
				
				if("Direct".equals(Direct))
				{
					mode = "DIRECT SALES";
					sql = sql+" SELECT a.CHR_SALESORDERNO , FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),FIND_A_BANKGROUP_NAME(a.CHR_BANKNAME),a.CHR_PAYNO, ";
					sql = sql+" date_format(a.DAT_PAYMENTDATE,'%d-%b-%Y'), a.DOU_PAIDAMOUNT,date_format(a.CHR_CHKDATE,'%d-%b-%Y') ";
					sql = sql+"  ,date_format(d.DAT_SALESDATE,'%d-%b-%Y') ,a.CHR_REMARK ";
					sql = sql+"  ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_PAYEMENTCOLLECTEDBY)  ,a.CHR_PAYEMENTCOLLECTEDBY  ";//extra
					sql = sql + " ,e.CHR_COMPANYNAME,f.CHR_BRANCHNAME,datediff(a.CHR_CHKDATE,d.DAT_SALESDATE),g.CHR_DIVICODE  FROM inv_t_customersalespayment a,";
					sql = sql+" inv_m_customerinfo b ,inv_t_directsales d ,com_m_company e, com_m_branch f,inv_m_division g WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
					sql = sql+"   AND a.CHR_SALESORDERNO =d.CHR_SALESNO AND d.INT_BRANCHID = f.INT_BRANCHID AND f.INT_COMPANYID =e.INT_COMPANYID           AND d.INT_DIVIID = g.INT_DIVIID ";
					 if(!"0".equals(Branch))
						sql = sql+" AND a.INT_BRANCHID ="+Branch;
					sql = sql + divsql +refsql;
					  
						
					if(!"0".equals(customer))	
						sql = sql+" AND a.INT_CUSTOMERID="+customer;
						//,e.CHR_COMPANYNAME,f.CHR_BRANCHNAME   ,com_m_company e, com_m_branch f  AND d.INT_BRANCHID = f.INT_BRANCHID AND f.INT_COMPANYID =e.INT_COMPANYID 
					//INT_COMPANYID,CHR_COMPANYNAME   com_m_company INT_BRANCHID , CHR_BRANCHNAME com_m_branch
					if("2".equals(Chequedt))
						sql = sql+" AND a.DAT_PAYMENTDATE<='"+tdt+"' AND a.DAT_PAYMENTDATE>='"+fdt+"' ";
					else
						sql = sql+" AND a.CHR_CHKDATE<='"+tdt+"' AND a.CHR_CHKDATE>='"+fdt+"' ";
							
					sql = sql+" ORDER BY a.CHR_SALESORDERNO ";
				}
				else if("DirectBilling".equals(Direct))
				{
					mode = "DIRECT BILLING ";
					 
				}
				else if("ServiceBilling".equals(Direct))
				{
				
					mode = "SERVICE BILLING";
					sql = sql+" SELECT a.CHR_SALESNO , FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),FIND_A_BANKGROUP_NAME(a.INT_BANKID),a.CHR_REFNO, ";
					sql = sql+" date_format(a.DAT_PAYMENTDATE,'%d-%b-%Y'), a.DOU_PAIDAMOUNT,date_format(a.CHR_CHKDATE,'%d-%b-%Y') ";
					sql = sql+"  ,date_format(d.DAT_SALESDATE,'%d-%b-%Y') ,a.CHR_REMARK ";
					sql = sql+"  ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_PAYEMENTCOLLECTEDBY),a.CHR_PAYEMENTCOLLECTEDBY  ";//extra
					sql = sql + ",e.CHR_COMPANYNAME,f.CHR_BRANCHNAME,datediff(a.CHR_CHKDATE,d.DAT_SALESDATE),g.CHR_DIVICODE    FROM inv_t_servicebillingpayment a,";
					sql = sql+" inv_m_customerinfo b, inv_t_servicebilling d ,com_m_company e, com_m_branch f,inv_m_division g  WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
					sql = sql+"   AND a.CHR_SALESNO =d.CHR_SALESNO   AND d.INT_BRANCHID = f.INT_BRANCHID AND f.INT_COMPANYID =e.INT_COMPANYID    AND d.INT_DIVIID = g.INT_DIVIID ";
					 //,e.CHR_COMPANYNAME,f.CHR_BRANCHNAME   ,com_m_company e, com_m_branch f  AND d.INT_BRANCHID = f.INT_BRANCHID AND f.INT_COMPANYID =e.INT_COMPANYID 
					if(!"0".equals(Branch))
						sql = sql+" AND a.INT_BRANCHID ="+Branch;
					
					
					sql = sql + divsql+refsql;
					if(!"0".equals(bank))
						sql = sql+" AND a.INT_BANKID='"+bank+"' ";
					if(!"0".equals(customer))	
						sql = sql+" AND a.INT_CUSTOMERID="+customer;
					
					if("2".equals(Chequedt))
						sql = sql+" AND a.DAT_PAYMENTDATE<='"+tdt+"' AND a.DAT_PAYMENTDATE>='"+fdt+"' ";
					else
						sql = sql+" AND a.CHR_CHKDATE<='"+tdt+"' AND a.CHR_CHKDATE>='"+fdt+"' ";
							
					sql = sql+" ORDER BY a.CHR_SALESNO ";
				}
				
				 //out.println(sql); 
				
				String reportheader="PAYMENY COLLECTION FOR  "+mode+"   [ FROM -"+fromdate +"  TO-  "+ todate +" ] "; 
				Vector mn = new Vector();
				Vector child= null; 
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length>0)
				{
				
					double sum=0.0;
					for(int u=0;u<data.length;u++)
					{
						
						child = new Vector();
						child.addElement((u+1));
						child.addElement(mode);
						 
						child.addElement(data[u][0]);
						child.addElement(data[u][11]);
						child.addElement(data[u][12]);
						child.addElement(data[u][14]);
						child.addElement(data[u][7]);
						child.addElement(data[u][1]);
						child.addElement(data[u][2]);
						child.addElement(data[u][3]);
						child.addElement(data[u][6]);
						
						child.addElement(data[u][13]);
						child.addElement(data[u][8]);
						child.addElement(data[u][9]+" / "+data[u][10]);
						child.addElement(data[u][4]);
						child.addElement(data[u][5]);
						mn.add(child);
						sum = sum+Double.parseDouble(data[u][5]);
						
						 
					}
						child = new Vector();
						child.addElement("");
						 
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement(" TOTAL : ");
						child.addElement(Math.round(sum));
						mn.add(child); 
					 			  
					 
				}
				 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
  
		 
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="INVOICE Type" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="INVOICE NUMBER" sortable="true"><%=temp.elementAt(2)%></display:column>
					 
					<display:column title="BRANCH" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="DIVISION" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="INVOICE DATE " sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Customer Name " sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Bank Name " sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Payment-Details" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Cheque Date" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Day Difference" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Payment Description" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Payment Collected By" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Payment collect Date" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="Paid Amount" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:setProperty name="export.excel.filename" value="Rept_PaymentCollection.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_PaymentCollection.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_PaymentCollection.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					
					
					 
					 
</display:table>     
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center><br /><br />


 
<%		 		 
			}
			catch(Exception e)
			{
			}	
	  %>
	  
 </body>
</html>
