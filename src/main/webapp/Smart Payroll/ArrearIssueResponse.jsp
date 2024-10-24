 <%@ page import="java.sql.*" isErrorPage="false" errorPage="./InValidSession.jsp"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>
<%
try
{
%>
<html>
<head>
 

<title> :: PAYROLL ::</title>



<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
  
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

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>

<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td>
<form  AUTOCOMPLETE = "off" method="post"   name="salfrm" action="../SmartLoginAuth" onSubmit="return validate()">
<%
	String  Office= request.getParameter("Office");
	String  dept= request.getParameter("dept");
	String  Category= request.getParameter("Category");
	String  Month= request.getParameter("Month");
	String  Year= request.getParameter("Year");
	String  issuedate= request.getParameter("issuedate");
	String  issuemode= request.getParameter("issuemode");
	String  bankgroup= request.getParameter("bankgroup");
	String  memo= request.getParameter("memo");
	String monthname= DateUtil.getMonth(Integer.parseInt(Month));
	issuedate = DateUtil.FormateDateSQL(issuedate);
	String sql ="";
	
	
	sql = sql + " SELECT b.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,   ";
	sql = sql + " d.CHR_DEPARTNAME,e.CHR_CATEGORYNAME,  ";
	sql = sql + " MONTHNAME(b.DAT_DOR),YEAR(b.DAT_DOR),  ";
	sql = sql + " if(b.CHR_REVISION='Y' ,'Yes','No'),  ";
	sql = sql + " if(b.CHR_REVISION_TYPE='M' ,'Manual','Automatic'),  ";
	sql = sql + " DATE_FORMAT(b.DAT_DOA,'%d-%b-%Y'),  ";
	sql = sql + " DATE_FORMAT(b.DAT_DOA1,'%d-%b-%Y'),  ";
	sql = sql + " b.INT_DIFFERENCE,b.DOU_INCREMENT,b.DOU_ARREAR_AMOUNT,  ";
	sql = sql + " b.INT_OLD_GROSS,b.INT_GROSS,  ";
	sql = sql + " b.INT_OLDCTC,b.INT_CTC,  ";
	sql = sql + " b.DOU_GROSS_DIFFERENCE,b.DOU_CTC_DIFFERENCE,b.CHR_ISSUEMODE ,b.INT_APPRAISALID  ";
	sql = sql + " FROM com_m_staff a,pay_t_appraisal b,com_m_office c, com_m_depart d, com_m_employeecategory e   ";
	sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID    ";
	sql = sql + " AND a.INT_OFFICEID =c.INT_OFFICEID   ";
	sql = sql + " 	AND a.INT_DEPARTID =d.INT_DEPARTID   ";
	sql = sql + " AND a.CHR_CATEGORY = e.INT_EMPLOYEECATEGORYID   ";
	sql = sql + " AND b.CHR_ISSUEMODE='0'   ";
	
	sql = sql + " AND MONTHNAME(b.DAT_DOR ) ='"+monthname+"' ";
	sql = sql + " AND YEAR(b.DAT_DOR) = "+Year;
	if(!"0".equals(dept))
		sql = sql+" AND a.INT_DEPARTID="+dept +" ";
	if(!"0".equals(Office))
		sql = sql+" AND a.INT_OFFICEID="+Office +" ";  
	if(!"0".equals(Category))
		sql = sql+" AND a.CHR_CATEGORY='"+Category +"' ";
	
	sql = sql + " ORDER BY b.CHR_STAFFNAME  ";
	//out.println(sql);
	
	String data[][]=CommonFunctions.QueryExecute( sql);						
	if(data.length>0)
	{
		out.println("<center>");
		out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		
		out.println("<tr class='MRow1'> ");
		out.println("<td class='boldEleven' colspan='25' align='center'>");
		
		out.println("<table border='0' cellspacing='0' cellpadding='3' width='80%'>");
		out.println("<tr> ");
		out.println("<td class='boldEleven'><b>Month</b></td>");
		out.println("<td class='boldEleven'>"+monthname+"</td>");
		out.println("<td class='boldEleven'><b>Year</b></td>");
		out.println("<td class='boldEleven'>"+Year+"</td>");
		out.println("</tr>");
		out.println("<tr> ");
		out.println("<td class='boldEleven'><b>Issue Date</b></td>");
		out.println("<td class='boldEleven'>"+issuedate+"</td>");
		out.println("<td class='boldEleven'><b>Issue Mode</b></td>");
		out.println("<td class='boldEleven'>");
		if("D".equals(issuemode))
			out.println("DD");
		else if("C".equals(issuemode))
			out.println("CHEQUE");
		else if("H".equals(issuemode))
			out.println("CASH");
		else if("N".equals(issuemode))
			out.println("NEFT");
		else if("R".equals(issuemode))
			out.println("RTGS");
		out.println("</td>");
		
		out.println("</tr>");
		out.println("<tr> ");
		out.println("<td class='boldEleven'><b>Bank</b></td>");
		out.println("<td class='boldEleven'>"+CommonFunctions.QueryExecute("SELECT CHR_BANKGROUPNAME FROM com_m_bankgroup WHERE INT_BANKGROUPID="+bankgroup)[0][0]+"</td>");
		
		out.println("<td class='boldEleven'><b>Checked</b></td>");
		out.println("<td class='boldEleven'><input id='Astatus' name='status' type='checkbox' value='A' onClick=\"Acceptall('Astatus')\" checked ></td>");
		
		
		
		
		
		out.println("</tr>");
		out.println("</table>");
		
		out.println("</td>");
		out.println("</tr>");
		
		
		out.println("<tr class='MRow1'> ");
		out.println("<td class='boldEleven'><b>S.No</b></td>");
		out.println("<td class='boldEleven'><b>Empid</b></td>");
		out.println("<td class='boldEleven'><b>Emp Name</b></td>");
		out.println("<td class='boldEleven'><b>Office</b></td>");
		out.println("<td class='boldEleven'><b>Department</b></td>");
		out.println("<td class='boldEleven'><b>Category</b></td>");
		out.println("<td class='boldEleven'><b>Month</b></td>");
		out.println("<td class='boldEleven'><b>Year</b></td>");
		out.println("<td class='boldEleven'><b>Revision</b></td>");
		out.println("<td class='boldEleven'><b>Revision Type</b></td>");
		out.println("<td class='boldEleven'><b>Arrear From</b></td>");
		out.println("<td class='boldEleven'><b>Arrear To</b></td>");
		out.println("<td class='boldEleven'><b>Days Difference</b></td>");
		out.println("<td class='boldEleven'><b>Increment</b></td>");
		out.println("<td class='boldEleven'><b>Arrear Amount</b></td>");
		out.println("<td class='boldEleven'><b>OLD GROSS</b></td>");
		out.println("<td class='boldEleven'><b>NEW GROSS</b></td>");
		out.println("<td class='boldEleven'><b>OLD CTC</b></td>");
		out.println("<td class='boldEleven'><b>NEW CTC</b></td>");
		out.println("<td class='boldEleven'><b>GROSS DIFFERENCE</b></td>");
		out.println("<td class='boldEleven'><b>CTC DIFFERENCE</b></td>");
		
		out.println("<td class='boldEleven'><b>Issue</b></td>");
		out.println("</tr>");
		
		for(int u=0;u<data.length;u++)
		{
			if(u%2==0)
				out.println("<tr class='MRow1'> ");
			else
				out.println("<tr class='MRow2'> ");	
			out.println("<td class='boldEleven'>"+(u+1)+".</td>");	
			out.println("<td class='boldEleven'>"+data[u][0]+"</td>");	
			out.println("<td class='boldEleven'>"+data[u][1]+"</td>");	
			out.println("<td class='boldEleven'>"+data[u][2]+"</td>");	
			out.println("<td class='boldEleven'>"+data[u][3]+"</td>");	
			out.println("<td class='boldEleven'>"+data[u][4]+"</td>");	
			out.println("<td class='boldEleven'>"+data[u][5]+"</td>");	
			out.println("<td class='boldEleven'>"+data[u][6]+"</td>");	
			out.println("<td class='boldEleven'>"+data[u][7]+"</td>");	
			out.println("<td class='boldEleven'>"+data[u][8]+"</td>");	
			out.println("<td class='boldEleven'>"+data[u][9]+"</td>");	
			out.println("<td class='boldEleven'>"+data[u][10]+"</td>");	
			out.println("<td class='boldEleven'>"+data[u][11]+"</td>");	
			out.println("<td class='boldEleven' align='right'>"+data[u][12]+"</td>");	
			out.println("<td class='boldEleven' align='right'>"+data[u][13]+"</td>");	
			out.println("<td class='boldEleven' align='right'>"+data[u][14]+"</td>");	
			out.println("<td class='boldEleven' align='right' title='"+data[u][1]+"'>"+data[u][15]+"</td>");	
			out.println("<td class='boldEleven' align='right' title='"+data[u][1]+"'>"+data[u][16]+"</td>");	
			out.println("<td class='boldEleven' align='right' title='"+data[u][1]+"'>"+data[u][17]+"</td>");	
			out.println("<td class='boldEleven' align='right' title='"+data[u][1]+"'>"+data[u][18]+"</td>");	
			out.println("<td class='boldEleven' align='right' title='"+data[u][1]+"'>"+data[u][19]+"</td>");	
			
			if("0".equals(data[u][20]))
				out.println("<td class='boldEleven'><input name='issue"+(u+1)+"'  id='issue"+(u+1)+"' type='checkbox' value='Y' checked> ");
			else	
				out.println("<td class='boldEleven'>&nbsp;" );
				
			
			out.println("<input name='empid"+(u+1)+"' id='empid"+(u+1)+"' type='hidden' value='"+data[u][0] +"'>");	
			out.println("<input name='rowid"+(u+1)+"' id='rowid"+(u+1)+"' type='hidden' value='"+data[u][21] +"'>");	
			out.println("</td>");	
			 
		
			out.println("</tr>");
		}
		out.println("<tr class='MRow1'> ");
		out.println("<td class='boldEleven' colspan='25' align='center'>");
		
		
			out.println("<input name='monthname' id='monthname' type='hidden' value='"+monthname+"'>");
			out.println("<input name='year' id='year' type='hidden' value='"+Year+"'>");
			out.println("<input name='issuedate' id='issuedate' type='hidden' value='"+issuedate+"'>");
			out.println("<input name='issuemode' id='monthname' type='hidden' value='"+issuemode+"'>");
			out.println("<input name='bankgroup' id='bankgroup' type='hidden' value='"+bankgroup+"'>");
			out.println("<input name='memo' id='memo' type='hidden' value='"+memo+"'>");
	
		
		
		out.println("<table border='0' cellspacing='0' cellpadding='3'>");
		out.println("<tr> ");
		out.println("<td width='56'><input name='Submit' type='submit' class='buttonbold' value='Issue'></td>");
		out.println("<td width='56'><input name='Submit2' type='button' class='buttonbold' value='Close'	onClick=\"redirect('ArrearIssue.jsp')\"></td>");
		out.println("</tr>");
		out.println("</table>");
		
		out.println("</td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("</center>");
	}
	 			
	 
	
%>

<input name='dec' type='hidden' class='formText135' id='dec' size='15' maxlength='100' value=<%= data.length%>>
<input type="hidden" name="filename" id="filename"  value="PayRollRevision">
<input type="hidden" name="actionS" value="PAYPayRollRevisionArrearIssue">



<script language="javascript">
function validate()
{
	try
	{
	
		var len=document.getElementById("dec").value;
		var acount=0;
		for(var i=1;i<=len;i++)
		 if(document.getElementById("issue"+i).checked)	  	
			acount=acount+1;
		
		 
		
		if( acount<=0  )
		{
			alert("Select Atleast One Issue...");
			return false;
		}	
		else
		{
			return true;
		}	
	}
	catch(err)
	{
		alert(err)
		return false;
	}
}



function Acceptall(ctr)
	{
		var len=document.getElementById("dec").value;
		if(document.getElementById(ctr).checked)
		{
			for(var i=1;i<=len;i++)
			{
		  		var f0 = "issue"+i;
				document.getElementById(f0).checked=true;
				 
	    	}
		}
		else
		{
			for(var i=1;i<=len;i++)
			{
		  		var f0 = "issue"+i;
				document.getElementById(f0).checked=false;
				 
	    	}
		
		}
		 
	}
</script>



</form>	  </td>
	</tr>
	<tr>
		<td>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>
		</td>
	</tr>
</table>


<%@ include file="../footer.jsp"%>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>

</body>
</html>
