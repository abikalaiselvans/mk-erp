<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title> 
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

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	
	if( 
	 checkNull( "name","Enter Name" )
	  && checkNull( "desc","Enter Description" )
	 
	)
		return true;
	else
		return false;				
		
	
 } 	
</script>
<body    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
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
  <tr>
    <td><table width="60%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2"><div align="center">
          <%
String customerid= request.getParameter("customerid");
String Serviceitemid= request.getParameter("Serviceitemid");

String sql="";
sql =" SELECT ";
sql = sql + " a.INT_AMCID,a.CHR_AMCID,c.CHR_CUSTOMERNAME,b.CHR_SERVICEITEMNAME,a.CHR_SERIALNO,a.CHR_DESC,  ";
sql = sql + " DATE_FORMAT(DAT_UPDATION,'%d-%m-%Y'),DATE_FORMAT(DT_ENDDATE,'%d-%m-%Y'),INT_NOOFYEAR FROM  inv_m_serviceamc a,inv_m_serviceitems b,inv_m_servicecustomerinfo c ";
sql = sql + " WHERE a.INT_SERVICEITEMID= b.INT_SERVICEITEMID ";
sql = sql + " AND a.INT_CUSTOMERID =c.INT_CUSTOMERID ";
sql = sql + " AND a.INT_CUSTOMERID="+customerid;
sql = sql + " AND a.INT_SERVICEITEMID="+Serviceitemid;
sql = sql + " ORDER BY a.INT_AMCID ";
String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
if(readData.length>0)
{
	out.println("<center>");
	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr bgcolor='#ffffff'><td class='bolddeeplogin'><b>S.No</b></td>");
	out.println("<td class='bolddeeplogin'><b>Customer Name</b></td>");
	out.println("<td class='bolddeeplogin'><b>Pheriperals</b></td>");
	out.println("<td class='bolddeeplogin'><b>Serial Number</b></td>");
	out.println("<td class='bolddeeplogin'><b>Description</b></td>");
	out.println("<td class='bolddeeplogin'><b>Start Date</b></td>");
	out.println("<td class='bolddeeplogin'><b>End Date</b></td>");
	out.println("<td class='bolddeeplogin'><b>No of.Years</b></td>");
	out.println("<td class='bolddeeplogin'><b>&nbsp;</b></td>");
	
	for(int u=0;u<readData.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");
		
		out.println("<td class='boldeleven'>"+(u+1)+"</td>");
		out.println("<td class='boldeleven'>"+readData[u][2]+"</td>");
		out.println("<td class='boldeleven'>"+readData[u][3]+"</td>");
		out.println("<td class='boldeleven'><a href='AMCActionEdit.jsp?id="+readData[u][1]+"'>"+readData[u][4]+"</a></td>");
		out.println("<td class='boldeleven'>"+readData[u][5]+"</td>");	
		out.println("<td class='boldeleven'>"+readData[u][6]+"</td>");	
		out.println("<td class='boldeleven'>"+readData[u][7]+"</td>");	
		out.println("<td class='boldeleven' align='right'>"+readData[u][8]+"</td>");	
		if("F".equals(session.getAttribute("USRTYPE")))
			out.println("<td class='boldeleven' ><a href='../SmartLoginAuth?filename=ServiceAMC&actionS=INVServiceAMCDELETEs&id="+readData[u][0]+"'>Delete</a></td>");	
		else
			out.println("<td class='boldeleven' >&nbsp;</td>");	
			
	}	
	out.println("</table>");
	out.println("</center>");
}

				%>
        </div></td>
      </tr>
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2"><table width="100" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><input type="button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('amc.jsp')" /></td>
          </tr>
         
        </table></td>
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
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
}
%>