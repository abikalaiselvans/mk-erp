<%@ page import="java.sql.*,java.util.*,java.io.*" autoFlush ="true"%>
<%@ page import="com.my.org.erp.common.*" %>
<%@ page import="com.my.org.erp.setting.*"%>
<%
try
{
	CommonFunctions.autoUpdate(request,""+application.getInitParameter("Auto"));
%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


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
<body  onpaste='return false;'>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index.jsp"%></td>
  </tr>
  <tr>
    <td height="200">
	  
	    <%
		
		/*
		String sql = " SELECT COUNT(*) FROM att_t_commonholiday  WHERE MONTH(now()) = MONTH(DT_HOLIDATE) AND YEAR(NOW()) = YEAR(DT_HOLIDATE) AND CHR_STATUS='N' ";
		String Data[][] =CommonFunctions.QueryExecute(sql);
		if(Data.length>0)
		{
			sql = " SELECT  DAY(DT_HOLIDATE),CHR_MONTH,INT_YEAR,DT_HOLIDATE   FROM att_t_commonholiday  WHERE MONTH(now()) = MONTH(DT_HOLIDATE) AND YEAR(NOW()) = YEAR(DT_HOLIDATE) ";
			 
			String Data1[][] = CommonFunctions.QueryExecute(sql);
			if(Data1.length>0)
			for(int u=0;u<Data1.length;u++)
			{
				
				sql="UPDATE att_t_register SET CHR_MORNING"+Data1[u][0]+"='HOL' ,";
				sql=sql+ " CHR_EVENING"+Data1[u][0]+" ='HOL' ";
				sql = sql+" WHERE CHR_MONTH =( SELECT monthname('"+Data1[u][3]+"') )  AND ";
				sql = sql+" INT_YEAR = ( SELECT year('"+Data1[u][3]+"'))  ";
				 
				CommonFunctions.Execute(sql);
				
				sql = " UPDATE att_t_commonholiday SET CHR_STATUS='Y' WHERE DT_HOLIDATE='"+Data1[u][3]+"'";
				//com.my.org.erp.common.CommonFunctions.Execute(sql);
			}
		}
		
		
		sql ="SELECT (DAY(NOW())<=31), (DAY(NOW())>=27),((DAY(NOW()) <=31) AND (DAY(NOW())>=27)), MONTHNAME(NOW()), YEAR(NOW())";
		String MData[][] =  CommonFunctions.QueryExecute(sql);
		if(MData.length>0)
		{
			int f = Integer.parseInt(MData[0][2]);
			if(f == 1)
			{
				if(!CommonFunction.RecordExist("SELECT COUNT(*) FROM att_t_attsendmail WHERE CHR_MONTH = MONTHNAME(NOW()) AND INT_YEAR =YEAR(NOW()) AND CHR_STATUS='Y'"))
				{
					sql = "INSERT INTO att_t_attsendmail (CHR_MONTH,INT_YEAR,CHR_STATUS,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (MONTHNAME(NOW()), YEAR(NOW()) , 'Y','"+session.getAttribute("USRID")+"',NOW(),'Y')";
					CommonFunctions.Execute(sql);
					com.my.org.erp.mail.Mail.SimpleMail(  ""+CommonData.mailid, "Please update your Attendance   ", "<h1 style='color:#FF0000'>Alert Please update your attendance, else processing of salary will be delayed..</h1>");
					 
				}
			}	
		}
		
		session.removeAttribute("attinfo"); 
	

		System.out.println("DELETE PREVIOUS MONTH RESIGNNER ID"); 
		
		sql = " SELECT CHR_EMPID FROM pay_m_emp_termination WHERE  ";
		sql = sql + " MONTHNAME(DT_TERM_DATE) = (SELECT MONTHNAME(date_sub(current_date, INTERVAL 1 MONTH))) ";
		sql  = sql + " AND YEAR(DT_TERM_DATE) = (SELECT YEAR(date_sub(current_date, INTERVAL 1 MONTH))) ";
		sql  = sql + "AND DAY(NOW()) >=15";
		String RData[][] = CommonFunctions.QueryExecute(sql);
		if(RData.length>0)
		{
			sql = " DELETE FROM att_t_register WHERE CHR_MONTH=MONTHNAME(NOW())  AND INT_YEAR=YEAR(NOW()) ";
			sql  = sql + " AND CHR_EMPID IN ( ";
			for(int y=0;y<RData.length;y++)
				sql  = sql + " '" +RData[y][0]+"',";
			sql  = sql + " '0' ) "	;
			CommonFunctions.Execute(sql);
			
		}*/
 
 
 		


	
%>    </td>
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
	System.out.println(e.getMessage());
 }
 %>
</body>
</html>
