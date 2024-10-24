<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>


<%@include file="Redirect.jsp" %>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<title> :: UTILITY :: </title>


</head>

<body  onpaste='return false;'>
<%
try
{
 
	 String mailfeatue =""+request.getParameter("mailfeatue");
	 String emailid =""+request.getParameter("emailid");
	 String deleteuser =""+request.getParameter("deleteuser");
	 String edituser =""+request.getParameter("edituser");
	 String collectionmail =""+request.getParameter("collectionmail");
	 String collectionemailids =""+request.getParameter("collectionemailids");
	 String mailtime =""+request.getParameter("mailtime");
	 String deliverydays =""+request.getParameter("deliverydays");
	 String deliverykilometer =""+request.getParameter("deliverykilometer");
	 String menamechange =""+request.getParameter("menamechange");
	 String emdmail =""+request.getParameter("emdmail");
	 String deliverypendingmail =""+request.getParameter("deliverypendingmail");
	 String installationpendingmail =""+request.getParameter("installationpendingmail");
	 String prlock =""+request.getParameter("prlock");
	 String blockinvoice =""+request.getParameter("blockinvoice");
	 String mailstockbranch[] =request.getParameterValues("mailstockbranch");
	 String contributionlevel1 =""+request.getParameter("contributionlevel1");
	 String contributionlevel2 =""+request.getParameter("contributionlevel2");
	 String creditlimit =""+request.getParameter("creditlimit");
	 String invoicechanges =""+request.getParameter("invoicechanges");
	 String prapproval =""+request.getParameter("prapproval");
	 String perclosed =""+request.getParameter("perclosed");
	 String inwardmail =""+request.getParameter("inward");
	 String paymentupdate =""+request.getParameter("paymentupdate");
	 String stocktransfermail =""+request.getParameter("stocktransfermail");
	 String bypasspr =""+request.getParameter("bypasspr");
	 
	 String bankname =""+request.getParameter("bankname");
   	 String accountnumber =""+request.getParameter("accountnumber");
	 String ifsccode =""+request.getParameter("ifsccode");
	 String footercontent =""+request.getParameter("footercontent");
	 String salesinvoice =""+request.getParameter("salesinvoice");
	
	 if(!"Y".equals(mailfeatue))
	 		mailfeatue="N";
	 if(!"Y".equals(collectionmail))
	 		collectionmail="N";
	 if(!"Y".equals(creditlimit))
	 		creditlimit="N";
			
	 String mailstockbranchs="";
	 if(mailstockbranch.length>0)	 
	 {
		 for(int u=0; u < mailstockbranch.length; u++)
		 	mailstockbranchs = mailstockbranchs +mailstockbranch[u]+",";
	 }
	  
	 String sql = " UPDATE m_inventorysetting SET CHR_MAILENABLE ='"+mailfeatue+"', CHR_INVOICEDELETE='"+emailid+"', CHR_EDITUSER='"+edituser+"' , CHR_DELETEUSER='"+deleteuser+"' , CHR_DAILY_COLLECTION_MAIL='"+collectionmail+"',CHR_DAILY_COLLECTION_MAIL_IDS='"+collectionemailids+"', INT_DAILY_COLLECTION_MAIL_TIME="+mailtime+" , INT_DELIVERYDAYS="+deliverydays+" , INT_DELIVERY_KM = "+deliverykilometer +" , INT_ME_NAME_CHANGE="+menamechange+" ,CHR_EMD_MAILIDS ='"+emdmail+"', CHR_DELIVERY_PENDING_MAIL_IDS='"+deliverypendingmail+"',CHR_INSTALLATION_PENDING_MAIL_IDS = '"+installationpendingmail+"', INT_PURCHASEREQUEST_LOCK ="+prlock+" , CHR_STOCKMAIL_ALERT_BRANCH='"+mailstockbranchs+"',INT_UNBLOCK ="+blockinvoice+",INT_CONTRIBUTION_LEVEL1   ="+contributionlevel1+" ,INT_CONTRIBUTION_LEVEL2   ="+contributionlevel2+", CHR_CUSTOMERCREDITLIMIT='"+creditlimit+"', CHR_PR_APPROVAL='"+prapproval+"', CHR_PR_CLOSED='"+perclosed+"', CHR_INWARDMAIL ='"+inwardmail+"', CHR_STOCKTRANSFERMAIL ='"+stocktransfermail+"', CHR_PAYMENTMAIL ='"+paymentupdate+"' , CHR_PR_BYPASS='"+bypasspr+"', INT_INVOCECHANGES = "+invoicechanges+" , CHR_BANK_NAME='"+bankname+"', CHR_IFSCCODE='"+ifsccode+"', CHR_ACCOUNT_NO='"+accountnumber+"', CHR_FOOTER_CONTENT='"+footercontent+"',  CHR_SALES_INVOICE_CREATED ='"+salesinvoice+"'   WHERE INT_ROWID=1";
 //out.println(sql); 

//CHR_BANK_NAME,CHR_IFSCCODE,CHR_ACCOUNT_NO, CHR_FOOTER_CONTENT
 	 CommonFunctions.Execute(sql);
	 %>
     
     <p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center" class="DataGridFixedHeader">Updated Sucessfully</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<h3>
<p align="center" class="boldThirteen">Do you want to change Inventory Settings again : <a href="InventorySetting.jsp">YES</a>&nbsp;/&nbsp;<a
	href="Userframe.jsp">NO</a></p>
<p align="center" class="boldThirteen">&nbsp;</p>
</h3>

     
     <%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}

%>



</body>
</html>
