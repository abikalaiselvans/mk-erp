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
		 
		String sql ="";
		String salestype = request.getParameter("salestype");
		String Branch = request.getParameter("Branch");
		String division = request.getParameter("division");
		String status = request.getParameter("status");
		
		
		Vector mn = new Vector();
	 	Vector child= null;
		String title="";
		String reportheader="PAYMENT COMMITMENT REPORT";
		if("C".equals(salestype)  || "A".equals(salestype) )
		{
			title="CUSTOMER SALES";
			sql ="";
			sql = " SELECT a.INT_PAYMENTCOMMITMENTID, a.CHR_SALESNO, a.CHR_INVOICETYPE, DATE_FORMAT(b.DAT_SALESDATE,'%d-%b-%Y'), ";
			sql = sql +" DATEDIFF(a.DT_COMMITMENTDATE,b.DAT_SALESDATE), DATE_FORMAT(a.DT_COMMITMENTDATE,'%d-%b-%Y'),a.DOU_COMMITMENTAMOUNT,a.DT_RECIEVEDDATE,a.DOU_RECEIVEDAMOUNT, ";
			sql = sql +" a.CHR_DESCRIPTION, (b.DOU_TOTALAMOUNT -a.DOU_RECEIVEDAMOUNT )  ,a.CHR_STATUS,a.CHR_PAYMENTFLAG,a.CHR_NEXTFLAG ,b.DOU_TOTALAMOUNT,FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID ) ,d.CHR_DIVICODE  ";
			sql = sql +"  FROM inv_t_paymentcommitment a,inv_t_directsales b,inv_m_customerinfo c,inv_m_division d WHERE a.CHR_SALESNO=b.CHR_SALESNO  AND b.INT_CUSTOMERID =c.INT_CUSTOMERID AND  b.CHR_CANCEL='N'  ";
			sql = sql +"  AND b.INT_DIVIID= d.INT_DIVIID AND a.CHR_INVOICETYPE='C'		 ";
			if(!"0".equals(Branch))
				sql = sql+" AND b.INT_BRANCHID ="+Branch;
			if(!"0".equals(division))
				sql = sql+" AND  b.INT_DIVIID ="+division;
			 
			sql = sql+" AND a.CHR_PAYMENTFLAG = '"+status+"'";
			sql = sql +"  ORDER BY a.CHR_SALESNO,a.DT_COMMITMENTDATE  ";
			//out.println(sql);
			String Data[][] =  CommonFunctions.QueryExecute(sql);
			if(Data.length>0)
			{
					for(int u=0;u<Data.length;u++)
					{
						child = new Vector();
						child.addElement((u+1));
						child.addElement("CUSTOMER SALES" );
						child.addElement(Data[u][1]); 
						child.addElement(Data[u][15]); 
						child.addElement(Data[u][16]); 
						child.addElement(Data[u][3]); 
						child.addElement(Data[u][5]); 
						child.addElement(Data[u][4]);
						child.addElement(Data[u][14]);  
						child.addElement(Data[u][6]); 
						child.addElement(Data[u][7]); 
						child.addElement(Data[u][8]); 
						child.addElement(Data[u][9]); 
						child.addElement(Data[u][10]); 
						 
						if("Y".equals(Data[u][11]))
							child.addElement("Commitment assigned");
						else
							child.addElement("Commitment not assigned");	
							
					   if("Y".equals(Data[u][12]))
							child.addElement("Payment Received");
						else
							child.addElement("Payment Not Received");	
						 
						if("Y".equals(Data[u][13]))
							child.addElement("Commitment postponed");
						else
							child.addElement("");	
							
						 
						mn.add(child);
					}
			}
			
		}	
		else if("D".equals(salestype) || "A".equals(salestype) )
		{
			title="DIRECT BILLING";
			sql ="";
			sql = " SELECT a.INT_PAYMENTCOMMITMENTID, a.CHR_SALESNO, a.CHR_INVOICETYPE, DATE_FORMAT(b.DAT_SALESDATE,'%d-%b-%Y'), ";
			sql = sql +" DATEDIFF(a.DT_COMMITMENTDATE,b.DAT_SALESDATE), DATE_FORMAT(a.DT_COMMITMENTDATE,'%d-%b-%Y'),a.DOU_COMMITMENTAMOUNT,a.DT_RECIEVEDDATE,a.DOU_RECEIVEDAMOUNT, ";
			sql = sql +" a.CHR_DESCRIPTION,   (b.DOU_NETAMOUNT -a.DOU_RECEIVEDAMOUNT )     ,a.CHR_STATUS,a.CHR_PAYMENTFLAG,a.CHR_NEXTFLAG,b.DOU_NETAMOUNT,FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID ) ,d.CHR_DIVICODE    ";
			sql = sql +"  FROM inv_t_paymentcommitment a,inv_t_directbilling b,inv_m_customerinfo c,inv_m_division d  WHERE a.CHR_SALESNO=b.CHR_SALESNO  AND b.INT_CUSTOMERID =c.INT_CUSTOMERID ";
			sql = sql +" AND b.INT_DIVIID= d.INT_DIVIID AND a.CHR_INVOICETYPE='D'		 ";
			if(!"0".equals(Branch))
				sql = sql+" AND b.INT_BRANCHID ="+Branch;
			if(!"0".equals(division))
				sql = sql+" AND  b.INT_DIVIID ="+division;
			sql = sql+" AND a.CHR_PAYMENTFLAG = '"+status+"'";
			sql = sql +"  ORDER BY a.CHR_SALESNO,a.DT_COMMITMENTDATE  ";
			String Data[][] =  CommonFunctions.QueryExecute(sql);
			if(Data.length>0)
			{
					for(int u=0;u<Data.length;u++)
					{
						
						child = new Vector();
						child.addElement((u+1));
						child.addElement("DIRECT BILLING" );
						child.addElement(Data[u][1]); 
						child.addElement(Data[u][15]); 
						child.addElement(Data[u][16]); 
						child.addElement(Data[u][3]); 
						child.addElement(Data[u][5]); 
						child.addElement(Data[u][4]);
						child.addElement(Data[u][14]);  
						child.addElement(Data[u][6]); 
						child.addElement(Data[u][7]); 
						child.addElement(Data[u][8]); 
						child.addElement(Data[u][9]); 
						child.addElement(Data[u][10]); 
						 
						if("Y".equals(Data[u][11]))
							child.addElement("Commitment assigned");
						else
							child.addElement("Commitment not assigned");	
							
					   if("Y".equals(Data[u][12]))
							child.addElement("Payment Received");
						else
							child.addElement("Payment Not Received");	
						 
						if("Y".equals(Data[u][13]))
							child.addElement("Commitment postponed");
						else
							child.addElement("");	
						
						mn.add(child);
					}
			}
		}
		else if("S".equals(salestype) || "A".equals(salestype) )
		{
			title="SERVICE BILLING";
			sql ="";
			sql = " SELECT a.INT_PAYMENTCOMMITMENTID, a.CHR_SALESNO, a.CHR_INVOICETYPE, DATE_FORMAT(b.DAT_SALESDATE,'%d-%b-%Y'), ";
			sql = sql +" DATEDIFF(a.DT_COMMITMENTDATE,b.DAT_SALESDATE), DATE_FORMAT(a.DT_COMMITMENTDATE,'%d-%b-%Y'),a.DOU_COMMITMENTAMOUNT,a.DT_RECIEVEDDATE,a.DOU_RECEIVEDAMOUNT, ";
			sql = sql +" a.CHR_DESCRIPTION, (b.DOU_NETAMOUNT -a.DOU_RECEIVEDAMOUNT )   ,a.CHR_STATUS,a.CHR_PAYMENTFLAG,a.CHR_NEXTFLAG  ,b.DOU_NETAMOUNT,FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID ) ,d.CHR_DIVICODE    ";
			sql = sql +"  FROM inv_t_paymentcommitment a,inv_t_servicebilling b,inv_m_customerinfo c,inv_m_division d  WHERE a.CHR_SALESNO=b.CHR_SALESNO  AND b.INT_CUSTOMERID =c.INT_CUSTOMERID";
			sql = sql +"  AND b.INT_DIVIID= d.INT_DIVIID AND a.CHR_INVOICETYPE='S'	 AND  b.CHR_CANCEL='N' 	 ";
			if(!"0".equals(Branch))
				sql = sql+" AND b.INT_BRANCHID ="+Branch;
			if(!"0".equals(division))
				sql = sql+" AND  b.INT_DIVIID ="+division;
				
			sql = sql+" AND  a.CHR_PAYMENTFLAG = '"+status+"'";
			sql = sql +"  ORDER BY a.CHR_SALESNO,a.DT_COMMITMENTDATE  ";
			String Data[][] =  CommonFunctions.QueryExecute(sql);
			if(Data.length>0)
			{
					for(int u=0;u<Data.length;u++)
					{
						
						child = new Vector();
						child.addElement((u+1));
						child.addElement("SERVICE BILLING" );
						child.addElement(Data[u][1]); 
						child.addElement(Data[u][15]); 
						child.addElement(Data[u][16]); 
						child.addElement(Data[u][3]); 
						child.addElement(Data[u][5]); 
						child.addElement(Data[u][4]);
						child.addElement(Data[u][14]);  
						child.addElement(Data[u][6]); 
						child.addElement(Data[u][7]); 
						child.addElement(Data[u][8]); 
						child.addElement(Data[u][9]); 
						child.addElement(Data[u][10]); 
						 
						if("Y".equals(Data[u][11]))
							child.addElement("Commitment assigned");
						else
							child.addElement("Commitment not assigned");	
							
					   if("Y".equals(Data[u][12]))
							child.addElement("Payment Received");
						else
							child.addElement("Payment Not Received");	
						 
						if("Y".equals(Data[u][13]))
							child.addElement("Commitment postponed");
						else
							child.addElement("");	
							
						mn.add(child);
					}
			}
		}
	
	
	
	request.setAttribute("table",mn);
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="TYPE"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Invoice No" sortable="true" ><%=temp.elementAt(2)%></display:column>
 					<display:column title="Customer Name" sortable="true" ><%=temp.elementAt(3)%></display:column>
 					<display:column title="Division" sortable="true" ><%=temp.elementAt(4)%></display:column>
					<display:column title="Invoice Date" sortable="true" ><%=temp.elementAt(5)%></display:column>
					<display:column title="CommitmentDate" sortable="true" ><%=temp.elementAt(6)%></display:column>
					<display:column title="Day Difference" sortable="true" ><%=temp.elementAt(7)%></display:column>
					<display:column title="Invoice Amount"  style="text-align:right" sortable="true" ><%=temp.elementAt(8)%></display:column>
					<display:column title="Commitment Amount"  style="text-align:right" sortable="true" ><%=temp.elementAt(9)%></display:column>
					<display:column title="Received Date" sortable="true" ><%=temp.elementAt(10)%></display:column>
					<display:column title="Received Amount" style="text-align:right" sortable="true" ><%=temp.elementAt(11)%></display:column>
					<display:column title="Description" sortable="true" ><%=temp.elementAt(12)%></display:column>
					<display:column title="Balance"  style="text-align:right" sortable="true" ><%=temp.elementAt(13)%></display:column>
					<display:column title="Commitment Status" sortable="true" ><%=temp.elementAt(14)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="Rept_PaymentCommitmentBillingwise.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_PaymentCommitmentBillingwise.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_PaymentCommitmentBillingwise.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table>     
<br />	<center>	<a href='Rept_PaymentCommitmentBillingwise.jsp'> CLOSE</a></center>
<% 	  
		 
 }
 catch(Exception e)
 {
 }
 %>
 </body>
</html>
