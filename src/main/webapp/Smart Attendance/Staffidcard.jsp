<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%
try
{
%>
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


<title> :: ATTENDANCE ::</title>



<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

 <%
 	String staffid= request.getParameter("staffid");
	String sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y') ,f.CHR_GROUPNAME ,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'),a.CHR_GENDER,  ";
	sql = sql+ " b.CHR_DEPARTNAME,c.CHR_DESIGNAME,d.CHR_COMPANYNAME,e.CHR_BRANCHNAME,e.CHR_STREET,e.CHR_CITY,e.CHR_POSTAL,e.CHR_PHONE,e.CHR_FAX   ";
	sql = sql+ " FROM com_m_staff a  ,com_m_depart b,com_m_desig c,com_m_company d,com_m_branch e ,com_m_bloodgroup f ";
	sql = sql+ " WHERE   a.INT_DEPARTID = b.INT_DEPARTID  ";
	sql = sql+ " AND a.INT_DESIGID =c.INT_DESIGID   ";
	sql = sql+ " AND a.INT_COMPANYID = d.INT_COMPANYID   ";
	sql = sql+ " AND a.INT_COMPANYID = e.INT_COMPANYID  ";
	sql = sql+ " AND a.INT_BRANCHID = e.INT_BRANCHID   ";
	sql = sql+ " AND a.CHR_BG = f.INT_BLOODGROUPID   ";
	
	sql = sql+ " AND a.CHR_EMPID='"+staffid+"'";
	String	data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data.length>0)
	{
	%>
 <table width="618" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
     <td bordercolor="#666666"> <table width="300" border="0" align="center" cellpadding="1" cellspacing="1">
       <tr>
         <td><div align="center"><img src="../images/logo.jpg" width="159" height="49"></div></td>
       </tr>
       <tr>
         <td>&nbsp;</td>
       </tr>
       <tr>
         <td>&nbsp;</td>
       </tr>
       <tr>
         <td align="center"><%
			String staffphoto = request.getRealPath("/")+"StaffPhoto/"+staffid.trim() +".jpg";
			String defaul = "../StaffPhoto/default.jpg" ;
			String photo="";
			File f = new File(staffphoto);
			if (f.exists())
				photo ="../StaffPhoto/"+staffid.trim() +".jpg";
			else
				photo =defaul;
	%>
             <img src="<%=photo%>" title="<%=photo%>" width="100" height="130" border="1" name="Photo" id="Photo" /> </td>
       </tr>
       <tr>
         <td class="boldEleven"><div align="center"><%=data[0][1]%></div></td>
       </tr>
       <tr>
         <td>&nbsp;</td>
       </tr>
       <tr>
         <td><div align="center"><img src="../images/wipro.jpg" width="112" height="112"></div></td>
       </tr>
     </table></td>
     <td width="100" align="center" valign="top">&nbsp;</td>
     <td align="center" valign="top"> <table width="300" border="0" align="center" cellpadding="1" cellspacing="1">
       <tr>
         <td width="200"><div align="center"> </div></td>
         <td width="200">&nbsp;</td>
       </tr>
       <tr>
         <td class="boldEleven">Emp Id </td>
         <td class="boldEleven"><%=data[0][0]%></td>
       </tr>
       <tr>
         <td class="boldEleven">Blood Group </td>
         <td class="boldEleven"><%=data[0][3]%></td>
       </tr>
       <tr>
         <td align="center" class="boldEleven">&nbsp;</td>
         <td align="center" class="boldEleven">&nbsp;</td>
       </tr>
       <tr>
         <td colspan="2" class="bold1">Instruction </td>
       </tr>
       <tr>
         <td colspan="2" class="boldEleven">1. Not transferable. </td>
       </tr>
       <tr>
         <td colspan="2" class="boldEleven">2. If lost , inform HR Dept. </td>
       </tr>
       <tr>
         <td class="boldEleven">&nbsp;</td>
         <td class="boldEleven">&nbsp;</td>
       </tr>
       <tr>
         <td class="boldEleven">&nbsp;</td>
         <td class="boldEleven">&nbsp;</td>
       </tr>
       <tr>
         <td colspan="2" class="bold1">If found, Please return to </td>
       </tr>
       <tr>
         <td colspan="2" class="boldEleven">&nbsp;</td>
       </tr>
       <tr>
         <td colspan="2" class="bold1"><%=data[0][8].toUpperCase()%></td>
       </tr>
       <tr>
         <td colspan="2" class="boldEleven"><%=data[0][10]%></td>
       </tr>
       <tr>
         <td colspan="2" class="boldEleven"><%=data[0][11]+"-"+data[0][12]%></td>
       </tr>
       <tr>
         <td colspan="2" class="boldEleven">Tel :<%=data[0][13]%></td>
       </tr>
       <tr>
         <td colspan="2" class="boldEleven">Fax :<%=data[0][14]%></td>
       </tr>
       <tr>
         <td class="boldEleven">&nbsp;</td>
         <td class="boldEleven">&nbsp;</td>
       </tr>
       <tr>
         <td class="boldEleven">&nbsp;</td>
         <td class="boldEleven">&nbsp;</td>
       </tr>
       <tr>
         <td colspan="2" class="boldEleven"><div align="right">Issuing Authority </div></td>
       </tr>
     </table></td>
   </tr>
 </table>
    
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 <p align="center"><a href="javascript:window.print()">Print</a>&nbsp;<a href='AttendanceMain.jsp'>Back<a></p>
   <%
	
	}
	else
	{
		out.println("<br><br><br><br><br><br><center><font class='bolddeepred'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Data not found...<br><a href='AttendanceMain.jsp'>Back<a></font></center>");
	}	
	
	
 %>
   
   
   <%
}
catch(Exception e)
{
}
%>

