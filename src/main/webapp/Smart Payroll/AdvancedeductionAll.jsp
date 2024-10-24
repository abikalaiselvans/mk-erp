<%@ page language="java" import="java.sql.*,com.my.org.erp.ServiceLogin.*" errorPage=""%>
<html>
<head>
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


<title> :: PAYROLL ::</title>


 
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste='return false;'>


 
<%@ include file="index.jsp"%>
 
  <%
try
{
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	<form method="post" action="../SmartLoginAuth" onSubmit="return Valid()">
	<div align="center">
	<%
	
	String sql=" SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,d.CHR_OFFICENAME, ";
	sql = sql+" (SELECT sum(b.INT_ADVAMT) from pay_m_advance b where b.CHR_EMPID=a.CHR_EMPID),"; 
	sql = sql+" (SELECT sum(c.INT_DUEAMT) FROM pay_t_advance c where c.CHR_EMPID=a.CHR_EMPID), ";
	sql = sql+" ((SELECT sum(b.INT_ADVAMT) from pay_m_advance b where b.CHR_EMPID=a.CHR_EMPID)- ";
	sql = sql+" (SELECT sum(c.INT_DUEAMT) FROM pay_t_advance c where c.CHR_EMPID=a.CHR_EMPID)) ,a.CHR_TYPE,a.CHR_MOBILE";
	sql = sql+" FROM com_m_staff a ,  com_m_office  d WHERE a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y'  ";
	sql = sql+" AND (SELECT sum(b.INT_ADVAMT) from pay_m_advance b where b.CHR_EMPID=a.CHR_EMPID) is not null ";
	sql = sql+" AND ((SELECT sum(b.INT_ADVAMT) from pay_m_advance b where b.CHR_EMPID=a.CHR_EMPID)- ";
	sql = sql+" (SELECT sum(c.INT_DUEAMT) FROM pay_t_advance c where c.CHR_EMPID=a.CHR_EMPID)) >0 ";
	sql = sql+" AND  a.INT_OFFICEID=d.INT_OFFICEID group by a.CHR_EMPID ORDER BY a.CHR_STAFFNAME";
	//a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y' AND   
	
	
	sql = "SELECT b.CHR_EMPID,a.CHR_STAFFNAME, d.CHR_OFFICENAME,  ";
	sql = sql+" (SELECT sum(b.INT_ADVAMT) from pay_m_advance b where b.CHR_EMPID=a.CHR_EMPID), ";
	sql = sql+" a.CHR_TYPE ,a.CHR_MOBILE ";
	sql = sql+" from com_m_staff a , pay_m_advance b ,  com_m_office  d  ";
	sql = sql+" WHERE b.CHR_EMPID=a.CHR_EMPID AND a.INT_OFFICEID=d.INT_OFFICEID    group by  b.CHR_EMPID  order by a.CHR_STAFFNAME";
	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	String Month = request.getParameter("Month");
	String Year = request.getParameter("Year");
	
	out.println("<center><table id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr bgcolor='#ffffff'><td class='boldEleven' colspan=8 align=center><b> ADVANCE ");
	out.println(" ( "+DateUtil.getMonth(Integer.parseInt(Month))+" - "+Year +" )" );
	out.println("<tr bgcolor='#ffffff'><td class='boldEleven' colspan=8 align=center>");
	
	

	
	out.println("<tr bgcolor='#ffffff'><td class='boldEleven'><b>S.No");
	out.println("<td class='boldEleven'><b>EmpId");
	out.println("<td class='boldEleven'><b>Staff Name");
	out.println("<td class='boldEleven'><b>Office");
	out.println("<td class='boldEleven'><b>Mobile");
	out.println("<td class='boldEleven'><b>Advance Pending");
	out.println("<td class='boldEleven'><b>Deduction Amount");
	out.println("<td class='boldEleven'>");
	 
	String link="";
	int u=0;
	double advance=0;
	double deduction=0;
	double balance=0;
	boolean f=false;
	String alreadydeduction="";
	String readonly="";
	for(int y=0;y<data.length;y++)
	{
		 
		advance=0;
		deduction=0;
		balance=0;
		sql = " SELECT sum(INT_DUEAMT) FROM pay_t_advance where CHR_EMPID='"+data[y][0]+"'";
		String balancedata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(!"-".equals(balancedata[0][0]))
				deduction= Double.parseDouble(balancedata[0][0]);
		else
			deduction=0;		
		advance=Double.parseDouble(data[y][3]);	
		balance = advance-deduction;
		
		if(balance>0)
		{		
			
			sql = " SELECT count(*) FROM pay_t_advance where CHR_EMPID='"+data[y][0]+"'";
			sql = sql +" AND INT_YEAR ="+Year+" AND CHR_MONTH='"+DateUtil.getMonth(Integer.parseInt(Month))+"' AND CHR_TYPE='Y' ";
			if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
			{
				alreadydeduction=" bgcolor='#00FFFF' ";
				readonly=" readonly='readonly' ";
			}	
			else
			{
				alreadydeduction ="";
				readonly="";
			}	
			if(u%2==0)
				out.println("<tr bgcolor='#ffffff'><td class='boldEleven'>"+(u+1));
			else
				out.println("<tr bgcolor='#efefef'><td class='boldEleven'>"+(u+1));	
			out.println("<td class='boldEleven'>"+data[y][0]);
			link="";
			link="AdvanceIndividualview.jsp?ename="+data[y][0];
			out.println("<td class='boldEleven'>"+data[y][1]);
			out.println("<td class='boldEleven'>"+data[y][2]);
			out.println("<td class='boldEleven'>"+data[y][5]);
			out.println("<td class='boldEleven' "+alreadydeduction+" align='right'><b><font color=red>"+(int)balance+"</font>");
			out.println("<input type=hidden name='empid"+(u+1)+"' id='empid"+(u+1)+"' value='"+data[y][0]+"'>");
			out.println("<td class='boldEleven'>");
			out.println("<input type=text size=10 name='advdeduction"+(u+1)+"' onkeyPress=\"numericValue('advdeduction"+(u+1)+"',6)\" ");
			out.println(" id='advdeduction"+(u+1)+"' value='0' class='formText135' style='text-align:right' "+readonly+" >");	
			
			sql = " SELECT SUM(INT_DUEAMT) FROM pay_t_advance where CHR_EMPID='"+data[y][0]+"'";
			sql = sql +" AND INT_YEAR ="+Year+" AND CHR_MONTH='"+DateUtil.getMonth(Integer.parseInt(Month))+"' AND CHR_TYPE='Y' ";
			String data1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			out.println("<td class='boldEleven'>");
			if(!"-".equals(data1[0][0]))
				out.println(data1[0][0]);
			else
				out.println("&nbsp;");	
			out.println("<input type=hidden name='advpending"+(u+1)+"' id='advpending"+(u+1)+"' value='"+(int)balance+"'>"); 
			u = u+1;	
		} 	
	}
	out.println("<tr bgcolor='#ffffff'><td class='boldEleven' colspan=8 align=center>");
	out.println("<input type=hidden name=totalrow id=totalrow value='"+u+"'>");
	out.println("<tr bgcolor='#ffffff'><td class='boldEleven' colspan=8 align=center>");
	%>
	  </div>
	<table width="182" border="0" align="center" cellpadding="2" cellspacing="2">
		<tr>
			<td width="42"><input name="actionS"
								type="hidden" id="actionS" value="PAYAdvanceTotalRecovery" />
              <input name="filename" type="hidden"
								id="filename" value="EmpAdvance" />
              <input name="Month" type="hidden" id="Month" value="<%=Month%>">
              <input name="Year" type="hidden" id="Year" value="<%=Year%>"></td>
			<td width="67"><input type="submit" name="Submit"
				id="submit_btn" class="tMLAscreenHead" value="Adv- Rec" />			  </td>
			<td width="53"><input type="button" name="submit"
				class="tMLAscreenHead"  value="Close"   accesskey="c" 
				onClick="redirect('Payrollmain.jsp')" /></td>
		</tr>
	</table>
	
	<div align="center">
	  <%
		
	out.println("</table></center>");
	
	
	
	

	%>
	
	<script language="javascript">

 
function  Valid()
{
	
	var row="<%=u%>";
	var balance=0;
	var advamount=0;
	var am1=0;
	var am2=0;
	var f = false;
	var s="";
	for(u=1;u<=row;u++)
	{
		
		s=("advpending"+u);
		balance=document.getElementById(s).value;
		s=("advdeduction"+u);
   		advamount=document.getElementById(s).value;
		am1= parseInt(advamount);
   		am2= parseInt(balance);
		if(am1>am2)
		{
			alert("Invalid Amount");
			document.getElementById("advdeduction"+u).focus();
			f = true;
			return false;
		}
	}
	 
	if(f)
		return false;
	else
		return true;
}	
</script>
	
	  </div>
	</form>
	<div align="center"></div></td>
  </tr>
  <tr>
    <td>
	

	</td>
  </tr>
</table>


<%
	
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
<p>&nbsp;</p>
<%@ include file="../footer.jsp"%>
</body>
</html>
