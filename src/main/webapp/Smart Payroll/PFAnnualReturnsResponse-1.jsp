<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage=""%>
<%
try
{
%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<%@ include file="index.jsp"%>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<br>
 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="42">&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>
	<%

String sql="";
String company=request.getParameter("company");
String branch=request.getParameter("branch");
String office=request.getParameter("Office");
String year=request.getParameter("Year");
String year1=""+(Integer.parseInt(""+year)+1); 
String category[]=request.getParameterValues("Category");
String resigned=request.getParameter("Resigned");
String hold=request.getParameter("Hold");
  
String dept=request.getParameter("dept");
sql ="";
 out.println("<center>");
out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
out.println("<tr class='MRow1'><td class='boldEleven' colspan='93' align='center'><h2>PF ANNUAL RETURNS </h2></td></tr>");
out.println("<tr class='MRow2'>");
out.println("<td class='boldEleven'  rowspan='2' align='center'><b>S.No </b></td> ");
out.println("<td class='boldEleven'  rowspan='2' align='center'><b>Empid </b></td> ");
out.println("<td class='boldEleven'  rowspan='2' align='center'><b>Emp Name</b></td> ");
out.println("<td class='boldEleven'  rowspan='2' align='center'><b>Emp FatherName</b></td> ");
out.println("<td class='boldEleven'  rowspan='2' align='center'><b>Company</b></td> ");
out.println("<td class='boldEleven'  rowspan='2' align='center'><b>Branch</b></td> ");
out.println("<td class='boldEleven'  rowspan='2' align='center'><b>Office</b></td> ");
out.println("<td class='boldEleven'  rowspan='2' align='center'><b>Category</b></td> ");
out.println("<td class='boldEleven'  rowspan='2' align='center'><b>Date Of Joining</b></td> ");
out.println("<td class='boldEleven'  colspan='7' align='center'><b>March - "+year+" </b></td> ");
out.println("<td class='boldEleven'  colspan='7' align='center'><b>April - "+year+" </b></td> ");
out.println("<td class='boldEleven'  colspan='7' align='center'><b>May - "+year+" </b></td> ");
out.println("<td class='boldEleven'  colspan='7' align='center'><b>June - "+year+" </b></td> ");
out.println("<td class='boldEleven'  colspan='7' align='center'><b>July - "+year+" </b></td> ");
out.println("<td class='boldEleven'  colspan='7' align='center'><b>August - "+year+" </b></td> ");
out.println("<td class='boldEleven'  colspan='7' align='center'><b>September - "+year+" </b></td> ");
out.println("<td class='boldEleven'  colspan='7' align='center'><b>October - "+year+" </b></td> ");
out.println("<td class='boldEleven'  colspan='7' align='center'><b>November - "+year+" </b></td> ");
out.println("<td class='boldEleven'  colspan='7' align='center'><b>December - "+year+" </b></td> ");
out.println("<td class='boldEleven'  colspan='7' align='center'><b>January - "+year1+" </b></td> ");
out.println("<td class='boldEleven'  colspan='7' align='center'><b>February - "+year1+" </b></td> ");
out.println("</tr>");

out.println("<tr class='MRow2'>");
out.println("<td class='boldEleven' align='center'><b>BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>PEN BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PF</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PENSION</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE</b></td> ");
out.println("<td class='boldEleven' align='center'><b>EDLI</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE1</b></td> ");

out.println("<td class='boldEleven' align='center'><b>BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>PEN BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PF</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PENSION</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE</b></td> ");
out.println("<td class='boldEleven' align='center'><b>EDLI</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE1</b></td> ");

out.println("<td class='boldEleven' align='center'><b>BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>PEN BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PF</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PENSION</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE</b></td> ");
out.println("<td class='boldEleven' align='center'><b>EDLI</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE1</b></td> ");

out.println("<td class='boldEleven' align='center'><b>BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>PEN BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PF</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PENSION</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE</b></td> ");
out.println("<td class='boldEleven' align='center'><b>EDLI</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE1</b></td> ");


out.println("<td class='boldEleven' align='center'><b>BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>PEN BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PF</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PENSION</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE</b></td> ");
out.println("<td class='boldEleven' align='center'><b>EDLI</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE1</b></td> ");

out.println("<td class='boldEleven' align='center'><b>BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>PEN BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PF</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PENSION</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE</b></td> ");
out.println("<td class='boldEleven' align='center'><b>EDLI</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE1</b></td> ");


out.println("<td class='boldEleven' align='center'><b>BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>PEN BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PF</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PENSION</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE</b></td> ");
out.println("<td class='boldEleven' align='center'><b>EDLI</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE1</b></td> ");

out.println("<td class='boldEleven' align='center'><b>BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>PEN BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PF</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PENSION</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE</b></td> ");
out.println("<td class='boldEleven' align='center'><b>EDLI</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE1</b></td> ");


out.println("<td class='boldEleven' align='center'><b>BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>PEN BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PF</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PENSION</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE</b></td> ");
out.println("<td class='boldEleven' align='center'><b>EDLI</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE1</b></td> ");


out.println("<td class='boldEleven' align='center'><b>BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>PEN BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PF</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PENSION</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE</b></td> ");
out.println("<td class='boldEleven' align='center'><b>EDLI</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE1</b></td> ");

out.println("<td class='boldEleven' align='center'><b>BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>PEN BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PF</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PENSION</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE</b></td> ");
out.println("<td class='boldEleven' align='center'><b>EDLI</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE1</b></td> ");

out.println("<td class='boldEleven' align='center'><b>BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>PEN BASIC</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PF</b></td> ");
out.println("<td class='boldEleven' align='center'><b>COMPANY PENSION</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE</b></td> ");
out.println("<td class='boldEleven' align='center'><b>EDLI</b></td> ");
out.println("<td class='boldEleven' align='center'><b>ADMIN CHARGE1</b></td> ");


out.println("</tr>");



sql = " SELECT  a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,b.CHR_OFFICENAME ,h.CHR_CATEGORYNAME, ";
sql = sql+ " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y')  ";
sql = sql+ " FROM com_m_staff a , com_m_office b  , com_m_branch f , com_m_company g ,com_m_employeecategory h ";
sql = sql+ " WHERE  a.INT_OFFICEID= b.INT_OFFICEID  AND a.CHR_PF='C'";
sql = sql+ " AND a.INT_BRANCHID =f.INT_BRANCHID "; 
sql = sql+ " AND a.INT_COMPANYID =g.INT_COMPANYID  ";
sql = sql+ " AND a.CHR_CATEGORY=h.INT_EMPLOYEECATEGORYID ";
sql = sql+ " AND a.DT_DOJCOLLEGE <='"+year1+"-02-29' ";
 
if(!"0".equals(company))
	sql = sql+ " AND a.INT_COMPANYID = "+company;

if(!"0".equals(branch))
	sql = sql+ " AND a.INT_BRANCHID = "+branch;

if(!"0".equals(office))
	sql = sql+ " AND a.INT_OFFICEID = "+office;
	
if(!"Y".equals(resigned))
	sql = sql+ " AND a.CHR_TYPE!='T' ";	
if(!"Y".equals(hold))
	sql = sql+ " AND a.CHR_HOLD!='Y' ";	
	
sql = sql+ " ORDER BY a.CHR_EMPID  ";
 
String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
if(Data.length>0)
{
	for(int u=0;u<Data.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");
			
			out.println("<td class='boldEleven'  >"+(u+1)+" </td> ");
			out.println("<td class='boldEleven'  >"+Data[u][0]+"</td> ");
			out.println("<td class='boldEleven'  >"+Data[u][1]+"</td> ");
			out.println("<td class='boldEleven'  >"+Data[u][2]+"</td> ");
			out.println("<td class='boldEleven'  >"+Data[u][3]+"</td> ");
			out.println("<td class='boldEleven'  >"+Data[u][4]+"</td> ");
			out.println("<td class='boldEleven'  >"+Data[u][5]+"</td> ");
			out.println("<td class='boldEleven' >"+Data[u][6]+"</td> ");
			out.println("<td class='boldEleven'>"+Data[u][7]+"</td> ");
			
			
				sql =" SELECT b.DOU_BASIC,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION,b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1  ";
				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				sql = sql +" AND a.CHR_EMPID =   '"+Data[u][0]+"' " ;
				sql = sql +" AND b.CHR_MONTH IN('March')  ";
				sql = sql +" AND b.INT_YEAR="+year    ;
				 
				String Data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(Data1.length>0)
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >"+Data1[0][v]+"</td> ");
				}
				else
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >&nbsp;</td> ");
				}
					
					
					
				sql =" SELECT b.DOU_BASIC,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION,b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1  ";
				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				sql = sql +" AND a.CHR_EMPID =   '"+Data[u][0]+"' " ;
				sql = sql +" AND b.CHR_MONTH IN('April')  ";
				sql = sql +" AND b.INT_YEAR="+year    ;
				String Data2[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(Data2.length>0)
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >"+Data2[0][v]+"</td> ");
				}
				else
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >&nbsp;</td> ");
				}
					
					
				sql =" SELECT b.DOU_BASIC,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION,b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1  ";
				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				sql = sql +" AND a.CHR_EMPID =   '"+Data[u][0]+"' " ;
				sql = sql +" AND b.CHR_MONTH IN('May')  ";
				sql = sql +" AND b.INT_YEAR="+year    ;
				String Data3[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(Data3.length>0)
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >"+Data3[0][v]+"</td> ");	
				}
				else
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >&nbsp;</td> ");
				}
					
					
				sql =" SELECT b.DOU_BASIC,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION,b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1  ";
				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				sql = sql +" AND a.CHR_EMPID =   '"+Data[u][0]+"' " ;
				sql = sql +" AND b.CHR_MONTH IN('June')  ";
				sql = sql +" AND b.INT_YEAR="+year    ;
				String Data4[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(Data4.length>0)
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >"+Data4[0][v]+"</td> ");	
				}
				else
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >&nbsp;</td> ");
				}
					
					
					
					
				sql =" SELECT b.DOU_BASIC,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION,b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1  ";
				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				sql = sql +" AND a.CHR_EMPID =   '"+Data[u][0]+"' " ;
				sql = sql +" AND b.CHR_MONTH IN('July')  ";
				sql = sql +" AND b.INT_YEAR="+year    ;
				String Data5[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(Data5.length>0)
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >"+Data5[0][v]+"</td> ");		
				}
				else
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >&nbsp;</td> ");
				}
					
					
					
				sql =" SELECT b.DOU_BASIC,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION,b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1  ";
				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				sql = sql +" AND a.CHR_EMPID =   '"+Data[u][0]+"' " ;
				sql = sql +" AND b.CHR_MONTH IN('August')  ";
				sql = sql +" AND b.INT_YEAR="+year    ;
				String Data6[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(Data6.length>0)
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >"+Data6[0][v]+"</td> ");		
				}
				else
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >&nbsp;</td> ");
				}
					
					
				
					sql =" SELECT b.DOU_BASIC,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION,b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1  ";
				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				sql = sql +" AND a.CHR_EMPID =   '"+Data[u][0]+"' " ;
				sql = sql +" AND b.CHR_MONTH IN('September')  ";
				sql = sql +" AND b.INT_YEAR="+year    ;
				String Data7[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(Data7.length>0)
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >"+Data7[0][v]+"</td> ");		
				}
				else
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >&nbsp;</td> ");
				}
					
				
					
					sql =" SELECT b.DOU_BASIC,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION,b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1  ";
				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				sql = sql +" AND a.CHR_EMPID =   '"+Data[u][0]+"' " ;
				sql = sql +" AND b.CHR_MONTH IN('October')  ";
				sql = sql +" AND b.INT_YEAR="+year    ;
				String Data8[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(Data8.length>0)
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >"+Data8[0][v]+"</td> ");		
				}
				else
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >&nbsp;</td> ");
				}
					
					
					
					sql =" SELECT b.DOU_BASIC,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION,b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1  ";
				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				sql = sql +" AND a.CHR_EMPID =   '"+Data[u][0]+"' " ;
				sql = sql +" AND b.CHR_MONTH IN('November')  ";
				sql = sql +" AND b.INT_YEAR="+year    ;
				String Data9[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(Data9.length>0)
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >"+Data9[0][v]+"</td> ");		
				}
				else
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >&nbsp;</td> ");
				}
					
					
					
					sql =" SELECT b.DOU_BASIC,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION,b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1  ";
				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				sql = sql +" AND a.CHR_EMPID =   '"+Data[u][0]+"' " ;
				sql = sql +" AND b.CHR_MONTH IN('December')  ";
				sql = sql +" AND b.INT_YEAR="+year    ;
				String Data10[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(Data10.length>0)
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >"+Data10[0][v]+"</td> ");		
				}
				else
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >&nbsp;</td> ");
				}
					
			 
					
					sql =" SELECT b.DOU_BASIC,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION,b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1  ";
				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				sql = sql +" AND a.CHR_EMPID =   '"+Data[u][0]+"' " ;
				sql = sql +" AND b.CHR_MONTH IN('January')  ";
				sql = sql +" AND b.INT_YEAR="+year1    ;
				String Data11[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(Data11.length>0)
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >"+Data11[0][v]+"</td> ");		
				}
				else
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >&nbsp;</td> ");
				}
					
					
					
					sql =" SELECT b.DOU_BASIC,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION,b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1  ";
				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				sql = sql +" AND a.CHR_EMPID =   '"+Data[u][0]+"' " ;
				sql = sql +" AND b.CHR_MONTH IN('February')  ";
				sql = sql +" AND b.INT_YEAR="+year1    ;
				String Data12[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(Data12.length>0)
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >"+Data12[0][v]+"</td> ");		
				}
				else
				{
					for(int v=0;v<7;v++)
						out.println("<td class='boldEleven'   >&nbsp;</td> ");
				}
					
					
						
					
					
						
 
			
			 
 	
			out.println("</tr>");
	
	}
}

out.println("</table>");
out.println("</center>"); 





	%>
	
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  <tr>
    <td><table width="184" align="center" cellpadding="15" cellspacing="0">
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
			onClick="windowSave('Monthlypf.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('Monthlypf.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('Monthlypf.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>

	</tr>
</table></td>
</table>
 
<%@ include file="../footer.jsp"%>
</body>

</html>
<%
}
catch(Exception e)
{
	out.println(""+e.getMessage());
}

%>