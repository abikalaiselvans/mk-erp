<%@ page import="java.io.*,java.util.*"%>
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
<script language="JavaScript" src="../JavaScript/calendar1.js" ></script>
<script language="javascript">
function valid()
{
	
	if(Edit())
		return true;
	else
		return false;
}



function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].customergroupid
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].customergroupid.checked) { count=1;}
		}
		if(count>=1)
			return true;
		else
		{
		    alert("Select Only one Group");
		    return false;
		}
 	}	

</script>
	
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post"  action="ReptCustomerResponse.jsp" onSubmit="return valid()">
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
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<%
	try
	{	
		String fromdate = request.getParameter("saleDate");
		String todate = request.getParameter("saleDate2");
		fromdate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate);
	 	todate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
		String daterange= request.getParameter("daterange");
		String division = request.getParameter("division");
		String dateheader="";
		String sqldaterange="";
		if("Y".equals(daterange))
		{
			sqldaterange=" AND a.DAT_TRANSFERDATE >='"+fromdate+"' AND a.DAT_TRANSFERDATE<='"+todate+"' ";
			dateheader = "( "+ fromdate +" - " + todate +" )";
		}	
		String sqldivision="";
		if(!"0".equals(division))
			sqldivision=" AND a.INT_DIVIID="+division;
		
	 	String sql="";
		sql="SELECT a.CHR_STOCKTRANSFERID, ";
		sql=sql+" a.INT_BRANCHID_FROM, ";
		sql=sql+" (Select c.CHR_BRANCHNAME from  com_m_branch  c  ,com_m_company d where  c.INT_COMPANYID = d.INT_COMPANYID AND  ";
		sql=sql+" c.INT_BRANCHID = a.INT_BRANCHID_FROM) ,  ";
		sql=sql+" (Select d.CHR_COMPANYNAME from  com_m_branch  c  ,com_m_company d where  c.INT_COMPANYID = d.INT_COMPANYID AND ";
		sql=sql+" c.INT_BRANCHID = a.INT_BRANCHID_FROM) , ";
		sql=sql+" a.INT_BRANCHID_TO, ";
		sql=sql+" (Select c.CHR_BRANCHNAME from  com_m_branch  c  ,com_m_company d where  c.INT_COMPANYID = d.INT_COMPANYID AND ";
		sql=sql+" c.INT_BRANCHID = a.INT_BRANCHID_TO) , ";
		sql=sql+" (Select d.CHR_COMPANYNAME from  com_m_branch  c  ,com_m_company d where  c.INT_COMPANYID = d.INT_COMPANYID AND ";
		sql=sql+" c.INT_BRANCHID = a.INT_BRANCHID_TO) , ";
		sql=sql+" (SELECT b.CHR_DIVICODE FROM inv_m_division b WHERE b.INT_DIVIID=a.INT_DIVIID), ";
		sql=sql+" date_format(a.DAT_TRANSFERDATE,'%d-%m-%Y'),a.CHR_TRANSFERBY,date_format(a.DAT_RECEIVEDDATE,'%d-%m-%Y'), ";
		sql=sql+" a.CHR_RECEIVEDBY,a.CHR_DES,a.INT_STATUS,a.INT_TRANSFERSTATUS  ";
		sql=sql+" FROM   inv_t_stocktransfer a  WHERE a.CHR_STOCKTRANSFERID is not null";
		sql=sql+sqldaterange;
		sql=sql+sqldivision;
		sql=sql+" ORDER BY a.CHR_STOCKTRANSFERID  ";
		String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		out.println("<center><table  width='900'  cellpadding=2 cellspacing=1 bgcolor='#9900CC'   id='myTable'><tr bgcolor='#ffffff'>");
		out.println("<td colspan=13 class='boldEleven'><center><h3>Stock Transfer Report Branch wise"+dateheader+"</h3></center>");
		if(data.length>0)
		{
			out.println("<tr bgcolor='#ffffff'><td class='boldEleven'><b>S.No");
			out.println("<td class='boldEleven'><b>");
			out.println("<td class='boldEleven'><b>Transfer Id");
			out.println("<td class='boldEleven'><b>From");
			out.println("<td class='boldEleven'><b>To");
			out.println("<td class='boldEleven'><b>Division");
			out.println("<td class='boldEleven'><b>Transfer Date");
			out.println("<td class='boldEleven'><b>Transfered By");
			out.println("<td class='boldEleven'><b>Received Date");
			out.println("<td class='boldEleven'><b>Received By");
			out.println("<td class='boldEleven'><b>Description");
			out.println("<td class='boldEleven'><b>Transfer Status");
			out.println("<td class='boldEleven'><b>Received Status");
			String link="";
			for(int u=0;u<data.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");	
				out.println("<td class='boldEleven'>"+(u+1));	
				link="javascript:showinvoice('stocktransfer"+(u+1)+"','ReportStockTransSerialView.jsp?transNo="+data[u][0]+"','photo"+(u+1)+"','minus"+(u+1)+"')";
				out.println("<td class='boldEleven'><img id='photo"+(u+1)+"' src=\"../Image/report/plus.gif\" width=9 height=9 onClick="+link+">");
				out.println("<td class='boldEleven'>"+data[u][0]);	
				out.println("<td class='boldEleven'>"+data[u][3]+" @ " +data[u][2]);	
				out.println("<td class='boldEleven'>"+data[u][6]+" @ " +data[u][5]);	
				out.println("<td class='boldEleven'>"+data[u][7]);
				out.println("<td class='boldEleven'>"+data[u][8]);
				out.println("<td class='boldEleven'>"+data[u][9]);
				out.println("<td class='boldEleven'>"+data[u][10]);
				out.println("<td class='boldEleven'>"+data[u][11]);
				out.println("<td class='boldEleven'>"+data[u][12]);
				if("1".equals(data[u][13]))
					out.println("<td class='boldEleven'>Transfered");
				else
					out.println("<td class='boldEleven'>Not Transfered");	
				if("1".equals(data[u][14]))
					out.println("<td class='boldEleven'>Received");
				else
					out.println("<td class='boldEleven'>Not Received");
				out.println("<input type='hidden' name='minus"+(u+1)+"' id='minus"+(u+1)+"' value='N'>");	
				out.println("<tr bgcolor='#ffffff'><td colspan=13> <div id='stocktransfer"+(u+1)+"'></div> </td></tr>");	
			}
		}
		else
		{
			out.println("<tr bgcolor='#ffffff'><td colspan=13 class='boldred'><center>Data not found...</center>");
		}
		out.println("</table></center>");
	}
	catch(Exception e)
	{
	
	}
		%>		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
	</tr>
	<tr>
	  <td>&nbsp; </td>
    </tr>
	<tr>
		<td>
<%
try
{
	String fs="";
	fs =" package sample; ";
	fs = fs +" public interface Postman {";
	fs = fs +" 	void deliverMessage(String msg);}";
	//out.println(""+com.sun.tools.javac.Main.compile(fs));
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
			document.getElementById(divname).innerHTML = response;
		}
	}

 
	
</script>


</td>
	</tr>
	<tr>
		<td><table width="184" align="center" cellpadding="15" cellspacing="0">
          <tr>
            <td width="100" height="44" class="boldEleven"><strong>Export </strong></td>
            <td class="boldEleven"><div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a> </div></td>
            <td class="boldEleven"><div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('stocktransfer.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div></td>
            <td class="boldEleven"><div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('stocktransfer.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div></td>
            <td class="boldEleven"><div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('stocktransfer.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div></td>
            <td class="boldEleven"><div align="center"><a
			href="javascript:window.close()">Close</a></div></td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>


<%@ include file="../footer.jsp"%></form>
</body>
</html>
