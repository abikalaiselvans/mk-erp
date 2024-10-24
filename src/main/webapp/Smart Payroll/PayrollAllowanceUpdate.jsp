
<html>
<head>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Payroll/UpdateAllowanceAjax.js"></script>

<title> :: PAYROLL ::</title>


 

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

<style type="text/css">
<!--
.style8 {font-family: Verdana;
	font-size: 12px;
}
.style11 {
	color: #000066;
	font-size: 14px;
}
-->
</style>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="payslipfrm" method="post" action="../SmartLoginAuth">
<table width="100%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="bigusername">
		<div align="center">
		<%
	String month = request.getParameter("month");
	String mnth =month;
	String year = request.getParameter("year");
	String office= ""+request.getParameter("Office");
	String dept = ""+request.getParameter("dept");
	String Category = ""+request.getParameter("Category");
	
	String squery ="PayrollAllowanceUpdate.jsp?year="+year+"&Office="+office+"&dept="+dept+"&month="+month+"&Category="+Category;
	String search= ""+request.getParameter("searchs");
	String sch="";
	if(!"null".equals(search))
		sch = " AND b.CHR_STAFFNAME like '"+search+"%' ";
	
	String off="";
	String dep="";
	if(!"0".equals(office))
		off=" AND b.INT_OFFICEID="+office;
	if(!"0".equals(dept))
		dep=" AND b.INT_DEPARTID= "+dept;
		
		 
	month = com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month));
	%> Allowance /Recovery/Advance/Messbill Updation (<%=month%> - <%=year%>)</div>
		</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center">
		<table width="256" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td width="167" class="bold">Search by name</td>
				<td width="75" class="bold"><input name="searchs" type="text"
					class="formText135" id="searchs"
					onBlur='redirectValue("<%=squery%>","searchs","searchs")' size="15"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center"><!--<div align="center"  id="divscroll" style="OVERFLOW: auto;width:818px;height:340px">-->
		<div>
		<%
	
	
	String sql ="SELECT CHR_ACODE,CHR_ANAME from pay_m_allowance where CHR_MONTHFLAG='Y'  order by INT_ALLOWANCEID ";
	String data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
	String allowancesql = "";
	for(int u=0;u<data.length;u++)
		allowancesql = allowancesql+data[u][0]+", ";
	
	 
 	String recoverysql ="SELECT CHR_RCODE,CHR_RNAME from pay_m_recovery where CHR_MONTHFLAG='Y'  order by INT_RECOVERYID" ;
	String recoverydata[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(recoverysql);
	String recs="";
	for(int x=0;x<recoverydata.length;x++)
		recs = recs+recoverydata[x][0]+",";
	
	double advance=0.0,dtection=0.0;
	
	sql= "SELECT a.CHR_EMPID,b.CHR_STAFFNAME FROM att_t_register a , com_m_staff b WHERE a.CHR_MONTH ='"+month+"'";
	sql=sql+" AND a.INT_YEAR="+year;
	
	if(!"0".equals(Category))
		dep=" AND b.CHR_CATEGORY= "+Category;
		
		
	sql=sql+" AND a.CHR_EMPID=b.CHR_EMPID "+off+" "+dep+sch+" ORDER BY b.CHR_STAFFNAME ";
  	out.println(sql);
	
	
	//sql=" SELECT   CHR_EMPID, CHR_STAFFNAME from  com_m_staff   WHERE CHR_TYPE!='T' ORDER BY CHR_STAFFNAME";
	String datas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
	out.println("<br><center><table id='top' cellpadding=2 cellspacing=1 bgcolor='#9900CC'  border=0 width=800 >");
	
	out.println("<tr class='MRow4'>&nbsp;");
	out.println("<td class='boldEleven'>&nbsp;");
	out.println("<td class='boldEleven'>&nbsp;");
	out.println("<td >&nbsp;"); 
	out.println("<td colspan="+data.length+"><center><b>Allowance</b>"); 
	out.println("<td colspan="+recoverydata.length+"><center><b>Recovery</b>"); 
	out.println("<td class='boldEleven'>&nbsp;"); 
	out.println("<td class='boldEleven'>&nbsp;"); 
	
	
	
	out.println("<tr class='MRow4'>");
	out.println("<td class='boldEleven'><b>S.No");
	out.println("<td class='boldEleven'><b>Empid");
	out.println("<td v>Emp Name"); 
	for(int x=0;x<data.length;x++)
		out.println("<td class='boldEleven'><b>"+data[x][1]); 
	for(int x=0;x<recoverydata.length;x++)
		out.println("<td class='boldEleven'><b>"+recoverydata[x][1]); 
	out.println("<td class='boldEleven'><b>CPY Advance"); 
	out.println("<td class='boldEleven'><b>MessBill"); 
	out.println("</tr>");
	String s="";
	
	for(int u=0;u<datas.length;u++)
	{
		advance=0.0;
		dtection=0.0;
		int column=0;
		if(u%2==0)
			out.println("<tr class='MRow3'>");
		else
			out.println("<tr class='MRow4'>");	
		
		out.println("<td id='T"+u+"0' align=left class='boldEleven'>"+(u+1));
		out.println("<div id='rowid"+(u+1)+"' ></div></td>");
		out.println("<td id='T"+u+"1' align=left class='boldEleven'>"+datas[u][0]);
		out.println("<td align=left class='boldEleven'>"+datas[u][1]); 
		
		//Allowance Updation
		sql = "SELECT "+ allowancesql+" CHR_EMPID FROM pay_t_salaryallowance WHERE CHR_EMPID='"+datas[u][0]+"' AND ";
		sql = sql+" CHR_MONTH='"+month+"' AND INT_YEAR="+year;
		String Adatas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
		if(Adatas.length>0)
		{
		 	for(int x=0;x<data.length;x++)
		 	{
s = "onblur=\"UpdateAllowance('"+datas[u][0]+"','"+month+"','"+year+"','"+data[x][0]+"','"+u+column+"','D"+u+column+"','T"+u+(column+2)+"','pay_t_salaryallowance','rowid"+(u+1)+"')\""	;
		 
		 out.println("<td  id='T"+u+(column+2)+"'align=right class='boldEleven' bgcolor='#33CCCC'><input type=text class='boldEleven' size=5 maxlength='7'" +s);
		 out.println(" name='"+u+column+"' id='"+u+column+"' value='"+Adatas[0][x]+"'   onKeyPress=\"numericValue('"+u+column+"','7')\">");
		 out.println("<div id='D"+u+column+"'	></div>");	
		 column=column+1;
			}	
		}	
		else
		{
			for(int x=0;x<data.length;x++)
			{
			 out.println("<td>&nbsp;");
			   
			} 
		}
		
		
		//Recovery Updation
		sql = "SELECT "+ recs+" CHR_EMPID FROM pay_t_salaryrecovery WHERE CHR_EMPID='"+datas[u][0]+"' AND ";
		sql = sql+" CHR_MONTH='"+month+"' AND INT_YEAR="+year;
		String Rdatas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
		if(Rdatas.length>0)
		{
		 	for(int x=0;x<recoverydata.length;x++)
		 	{
s = "onblur=\"UpdateAllowance('"+datas[u][0]+"','"+month+"','"+year+"','"+recoverydata[x][0]+"','"+u+column+"','D"+u+column+"','T"+u+(column+2)+"','pay_t_salaryrecovery')\""	;
		 
		 out.println("<td id='T"+u+(column+2)+"'align=right class='boldEleven'  bgcolor='#339900'><input type=text class='boldEleven' size=5 maxlength='7'" +s);
		 out.println(" name='"+u+column+"' id='"+u+column+"' value='"+Rdatas[0][x]+"'   onKeyPress=\"numericValue('"+u+column+"','7')\">");
		 out.println("<div id='D"+u+column+"'	></div>");	
		 column=column+1;
			}	
		}	
		else
		{
			for(int x=0;x<recoverydata.length;x++)
			 out.println("<td>&nbsp;");
		}
		 
		 //Advance updation
		 out.println("<td>&nbsp;");
		 sql="SELECT sum(INT_ADVAMT) FROM pay_m_advance WHERE CHR_EMPID='"+datas[u][0]+"' ";
		 String advdata[][] = com.my.org.erp.common.CommonFunction.doubleRecordSetArray(sql);
		 advance=Double.parseDouble(advdata[0][0]);
		 sql="SELECT sum(INT_DUEAMT) FROM pay_t_advance WHERE CHR_EMPID='"+datas[u][0]+"' ";
		 String detectdata[][] = com.my.org.erp.common.CommonFunction.doubleRecordSetArray(sql);
		 dtection=Double.parseDouble(detectdata[0][0]);
		 if(Math.round(advance-dtection)!=0)
		 	out.print(Math.round(advance-dtection));
		 //Mess bill updation
		 out.println("<td>&nbsp;");
		
		
	}
	out.print("</table></center>");
	%>
		</div>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table align="center">
			<tr>

				<!-- 
        <td width="56">
		<input name="CalculationNPF" type="submit" class="buttonbold14" id="CalculationNPF" value="Salary"    >        </td>-->
				<td width="56"><input type="button" class="buttonbold14" id='Close'
					 value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="SalaryProcess">
		<input type="hidden" name="actionS" value="PAYSalaryView"> <input
			type="hidden" name="reportType" value="Month"> <input
			type="hidden" name="Department" value="-1"> <input
			type="hidden" name="Month" value="<%=mnth%>"> <input
			type="hidden" name="Year" value="<%=year%>"></td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>

</html>
