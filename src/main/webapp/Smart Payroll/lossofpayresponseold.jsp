<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*,com.my.org.erp.Math.*"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>

<title> :: PAYROLL ::</title>


 

<%
try
{
 	String  company  = request.getParameter("company");
	String  branch  = request.getParameter("branch");
	String  Office  = request.getParameter("Office");
	String  Month  = request.getParameter("Month");
	String  Year  = request.getParameter("Year");
	String repmon = DateUtil.getMonth(Integer.parseInt( Month));
	String bra="";
	String off="";
	String sql="";
	sql  =" SELECT INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT FROM m_institution  ";
	String cpydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	double cpypf1 = Double.parseDouble(cpydata[0][0]);
	double cpypf2 = Double.parseDouble(cpydata[0][1]);
	double cpyesi = Double.parseDouble(cpydata[0][2]);
	sql="";
	if(!"-1".equals(branch))
		bra = " AND a.INT_BRANCHID=  "+branch;
	if(!"0".equals(Office))
		off = " AND a.INT_OFFICEID=  "+Office;
		
		
	sql = " SELECT b.CHR_EMPID,a.CHR_STAFFNAME,";
	sql = sql +" b.DOU_WORKDAYS,b.DOU_BASIC,c.CHR_COMPANYNAME,d.CHR_BRANCHNAME,e.CHR_OFFICENAME,b.DOU_CTC  ";
	sql = sql +" FROM com_m_staff a, pay_t_salary b,com_m_company c,com_m_branch d, com_m_office  e ";
	sql = sql +" WHERE a.CHR_TYPE !='T' AND a.CHR_HOLD!='Y' ";
	sql = sql +" AND b.CHR_EMPID=a.CHR_EMPID ";
	sql = sql +" AND a.INT_OFFICEID=  e.INT_OFFICEID ";
	sql = sql +" AND a.INT_COMPANYID= c.INT_COMPANYID ";
	sql = sql +" AND a.INT_BRANCHID= d.INT_BRANCHID ";
	
	sql = sql +" AND b.CHR_MONTH ='"+repmon+"' ";
	sql = sql +" AND b.INT_YEAR = "+Year;
	sql = sql +off;
	sql = sql +" AND a.INT_COMPANYID=  "+company;
	sql = sql +bra;
	sql = sql + " ORDER BY a.CHR_STAFFNAME";
	//out.println(sql);
 	String reportdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	double basic=0.0;
	double allowance=0.0;
	double calpf1=0;
	double calpf2=0;
	double calesi=0;
	double total1=0;
	double total2=0;
	double total3=0;
	if(reportdata.length>0)
	{
		out.println("<center><table  id='myTable' cellspacing=0 cellpadding=2 border=1>");
		out.println("<tr><td class='boldEleven'><b> S.No");
		out.println("<td class='boldEleven'><b>Emp Id");
		out.println("<td class='boldEleven'><b>Emp Name");
		out.println("<td class='boldEleven'><b>Date of Join");
		out.println("<td class='boldEleven'><b>Company");
		out.println("<td class='boldEleven'><b>Branch");
		out.println("<td class='boldEleven'><b>Office");
		out.println("<td class='boldEleven'><b>No of loss of day");
		out.println("<td class='boldEleven'><b>Original CTC");
		out.println("<td class='boldEleven'><b>Month    CTC");
		out.println("<td class='boldEleven'><b>Difference");
		boolean f = false;
		for(int u=0;u<reportdata.length;u++)
		{
			sql ="select count(*) from com_m_staff  where month(DT_DOJCOLLEGE)="+Month;
			sql = sql+" and year(DT_DOJCOLLEGE)="+Year + " AND CHR_EMPID='"+reportdata[u][0].trim()+"'";
			f = com.my.org.erp.common.CommonFunction.RecordExist(sql);
			sql =  "SELECT month(DT_DOJCOLLEGE),month(now()), year(DT_DOJCOLLEGE),year(now()),DT_DOJCOLLEGE  From com_m_staff WHEre CHR_EMPID='"+reportdata[u][0].trim()+"'";
			String reportdatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			
			
			
			
			
				
			if(!f)
			{	
				out.println("<tr><td class='boldEleven' align='right'>"+(u+1));
				out.println("<td class='boldEleven'>"+reportdata[u][0].trim());
				out.println("<td class='boldEleven'>"+reportdata[u][1].trim());
				out.println("<td class='boldEleven'>"+reportdatas[0][4].trim());
				out.println("<td class='boldEleven'>"+reportdata[u][4].trim());
				out.println("<td class='boldEleven'>"+reportdata[u][5].trim());
				out.println("<td class='boldEleven'>"+reportdata[u][6].trim());
				sql = "SELECT DOU_ABSENT FROM att_t_register where CHR_EMPID='"+reportdata[u][0].trim()+"'  AND CHR_MONTH='"+repmon+"'  AND INT_YEAR="+Year;
				String lopday[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(lopday.length>0)
					out.println("<td class='boldEleven'>"+lopday[0][0].trim());
				else
					out.println("<td class='boldEleven'>");	
				basic=0.0;
				allowance=0.0;
	
sql="";
sql =" SELECT (b.A001+b.A002+b.A003+b.A004+b.A005+b.A006)";
sql = sql+" FROM pay_t_salaryallowance b ";
sql = sql+" WHERE b.CHR_MONTH ='"+repmon+"' AND b.INT_YEAR = "+Year+"  AND  b.CHR_EMPID = '"+reportdata[u][0].trim()+"'";
String grossdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
if(grossdata.length>0)
	allowance = Double.parseDouble(grossdata[0][0]);
	
sql="";
sql =" SELECT a.INT_SALARY ";
sql = sql+" FROM pay_t_salarybasic a";
sql = sql+" WHERE a.CHR_MONTH ='"+repmon+"' AND a.INT_YEAR = "+Year+"  AND  a.CHR_EMPID = '"+reportdata[u][0].trim()+"'";
String basicdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
if(basicdata.length>0)
	 basic= Double.parseDouble(basicdata[0][0]);
	
	
				calpf1 = basic*(cpypf1/100)	;
				calpf2 = basic*(cpypf2/100)	;
				calesi = (basic+allowance)*(cpyesi/100);
				total1 = allowance+basic+calpf1+calpf2+calesi;
				total2 = Double.parseDouble(reportdata[u][7].trim());

				out.println("<td class='boldEleven'  align='right'>"+Math.round(total1));
				out.println("<td class='boldEleven'  align='right'>"+total2);
				out.println("<td class='boldEleven'  align='right'>"+Math.round(total1-total2));
				total3 = total3+Math.round(total1-total2);
			}
		}
		out.println("<tr><td colspan=8>&nbsp;<td>"+total3);
		out.println("</table>");
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
			onClick="windowSave('lop.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('lop.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('lop.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>

	</tr>
</table>
		<%
		
	}
}
catch(Exception e)
{
}
 %>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
