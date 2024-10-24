<%@ page import="java.io.*,java.util.*,com.my.org.erp.bean.inventory.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
 
<body >
<%@ include file="indexinv.jsp"%>
<%
try
{
%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td></td>
  </tr>
  <tr>
	  <td>
	  	<%
		
		ArrayList rrep=(ArrayList) session.getAttribute("rep");
		int totalRecord=rrep.size();
		if(totalRecord>0)
		{
			out.println("<center><table border='0' bgcolor='#CCCCCC' class='boldEleven' cellpadding=3 cellspacing=1>");
			out.println("<tr bgcolor='#ffffff'><td colspan=7  class='boldEleven'><b><center>Target Vs Achievement - M.E Wise "+request.getParameter("type")+"</center></b></td>");
			out.println("<tr  bgcolor='#ffffff'><td class='boldEleven'><b>S.No");
			out.println("<td class='boldEleven'><b>Emp Id");
			out.println("<td class='boldEleven'><b>Emp Name");
			out.println("<td class='boldEleven'><b>Sales Amount");
			out.println("<td class='boldEleven'><b>Target(In lakhs)");
			out.println("<td class='boldEleven'><b>Achievements(In lakhs)");
			out.println("<td class='boldEleven'><b>% of Ach.");
			
			double sum=0;
			double sum1=0;
			for(int u=0;u<totalRecord;u++)
			{
			  if(u%2 == 0)
				out.println("<tr class='MRow1'>");
			  else
				out.println("<tr class='MRow2'>");	
			  TargetAchieveBeanList r= (TargetAchieveBeanList)rrep.get(u);
			  out.println("<td class='boldEleven'>"+(u+1));
			  out.println("<td class='boldEleven'>"+r.getEmpid());
			  out.println("<td class='boldEleven'>"+r.getEmpname());
			  out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.Round(r.getSalesamount()));
			  out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.Round(r.getTarget()));
			  sum = sum+r.getTarget();
			  sum1 = sum1+com.my.org.erp.common.CommonFunctions.Round(r.getSalesamount()/100000);
			  out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.Round(r.getSalesamount()/100000));
			  out.println("<td class='boldEleven' align='right'>");
			  out.println(com.my.org.erp.common.CommonFunctions.Round((r.getSalesamount()/100000)/r.getTarget()*100)+"%");
			}
			out.println("<tr  bgcolor='#ffffff'><td colspan=5 class='boldEleven' align='right'><b>"+Math.round(sum));
			out.println("<td class='boldEleven' align='right'><b>"+Math.round(sum1));
			out.println("<td class='boldEleven'></table></center>");
		}
		else
		{
			out.println("<br><br><br><center><font class='boldre'>Data not found...</font></center>");
		}
		
		%>	  </td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table border="0" align="center" cellpadding="2"
										cellspacing="2">
      <tr>
        
        <td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c" 	onClick="redirect( 'InventoryMains.jsp')" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
</table>
<%
}
catch(Exception e)
{
}
%>
<%@ include file="../footer.jsp"%>
</body>
</html>
