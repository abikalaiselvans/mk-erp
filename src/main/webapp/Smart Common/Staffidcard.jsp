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


<title> :: COMMON ::</title>



<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

 <p>
   <%
 	String staffid= request.getParameter("staffid");
	String sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y') ,f.CHR_GROUPNAME ,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'),a.CHR_GENDER,  ";
	sql = sql+ " b.CHR_DEPARTNAME,c.CHR_DESIGNAME,d.CHR_COMPANYNAME,e.CHR_BRANCHNAME,e.CHR_STREET,e.INT_PINCODE,e.INT_PINCODE,e.CHR_PHONE,e.CHR_FAX   ";
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
 </p>
 <table width="600" height="450" border="0" align="center" cellpadding="0" cellspacing="00">
   <tr>
     <td width="270" background="../images/id1.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
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
         <td>&nbsp;</td>
       </tr>
       <tr>
         <td>&nbsp;</td>
       </tr>
       <tr>
         <td><div align="center">
           <%
			String staffphoto = request.getRealPath("/")+"StaffPhoto/"+staffid.trim() +".jpg";
			String defaul = "../StaffPhoto/default.jpg" ;
			String photo="";
			File f = new File(staffphoto);
			if (f.exists())
				photo ="../StaffPhoto/"+staffid.trim() +".jpg";
			else
				photo =defaul;
			
	%>
           <img src="<%=photo%>" title="<%=photo%>" width="100" height="130" border="1" name="Photo" id="Photo" /> </div></td>
       </tr>
       <tr>
         <td>&nbsp;</td>
       </tr>
       <tr>
         <td></td>
       </tr>
       <tr>
         <td>&nbsp;</td>
       </tr>
       <tr>
         <td><b><div align="center"><%=data[0][1]%></div></b></td>
       </tr>
	   <tr>
         <td>&nbsp;</td>
       </tr><tr>
         <td><b><div align="center">Emp No :<%=data[0][0]%></div></b></td>
       </tr>
       
         <tr>
           <td>&nbsp;</td>
         </tr>
         <tr>
           <td>&nbsp;</td>
         </tr>
         <td>&nbsp;</td>
       </tr>
       <tr>
         <td align="center"><b><%=data[0][8].toUpperCase()%><b><br>
			 <%=data[0][10]%><br>
			 <%=data[0][11]+"-"+data[0][12]%><br>			 </td>
       </tr>
     </table></td>
     <td width="280" background="../images/id2.gif">&nbsp;</td>
   </tr>
 </table>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 <p align="center"><a href="javascript:window.print()">Print</a>&nbsp;<a href='commonmain.jsp'>Back<a></p>
   <%
	
	}
	else
	{
		out.println("<br><br><br><br><br><br><center><font class='bolddeepred'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Data not found...<br><a href='commonmain.jsp'>Back<a></font></center>");
	}	
	
	
 %>
   
   
   <%
}
catch(Exception e)
{
}
%>

