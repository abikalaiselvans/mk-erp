<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>

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
<script language="javascript">

function changeDisplay(theChecked,theWhat) 
{
	var theNode;
	var theDisplay;
	if (theChecked == true)
	{
	theDisplay = "";
	}
	else
	{
	theDisplay = "none";
	}

	for (var i = 1;;i++)
	{
		// Check if the getElementById method is available
		if (document.getElementById)
		{
			theNode = document.getElementById(theWhat+i);
			 if (theNode == null)
			{ return; }
		}
		else if (document.all)
		{
			// The alert lets me verify that I tested the path.
			alert("Running an older version of IE." +" May not be able to hide rows");
			theNode = document.all[theWhat+i];
			if (theNode == null)
			{ return; }
		}
		else
		{
			alert("Cannot change visibility of the display element." +" Was " + theWhat);
			return;
		}

		theNode.style.display = theDisplay;
	}
}





function validate()
{
	if(checkNull("ref","Select Employee Name"))
		return true;
	else
		return false;
}
</script>
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
    <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>
	  	<%
		
		String sql = " SELECT e.CHR_EMPID FROM inv_t_directsales a , inv_m_customerinfo b, inv_m_division c , inv_t_contribution d";
		sql = sql +  " ,com_m_staff e  WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID AND e.CHR_EMPID  = a.CHR_REF ";
		sql = sql + " AND d.CHR_EMPID=a.CHR_REF AND a.INT_DIVIID = c.INT_DIVIID  AND a.CHR_SALESNO = d.CHR_SALESNO ";
		sql = sql + " group BY a.CHR_REF ORDER BY e.CHR_STAFFNAME ";
		String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		
		if(data.length>0)
		{
			out.println("<center><table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			out.println("<tr class='MRow1'><td colspan=9 class='boldEleven'><center><h3>Sales Report Employee wise</h3></center>");
			out.println("<tr class='MRow1'><td class='boldEleven'><b>S.No");
			out.println("<td class='boldEleven'><b>Sales No");
			out.println("<td class='boldEleven'><b>Sales Date");
			out.println("<td class='boldEleven'><b>Division Name");
			out.println("<td class='boldEleven'><b>Reference");
			out.println("<td class='boldEleven'><b>Customer Name");
			out.println("<td class='boldEleven'><b>Others");
			out.println("<td class='boldEleven'><b>Contribution");
			out.println("<td class='boldEleven'><b>Total Amount");
			double sum=0.0;
			for(int u=0;u<data.length;u++)
			{
				sql = "SELECT a.CHR_SALESNO,a.DAT_SALESDATE,a.DOU_TOTALAMOUNT,c.CHR_DIVICODE,a.CHR_REF,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),  ";
				sql = sql + " a.CHR_OTHERREF ,d.DOU_PAMOUNT,d.DOU_SAMOUNT,d.DOU_CONTRIBUTION ,e.CHR_STAFFNAME  ";
				sql = sql + "FROM inv_t_directsales a,inv_m_customerinfo b,inv_m_division c , inv_t_contribution d ,com_m_staff e ";
			  	sql = sql + " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID AND e.CHR_EMPID  = a.CHR_REF  AND a.CHR_CANCEL='N' ";
				sql = sql + " AND d.CHR_EMPID=a.CHR_REF AND a.INT_DIVIID = c.INT_DIVIID ";
				sql = sql + " AND a.CHR_SALESNO = d.CHR_SALESNO ";
				sql = sql + " AND a.CHR_REF ='"+data[u][0].trim()+"' ";
				String salesdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				double sum1=0;
				String h="aug"+u;
				int xh=0;
				String bgcolor =" class='MRow1' ";
				if(u%2==0)
					bgcolor =" class='MRow1' ";
				else
					bgcolor =" class='MRow2' ";	
				
				for(int v=0;v<salesdata.length;v++)
				{
					if(v>=1)
					{
						xh=xh+1;
						out.println("<tr "+bgcolor+" id='"+h+xh+"'  style=\"display:none\"><td class='boldEleven' >");
					}	
					else	
					{
						out.println("<tr "+bgcolor+"><td class='boldEleven'>"+(u+1));
						out.println("<input name='"+h+"'  onClick=\"changeDisplay(this.checked,this.name)\" type='checkbox'>");
					}
					
					out.println("<td class='boldEleven'>"+salesdata[v][0]);
					out.println("<td class='boldEleven'>"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(salesdata[v][1]));
					out.println("<td class='boldEleven'>"+salesdata[v][3]);
					out.println("<td class='boldEleven'>"+salesdata[v][10]);
					out.println("<td class='boldEleven'>"+salesdata[v][5]);
					out.println("<td class='boldEleven'>"+salesdata[v][6]);
					out.println("<td class='boldEleven' align='right'>"+salesdata[v][9]);
					out.println("<td class='boldEleven' align='right'>"+salesdata[v][2]);
					sum = sum+Double.parseDouble(salesdata[v][2]);
					sum1 = sum1+Double.parseDouble(salesdata[v][2]);
				}
				// class='vbmenu_hilite'
				out.println("<tr class='MRow1'><td colspan=8 class='boldEleven' align='right'><b>SUM ::");
				out.println("<td class='boldEleven' align='right'><b>"+com.my.org.erp.common.CommonFunctions.Round(sum1));
			}
			out.println("<tr class='MRow1'><td colspan=8 class='boldEleven' align='right'><b>SUM ::");
			out.println("<td class='boldEleven' align='right'><b>"+com.my.org.erp.common.CommonFunctions.Round(sum));
			
			out.println("</table></center>");
			%>
			<table width="184" align="center" cellpadding="15" cellspacing="0">
          <tr>
            <td width="100" height="44" class="boldEleven"><strong>Export </strong></td>
            <td class="boldEleven"><div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a> </div></td>
            <td class="boldEleven"><div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('Sales.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div></td>
            <td class="boldEleven"><div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('Sales.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div></td>
            <td class="boldEleven"><div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('Sales.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div></td>
            <td class="boldEleven"><div align="center"><a
			href="javascript:window.close()">Close</a></div></td>
          </tr>
        </table>
			<%
		}
		else
		{
			out.println("<center><font class='boldred'>Data not found...</font></center>");
		}
		%>	  </td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
</table>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
<%@ include file="../footer.jsp"%>
</body>
</html>
