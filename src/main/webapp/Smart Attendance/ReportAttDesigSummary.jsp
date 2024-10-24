<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
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


<link href="../Styles/styles.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<table width="99%" border="1" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td height="125">
		<table width="97%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr class="bold1">
				<td colspan="12">&nbsp;</td>
			</tr>
			<tr class="bold1">
				<td colspan="12">&nbsp;</td>
			</tr>
			<tr class="bold1">
				<td colspan="12"><%@ include file="../PrintHeader.jsp"%></td>
			</tr>
			<tr class="bold1">
				<td colspan="12">&nbsp;</td>
			</tr>
			<tr class="bold1">
				<td width="4%">S.No</td>
				<td width="9%">EmployeeId</td>
				<td width="12%">Employee Name</td>
				<td width="13%">Designation Name</td>
				<td width="10%">Present Days</td>
				<td width="10%">Absent Days</td>
				<td width="5%">Leave</td>
				<td width="7%">On Duty</td>
				<td width="4%">Late</td>
				<td width="7%">Holiday</td>
				<td width="7%">Sunday</td>
				<td width="12%">OverTimeMin</td>
			</tr>
			<tr>
				<td colspan='12'>
				<hr size='1' width='100%' />
				</td>
				<%
      
      	String month= request.getParameter("Month");
   	 	String year=request.getParameter("Year");
		 String atda=request.getParameter("atda");
         String desig=""; 
      	 String Sname="";
      	 String EmpId="";
      	 String pres="";
      	 String abs="";
      	 String lea="";
      	 String onduty="";
      	 String late="";
      	 String hday="";
      	 String sday="";
      	 String otimes="",msg="";
      		
      	 
     String sql=" SELECT B.CHR_EMPID,B.CHR_STAFFNAME,A.CHR_DESIGNAME,";
      sql=sql+"C.DOU_PRESENT,C.DOU_ABSENT,C.DOU_LEAVE,C.DOU_OD,C.INT_LATE,C.DOU_HOLIDAY,";
     sql=sql+" C.DOU_SUNDAY,C.INT_OTMINS FROM com_m_desig A,com_m_staff B,att_t_attendancedetail C ";
     sql=sql+"where B.INT_DESIGID=A.INT_DESIGID AND B.CHR_EMPID=C.CHR_EMPID AND C.LOGMONTH LIKE '"+month+"' AND C.LOGYEAR='"+year+"'";
     String count[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
     if(count.length==0)
     {
    	 msg="DATA NOT FOUND";
     }
     else
     	{
     		for(int i=0;i<count.length;i++)
          	{
        	  
        	  EmpId=count[i][0];
        	  Sname=count[i][1];
        	  desig=count[i][2];
        	  pres=count[i][3];
        	  abs=count[i][4];
        	  lea=count[i][5];
        	  onduty=count[i][6];
        	  late=count[i][7];
        	  hday=count[i][8];
        	  sday=count[i][9];
        	  otimes=count[i][10];
        	  out.println("<tr><td class='boldEleven'>"+(i+1)+" <td width='250' class='boldEleven'>"+EmpId+"</td>");
              out.println("<td align='left' class='boldEleven'>"+Sname+"</td>");
              out.println("<td align='left' class='boldEleven'>"+desig+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+pres+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+abs+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+lea+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+onduty+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+late+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+hday+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+sday+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+otimes+"</td>");
			 	  
			  out.println("<tr ><td colspan='12'><hr size='1' width='100%'/></td>");
           
            }
          
     	}
          
    	 
        	  %>
			
			<tr>
				<td colspan="12" class="bold1">
				<div align="center"><font color="red"> <%= msg %></div>
				</td>
			</tr>
			<tr class="bold1">
				<td colspan="12">&nbsp;</td>
			</tr>
			<tr class="bold1">
				<td colspan="12">
				<table width="100%" border="0">
					<tr>
						<td><a href='SummaryAtt.jsp?att=<%=atda%>'><font
							class="boldEleven">Back</font></a></td>
						<td>
						<div align="right"><a href='javascript:window.print()'><font
							class="boldEleven">Print</font></a></div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr class="bold1">
				<td colspan="12">&nbsp;</td>
			</tr>

		</table>
		</td>
	</tr>
</table>
<p>&nbsp;</p>


</body>
</html>


