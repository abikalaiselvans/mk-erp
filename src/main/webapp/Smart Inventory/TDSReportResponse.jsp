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
	  	try
			{
	  			String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate"); 
				String customer = request.getParameter("customer");
				String Branch = request.getParameter("Branch");
				String status=request.getParameter("status");
				String division=request.getParameter("division");
				String Direct=request.getParameter("payType"); 
				String creditto = request.getParameter("creditto"); 
				String refsql="";
				String divsql="";
				String sql="";
				String fdt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate);
				String tdt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
				String mode="";
				if("Direct".equals(Direct))
				{
					mode = "DIRECT SALES";
					sql = "SELECT a.CHR_SALESNO saleno, DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y') saledate, FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) customer,   "; 
					sql = sql + " SUM(a1.DOU_TOTAL - a1.DOU_TAX_AMOUNT)  beforetax,   "; // FUN_INV_DIRECT_SALE_BEFORE_TAX_AMOUNT( a.CHR_SALESNO)
					sql = sql + " a.DOU_TOTALAMOUNT netamount, b.DOU_PAIDAMOUNT tdsamount,c.CHR_DEPOSITNAME tds,  b.CHR_PAYNO tdsP, b.DAT_PAYMENTDATE tdsdate,   ";
					sql = sql + " FIND_A_EMPLOYEE_NAME_ONLY(a.CHR_REF) manager1,FIND_A_EMPLOYEE_NAME_ONLY(a.CHR_REF1) manager2,  ";
					sql = sql + " b.DOU_TDS_RECEIVED_AMOUNT, b.CHR_TDS_RECEIVE_DATE, ( b.DOU_PAIDAMOUNT - b.DOU_TDS_RECEIVED_AMOUNT) balance";
					sql = sql + " from inv_t_directsales a, inv_t_swapsalesitem a1, inv_t_customersalespayment b, com_m_deposit_to c,inv_m_division d   ";
					sql = sql + " WHERE a.CHR_CANCEL ='N' AND a.CHR_SALESTYPE !='R' AND a.DOU_TOTALAMOUNT >0 AND a.CHR_SALESNO = a1.CHR_SALESNO  ";
					sql = sql + " AND a.CHR_SALESNO= b.CHR_SALESORDERNO AND b.INT_DEPOSITID = b.INT_DEPOSITID   ";
					sql = sql + " AND a.INT_DIVIID=d.INT_DIVIID ";
					if(status.equals("R")){
						sql = sql + "  AND b.DOU_TDS_RECEIVED_AMOUNT > 0 ";
					}
					else if (status.equals("N")){
						sql = sql + " AND b.DOU_TDS_RECEIVED_AMOUNT < b.DOU_PAIDAMOUNT ";
					}
					 
					if(!"0".equals(division))
						sql = sql +" AND a.INT_DIVIID="+division+" ";
					
					sql = sql + " AND b.INT_DEPOSITID =  "+creditto;
					sql = sql + " AND c.INT_DEPOSITID =  "+creditto;
					sql = sql + " AND a.DAT_SALESDATE<='"+tdt+"' AND a.DAT_SALESDATE>='"+fdt+"' ";
					sql = sql + " GROUP BY a.CHR_SALESNO  ";
					sql = sql + " ORDER BY a.DAT_SALESDATE DESC   ";
					
				}
				else if("DirectBilling".equals(Direct))
				{
					mode = "DIRECT BILLING ";
				}
				else if("ServiceBilling".equals(Direct))
				{
					mode = "SERVICE BILLING";
				}
				//out.println(sql); 
				String reportheader="TDS RECEIVABLE FOR  "+mode+"   [ FROM -"+fromdate +"  TO-  "+ todate +" ] "; 
				Vector mn = new Vector();
				Vector child= null; 
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length>0)
				{
					double sum=0.0;
					double paid=0.0;
					double balance=0.0;
					for(int u=0;u<data.length;u++)
					{
						
						child = new Vector();
						child.addElement((u+1));
						child.addElement(mode);
						 
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
						sum = sum+Double.parseDouble(data[u][5]);
						paid = paid+Double.parseDouble(data[u][11]);
						balance = balance+Double.parseDouble(data[u][13]);
					}
						child = new Vector();
						child.addElement("");
						 
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement(" TOTAL : ");
						child.addElement(Math.round(sum));
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement("");
						child.addElement(Math.round(paid));
						child.addElement(""); 
						child.addElement(Math.round(balance)); 
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
					 
					<display:column title="INVOICE DATE" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="CUSTOMER" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="BEFORE TAX " sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="NET AMOUNT" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="TDS AMOUNT" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="TDS" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="TDS %" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="TDS DATE" sortable="true"><%=temp.elementAt(10)%></display:column>
					
					<display:column title="TDS RECEIVED AMOUNT" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="BALANCE" sortable="true"><%=temp.elementAt(15)%></display:column>
					 
					<display:column title="ACCOUNT MANAGER-1" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="ACCOUNT MANAGER-2" sortable="true"><%=temp.elementAt(12)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="Rept_TDSReceivable.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_TDSReceivable.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_TDSReceivable.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
	 				 
		</display:table> 
    
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center><br /><br />

 
					 

			
 
<%		 		 
			}
			catch(Exception e)
			{
				out.println(e.getMessage());
			}	
	  %>
	  
 </body>
</html>
