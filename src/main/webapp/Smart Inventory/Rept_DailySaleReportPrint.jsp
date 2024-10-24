<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%><head>
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
		java.text.NumberFormat formatter = java.text.NumberFormat.getInstance();
		formatter.setMaximumFractionDigits(2);
   		formatter.setMinimumFractionDigits(2); 
		String branchid = session.getAttribute("BRANCHID").toString();
				
		 
		String dt = ""+request.getParameter("dt");
		String dt2 = request.getParameter("dt2");
		String sql = ""+request.getParameter("sql");
		String division = ""+request.getParameter("division");
		String ref = ""+request.getParameter("ref");
		String detail = ""+request.getParameter("detail");
		String custid=request.getParameter("customer");
		String type=request.getParameter("type");
		String Branch=request.getParameter("Branch");
		 
			
		String refid="";
		String div ="";
		String cust ="";
		String reportheader=" SALES ON  :: ("+dt +" to " +dt2+" ) "; 
		Vector mn = new Vector();
	 	Vector child= null; 
		double sum=0.0;
		double totalsum=0.0;
		double pprice=0.0;
		double ssum=0.0;
 
		
		if(("1".equals(type)) || ("0".equals(type) ))
		{
			 
			sql =" SELECT CONCAT('DIRECT SALES'),a.CHR_SALESNO,e.CHR_COMPANYNAME,d.CHR_BRANCHNAME, ";
			sql = sql + " f.CHR_DIVICODE,a.CHR_DESTINATION ,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),c.CHR_STAFFNAME, ";
			sql = sql + " DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), ";
			sql = sql + " a.DOU_AMOUNT,g.CHR_TAXNAME, a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT  ";  
			sql = sql + " FROM inv_t_directsales a ,inv_m_customerinfo b ,com_m_staff c ,com_m_branch d , ";
			sql = sql + " com_m_company e, inv_m_division f , inv_m_tax g ";
			sql = sql + " WHERE a.INT_BRANCHID = d.INT_BRANCHID  ";
			sql = sql + " AND a.CHR_CANCEL='N' AND d.INT_COMPANYID=e.INT_COMPANYID ";
			sql = sql + " AND a.INT_TAXID = g.INT_TAXID  ";
			sql = sql + " AND a.INT_DIVIID=f.INT_DIVIID  ";
			sql = sql + " AND a.DAT_SALESDATE >= '"+dt+"' ";
			sql = sql + " AND a.DAT_SALESDATE <='"+dt2+"' ";
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID="+division ;
			if(!"0".equals(custid))
				sql = sql + "  AND a.INT_CUSTOMERID="+custid ;
			if(!"0".equals(ref))
				sql = sql + "  AND a.CHR_REF ='"+ref+"' ";
			if(!"0".equals(Branch))
				sql = sql + "  AND a.INT_BRANCHID="+Branch ;
			sql = sql + "  AND a.INT_SALESSTATUS=1 AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
			sql = sql + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
			//out.println(sql);
			 
			String data[][] = CommonFunction.RecordSetArray(sql);		 
			if(data.length>0)
			{
					
				
				for(int u=0;u<data.length;u++) 
				{
					
					 
					sum = sum+Double.parseDouble(data[u][9]);
					ssum = ssum+Double.parseDouble(data[u][12]);	
					child = new Vector();
					child.addElement((u+1)); 
					child.addElement(data[u][0]); 
					child.addElement(data[u][1]);
					child.addElement("<a href='SwapSaleSerialView.jsp?salno="+data[u][1]+"' target=_blank > Details</a>");
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
				child.addElement(formatter.format(sum));
				child.addElement("");
				child.addElement("");
				child.addElement(formatter.format(ssum));
				mn.add(child);
				 
		}
		
		
	}
		
		 
		


		//Direct Billing
		if(("0".equals(type)) || ("2".equals(type)))
		{
			 
			div="";
			cust="";
			Branch=request.getParameter("Branch");;
					
			
			sql = " SELECT CONCAT('DIRECT BILLING'),a.CHR_SALESNO,e.CHR_COMPANYNAME,d.CHR_BRANCHNAME , ";
			sql = sql + " f.CHR_DIVICODE,CONCAT('-') ,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),c.CHR_STAFFNAME, ";
			sql = sql + " DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), ";
			sql = sql + " a.DOU_AMOUNT,g.CHR_TAXNAME,a.DOU_TAXVALUE,a.DOU_NETAMOUNT  ";
			sql = sql + " FROM inv_t_directbilling a ,inv_m_customerinfo b ,com_m_staff c ,com_m_branch d ,com_m_company e, ";
			sql = sql + " inv_m_division f, inv_m_tax g WHERE a.INT_BRANCHID = d.INT_BRANCHID  ";
			sql = sql + " AND a.INT_DIVIID=f.INT_DIVIID AND d.INT_COMPANYID=e.INT_COMPANYID  ";
			sql = sql + " AND a.INT_TAXID = g.INT_TAXID  ";
			sql = sql + " AND a.DAT_SALESDATE >= '"+dt+"' ";
			sql = sql + " AND a.DAT_SALESDATE <= '"+dt2+"' ";
			
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID="+division ;
			if(!"0".equals(custid))
				sql = sql + "  AND a.INT_CUSTOMERID="+custid ;
			if(!"0".equals(ref))
				sql = sql + "  AND a.CHR_REF ='"+ref+"' ";
			if(!"0".equals(Branch))
				sql = sql + "  AND a.INT_BRANCHID="+Branch ;
			sql = sql + " AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
			sql = sql + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
			//out.println(sql); 
	 		
			String data[][] = CommonFunction.RecordSetArray(sql);		 
			if(data.length>0)
			{
				
				for(int u=0;u<data.length;u++)
				{
					 
					 
					sum = sum+Double.parseDouble(data[u][9]);
					ssum = ssum+Double.parseDouble(data[u][12]);	
					child = new Vector();
					child.addElement((u+1)); 
					child.addElement(data[u][0]); 
					child.addElement(data[u][1]);
					child.addElement("");
					//child.addElement("<a href='DirectBillingEdit.jsp?salesid="+data[u][1]+"' target=_blank > Details</a>");
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
				child.addElement(formatter.format(sum));
				child.addElement("");
				child.addElement("");
				child.addElement(formatter.format(ssum));
				mn.add(child);	
 		 						
			}
		}
		
		
		
		
					
		
		//Service Billing
		if(("3".equals(type) )|| ("0".equals(type)))
		{
			div="";
			cust="";
			Branch=request.getParameter("Branch");;
			 
			
			sql = " SELECT CONCAT('SERVICE BILLING'),a.CHR_SALESNO,e.CHR_COMPANYNAME,d.CHR_BRANCHNAME,  ";
			sql = sql + "  f.CHR_DIVICODE,a.CHR_DESTINATION,  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), c.CHR_STAFFNAME,  ";
			sql = sql + "  DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),  ";
			sql = sql + "  a.DOU_AMOUNT,CONCAT('SERVICE TAX 12.36%'),a.DOU_SERVICE_AMOUNT, a.DOU_NETAMOUNT   ";
			sql = sql + "  FROM inv_t_servicebilling a ,inv_m_customerinfo b ,com_m_staff c,com_m_branch d ,com_m_company e ,  ";
			sql = sql + "  inv_m_division f  WHERE a.INT_BRANCHID = d.INT_BRANCHID   ";
			sql = sql + "  AND a.CHR_CANCEL='N' AND d.INT_COMPANYID=e.INT_COMPANYID   ";
			sql = sql + "  AND a.INT_DIVIID=f.INT_DIVIID   ";
			sql = sql + "  AND a.DAT_SALESDATE >='"+dt+"' ";
			sql = sql + " AND a.DAT_SALESDATE<='"+dt2+"' " ;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID="+division ;
			if(!"0".equals(custid))
				sql = sql + "  AND a.INT_CUSTOMERID="+custid ;
			if(!"0".equals(ref))
				sql = sql + "  AND a.CHR_REF ='"+ref+"' ";
			if(!"0".equals(Branch))
				sql = sql + "  AND a.INT_BRANCHID="+Branch ;
			sql = sql + "  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
			sql = sql + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
			//out.println(sql); 
			  
			 
			String data[][] = CommonFunction.RecordSetArray(sql);		 
			if(data.length>0)
			{
				
				for(int u=0;u<data.length;u++)
				{
					 
					 
					sum = sum+Double.parseDouble(data[u][9]);
					ssum = ssum+Double.parseDouble(data[u][12]);	
					child = new Vector();
					child.addElement((u+1)); 
					child.addElement(data[u][0]); 
					child.addElement(data[u][1]);
					child.addElement("<a href='ServiceBillingPrint.jsp?salno="+data[u][1]+"' target=_blank > Details</a>");
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
				child.addElement(formatter.format(sum));
				child.addElement("");
				child.addElement("");
				child.addElement(formatter.format(ssum));
				mn.add(child);	
		 	}
		}
		
		
		
		
	 
		request.setAttribute("table",mn);
		out.println("<br><center><h3> "+reportheader+" </h3></center> ");
  
%>		 
		 
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Type" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Invoice No" sortable="true" ><%=temp.elementAt(2)%></display:column>
					<display:column title="Branch" sortable="true" ><%=temp.elementAt(5)%></display:column>
					<display:column title="Division" sortable="true" ><%=temp.elementAt(6)%></display:column>
					<display:column title="Destination" sortable="true" ><%=temp.elementAt(7)%></display:column>
					<display:column title="Customer" sortable="true" ><%=temp.elementAt(8)%></display:column>
					<display:column title="Marketing Executives" sortable="true" ><%=temp.elementAt(9)%></display:column>
					<display:column title=" Sales date" sortable="true" ><%=temp.elementAt(10)%></display:column>
                    <display:column title="Amount"  style="text-align:right" sortable="true" ><%=temp.elementAt(11)%></display:column>
                    <display:column title="Tax" sortable="true" ><%=temp.elementAt(12)%></display:column>
                    <display:column title="Tax Amount"  style="text-align:right" sortable="true" ><%=temp.elementAt(13)%></display:column>
                    <display:column title="Net Amount"   style="text-align:right" sortable="true" ><%=temp.elementAt(14)%></display:column>
					<display:column  media="html" title="Details" sortable="true" ><%=temp.elementAt(3)%></display:column>
						
					<display:setProperty name="export.excel.filename" value="Rept_DailySalesReport.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_DailySalesReport.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_DailySalesReport.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     

<br />	<center>	<a   href='Rept_DailySalesReport.jsp' > CLOSE</a></center>

<br /><br />
 
	 		 
<%		 	
}
catch(Exception e)
{

	out.println(e.getMessage());		
}	
	
	 
  %>

 
