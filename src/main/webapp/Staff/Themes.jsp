<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
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

 

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<script type="text/javascript"	src="<%=response.encodeURL(request.getContextPath()+"/JavaScript/comfunction.js")%>"></script>

 </head>

<body  onpaste='return false;'>

<form name="frm" method="post" action="ThemesResponse.jsp">
<table width="100%" border="0" cellspacing="4" cellpadding="3">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td> </td>
  </tr>
  <tr>
    <td>
	
	<%
	String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_STYLESCOLORID,CHR_COLORNAME,CHR_COLORVALUE,CHR_BODYVALUE FROM  com_m_stylescolor ORDER BY INT_STYLESCOLORID");
	if(data.length>0)
	{
		
		
      
        
		
		out.println("<center>");
		
		out.println("<table width='90%' height='200' border='0' align='center' cellpadding='0' cellspacing='0' class='TableDesign0'>");
		out.println("<tr> ");
		out.println("<td   height='31'  align='center' class='whiteMedium'> SELECT THEME </td>");
		out.println("</td>");
		out.println("</tr> ");
		out.println("<tr  class='MRow1'> ");
		out.println("<td   height='31'   >");
		
		out.println("<div id='Theme' style='OVERFLOW:auto;width:100%;height:500px'>");
		
		out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1  >");
		int i=0;
		for(int k=0;k<data.length;k++)
		{
				if(i%5==0)
				{
					if(k%2==1)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr  class='MRow1'>");
					i=0;
				}		
				out.println("<td class='boldEleven'  valign='middle' align='center' height='100'><table width='120' height='70' class='boldEleven' cellpadding=2 cellspacing=1 border='0'><tr><td   style=\"box-shadow: 5px 5px 5px "+data[k][2]+"; -moz-border-radius:5px;border:1px solid;border-color:"+data[k][2]+";border-radius:5px;\" bgcolor='"+data[k][2]+"'  valign='middle' align='center'><a style=\"text-decoration:none\" href='ThemesResponse.jsp?radiobutton="+data[k][2].replaceAll("#","")+"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></td></tr></table></td>");
				i++;
				 
				 
			
		}
		
		out.println("</table>");
		out.println("</div><br>");
		out.println("</td>");
		
		out.println("</tr> ");
		out.println("</table>");
		out.println("</center>");
	}
	%>
	
	
	</td>
  </tr>
  <tr>
    <td><table  border="0" align="center" cellpadding="3" cellspacing="4">
      <tr>
         
        <td width="56"><input type="button" name="Submit2"  value="Close"   accesskey="c"  class="buttonbold" onClick="redirect('Userframe.jsp')"></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>

</body>
</html>
