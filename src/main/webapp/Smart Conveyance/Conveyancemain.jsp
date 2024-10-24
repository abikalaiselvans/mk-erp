<%@ page contentType="text/html; charset=iso-8859-1" language="java"	import="java.sql.*,java.text.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
	CommonFunctions.autoUpdate(request,""+application.getInitParameter("Auto"));
%>
<html>
<head>
 

<title> :: CONVEYANCE ::</title>


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

</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index.jsp"%></td>
  </tr>
  <tr>
    <td height="480">
	
	<%
					DecimalFormat myFormatter = new DecimalFormat("0.00");
					// Conveyance List alert
					String fsql= " select count(*) from conveyance_t_conveyance a, com_m_staff b     ";
					fsql = fsql + " WHERE a.CHR_EMPID in(SELECT c.CHR_EMPID FROM com_m_staff c WHERE c.CHR_REPTO='"+session.getAttribute("EMPID")+"'   ";
					fsql = fsql + " AND CHR_TYPE!='T' AND CHR_HOLD!='Y' order by CHR_STAFFNAME )    ";
					fsql = fsql + " AND a.CHR_EMPID =b.CHR_EMPID AND a.CHR_STATUS='N'   ";  
					fsql = fsql + " group by a.CHR_EMPID ORDER BY  b.CHR_STAFFNAME  ";
					//out.println(fsql);
					String dconata[][]=  CommonFunctions.QueryExecute(fsql);
					if(dconata.length>0)
					{
						%>
          <script language="javascript">
							alert("Please give the conveyance approval for <%=dconata.length%> employee... ")
						</script>
          <%
					}

				%>      
	
	
	
	
	
	<%
fsql ="";
fsql = " INSERT INTO conveyance_t_backup   ";
fsql = fsql + " (  ";
fsql = fsql + " CHR_EMPID,	DAT_CONDATE,	CHR_REPTTO,	INT_DIVID,	CHR_FROM,	CHR_TO,	DOU_KM,	DOU_TRAVEL,	DOU_TRAIN,  ";
fsql = fsql + " DOU_AUTO,	DOU_LUNCH,	DOU_TELEPHONE,	CHR_OTHERDESC,	DOU_OTHERAMT,	DOU_TOTAL,	CHR_STATUS,  ";
fsql = fsql + " CHR_ACCEPT,	CHR_DESC,	CHR_ACCSTATUS,	DAT_ACCDATE,	CHR_CALLID,	INT_BANKID,	DAT_CLEARINGDATE,  ";
fsql = fsql + " CHR_CLEARING_DESC,	CHR_FUTURE4,	CHR_FUTURE5,	CHR_FUTURE6,	DAT_CREATION_TIME,  ";
fsql = fsql + " DAT_MODIFIED_TIME,DAT_APPROVAL_TIME,	CHR_USRNAME	,DT_UPDATEDATE,	CHR_UPDATESTATUS  ";
fsql = fsql + " )  ";
fsql = fsql + " SELECT CHR_EMPID,	DAT_CONDATE,	CHR_REPTTO,	INT_DIVID,	CHR_FROM,	CHR_TO,	DOU_KM,	DOU_TRAVEL,	DOU_TRAIN,  ";
fsql = fsql + " DOU_AUTO,	DOU_LUNCH,	DOU_TELEPHONE,	CHR_OTHERDESC,	DOU_OTHERAMT,	DOU_TOTAL,	CHR_STATUS,  ";
fsql = fsql + " CHR_ACCEPT,	CHR_DESC,	CHR_ACCSTATUS,	DAT_ACCDATE,	CHR_CALLID,	INT_BANKID,	DAT_CLEARINGDATE,  ";
fsql = fsql + " CHR_CLEARING_DESC,	CHR_FUTURE4,	CHR_FUTURE5,	CHR_FUTURE6,	DAT_CREATION_TIME,  ";
fsql = fsql + " DAT_MODIFIED_TIME,DAT_APPROVAL_TIME,	CHR_USRNAME	,DT_UPDATEDATE,	CHR_UPDATESTATUS  ";
fsql = fsql + " FROM conveyance_t_conveyance  ";
fsql = fsql + " WHERE CHR_ACCEPT !='N'  "; //CHR_ACCEPT='Y' AND CHR_ACCSTATUS='Y'  
fsql = fsql + " AND DAT_CONDATE <= ( SELECT  DATE_FORMAT( (SELECT DATE_SUB(NOW(),  INTERVAL 120 DAY)) ,'%Y-%m-%d')  )  ";


com.my.org.erp.common.CommonFunctions.Execute(fsql);

fsql ="";
fsql = " DELETE  FROM conveyance_t_conveyance WHERE CHR_ACCEPT !='N'  "; //CHR_ACCEPT='Y' AND CHR_ACCSTATUS='Y'  
fsql = fsql + " AND DAT_CONDATE <= ( SELECT  DATE_FORMAT( (SELECT DATE_SUB(NOW(),  INTERVAL 120 DAY)) ,'%Y-%m-%d')  ) ";
com.my.org.erp.common.CommonFunctions.Execute(fsql);


	%>
	
	</td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>

 <%
 }
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
 %>
</body>
</html>
