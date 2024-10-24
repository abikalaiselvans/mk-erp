<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>

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
    <td></td>
  </tr>
  <tr>
    <td></td>
  </tr>
  <tr>
	  <td>
	  	<%
		
String sql = "";
String ref= request.getParameter("ref");
String from= request.getParameter("from");
String to= request.getParameter("to");
String usertype=""+session.getAttribute("USRTYPE");
	  


		out.println("<center><table width='80%' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'><td colspan=11 class='boldEleven'><center><h3>Sales Report Employee wise</h3></center>");
		out.println("<tr class='MRow1'><td class='boldEleven'><b>S.No");
		out.println("<td class='boldEleven'>&nbsp;");
		out.println("<td class='boldEleven'><b>Sales No");
		out.println("<td class='boldEleven'><b>Sales Date");
		out.println("<td class='boldEleven'><b>Division Name");
		out.println("<td class='boldEleven'><b>Reference");
		out.println("<td class='boldEleven'><b>Customer Name");
		out.println("<td class='boldEleven'><b>Others");
		out.println("<td class='boldEleven'><b>Contribution");
		out.println("<td class='boldEleven'><b>Amount(Without Tax)");
		out.println("<td class='boldEleven'><b>Amount (With Tax)");
		double sum=0.0;
		double contribution=0.0;
		double sum1=0.0;
	


		//Direct Sales Table
		sql =" SELECT a.CHR_SALESNO,a.DAT_SALESDATE,a.DOU_TOTALAMOUNT,c.CHR_DIVICODE,a.CHR_REF,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), "; 
		sql = sql+ " a.CHR_OTHERREF ,d.DOU_PAMOUNT,d.DOU_SAMOUNT,d.DOU_CONTRIBUTION ,e.CHR_STAFFNAME ,a.DOU_AMOUNT";
		sql = sql+ " FROM inv_t_directsales a , inv_m_customerinfo b, inv_m_division c , inv_t_contribution d ,com_m_staff e";
		sql = sql+ " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID AND e.CHR_EMPID  = a.CHR_REF";
		sql = sql+ " AND d.CHR_EMPID=a.CHR_REF AND a.INT_DIVIID = c.INT_DIVIID  AND a.CHR_CANCEL='N'  ";
		sql = sql+ " AND a.CHR_SALESNO = d.CHR_SALESNO AND a.CHR_REF='"+ref+"' "; 
		sql = sql+ " AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(to)+"' AND a.DAT_SALESDATE <='";
		sql = sql+DateUtil.FormateDateSQL(from)+"'";
		sql = sql+ " ORDER BY a.CHR_REF "; 
		String link="";
		
		String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			out.println("<tr class='MRow1'><td colspan=11 class='boldEleven'><center><h3>DIRECT SALES</h3></center>");
			for(int u=0;u<data.length;u++)
			{
				
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");
							
				out.println("<td class='boldEleven'>"+(u+1));
				//href='SwapSaleSerialView.jsp?salno="+data[u][0]+"'
	link="javascript:showinvoice('directsale"+(u+1)+"','Rept_SwapSaleSerialView.jsp?salno="+data[u][0]+"','photo"+(u+1)+"','minus"+(u+1)+"')";
				out.println("<td class='boldEleven'><img id='photo"+(u+1)+"' src=\"../Image/report/plus.gif\" width=9 height=9 onClick="+link+">");
				out.println("<td class='boldEleven'>"+data[u][0]);
				out.println("<td class='boldEleven'>"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(data[u][1]));
				out.println("<td class='boldEleven'>"+data[u][3]);
				out.println("<td class='boldEleven'>"+data[u][10]);
				out.println("<td class='boldEleven'>"+data[u][5]);
				out.println("<td class='boldEleven'>"+data[u][6]);
				if("F".equals(usertype))
					out.println("<td class='boldEleven' align='right'>"+data[u][9]);
				else
					out.println("<td class='boldEleven' align='right'>0");
				out.println("<td class='boldEleven' align='right'>"+data[u][11]);	
				out.println("<td class='boldEleven' align='right'>"+data[u][2]);
				out.println("<input type='hidden' name='minus"+(u+1)+"' id='minus"+(u+1)+"' value='N'>");
				out.println("<tr class='MRow1'><td colspan=11> <div id='directsale"+(u+1)+"'></div> </td></tr>");
				sum = sum+Double.parseDouble(data[u][2]);
				contribution=contribution+Double.parseDouble(data[u][9]);
				sum1 = sum1+Double.parseDouble(data[u][11]);
			}
		}
		else
		{
			out.println("<tr class='MRow1'><td colspan=11 class='boldEleven'><font class='boldred'>Data not found...</font>");
		} 
		
		
		
		//Direct Billing Table
		sql =" SELECT a.CHR_SALESNO,a.DAT_SALESDATE,a.DOU_AMOUNT,c.CHR_DIVICODE,a.CHR_REF,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), ";
		sql = sql+ " a.CHR_REF ,d.DOU_PAMOUNT,d.DOU_SAMOUNT,d.DOU_CONTRIBUTION ,e.CHR_STAFFNAME ,a.DOU_AMOUNT";
		sql = sql+ " FROM inv_t_directbilling a , inv_m_customerinfo b, inv_m_division c , ";
		sql = sql+ " inv_t_contribution d ,com_m_staff e ";
		sql = sql+ "WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID  ";
		sql = sql+ " AND e.CHR_EMPID = a.CHR_REF  ";
		sql = sql+ " AND d.CHR_EMPID=a.CHR_REF  ";
		sql = sql+ " AND a.INT_DIVIID = c.INT_DIVIID  ";
		sql = sql+ " AND a.CHR_SALESNO = d.CHR_SALESNO  ";
		
	
	  	sql ="SELECT a.CHR_SALESNO,a.DAT_SALESDATE,a.DOU_NETAMOUNT,c.CHR_DIVICODE,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_REF, e.CHR_STAFFNAME  "; 
	  	sql = sql+ " ,a.DOU_CONTRIBUTION ,a.DOU_AMOUNT FROM inv_t_directbilling a , inv_m_customerinfo b, inv_m_division c , com_m_staff e  ";
	  	sql = sql+ " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID ";
	  	sql = sql+ " AND e.CHR_EMPID = a.CHR_REF    ";
	  	sql = sql+ " AND a.INT_DIVIID =c.INT_DIVIID   "; 
	  	sql = sql+ " AND a.CHR_REF='"+ref+"' ";
		sql = sql+ " AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(to)+"' AND a.DAT_SALESDATE <='";
		sql = sql+DateUtil.FormateDateSQL(from)+"'";
		sql = sql+ " ORDER BY a.CHR_REF ";
		
		String data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(data1.length>0)
		{
			out.println("<tr class='MRow1'><td colspan=11 class='boldEleven'><center><h3>DIRECT BILLING</h3></center>");
			for(int u=0;u<data1.length;u++)
			{
				
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");
				out.println("<td class='boldEleven'>"+(u+1));
				link="javascript:showinvoice('directbill"+(u+1)+"','Rept_DirectBillingEdit.jsp?salesid="+data1[u][0]+"','photo1"+(u+1)+"','minus1"+(u+1)+"')";
				out.println("<td class='boldEleven'><img  id='photo1"+(u+1)+"' src=\"../Image/report/plus.gif\" width=9 height=9 onClick="+link+">");
				out.println("<td class='boldEleven'>"+data1[u][0]);
				out.println("<td class='boldEleven'>"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(data1[u][1]));
				out.println("<td class='boldEleven'>"+data1[u][3]);
				out.println("<td class='boldEleven'>"+data1[u][6]);
				out.println("<td class='boldEleven'>"+data1[u][4]);
				out.println("<td class='boldEleven'>-");
				out.println("<td class='boldEleven' align='right'>"+data1[u][7]);
				out.println("<td class='boldEleven' align='right'>"+data1[u][8]);
				out.println("<td class='boldEleven' align='right'>"+data1[u][2]);
				out.println("<input type='hidden' name='minus1"+(u+1)+"' id='minus1"+(u+1)+"' value='N'>");
				out.println("<tr class='MRow1'><td colspan=11> <div id='directbill"+(u+1)+"'></div> </td></tr>");
				sum = sum+Double.parseDouble(data1[u][2]);
				contribution=contribution+0;
				sum1 = sum1+Double.parseDouble(data1[u][8]);
			}
		}
		else
		{
			out.println("<tr class='MRow1'><td colspan=11 class='boldEleven'><font class='boldred'>Data not found...</font>");
		} 
		
		
		
		
		//SERVICE BILLING 
		sql = " SELECT a.CHR_SALESNO,a.DAT_SALESDATE,a.DOU_NETAMOUNT,c.CHR_DIVICODE,a.CHR_REF,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),   "; 
		sql = sql+ " a.CHR_OTHERREF, e.CHR_STAFFNAME ,a.DOU_AMOUNT  "; 
		sql = sql+ " FROM inv_t_servicebilling a , inv_m_customerinfo b, inv_m_division c , com_m_staff e  ";  
		sql = sql+ " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID  AND a.CHR_CANCEL='N'  "; 
		sql = sql+ " AND e.CHR_EMPID = a.CHR_REF   "; 
		sql = sql+ " AND a.INT_DIVIID = c.INT_DIVIID   "; 
		sql = sql+ " AND a.CHR_REF='"+ref+"' "; 
		sql = sql+ " AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(to)+"' AND a.DAT_SALESDATE <='";
		sql = sql+DateUtil.FormateDateSQL(from)+"'";
		sql = sql+ " ORDER BY a.CHR_REF "; 
		String data2[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(data2.length>0)
		{
			out.println("<tr class='MRow1'><td colspan=11 class='boldEleven'><center><h3>SERVICE BILLING</h3></center>");
			for(int u=0;u<data2.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");
				
				out.println(" <td class='boldEleven'>"+(u+1));
				link="javascript:showinvoice('servicebill"+(u+1)+"','Rept_ServiceBillingEdit.jsp?salno="+data2[u][0]+"','photo2"+(u+1)+"','minus2"+(u+1)+"')";
				out.println("<td class='boldEleven'><img  id='photo2"+(u+1)+"' src=\"../Image/report/plus.gif\" width=9 height=9 onClick="+link+">");
				out.println("<td class='boldEleven'>"+data2[u][0]);
				out.println("<td class='boldEleven'>"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(data2[u][1]));
				out.println("<td class='boldEleven'>"+data2[u][3]);
				out.println("<td class='boldEleven'>"+data2[u][7]);
				out.println("<td class='boldEleven'>"+data2[u][5]);
				out.println("<td class='boldEleven'>"+data2[u][6]);
				out.println("<td class='boldEleven' align='right'>0");
				out.println("<td class='boldEleven' align='right'>"+data2[u][8]);
				out.println("<td class='boldEleven' align='right'>"+data2[u][2]);
				out.println("<input type='hidden' name='minus2"+(u+1)+"' id='minus2"+(u+1)+"' value='N'>");
				out.println("<tr class='MRow1'><td colspan=11> <div id='servicebill"+(u+1)+"'></div> </td></tr>");
				sum = sum+Double.parseDouble(data2[u][2]);
				contribution=contribution+0;
				sum1 = sum1+Double.parseDouble(data2[u][8]);
			}
		}
		else
		{
			out.println("<tr class='MRow1'><td colspan=12 class='boldEleven'><font class='boldred'>Data not found...</font>");
		} 
		
		
		
		out.println("<tr class='MRow1'><td colspan=8 class='boldEleven' align='right'>SUM ::");
		if("F".equals(usertype))
			out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.Round(contribution));
		else
			out.println("<td class='boldEleven' align='right'>0");
		
		
		out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.Round(sum1));
		out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.Round(sum));
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
        </table>			  </td>
  </tr>
  <tr>
	  <td><div id="description"></div></td>
  </tr>
