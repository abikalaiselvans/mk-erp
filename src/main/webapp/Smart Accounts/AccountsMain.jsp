<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>

<title>:: ACCOUNTS ::</title>

 
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	background="../Image/Smart%20Attendance/background1.jpg">
<%@ include file="indexacct.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
	  <td height="19">
	  <%
	  try
	  {
	 	 //com.my.org.erp.mail.Mail.sendGmail();
	  }
	  catch(Exception e)
	  {
	  }	 
	  %>	   </td>
  </tr>
	<tr>
	  <td height="19">
	  
	  <%
	  try
	  {
		  	String CurrentFinancialYear = com.my.org.erp.common.CommonFunctions.CurrentFinancialYear();
			String sql = "";
			sql =" SELECT date(now()), month(now()),monthname(now()),year(now())"; 
			String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			int dbmonth=Integer.parseInt(data[0][1]);
			int dbyear=Integer.parseInt(data[0][3]);
			if(dbmonth==4)
			{
				com.my.org.erp.common.CommonFunctions.FinancialYear();
				String finishingstatus = (dbyear-1)+"-"+dbyear;
				
				sql =" SELECT COUNT(*) FROM acc_m_openingbalance WHERE INT_FINANCIALYEARID= ";
				sql = sql+ "(SELECT INT_FINANCIALYEARID FROM  com_m_financialyear WHERE CHR_FINANCIALYEAR='"+finishingstatus+"') ";
				if(!com.my.org.erp.common.CommonFunction.RecordExist(sql))
				{
				%>
				<script language="javascript">
					var d=new Date();
					var day=d.getDate();
					alert(d);
					if(day<=7) 
					{
						var rs  = confirm("You would like to account year closing automatically...");
						var rs1 = confirm("You would like to account year closing automatically...");
						var rs2 = confirm("You would like to account year closing automatically...");
						var rs3 = confirm("You would like to account year closing automatically...");
						if ((rs==true) && (rs1==true) && (rs2==true) && (rs3==true))
						{
							<%
							//Income 
					sql="SELECT SUM(DOU_AMOUNT) FROM   acc_t_receipts   WHERE INT_BRANCHID='"+bch+"' AND INT_FINANCIALYEARID= ";
					sql=sql+"(SELECT INT_FINANCIALYEARID FROM com_m_financialyear WHERE CHR_FINANCIALYEAR='"+finishingstatus+"') ";
							 
							String incomedata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							double income=0;
							if("-".equals(incomedata[0][0]))
								incomedata[0][0]="0";
								
							if(incomedata.length>0)
								income = Double.parseDouble(incomedata[0][0]);
							
							//Expense
							sql =" SELECT SUM(DOU_AMOUNT) FROM  acc_t_payments   WHERE  INT_BRANCHID='"+bch+"' AND INT_FINANCIALYEARID= ";
							sql = sql+ " (SELECT INT_FINANCIALYEARID FROM  com_m_financialyear WHERE CHR_FINANCIALYEAR='"+finishingstatus+"') ";
							 
							String expensedata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							double expense=0;
							if("-".equals(expensedata[0][0]))
								expensedata[0][0]="0";
								
							if(expensedata.length>0)
								expense = Double.parseDouble(expensedata[0][0]);
							 
							 double incomedifference=0;
							 double expensedifference=0;
							 if(income>expense)
							 	incomedifference =income-expense;
							 else
							 	expensedifference =expense-income;
								
							sql="INSERT INTO acc_m_openingbalance (INT_FINANCIALYEARID,INT_COMPANYID,INT_BRANCHID,DOU_OPENINGINCOME,DOU_OPENINGEXPENSE,CHR_USRNAME,DT_UPDATEDATE, CHR_UPDATESTATUS)";	
							sql = sql +" VALUES ( (SELECT INT_FINANCIALYEARID FROM  com_m_financialyear WHERE CHR_FINANCIALYEAR='"+finishingstatus+"') ,";
							sql = sql +" "+cpy+", ";
							sql = sql +" "+bch+", ";
							sql = sql +incomedifference+" ,";
							sql = sql +expensedifference+" , 'ADMIN',now(),'Y')";
							com.my.org.erp.common.CommonFunctions.Execute(sql);
							%>
							alert("Account Year Closing Finished...");
						}	
					}	
				</script>
				<%
				}
			}	
		}
		catch(Exception e)
		{
			out.println(e.getMessage());
		}	
	  %>	  </td>
  </tr>
	<tr>
	  <td height="19"><!--DWLayoutEmptyCell-->&nbsp;</td>
  </tr>
	<tr>
	  <td height="19">
	  
	  </td>
  </tr>
	<tr>
	  <td height="19" >	  </td>
  </tr>
	<tr>
	  <td height="19">
	  <%
	  try
	  {
	  		String gh = com.my.org.erp.common.CommonFunctions.dateandTimeDifference("2009-06-01 22:30:10", "2011-06-06 17:02:00");
	  		out.println(gh);
			
	  
	  }
	  catch(Exception e)
	  {
		}
		%>	  </td>
  </tr>
	<tr>
		<td height="19">
		<%
		//com.my.org.erp.common.CommonFunctions.CurrentFinancialYear()
		
		%></td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>

</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
