<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
Connection con;
Statement st;
ResultSet rs;
String sql;%>
 <%@ page import="com.my.org.erp.SmartPayroll.Travel"%>
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
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   method="get" name='frmState'>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<%
   	String OptType=request.getParameter("OptType");
	String mon=request.getParameter("Month");
	mon=DateUtil.getMonth(Integer.parseInt(mon));
	String title="";
	if(OptType.equals("D"))
		title="Date of Birth  - "+mon;
	else
		title="Wedding Date  -  "+mon;
		
	  out.println("<center><br><br><br>");
	  out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");	
	  out.println("<tr class='MRow1'><td colspan='10'  class='boldEleven' align='center'><b>"+title+"   <a title='Excel' href='javascript:;' onClick=' CreateExcelSheet()'><img src='../Image/report/Excel.png' width='15' height='14' border='0'></a>  </b></td></tr>");
	
	  out.println("<tr  class='MRow1' align='center' class='bolddeepblue'>");
	   out.println("<td     height='28' align='center' class='bold1'><div align='center'>S.No</div></td>");
	  out.println("<td     height='28' align='center' class='bold1'><div align='center'>Staff Id</div></td>");
	  out.println("<td    align='center' class='bold1'><div align='center'>Staff Name</div></td>");
	  out.println("<td    align='center' class='bold1'><div align='center'>Department</div></td>");
	  out.println("<td    align='center' class='bold1'><div align='center'>Designation</div></td>");
	  out.println(" <td     align='center' class='bold1'><div align='center'>Gender</div></td>");
	  out.println("<td    align='center' class='bold1'><div align='center'>Office</td>");
	  
	  out.println("<td    align='center' class='bold1'> <div align='center'>Date Of Joining</div></td>");
	  out.println("<td    align='center' class='bold1'><div align='center'>");
      if(OptType.equals("D"))
		out.println("Date of Birth</td>");
	  else
		out.println("Wedding Date</td>");	
	   
	  out.println("<td  align='center' class='bold1'><div align='center'>Mail</div></td>");
    
         if(OptType.equals("D"))
		 {
				sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,A.CHR_GENDER,DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%b-%Y'),";
				sql=sql+"DATE_FORMAT(A.DT_DOB,'%d-%b-%Y') ,D.CHR_OFFICENAME,DAY(A.DT_DOB), DAY(now()) FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C ,com_m_office D WHERE ";
				sql=sql+" MONTHNAME(A.DT_DOB)='"+mon+"' AND A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND ";
				sql=sql+" A.CHR_TYPE !='T' AND A.CHR_HOLD!='Y'  AND a.INT_OFFICEID =D.INT_OFFICEID order BY DAY(A.DT_DOB)";
		  		String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
				if(Data.length>0)
				{
					for(int u=0;u<Data.length;u++)
					{
						
						if(u%2==0)
							out.println("<tr class='Mrow1'>");
						else
							out.println("<tr class='Mrow2'>");
						out.println(" <td  class='boldEleven' align='left'>"+(u+1)+".</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][0]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][1]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][2]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][3]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][4]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][7]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][5]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][6]+"</td>");
						
						if( Data[u][8].equals(Data[u][9]) )
							out.println(" <td  class='boldEleven' align='left'><a href='../SmartLoginAuth?filename=DOBandWeddingMail&actionS=PAYDOBMail'><font class='bolddeepred'>send mail</font></a></td>");
						else
							out.println(" <td  class='boldEleven' align='left'>&nbsp;</td>"); 
						out.println("</tr>");
					}
				}
		}
		else
		{
				sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,A.CHR_GENDER,DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%b-%Y'),";
				sql=sql+"DATE_FORMAT(A.DT_WEDDATE,'%d-%b-%Y'),D.CHR_OFFICENAME,DAY(A.DT_WEDDATE), DAY(now()) FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C ,com_m_office D WHERE  ";
				sql=sql+" MONTHNAME(A.DT_WEDDATE)='"+mon+"'AND A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID  AND a.INT_OFFICEID =D.INT_OFFICEID ";
				sql=sql+" AND A.CHR_TYPE !='T' AND A.CHR_HOLD!='Y'   order BY DAY(A.DT_WEDDATE)";
				String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
				if(Data.length>0)
				{
					for(int u=0;u<Data.length;u++)
					{
						
						if(u%2==0)
							out.println("<tr class='Mrow1'>");
						else
							out.println("<tr class='Mrow2'>");
						out.println(" <td  class='boldEleven' align='left'>"+(u+1)+".</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][0]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][1]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][2]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][3]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][4]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][7]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][5]+"</td>");
						out.println(" <td  class='boldEleven' align='left'>"+Data[u][6]+"</td>");
						
						if( Data[u][8].equals(Data[u][9]) )
							out.println(" <td  class='boldEleven' align='left'><a href='../SmartLoginAuth?filename=DOBandWeddingMail&actionS=PAYDOBMail'><font class='bolddeepred'>send mail</font></a></td>");
						else
							out.println(" <td  class='boldEleven' align='left'>&nbsp;</td>"); 
						out.println("</tr>");
					}
				}
		}
	
	
	out.println("</table>");
	out.println("</center>");	
	
	
			%><br><br> 
		<table width="100" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td>&nbsp;</td>
				<td><input name="Button" type="button" class="buttonbold"
					 value="Close"   accesskey="c"  onClick="redirect('DOB.jsp')"></td>
			</tr>
		</table>		
<%@ include file="../footer.jsp"%>
</body>
</html>