</table>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
<script language="javascript">
	function createRequestObject() 
	{
		var tmpXmlHttpObject;
		if (window.XMLHttpRequest) 
		{ 
			tmpXmlHttpObject = new XMLHttpRequest();
		  }
		else if (window.ActiveXObject) 
		{ 
			tmpXmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP");
		}
		return tmpXmlHttpObject;
	}


	var http = createRequestObject();
	var divname="";
	function showinvoice(ctr,invoice,photo,img)
	{
		var sd=document.getElementById(img).value;
		if(sd=="N")
		{
			divname=ctr;
			var f =""+invoice +"&divanme="+divname;
			document.getElementById(divname).innerHTML ="<font class='boldred'><center>Loadning data, please wait</center></font>";
			http.open('get', f);
			http.onreadystatechange = processResponse;
			http.send(null);
			document.getElementById(photo).src="../Image/report/minus.gif";
			document.getElementById(img).value='Y';
		}
		else if(sd=="Y")
		{
			document.getElementById(divname).innerHTML ="";
			document.getElementById(img).value='N';
			document.getElementById(photo).src="../Image/report/plus.gif";
		}	
	}

	function processResponse() 
	{
		if(http.readyState == 4){
			var response = http.responseText;
			document.getElementById(divname).innerHTML = "<br><br><br>"+response+"<br><br><br>";
		}
	}

 
	
</script>
<%@ include file="../footer.jsp"%>
</body>
</html>
