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


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<br><br><br><table width="800" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign">
  <tr>
    <td align="center" class="whiteMedium">USER PASSWORD</td>
  </tr>
  <tr class="MRow1">
    <td><div align="center">
      <%
try
{
	String sql="SELECT a.CHR_EMPID,a.CHR_USRNAME,FUN_GET_PASSWORD(a.CHR_EMPID),b.CHR_STAFFNAME,DATE_FORMAT(b.DT_DOJCOLLEGE,'%d-%b-%Y'), ";
	sql = sql +" if(a.CHR_TYPE='F','Super Admin', if(a.CHR_TYPE='B' ,'Branch Admin',if(a.CHR_TYPE='A','Admin','Staff' ))), ";
	sql = sql +" a.CHR_LOGINTERMSANDCONDITIONS FROM m_user a  ,com_m_staff b WHERE A.CHR_EMPID=b.CHR_EMPID AND  b.CHR_TYPE!='T' ORDER BY a.CHR_USRNAME";
	String data[][]= CommonFunctions.QueryExecute(sql);
	out.println("<center><br>");
	out.println(" <div id='divscroll' style='OVERFLOW:auto;width:100%;height:500px' class='boldEleven'>");
	out.println("<table border='0' bgcolor='#9900CC' width='100%'  class='boldEleven' cellpadding='2' cellspacing='1'>");
	out.println("<tr bgcolor='#ffffff'>");
	//out.println("<td class='boldEleven'><b>S.No</b></td>");
	out.println("<td class='boldEleven'><b>Empid</b></td>");
	out.println("<td class='boldEleven'><b>Userid</b></td>");
	out.println("<td class='boldEleven' ><b>Name</b></td>");
	//out.println("<td class='boldEleven'><b>User</b></td>");
	//out.println("<td class='boldEleven'><b>Date of Joinning</b></td>");
	out.println("<td class='boldEleven'><b>Password</b></td>");
	out.println("<td class='boldEleven'><b>Rest</b></td>");
	out.println("<td class='boldEleven'><b>Read Operation Policy</b></td>");
	out.println("</tr>");
	
	for(int u=0;u<data.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");
			
		//out.println("<td class='boldEleven'>"+(u+1)+".</td>");	
		out.println("<td class='boldEleven'>"+data[u][0]+"</td>");	
		out.println("<td class='boldEleven'>"+data[u][1]+"</td>");	
		out.println("<td class='boldEleven'>"+data[u][3]+"</td>");	
		//out.println("<td class='boldEleven'>"+data[u][5]+"</td>");	
		//out.println("<td class='boldEleven'>"+data[u][4]+"</td>");	
		out.println("<td class='boldEleven'>"+data[u][2]+"</td>");	
		out.println("<td class='boldEleven'><a href='../SmartLoginAuth?filename=PasswordReSet&actionS=UTIPasswordReset&userid="+data[u][1]+"&type=U'>Rest</a></td> ");
		if("Y".equals(data[u][6]))
			out.println("<td class='boldEleven'><a href='../SmartLoginAuth?filename=PasswordReSet&actionS=UTIOperationPolicyReset&userid="+data[u][1]+"&type=U'>Reopen Opration Policy</a></td> ");
		else
			out.println("<td class='boldEleven'>&nbsp;</td>");	
		out.println("</tr>");	
		
	}
	out.println("</table></div></center>");
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
		System.out.println(e.getMessage());
	}
%>
        <br>
    </div></td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
