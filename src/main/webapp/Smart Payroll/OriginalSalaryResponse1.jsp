<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

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

<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<%@ include file="index.jsp"%>
<br>
<br>

<%
	String addsql="";
	String repName="";
	String repHeader="";
	String empid,empname,basic,bank,acno,fname,bg,mobile,cpyname,rivisiondate;
	String pf,esi,cpyesi,cpypf,ctc,office,email,paddress,bname,advamount;
	String doj,dob,dow,gender,dept,desig,qualification,caddress,experience,officename,resigned ;
	String Office= request.getParameter("Office");
	String Dept= request.getParameter("Dept");
	resigned= request.getParameter("resigned");
	String orderby= request.getParameter("orderby");
	
	String resgsql="";
	if(!"Y".equals(resigned))
		resgsql=" AND a.CHR_TYPE!='T'";
	else
		resgsql="";	
		
	String off="";
	String dep="";
	if(!"0".equals(Office))
		off=" AND a.INT_OFFICEID="+Office;
	if(!"0".equals(Dept))
		dep=" AND a.INT_DEPARTID= "+Dept;
	
	String allowdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("select CHR_ACODE ,CHR_ANAME from pay_m_allowance WHERE CHR_MONTHFLAG='N' AND CHR_FLAG='Y'");
	String allheader="";
	String sqlall="";
	String sqlallo="";
	for(int u=0;u<allowdata.length;u++)
	{
		allheader = allheader+allowdata[u][1]+",";
		sqlall = sqlall+" d."+allowdata[u][0]+", ";
		sqlallo = sqlallo+" d."+allowdata[u][0]+"+ ";
	}
	sqlall=sqlall.trim();
	sqlall = sqlall.substring(0,sqlall.length()-1);
	 
	repHeader = "S.No,Empid,EmpName,Date of Joning,Basic,";
	repHeader = repHeader +allheader+" Gross Pay,Employee PF,PF Number,Employee ESI,ESI Number ,Employeer Pension,Employeer PF,Employeer ESI,Total,CTC,Depart Name,Office Name,Qualification,Branch Name, Company Name, Bank Name,Account Number,Blood Group,Mobile ,Email,Gender,Date of Birth,Address,Experience(yrs)";	
	
	repHeader = repHeader +",Rivision Date";
	//sql = sql+",round(("+sqlgpay+"-("+sqlpf+"+"+sqlesi+"))+)";
	String sqlgpay =" (" +sqlallo+"a.INT_SALARY )";
	String sqlpf="(a.INT_SALARY )*(12/100)";
	String sqlesi="((" +sqlallo+"a.INT_SALARY )*(1.75/100))";
	String sqlcpypesion ="(a.INT_SALARY )*(8.35/100)";
	String sqlcpyppf ="(a.INT_SALARY )*(3.67/100)";
	String sqlcpyesi ="(" +sqlallo+"a.INT_SALARY )*(4.75/100)";
	
	String sql ="";
	sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.DT_DOJCOLLEGE,round(a.INT_SALARY) ,"+sqlall +",round(" +(sqlallo+"a.INT_SALARY )");
	sql = sql+",round((a.INT_SALARY )*(12/100))";
	sql = sql+",a.CHR_PFNO";
	sql = sql+",round((" +sqlallo+"a.INT_SALARY )*(1.75/100))";
	sql = sql+",a.CHR_ESINO";
	sql = sql+",round((a.INT_SALARY )*(8.35/100))";
	sql = sql+",round((a.INT_SALARY )*(3.67/100))";
	sql = sql+",round((" +sqlallo+"a.INT_SALARY )*(4.75/100))";
	sql = sql+",round("+sqlgpay+"-("+sqlpf+"+"+sqlesi+"))";
	sql = sql+",round(("+sqlgpay+")+("+sqlcpypesion+")+("+sqlcpyppf+")+("+sqlcpyesi+"))";
	sql = sql+",c.CHR_DEPARTNAME";
	sql = sql+",b.CHR_OFFICENAME ";
	sql = sql+",e.CHR_QUALIFICATIONNAME ,f.CHR_BRANCHNAME,g.CHR_COMPANYNAME,FIND_A_BANKNAME_NAME(h.INT_BANKID),a.CHR_ACCNO ";
	sql = sql+",a.CHR_BG,a.CHR_MOBILE,a.CHR_EMAILID,a.CHR_GENDER,a.DT_DOB";
	sql = sql+",CONCAT(CONCAT(\"S/o \",a.CHR_STAFFFNAME,\",\", a.CHR_PADD1,\",\", a.CHR_PADD2 ,\",\",a.CHR_PCITY ,\", PIN - \",a.CHR_PPIN))";
	sql = sql+",round(datediff(now(),a.DT_DOJCOLLEGE)/365)";
	
	//ctcsal=(grosspay+CompanyPF1+CompanyPF2+CompanyESI);
	sql = sql+" FROM com_m_staff  a ,  com_m_office  b ,com_m_depart c ,pay_t_allowance d ";
	sql = sql+" ,com_m_qualification e , com_m_branch f , com_m_company g, com_m_bank h ";
	
	
	// com_m_qualification INT_QUALIFICATIONID CHR_QUALIFICATIONNAME
 	//com_m_branch    INT_BRANCHID  CHR_BRANCHNAME
 	//com_m_company   INT_COMPANYID  CHR_COMPANYNAME
 	//com_m_bank      INT_BANKID  CHR_BANKNAME
 
	
	sql = sql+" where a.CHR_HOLD!='Y' "+resgsql;
	sql = sql+" AND a.INT_DEPARTID = c.INT_DEPARTID AND a.INT_OFFICEID= b.INT_OFFICEID";
	sql = sql+" AND  a.CHR_EMPID =d.CHR_EMPID ";
	
	sql = sql+" AND  a.CHR_QUALIFICATION =e.INT_QUALIFICATIONID ";
	sql = sql+" AND  a.INT_BRANCHID =f.INT_BRANCHID ";
	sql = sql+" AND  a.INT_COMPANYID =g.INT_COMPANYID ";
	sql = sql+" AND  a.CHR_BANK =h.INT_BANKID ";
	
	sql = sql +off;
	sql = sql +dep;
	sql = sql+" ORDER BY  "+orderby;
	
	//out.println(sql);
	double gp=0.0;
	String repdata[]=repHeader.split(",");
	String reportdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	out.println("<center> <table id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	if(reportdata.length>0)
	{
		out.println("<tr bgcolor='#ffffff'><td colspan=\""+repdata.length+"\"><h3>"+repName+"</h3></td></tr>");
		out.println("<tr bgcolor='#ffffff'>");
		for(int x=0;x<repdata.length;x++)
		out.println("<td class=\"boleEleven\"><b>"+repdata[x]);
		for(int x=0;x<reportdata.length;x++)
		{
			if(x%2 ==0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");	
			out.println("<td  class=\"Report\">"+(x+1));
			for(int y=0;y<repdata.length-2;y++)
			{
				if((y==13) || (y==17))
				{
					gp = Double.parseDouble(reportdata[x][10].trim());
					if(gp >=10001)
						out.println("<td  class=\"Report\" align=\"right\">0");
					else
						out.println("<td  class=\"Report\" align=\"right\">"+reportdata[x][y].trim());	
				}
				else	
					out.println("<td  class=\"Report\" align=\"right\">"+reportdata[x][y].trim());
			
			}
			String emp = reportdata[x][0];
			sql="SELECT DT_RIVISION FROM pay_t_rivision where INT_RIVISIONID = (select max(INT_RIVISIONID) from pay_t_rivision WHERE CHR_EMPID='"+emp+"')";
			String rividate[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(rividate.length>0)
				out.println("<td  class=\"Report\" align=\"right\">"+rividate[0][0]);
			else
				out.println("<td  class=\"Report\" align=\"right\">&nbsp;");
			
		}	
	}
	out.println("</table></center>"); 
%>

<table width="184" align="center" cellpadding="15" cellspacing="0">
	<tr>
		<td width="100" height="44" class="boldEleven"><strong>Export
		</strong></td>
		<td class="boldEleven">
		<div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>
		</div>
		</td>

		<td class="boldEleven">
		<div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('Salary.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('Salary.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('Salary.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>

	</tr>
</table>
<%@ include file="../footer.jsp"%>