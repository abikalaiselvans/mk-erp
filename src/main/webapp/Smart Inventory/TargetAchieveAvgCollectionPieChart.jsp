<%@page import="java.io.*"%>
<%@page import="java.awt.*"%>
<%@page import="com.lowagie.text.*"%>
<%@page import="com.lowagie.text.pdf.*"%>
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

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>


<%
try 
{
	 
	 
	          
			response.setContentType("application/pdf");
			PdfWriter.getInstance(document, response.getOutputStream());
			document.open();
			document.add(new Paragraph("Hello Kiran"));
			document.addTitle("Mythra PAY SLIP");
			document.add(new Paragraph(new Date().toString()));
		 
	     
			document.close(); 
	
			String years= request.getParameter("year");
    		String Branch= request.getParameter("Branch");
    		String division= request.getParameter("division");
    		String months= request.getParameter("month");
    		String sql="";
    		int year = Integer.parseInt(years);
    		int month = Integer.parseInt(months);
    		sql ="SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM inv_m_customergroup ORDER BY INT_CUSTOMERGROUPID";
    		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		/*
    			StringBuffer sb = new StringBuffer();
    			
				for(int u=0;u<data.length;u++)
				{
					sql = " SELECT count(*) ";
					sql = sql+ " FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d ";
					sql = sql+ " WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO ";
					sql = sql+ " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
					sql = sql+ " AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID "; 
					sql = sql+ " AND a.INT_BRANCHID= "+Branch;
					if(!"0".equals(division))
						sql = sql+ " AND b.INT_DIVIID= "+division;
					sql = sql+ " AND MONTH(a.DAT_PAYMENTDATE)= "+month;
					sql = sql+ " AND YEAR(a.DAT_PAYMENTDATE) = "+year;
					sql = sql+ " AND d.INT_CUSTOMERGROUPID= "+data[u][0] ;
					
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{	
						sql = " SELECT count(*) ,sum(a.DOU_PAIDAMOUNT),sum(DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE)), ";
						sql = sql+ " sum(DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE))/count(*) ";
						sql = sql+ " FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d ";
						sql = sql+ " WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO ";
						sql = sql+ " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
						sql = sql+ " AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID "; 
						sql = sql+ " AND a.INT_BRANCHID= "+Branch;
						if(!"0".equals(division))
							sql = sql+ " AND b.INT_DIVIID= "+division;
						sql = sql+ " AND MONTH(a.DAT_PAYMENTDATE)= "+month;
						sql = sql+ " AND YEAR(a.DAT_PAYMENTDATE) = "+year;
						sql = sql+ " AND d.INT_CUSTOMERGROUPID= "+data[u][0] ;
						String vdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						sb.append("<TargetAssign>");
		   		 		sb.append("<Groupname>" + data[u][1]+ "</Groupname>");
		   		 		sb.append("<NoofINV>" + vdata[0][0]+ "</NoofINV>");
		   		 		sb.append("<Collectionamt>" +com.my.org.erp.common.CommonFunctions.Round((Double.parseDouble(vdata[0][1]))) +"</Collectionamt>");
		   		 		sb.append("<Collectionday>" + vdata[0][2]+ "</Collectionday>");
		   		 		sb.append("<Avg>" + com.my.org.erp.common.CommonFunctions.Round((Double.parseDouble(vdata[0][3])))+ "</Avg>");
		   		 		 
						sb.append("<Detailed>"+data[u][0]+"</Detailed>");
		   		 		sb.append("</TargetAssign>");
		   		 	}
					else
					{
						sb.append("<TargetAssign>");
		   		 		sb.append("<Groupname>" + data[u][1]+ "</Groupname>");
		   		 		sb.append("<NoofINV>0</NoofINV>");
		   		 		sb.append("<Collectionamt>0</Collectionamt>");
		   		 		sb.append("<Collectionday>0</Collectionday>");
		   		 		sb.append("<Avg>0</Avg>");
		   		 		sb.append("<Detailed>0</Detailed>");
		   		 		sb.append("</TargetAssign>");
					}
				}
				 
				 
			*/

}
catch (Exception e2) 
{
	System.out.println(e2.getMessage());
}

%>