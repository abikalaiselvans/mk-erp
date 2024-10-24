<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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

<title><%=CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='ATT' ")[0][0]%></title>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>

<body  onpaste='return false;' onLoad="javascript:window.print()">
<p>
  <%
try
{
	
 %>


<table width='90%' border="1" align="center"     cellpadding=3 cellspacing=2 bgcolor='#9900CC'  class='boldEleven'  id='myTable' >
 <tr><td width="50%" align="center" valign="top" bgcolor="#FFFFFF"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
   <tr>
     <td colspan="5" class="boldEleven"><div align="center" class="bold1">
         <div align="center">
           <h2>SERVICE CARD </h2>
         </div>
     </div></td>
   </tr>
   <tr>
     <td class="bold1">EMPID
       <%
String id = request.getParameter("ename");
String sql=""; 
sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,a.CHR_GENDER,  ";
sql = sql + " DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'),DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),a.CHR_MARITALSTATUS,DATE_FORMAT(a.DT_WEDDATE,'%d-%m-%Y'),  ";
sql = sql + " g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME,i.CHR_DESIGNAME,b.CHR_OFFICENAME ,e.CHR_QUALIFICATIONNAME ,j.CHR_GROUPNAME,  ";

sql = sql + " a.CHR_PADD1,a.CHR_PADD2,n.CHR_CITYNAME,m.CHR_DISTRICT,l.CHR_STATENAME,k.CHR_COUNTRYNAME,a.CHR_PPIN,a.CHR_PPHONE,  ";
sql = sql + " a.CHR_SADD1,a.CHR_SADD2,n.CHR_CITYNAME,m.CHR_DISTRICT,l.CHR_STATENAME,k.CHR_COUNTRYNAME,a.CHR_SPIN,a.CHR_SPHONE ,  ";
sql = sql + " a.CHR_EMAILID, a.CHR_MOBILE,a.INT_SALARY,  ";
sql = sql + " a.CHR_PF,g.CHR_PFNUMBER,a.CHR_PFNO,a.CHR_ESI,a.CHR_ESINO,  ";
sql = sql + " FIND_A_BANKGROUP_NAME(a.CHR_BANK) ,a.CHR_ACCNO  ,  ";
sql = sql + " round(datediff(now(),a.DT_DOJCOLLEGE)/365),   ";
sql = sql +" FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE), ";

//sql = sql +" FUN_GET_ESIAMOUNT('STAFF',a.CHR_ESI,FUN_PAY_GET_ORIGINAL_GROSS(a.CHR_EMPID) ), ";
//sql = sql +" FUN_GET_ESIAMOUNT('CPY',a.CHR_ESI,FUN_PAY_GET_ORIGINAL_GROSS(a.CHR_EMPID) ),  "; 

sql = sql + " FUN_PAY_GET_ESI_CALCULATION('STAFF',a.CHR_EMPID,a.CHR_ESI) STAFFESI ,";
sql = sql + " FUN_PAY_GET_ESI_CALCULATION('CPY',a.CHR_EMPID,a.CHR_ESI) ESI ,";
				
sql = sql +" FIND_A_INSTITUTION_NAME(),  "; 
sql = sql +" FUN_PAY_GET_ORIGINAL_PROFESSIONAL_TAX_AMOUNTS(a.CHR_EMPID,FUN_PAY_GET_ORIGINAL_GROSS(a.CHR_EMPID)  ) pftax  "; 
sql = sql + " FROM com_m_staff a , com_m_office b ,com_m_depart c ,pay_t_allowance d ,com_m_qualification e ,   ";
sql = sql + " com_m_branch f , com_m_company g,  com_m_desig i,com_m_bloodgroup j,  ";
sql = sql + " com_m_country k,com_m_state l,com_m_district m,com_m_city n  ";
sql = sql + " WHERE a.INT_DEPARTID = c.INT_DEPARTID   ";
sql = sql + " AND a.INT_OFFICEID= b.INT_OFFICEID   ";
sql = sql + " AND a.CHR_EMPID =d.CHR_EMPID   ";
sql = sql + " AND a.CHR_QUALIFICATION =e.INT_QUALIFICATIONID   ";
sql = sql + " AND a.INT_BRANCHID =f.INT_BRANCHID   ";
sql = sql + " AND a.INT_COMPANYID =g.INT_COMPANYID   ";
 sql = sql + " AND a.INT_DESIGID= i.INT_DESIGID  ";
sql = sql + " AND a.CHR_BG=j.INT_BLOODGROUPID  ";
sql = sql + " AND a.CHR_PCITY = n.INT_CITYID  ";
sql = sql + " AND a.INT_PDISTRICTID=m.INT_DISTRICTID  ";
sql = sql + " AND a.CHR_PSTATE=l.INT_STATEID  ";
sql = sql + " AND a.INT_PCOUNTRYID =k.INT_COUNTRYID  ";
sql = sql + " AND a.CHR_SCITY = n.INT_CITYID  ";
sql = sql + " AND a.INT_CDISTRICTID=m.INT_DISTRICTID  ";
sql = sql + " AND a.CHR_SSTATE=l.INT_STATEID  ";
sql = sql + " AND a.INT_CCOUNTRY  =k.INT_COUNTRYID  ";
sql = sql +" AND a.CHR_EMPID='"+id+"'";
sql = sql + " ORDER BY a.CHR_EMPID  ";
//out.println(sql);
String empdata[][]=CommonFunctions.QueryExecute(sql);

	%></td>
     <td class="boldEleven"><%=empdata[0][0]%></td>
     <td colspan="3" rowspan="5" class="bold1">
	 
	   <div align="center">
	     <%
		 
			String staffphoto = request.getRealPath("/")+"/uploadfiles/StaffPhoto/"+id.trim() +".jpg";
			File f = new File(staffphoto);
			boolean ff = f.exists(); 
			if (ff)
				staffphoto =id.trim() +".jpg";
			else	
				staffphoto   = "default.jpg";
			
			
				
			%>
	       <img src="<%="../uploadfiles/StaffPhoto/"+staffphoto%>"   width="100" height="130" border="1" name="Photo" id="Photo" />	       </div></td>
     </tr>
   <tr>
     <td class="bold1">NAME</td>
     <td class="boldEleven"><%=empdata[0][1]%></td>
     </tr>
   <tr>
     <td width="21%" class="bold1">FATHER </td>
     <td width="32%" class="boldEleven"><%=empdata[0][2]%></td>
     </tr>
   <tr>
     <td class="bold1">GENDER</td>
     <td class="boldEleven"><%=empdata[0][3]%></td>
     </tr>
   <tr>
     <td class="bold1">DOB </td>
     <td class="boldEleven"><%=empdata[0][4]%></td>
     </tr>
   <tr>
     <td class="bold1">DOJ </td>
     <td class="boldEleven"><%=empdata[0][5]%></td>
     <td width="22%" class="bold1">&nbsp;</td>
     <td width="25%" colspan="2" class="boldEleven">&nbsp;</td>
   </tr>
   <tr>
     <td class="bold1">COMPANY</td>
     <td class="boldEleven"><%=empdata[0][8]%></td>
     <td class="bold1">BRANCH</td>
     <td colspan="2" class="boldEleven"><%=empdata[0][9]%></td>
   </tr>
   <tr>
     <td class="bold1">DEPARTMENT</td>
     <td class="boldEleven"><%=empdata[0][10]%></td>
     <td class="bold1">DESIGNATION</td>
     <td colspan="2" class="boldEleven"><%=empdata[0][11]%></td>
   </tr>
   <tr>
     <td class="bold1">OFFICE</td>
     <td class="boldEleven"><%=empdata[0][12]%></td>
     <td class="bold1">BLOOD GROUP </td>
     <td colspan="2" class="boldEleven"><%=empdata[0][14]%></td>
   </tr>
   <tr>
     <td class="bold1">MARRIED</td>
     <td class="boldEleven"><%
	if("M".equals(empdata[0][6]))
		out.println("Married");
	else
		out.println("Unmarried");	
	%></td>
     <td class="bold1">QUALIFICATION</td>
     <td colspan="2" class="boldEleven"><%=empdata[0][13]%></td>
   </tr>
   <tr>
     <td class="bold1">WEDDING DATE </td>
     <td class="boldEleven"><%=empdata[0][7]%></td>
     <td class="bold1">&nbsp;</td>
     <td colspan="2" class="boldEleven">&nbsp;</td>
   </tr>
   
   <tr>
     <td colspan="2" class="boldEleven"><div align="center" class="bold1">
       <div align="center"><strong>PERMANANT </strong>ADDRESS</div>
     </div></td>
     <td colspan="3" class="boldEleven"><div align="center" class="bold1">
       <div align="center"><strong>COMMUNICATION </strong>ADDRESS</div>
     </div></td>
     </tr>
   <tr>
     <td colspan="2" class="boldEleven"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
         <tr>
           <td><p align="left" class="boldEleven"><%=empdata[0][15]%>,<br>
                   <%=empdata[0][16]%>,<br>
                   <%=empdata[0][17]%>,<br>
                   <%=empdata[0][18]%>,<br>
                   <%=empdata[0][19]%>, <br>
                   <%=empdata[0][20]%>,<br>
                   <%="PIN : "+empdata[0][21]%>,<br>
                   <%="Phone :"+empdata[0][22]%>,</p></td>
         </tr>
       </table>
         <br>     </td>
     <td colspan="3" class="boldEleven"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
         <tr>
           <td><div align="left" class="boldEleven">
               <p class="boldEleven"><%=empdata[0][23]%>,<br>
                   <%=empdata[0][24]%>,<br>
                   <%=empdata[0][25]%>,<br>
                   <%=empdata[0][26]%>,<br>
                   <%=empdata[0][27]%>,<br>
                   <%=empdata[0][28]%>,<br>
                   <%="PIN : "+empdata[0][29]%>,<br>
                   <%="Phone :"+empdata[0][30]%>,</p>
           </div></td>
         </tr>
       </table>       </td>
   </tr>
   <tr>
     <td class="bold1"><strong>EMAIL</strong></td>
     <td class="boldEleven"><%=empdata[0][31]%></td>
     <td class="bold1"><strong>MOBILE</strong></td>
     <td colspan="2" class="boldEleven"><%=empdata[0][32]%></td>
   </tr>
   <tr>
     <td class="bold1"><strong>P.F</strong></td>
     <td class="boldEleven"><%
	if("C".equals(empdata[0][34]))
		out.println("Common");
	else if("Y".equals(empdata[0][34]))
		out.println("Yes");
	else if("N".equals(empdata[0][34]))
		out.println("No");
		
		
	%></td>
     <td class="bold1"><strong>E.S.I</strong></td>
     <td colspan="2" class="boldEleven"><%
	if("C".equals(empdata[0][37]))
		out.println("Common");
	else if("Y".equals(empdata[0][37]))
		out.println("Yes");
	else if("N".equals(empdata[0][37]))
		out.println("No");
	%></td>
   </tr>
   <tr>
     <td class="bold1"><strong>P.F. NUMBER </strong></td>
     <td class="boldEleven"><%=empdata[0][35]+empdata[0][36]%></td>
     <td class="bold1"><strong>E.S.I NUMBER </strong></td>
     <td colspan="2" class="boldEleven"><%=empdata[0][38]%></td>
   </tr>
   <tr>
     <td class="bold1"><strong>BANK</strong></td>
     <td class="boldEleven"><%=empdata[0][39]%></td>
     <td class="bold1"><strong>A/C NUMBER </strong></td>
     <td colspan="2" class="boldEleven"><%=empdata[0][40]%></td>
   </tr>
    
   <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td colspan="2">&nbsp;</td>
   </tr>
 </table></td>
   <td align="center" valign="top" bgcolor="#FFFFFF"> <TABLE border="0" align="center" cellPadding="4" cellSpacing="4">
     <TBODY>
       <TR>
         <TD vAlign="bottom" noWrap colSpan="7" align="center"><h1>Annexure</h1></TD>
       </TR>
       <TR>
         <TD vAlign="bottom" noWrap  colSpan="2">Name&nbsp;&nbsp;<%=empdata[0][1]%></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
       </TR>
       <TR>
         <TD vAlign="bottom" noWrap  colSpan="2"><p>Designation -<strong> </strong><%=empdata[0][11]%></p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap  colSpan="2"><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
       </TR>
       <TR>
         <TD vAlign="bottom" noWrap  colSpan="2"><p>Department   -<%=empdata[0][10]%></p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
       </TR>
       <TR>
         <TD vAlign="bottom" noWrap  colSpan="2"><p>Date of Joining   -<%=empdata[0][5]%></p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
       </TR>
       <TR>
         <TD vAlign="bottom" noWrap  colSpan="2"><p><strong>Salary   Component</strong></p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
       </TR>
       <TR bgcolor="#666666"   >
         <TD vAlign="bottom" noWrap  colSpan="2"><p><strong>Particulars</strong></p></TD>
         <TD vAlign="bottom" noWrap ><p><strong>&nbsp;</strong></p></TD>
         <TD vAlign="bottom" noWrap ><p><strong>Amount</strong><strong>(P   M)</strong></p></TD>
         <TD vAlign="bottom" noWrap ><p><strong>&nbsp;</strong></p></TD>
         <TD vAlign="bottom" noWrap><p><strong>Amount   (P A)</strong></p></TD>
         <TD vAlign="bottom" noWrap ><p><strong>&nbsp;</strong></p></TD>
       </TR>
       <%
	   
				
				String AllowanceData[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
				String salaryband="   ";
				String grossband="";
				for(int u=0; u<AllowanceData.length;u++)
				{
					salaryband = salaryband+"  b."+AllowanceData[u][0]+",( b."+AllowanceData[u][0]+" *12) ,"; 
					grossband = grossband+"  b."+AllowanceData[u][0]+"+";
				}	
				salaryband=salaryband.trim();
				salaryband = salaryband.substring(0,salaryband.length()-1);		
				
				grossband=grossband.trim();
				grossband = grossband.substring(0,grossband.length()-1);		
				
				sql = " SELECT ROUND(a.INT_SALARY),ROUND(INT_SALARY*12),"+salaryband+" ,ROUND(a.INT_SALARY+("+grossband+")),ROUND( (a.INT_SALARY+("+grossband+"))*12 ),ROUND(a.INT_SALARY*12/100) ,ROUND((a.INT_SALARY*12/100)*12),ROUND( (a.INT_SALARY+("+grossband+"))  + (a.INT_SALARY*12/100) ) , ROUND(( (a.INT_SALARY+("+grossband+"))  + (a.INT_SALARY*12/100) )*12),ROUND( (a.INT_SALARY+("+grossband+")) - (a.INT_SALARY*12/100) )  FROM com_m_staff a,pay_t_allowance b ";
				sql = sql +" 	WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_EMPID='"+id+"' ";
				 
				String payData[][] = CommonFunctions.QueryExecute(sql);
				double monthbasic=0;
				double monthgross=0;
				double monthpf=0;
				double monthesi=0;
				double monthctc=0;
				
				double staffpf=0;
				double staffesi=0;
				double takehome=0;
				
				
				String institutionData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  INT_PFAMT,INT_ESIAMT,INT_ESILIMIT,INT_PFLIMIT,INT_PFLIMITMINIMUM ,INT_CPY_ESIAMT FROM m_institution WHERE INT_ID=1");
				double pfpercentage = Double.parseDouble( institutionData[0][0]);
				double esipercentage = Double.parseDouble( institutionData[0][1]);
				double esilimitamount = Double.parseDouble( institutionData[0][2]);
				double pfmaximumlimit = Double.parseDouble( institutionData[0][3]);
				double pfminimumlimit = Double.parseDouble( institutionData[0][4]);
				double esicomapnypercentage = Double.parseDouble( institutionData[0][5]);

	 	
				if(payData.length>0)
				{
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>Basic</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap align='right'><p>"+payData[0][0]+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  align='right'><p>"+payData[0][1]+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("</TR>");
					 int g=1;
					 int v=1;
					 for(int u=0; u<AllowanceData.length;u++)
					 {
						 
						  g = g+2;
						 out.println("<TR bgcolor='CCCCCC'>");
						 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p> "+AllowanceData[u][1]+"</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						  v=v+1;
						 out.println("<TD vAlign='bottom' noWrap align='right'><p> "+payData[0][v]+"</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						  v=v+1;
						 out.println("<TD vAlign='bottom' noWrap  align='right'><p> "+payData[0][v]+"</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						 out.println("</TR>");
						
						 
						
					 }
					 
					
					
					monthbasic=Double.parseDouble(payData[0][0]);
					monthgross=Double.parseDouble(payData[0][(g+1)]);
					
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>GROSS</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap align='right'><p>"+Math.round(monthgross)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  align='right'><p>"+Math.round(monthgross*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("</TR>"); 
					 
					 
					 String pf =empdata[0][34];
					 String  esi =empdata[0][37];	

					 
				 
					 monthpf = Double.parseDouble( empdata[0][42]);
					 staffpf = Double.parseDouble( empdata[0][42]);
					 
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom'    colSpan='2' class='boldEleven' ><p>EMPLOYEER PF</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+Math.round(monthpf)  +"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'   align='right' class='boldEleven' ><p>"+Math.round(monthpf*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("</TR>");  
				 
				 
					 staffesi = Double.parseDouble( empdata[0][43]);
					 monthesi = Double.parseDouble( empdata[0][44]);
					 
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom'   colSpan='2' class='boldEleven' ><p>EMPLOYEER ESI</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+Math.round(monthesi)+"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+Math.round(monthesi*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("</TR>");
					  	  
					 
					  
					 
					  monthctc=monthgross+monthpf+monthesi;
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>Total cost To Company   (TCTC)</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap align='right'><p>"+Math.round(monthctc) +"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  align='right'><p>"+Math.round((monthctc)*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("</TR>"); 
					 
					 double professiontax=Double.parseDouble(empdata[0][46]);
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>Professional Tax</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap align='right'><p>"+professiontax+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  align='right'><p>"+Math.round((professiontax)*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("</TR>");  
					 
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>As Applicable to your   Current Role</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap align='right'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  align='right'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("</TR>");  
					 
					  takehome=monthgross-(staffpf+staffesi+professiontax);;
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p><strong>Take Home  Salary=</strong><strong>"+Math.round(takehome)+"</strong><strong></strong></p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='107'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("</TR>"); 
					 
				}
			  %>
       <TR>
         <TD colspan="7" vAlign="bottom" noWrap ><div id="Rupees">
             <script language="javascript">numberWord("<%=takehome%>","Rupees") </script>
         </div></TD>
       </TR>
       
       <TR>
         <TD vAlign="bottom" noWrap ><p><strong><%=empdata[0][45]%></strong></p></TD>
         <TD vAlign="bottom" noWrap width="66" colSpan="2"><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
       </TR>
       <TR>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap width="66" colSpan="2"><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
       </TR>

       <TR>
         <TD vAlign="bottom" noWrap ><p><strong><em>Authorised   Signatory</em></strong><strong></strong></p></TD>
         <TD vAlign="bottom" noWrap width="66" colSpan="2"><p><strong>&nbsp;</strong></p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
         <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
       </TR>
        
       <TR height="0">
         <TD ></TD>
         <TD width="66"></TD>
         <TD ></TD>
         <TD ></TD>
         <TD ></TD>
         <TD></TD>
         <TD ></TD>
       </TR>
     </TBODY>
   </TABLE></td>
 </tr>
</table>
 <p>
   <%
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
 </body>
</html>
