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
 <script language="javascript" src="../JavaScript/comfunction.js"></script><title>:: INVENTORY ::</title> 


 
 
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
 		
		 String sql ="";
		 String salestype = request.getParameter("type");
		 String title="";
		 
		if("C".equals(salestype))
		{
			  title="CUSTOMER SALES";
			  sql="";
			  sql = " SELECT g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,a.CHR_SALESNO,e.CHR_DIVICODE,DATE_FORMAT(a.DAT_SALESDATE,'%d-%m-%Y') ,  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), a.CHR_REF,h.CHR_STAFFNAME,";
			  sql = sql + " a.DOU_TOTALAMOUNT,a.CHR_NOOFPAYMENTCOMMITMENT,d.DT_COMMITMENTDATE,d.DOU_COMMITMENTAMOUNT ,a.CHR_PAYMENTSTATUS ";
			  sql = sql + "  FROM inv_t_directsales  a ,inv_m_customerinfo b   ,inv_t_paymentcommitment d,inv_m_division e, ";
			  sql = sql + "  com_m_branch f , com_m_company g,com_m_staff h ";
			  sql = sql + "  where  d.CHR_SALESNO =a.CHR_SALESNO  ";
			  sql = sql + "  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
			  sql = sql + "   AND a.INT_DIVIID = e.INT_DIVIID  ";
			  sql = sql + "  AND a.INT_BRANCHID= f.INT_BRANCHID ";
			  sql = sql + "  AND f.INT_COMPANYID = g.INT_COMPANYID ";
			  sql = sql + "  AND a.CHR_REF=h.CHR_EMPID ";
			  sql = sql + "   AND a.CHR_PAYMENTSTATUS !='Y' ";
			  sql = sql + "  AND Date(d.DT_COMMITMENTDATE) = date(now()) ";
			  sql = sql + "  order by CHR_SALESNO, DAT_SALESDATE "; //GROUP BY a.CHR_SALESNO
		}
		else if("D".equals(salestype))
		{
			title="DIRECT BILLING";
			sql = " SELECT  g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,a.CHR_SALESNO ,e.CHR_DIVICODE,date_format(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_REF , c.CHR_STAFFNAME,   ";
			sql = sql + "  a.DOU_AMOUNT,  a.CHR_NOOFPAYMENTCOMMITMENT,d.DT_COMMITMENTDATE,d.DOU_COMMITMENTAMOUNT ,a.CHR_PAYMENTSTATUS  ";
			sql = sql + "  FROM inv_t_directbilling a, inv_m_customerinfo b ,com_m_staff c  ,inv_t_paymentcommitment d ,inv_m_division e,com_m_branch f , com_m_company g   ";
			sql = sql + "  WHERE  a.CHR_SALESNO =d.CHR_SALESNO    ";
			sql = sql + "  AND a.INT_CUSTOMERID=b.INT_CUSTOMERID     ";
			sql = sql + "  AND c.CHR_EMPID = a.CHR_REF     ";
			sql = sql + "  AND a.CHR_SALESNO =d.CHR_SALESNO    ";
			sql = sql + "  AND a.INT_DIVIID = e.INT_DIVIID    ";
			sql = sql + "  AND a.INT_BRANCHID= f.INT_BRANCHID   ";
			sql = sql + "  AND f.INT_COMPANYID = g.INT_COMPANYID       AND a.CHR_PAYMENTSTATUS !='Y' ";
			sql = sql + "  AND Date(d.DT_COMMITMENTDATE) = date(now())   ";
			sql = sql + "  order by CHR_SALESNO, DAT_SALESDATE	   ";	 		//GROUP BY a.CHR_SALESNO 
		 		 
			
		}	
		else if("S".equals(salestype))
		{
			title="SERVICE BILLING";
			sql = " SELECT g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,a.CHR_SALESNO ,e.CHR_DIVICODE,date_format(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_REF , c.CHR_STAFFNAME,   ";	
			 sql = sql + "  a.DOU_NETAMOUNT,   a.CHR_NOOFPAYMENTCOMMITMENT,d.DT_COMMITMENTDATE,d.DOU_COMMITMENTAMOUNT ,a.CHR_PAYMENTSTATUS  ";	
			 sql = sql + "  FROM inv_t_servicebilling a, inv_m_customerinfo b ,com_m_staff c ,inv_t_paymentcommitment d  ,inv_m_division e,com_m_branch f , com_m_company g   ";	
			 sql = sql + "  WHERE  a.CHR_SALESNO =d.CHR_SALESNO    ";	
			 sql = sql + "  AND a.CHR_SALESNO =d.CHR_SALESNO    ";	 
			 sql = sql + "   AND a.INT_CUSTOMERID=b.INT_CUSTOMERID    ";	
			 sql = sql + "  AND c.CHR_EMPID = a.CHR_REF     ";	
			 sql = sql + "  AND a.INT_DIVIID = e.INT_DIVIID    ";	
			 sql = sql + "  AND a.INT_BRANCHID= f.INT_BRANCHID   ";	
			 sql = sql + "  AND f.INT_COMPANYID = g.INT_COMPANYID       AND a.CHR_PAYMENTSTATUS !='Y' ";	
			 sql = sql + "  AND Date(d.DT_COMMITMENTDATE) = date(now())    ";	
		} 
		String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 
		Vector mn = new Vector();
		Vector child= null; 
		if(Data.length>0)
		{
		
			 
	
			for(int u=0;u<Data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(Data[u][0]);
				child.addElement(Data[u][1]);
				child.addElement(Data[u][2]);
				child.addElement(Data[u][3]);
				child.addElement(Data[u][4]);
				child.addElement(Data[u][5]);
				child.addElement(Data[u][6]);
				child.addElement(Data[u][7]);
				child.addElement(Data[u][8]);
				child.addElement(Data[u][9]);
				child.addElement(Data[u][10]);
				child.addElement(Data[u][11]);
				if("Y".equals(Data[u][11]))
					child.addElement(" Payment Collected..");
				else if("P".equals(Data[u][11]))
					child.addElement(" Payment Partially Collected..");
				else
					child.addElement(" Payment Not Collected..");
				mn.add(child);	
				 	
			}
		}
  	String reportheader  ="PAYMENT COMMITMENT "+title+"  REPORT "; 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center><br>");
 
  
			
  /*
  		 out.println("<center>");
		out.println("<table   class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr bgcolor='#ffffff'>");
		out.println("<td class='boldEleven' colspan='16'  align='center'><b>PAYMENT COMMITMENT "+title+"  REPORT</b></d>");
  		if(Data.length>0)
		{
		
			out.println("<tr class='MRow2'>");	
			out.println("<td class='boldEleven'  ><b>S.NO</b></td>");
			out.println("<td class='boldEleven'  ><b>Company</b></td>");
			out.println("<td class='boldEleven'  ><b>Branch</b></td>");
			out.println("<td class='boldEleven'  ><b>Sales No</b></td>");
			out.println("<td class='boldEleven'  ><b>Division</b></td>");
			out.println("<td class='boldEleven'  ><b>Sale Date</b></td>");
			out.println("<td class='boldEleven'   ><b>Customer Name</b></td>");
			out.println("<td class='boldEleven'  ><b>Empid</b></td>");
			out.println("<td class='boldEleven'  ><b>Staff Name</b></td>");
			out.println("<td class='boldEleven'  ><b>Invoice Amount</b></td>");
			out.println("<td class='boldEleven'  ><b>No of Commitment</b></td>");
			out.println("<td class='boldEleven'  ><b>Commitment Date</b></td>");
			out.println("<td class='boldEleven'  ><b>Commitment Amount</b></td>");
			 out.println("<td class='boldEleven'  ><b>Payment Status</b></td>");

			for(int u=0;u<Data.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");	
				
				out.println("<td class='boldEleven'  >"+(u+1)+".</td>");
				out.println("<td class='boldEleven'  >"+Data[u][0]+"</td>");
				out.println("<td class='boldEleven'  >"+Data[u][1]+"</td>");
				out.println("<td class='boldEleven'  >"+Data[u][2]+"</td>");
				out.println("<td class='boldEleven'  >"+Data[u][3]+"</td>");
				out.println("<td class='boldEleven'  >"+Data[u][4]+"</td>");
				out.println("<td class='boldEleven'  >"+Data[u][5]+"</td>");
				out.println("<td class='boldEleven'  >"+Data[u][6]+"</td>");
				out.println("<td class='boldEleven'  >"+Data[u][7]+"</td>");
				out.println("<td class='boldEleven'  align='right'>"+Data[u][8]+"</td>");
				out.println("<td class='boldEleven'  align='right'>"+Data[u][9]+"</td>");
				out.println("<td class='boldEleven'  >"+Data[u][10]+"</td>");
				out.println("<td class='boldEleven'  align='right'>"+Data[u][11]+"</td>");
		 		out.println("<td class='boldEleven' >");
				if("Y".equals(Data[u][11]))
					out.println(" Payment Collected..");
				else if("P".equals(Data[u][11]))
					out.println(" Payment Partially Collected..");
				else
					out.println(" Payment Not Collected..");
					
				out.println("</td>"); 	
			}
		}
		else
		{
		out.println("<tr bgcolor='#ffffff'>");
		out.println("<td class='boldEleven' colspan='16' align='center'><b>Data not found...</b></d>");
  		
		}
		out.println("</table>");
		out.println("</center>");*/ 
		 
	%>
			
				
	<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Company" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Sales No" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Division" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Sale Date" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Customer Name" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Empid" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Staff Name" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Invoice Amount " sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="No of Commitment " style="text-align:right" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Commitment Date" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Commitment Amount" style="text-align:right" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Payment Status	" sortable="true"><%=temp.elementAt(13)%></display:column>
					 
					 
					<display:setProperty name="export.csv.filename" value="PaymentCommitmentDetailedReport.csv"/>
					<display:setProperty name="export.excel.filename" value="PaymentCommitmentDetailedReport.xls"/>
					<display:setProperty name="export.xml.filename" value="PaymentCommitmentDetailedReport.xml"/>
					<display:setProperty name="export.pdf.filename" value="PaymentCommitmentDetailedReport.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table> 
   

	 		
			
			
			 
			 
 <%	  
 }
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
 %>

</body>
</html>
