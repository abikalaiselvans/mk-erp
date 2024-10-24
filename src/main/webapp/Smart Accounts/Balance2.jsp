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

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="indexacct.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr class="boldEleven">
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table class="BackGround1" cellspacing="0" cellpadding="0"
			align="center" border="0">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block" /></td>
          <td width="412" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td colspan="2">&nbsp;</td>
              </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td colspan="2">
			  <%
	String sql="";
	String creditdata[][] =  com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_TYPEGROUPID,CHR_TYPEGROUPNAME FROM  accc_m_typegroups WHERE INT_TYPEID=1");
	String debitdata[][] =  com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_TYPEGROUPID,CHR_TYPEGROUPNAME FROM  accc_m_typegroups WHERE INT_TYPEID=2");
	
	out.println("<center>");
	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr bgcolor='#ffffff'><td class='boldEleven'><b>S.No");
	out.println("<td class='boldEleven'><b>Description");
	out.println("<td class='boldEleven'><b>Debit");
	out.println("<td class='boldEleven'><b>Credit");
	int sno=1;
	if(creditdata.length>0)
	{
		out.println("<tr bgcolor='#ffffff'><td class='boldEleven' colspan='4'>&nbsp;");
		for(int u=0;u<creditdata.length;u++)
		{
			out.println("<tr bgcolor='#ffffff'><td class='boldEleven'>"+sno);
			out.println("<td class='boldEleven'>"+creditdata[u][1]);
			out.println("<td class='boldEleven'>&nbsp;");	
			out.println("<td class='boldEleven'  align='right'>&nbsp;");	
			sno = sno+1;
			
		}
	}
	
	
	if(debitdata.length>0)
	{
		out.println("<tr bgcolor='#ffffff'><td class='boldEleven' colspan='4'>&nbsp;");
		for(int u=0;u<debitdata.length;u++)
		{
			out.println("<tr bgcolor='#ffffff'><td class='boldEleven'>"+sno);
			out.println("<td class='boldEleven'>"+debitdata[u][1]);
			out.println("<td class='boldEleven'>&nbsp;");
			sql ="SELECT INT_TYPESUBGROUPID,CHR_TYPESUBGROUPNAME FROM  accc_m_typesubgroups WHERE INT_TYPEGROUPID="+debitdata[u][0]+"  ORDER BY CHR_TYPESUBGROUPNAME ";
			String data1[][] =  com.my.org.erp.common.CommonFunctions.QueryExecute(	sql);
			if(data1.length>0)
			{
				out.println("<table>");
				for(int h=0;h<data1.length;h++)
				{
					out.println("<tr><td  class='boldEleven'><b>"+data1[h][1]+"</td>");
					out.println("<td>&nbsp;</td>");
					out.println("</tr>");
				}	
				out.println("</table>");
			}
			out.println("<td class='boldEleven'  align='right'>&nbsp;");	
			sno = sno+1;
			
		}
	}
	
	
	
	
	out.println("</table>");
	out.println("</center>");
	
	
				
			  %>
			  
			  
			  </td>
              </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table></td>
          <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
      </tbody>
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
<%
}
catch(Exception e)
{
}
%>
</body>
</html>
