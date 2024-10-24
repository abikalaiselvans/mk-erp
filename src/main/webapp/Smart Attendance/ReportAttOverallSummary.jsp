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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style5 {font-size: 10px}
-->
</style>
</head>

<body  onpaste='return false;'>

<table width="100%" height="275" border="1" cellpadding="0"
	cellspacing="0">
	<tr>
		<td height="182">
		<table width="97%" height="221" border="0" align="center"
			cellpadding="0" cellspacing="0">
			<tr class="bold1">
				<td colspan="13">&nbsp;</td>
			</tr>
			<tr class="bold1">
				<td colspan="13">&nbsp;</td>
			</tr>
			<tr class="bold1">
				<td height="36" colspan="13"><%@ include
					file="../PrintHeader.jsp"%></td>
			</tr>
			<tr class="bold1">
				<td colspan="13">&nbsp;</td>
			</tr>
			<tr class="bold1">
				<td width="4%" height="32"><span class="style5">S.No</span></td>
				<td width="9%"><span class="style5">EmployeeId </span></td>
				<td width="12%"><span class="style5">Employee Name </span></td>
				<td width="12%"><span class="style5">Department Name </span></td>
				<td width="12%"><span class="style5">Designation Name</span></td>
				<td width="9%"><span class="style5">Present Days</span></td>
				<td width="9%"><span class="style5">Absent Days </span></td>
				<td width="4%"><span class="style5">Leave</span></td>
				<td width="6%"><span class="style5">On Duty </span></td>
				<td width="4%"><span class="style5">Late</span></td>
				<td width="5%"><span class="style5">Holiday</span></td>
				<td width="5%"><span class="style5">Sunday</span></td>
				<td width="9%"><span class="style5">OverTimeMin</span></td>
			</tr>
			<tr>
				<td colspan='13'>
				<hr size='1' width='100%' />
				</td>
				<%
      	 
      	String month= request.getParameter("Month");
 	 	String year=request.getParameter("Year");
		String atda=request.getParameter("atda");
      	 String dept="";
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
      		
      	 
      	String sql="SELECT B.CHR_EMPID,B.CHR_STAFFNAME,D.CHR_DEPARTNAME, A.CHR_DESIGNAME,";
      	sql=sql+"C.DOU_PRESENT,C.DOU_ABSENT,C.DOU_LEAVE,C.DOU_OD,C.INT_LATE,C.DOU_HOLIDAY,";
      	sql=sql+"C.DOU_SUNDAY,C.INT_OTMINS FROM com_m_desig A,com_m_staff B,att_t_attendancedetail C ,";
      	sql=sql+"COM_M_DEPART D where B.INT_DESIGID=A.INT_DESIGID ";
      	sql=sql+" AND B.CHR_EMPID=C.CHR_EMPID AND B.INT_DEPARTID=D.INT_DEPARTID AND C.LOGMONTH LIKE '"+month+"' AND C.LOGYEAR='"+year+"'";
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
        	  dept=count[i][2];
        	  desig=count[i][3];
        	  pres=count[i][4];
        	  abs=count[i][5];
        	  lea=count[i][6];
        	  onduty=count[i][7];
        	  late=count[i][8];
        	  hday=count[i][9];
        	  sday=count[i][10];
        	  otimes=count[i][11];
        	  out.println("<tr><td align='center' class='boldEleven'>"+(i+1)+" <td width='250' class='boldEleven'>"+EmpId+"</td>");
        	  out.println("<td align='left' class='boldEleven'>"+Sname+"</td>");
        	  out.println("<td align='left' class='boldEleven'>"+dept+"</td>");
              out.println("<td align='left' class='boldEleven'>"+desig+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+pres+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+abs+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+lea+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+onduty+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+late+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+hday+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+sday+"</td>");
			  out.println("<td align='center' class='boldEleven'>"+otimes+"</td>");
			 	  
			  out.println("<tr ><td colspan='13'><hr size='1' width='100%'/></td>");
           
            }
         	}
          
          
    	 
        	  %>
			
			<tr>
				<td colspan="12" class="bold1">
				<div align="center"><font color="red"> <%= msg %></div>
				</td>
			</tr>
			<tr class="bold1">
				<td colspan="13">&nbsp;</td>
			</tr>
			<tr class="bold1">
				<td colspan="13">&nbsp;</td>
			</tr>
			<tr class="bold1">
				<td colspan="13">
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

		</table>
		<p>&nbsp;</p>
		</td>
	</tr>
</table>
<p>&nbsp;</p>



</body>
</html>


