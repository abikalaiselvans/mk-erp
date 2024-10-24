<%@ page import="java.io.*,java.util.*"%>
<%
try
{
%>
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

<body >
<%@ include file="indexinv.jsp"%><!--ConsumablesStockEntryresponsed.jsp-->
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
	  <td>
	  <%
	  	String branchid=""+request.getParameter("Branch");
		String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  AND a.INT_BRANCHID="+branchid;
		String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
		out.println("<center><table><table width='600'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'><td colspan='6' class='boldEleven'><center> <b>Consumables Stock Adjustments");
		out.print(shipids[0][2]+ "  @  " +shipids[0][1]  );
		out.println("<tr class='MRow2'><td class='boldEleven' ><b>S.No");
		out.println("<td class='boldEleven'><b>Product Code");
		out.println("<td class='boldEleven'><b>Product Description");
		out.println("<td class='boldEleven'><b>Smart Stock");
		
		String sql = "SELECT a.CHR_PRODUCTID,a.CHR_PRODUCTCODE,a.CHR_PRODUCTDESC FROM inv_m_produtlist a WHERE a.CHR_PTYPE='S'";
		String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			
			String stock="stock";
			for(int u=0;u<data.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");	
			out.println("<td>"+(u+1));
			out.println("<td class='boldEleven'>"+data[u][1]);
			out.println("<td class='boldEleven'>"+data[u][2]);
			out.println("<td class='boldEleven'><input name='pid"+(u+1)+"' id='pid"+(u+1)+"' type='hidden' value='"+data[u][0]+"' >");
			out.println("<input id='"+(stock+(u+1))+"'  name='"+(stock+(u+1))+"' type='text' value='0' onKeyPress=\"numericValue('"+(stock+(u+1))+"','6')\" size=10 class='formText135' style='text-align:right'>");
			
			 
		}	
	}	
					
		out.println("</table></center>");	
	  %>
	  <br><br><input name="branchid" type="hidden" value="<%=branchid%>">
	  <input name="paramlength" type="hidden" value="<%=data.length%>">
	  <input name="filename" type="hidden" value="ConsumableEntry">
	  <input name="actionS" type="hidden" value="INVConsumableEntryADD">
	  <script language="JavaScript">

function Validate()
  {
	
	var s="<%=data.length%>";
	var name="";
	for(u=0;u<s;u++)
		name = name+"stock"+(u+1)+",";
	var textname= name.split(",");

	for( i=0; i<textname.length-1; i++)
	{
		window.status="Checking Data ..."+textname[i];
		var ck = "Enter Data...in  "+(i+1)+"  Row";
		if(checkNull(textname[i],ck) )
			d=1;
		else
			return false;				
	}
			 	
 } 	
</script>
	  </td>
    </tr>
	<tr><td>
	
	<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit2" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                            <td><input name="Close2" type="button"
											class="buttonbold13" id="Close2"  value="Close"   accesskey="c" 
											onClick="redirect('ConsumablesStockEntry.jsp')"></td>
                          </tr>
                      </table>
	</td></tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>		</td>
	</tr>
	<tr>
	  <td> </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
  <%@ include file="../footer.jsp"%></form>
</body>
</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
