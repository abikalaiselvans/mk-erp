<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
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

<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='ATT' ")[0][0]%></title>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<p>
  <%
try
{
	
 %></p>
 <table width='700' align="center"     cellpadding=2 cellspacing=1 bgcolor='#9900CC'  class='boldEleven'  id='myTable' >
 <tr><td bgcolor="#FFFFFF">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td colspan="5" class="boldEleven"><div align="center" class="bold1">
      <div align="center">SERVICE CARD </div>
    </div></td>
    </tr>
  <tr>
    <td width="16%" class="boldEleven"><strong>EMPID
        <%
String id = request.getParameter("empid");
String sql=""; 
sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,a.CHR_GENDER,  ";
sql = sql + " DATE_FORMAT(a.DT_DOB,'%d-%m-%Y'),DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y'),a.CHR_MARITALSTATUS,DATE_FORMAT(a.DT_WEDDATE,'%d-%m-%Y'),  ";
sql = sql + " g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME,i.CHR_DESIGNAME,b.CHR_OFFICENAME ,e.CHR_QUALIFICATIONNAME ,j.CHR_GROUPNAME,  ";

sql = sql + " a.CHR_PADD1,a.CHR_PADD2,n.CHR_CITYNAME,m.CHR_DISTRICT,l.CHR_STATENAME,k.CHR_COUNTRYNAME,a.CHR_PPIN,a.CHR_PPHONE,  ";
sql = sql + " a.CHR_SADD1,a.CHR_SADD2,n.CHR_CITYNAME,m.CHR_DISTRICT,l.CHR_STATENAME,k.CHR_COUNTRYNAME,a.CHR_SPIN,a.CHR_SPHONE ,  ";
sql = sql + " a.CHR_EMAILID, a.CHR_MOBILE,a.INT_SALARY,  ";
sql = sql + " a.CHR_PF,g.CHR_PFNUMBER,a.CHR_PFNO,a.CHR_ESI,a.CHR_ESINO,  ";
sql = sql + "  FIND_A_BANKGROUP_NAME(a.CHR_BANK) ,a.CHR_ACCNO  ,  ";
sql = sql + " round(datediff(now(),a.DT_DOJCOLLEGE)/365)   ";
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
 
String empdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	%>
    </strong></td>
    <td width="30%" class="boldEleven"><%=empdata[0][0]%></td>
    <td width="19%" class="boldEleven"><strong>COMPANY  </strong></td>
    <td colspan="2" class="boldEleven"><%=empdata[0][8]%></td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>NAME</strong></td>
    <td class="boldEleven"><%=empdata[0][1]%></td>
    <td class="boldEleven"><strong>BRANCH </strong></td>
    <td colspan="2" class="boldEleven"><%=empdata[0][9]%></td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>FATHER </strong></td>
    <td class="boldEleven"><%=empdata[0][2]%></td>
    <td class="boldEleven"><strong>DEPARTMENT</strong></td>
    <td colspan="2" class="boldEleven"><%=empdata[0][10]%></td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>GENDER</strong></td>
    <td class="boldEleven"><%=empdata[0][3]%></td>
    <td class="boldEleven"><strong>DESIGNATION</strong></td>
    <td class="boldEleven"><%=empdata[0][11]%></td>
    <td width="15%" rowspan="6" align="center" valign="middle" class="boldEleven">
	<%
		 
			
			
			String staffphoto = request.getRealPath("/")+"StaffPhoto/"+id.trim() +".jpg";
			String defaul = "../StaffPhoto/default.png" ;
			String photo="";
			File f = new File(staffphoto);	 
			if (f.exists())
				photo ="../StaffPhoto/"+id.trim() +".jpg";
			else
				photo =defaul;
				
			%>
						        <img src="<%=photo%>" title="<%=photo%>" width="100" height="130" border="1" name="Photo" id="Photo" />	 </td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>DOB </strong></td>
    <td class="boldEleven"><%=empdata[0][4]%></td>
    <td class="boldEleven"><strong>OFFICE</strong></td>
    <td width="20%" class="boldEleven"><%=empdata[0][12]%></td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>DOJ </strong></td>
    <td class="boldEleven"><%=empdata[0][5]%></td>
    <td class="boldEleven"><strong>BLOOD GROUP </strong></td>
    <td class="boldEleven"><%=empdata[0][13]%></td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>MARRIED </strong></td>
    <td class="boldEleven">
	<%
	if("M".equals(empdata[0][6]))
		out.println("Married");
	else
		out.println("Unmarried");	
	%></td>
    <td class="boldEleven"><strong>QUALIFICATION</strong></td>
    <td class="boldEleven"><%=empdata[0][14]%></td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>WEDDING DATE </strong></td>
    <td class="boldEleven"><%=empdata[0][7]%></td>
    <td class="boldEleven">&nbsp;</td>
    <td class="boldEleven">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" class="boldEleven"><div align="center"><strong>PERMANANT  </strong></div></td>
    <td colspan="2" class="boldEleven"><div align="center"><strong>COMMUNICATION  </strong></div></td>
  </tr>
  <tr>
    <td colspan="2" class="boldEleven"><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
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
	 <br>	 <br>	 </td>
    <td colspan="3" class="boldEleven"><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
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
     </table>
	 <br>	 <br>	</td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>EMAIL</strong></td>
    <td class="boldEleven"><%=empdata[0][31]%></td>
    <td class="boldEleven"><strong>MOBILE</strong></td>
    <td colspan="2" class="boldEleven"><%=empdata[0][32]%></td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>BASIC</strong></td>
    <td class="boldEleven"><%=empdata[0][33]%></td>
    <td class="boldEleven">&nbsp;</td>
    <td colspan="2" class="boldEleven">&nbsp;</td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>ALLOWANCE</strong></td>
    <td class="boldEleven">&nbsp; </td>
    <td class="boldEleven"><strong>GROSS</strong></td>
    <td colspan="2" class="boldEleven">&nbsp;</td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>P.F</strong></td>
    <td class="boldEleven"><%
	if("C".equals(empdata[0][34]))
		out.println("Common");
	else if("Y".equals(empdata[0][34]))
		out.println("Yes");
	else if("N".equals(empdata[0][34]))
		out.println("No");
		
		
	%></td>
    <td class="boldEleven"><strong>E.S.I</strong></td>
    <td colspan="2" class="boldEleven">
	 
	<%
	if("C".equals(empdata[0][37]))
		out.println("Common");
	else if("Y".equals(empdata[0][37]))
		out.println("Yes");
	else if("N".equals(empdata[0][37]))
		out.println("No");
	%></td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>P.F. NUMBER </strong></td>
    <td class="boldEleven"><%=empdata[0][35]+empdata[0][36]%></td>
    <td class="boldEleven"><strong>E.S.I NUMBER </strong></td>
    <td colspan="2" class="boldEleven"><%=empdata[0][38]%></td>
  </tr>
  <tr>
    <td class="boldEleven"><strong>BANK</strong></td>
    <td class="boldEleven"><%=empdata[0][39]%></td>
    <td class="boldEleven"><strong>A/C NUMBER  </strong></td>
    <td colspan="2" class="boldEleven"><%=empdata[0][40]%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">
	
	
	
	<table width="90%"   border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
        <tr>
          <td><TABLE border="0" align="center" cellPadding="4" cellSpacing="4">
            <TBODY>
              <TR>
                <TD vAlign="bottom" noWrap colSpan="7" align="center"><h1>Annexure</h1></TD>
                </TR>
              <TR>
                <TD vAlign="bottom" noWrap  colSpan="2"><p><strong>Name&nbsp;&nbsp; </strong><strong><%=empdata[0][1]%></p>
                    <p><strong>&nbsp;</strong></p></TD>
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
                <TD vAlign="bottom" noWrap ><p><strong>Amount</strong><strong>(P   M)</strong></p>                    </TD>
                <TD vAlign="bottom" noWrap ><p><strong>&nbsp;</strong></p></TD>
                <TD vAlign="bottom" noWrap><p><strong>Amount   (PA)</strong></p></TD>
                <TD vAlign="bottom" noWrap ><p><strong>&nbsp;</strong></p></TD>
              </TR>
              
			  <%
				
				String AllowanceData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
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
				 
				String payData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				double monthbasic=0;
				double monthgross=0;
				double monthpf=0;
				double monthesi=0;
				double monthctc=0;
				
				double staffpf=0;
				double staffesi=0;
				double takehome=0;
				
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
					 
					 if("C".equals(empdata[0][34]))
					 {
						 monthpf = (monthbasic*12/100);
						 staffpf = (monthbasic*12/100);
						 out.println("<TR bgcolor='CCCCCC'>");
						 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>EMPLOYEER PF</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap align='right'><p>"+Math.round(monthpf)+"</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  align='right'><p>"+Math.round(monthpf*12)+"</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						 out.println("</TR>"); 
					 }	 
						  
					 
					  
					 if("C".equals(empdata[0][37]) && monthgross <=15000)
					 { 
						 monthesi=(monthgross*4.75/100);
						 staffesi=(monthgross*1.75/100);
						 out.println("<TR bgcolor='CCCCCC'>");
						 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>EMPLOYEER ESI</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap align='right'><p>"+Math.round(monthesi)+"</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  align='right'><p>"+Math.round(monthesi*12)+"</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						 out.println("</TR>");
					}
					else
					{
						 monthesi=0;
						 staffesi=0;
						 out.println("<TR bgcolor='CCCCCC'>");
						 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>ESI</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap align='right'><p>0</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  align='right'><p>0</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						 out.println("</TR>"); 
					}	
					 
					  monthctc=monthgross+monthpf+monthesi;
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>Total cost To Company   (TCTC)</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap align='right'><p>"+Math.round(monthctc) +"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  align='right'><p>"+Math.round((monthctc)*12)+"</p></TD>");
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
					 
					  takehome=monthgross-(staffpf+staffesi);;
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
                <TD colspan="7" vAlign="bottom" noWrap ><div id="Rupees"><script language="javascript">numberWord("<%=takehome%>","Rupees") </script></div></TD>
                </TR>
              <TR>
                <TD vAlign="bottom" noWrap >&nbsp;</TD>
                <TD vAlign="bottom" noWrap colSpan="2">&nbsp;</TD>
                <TD vAlign="bottom" noWrap >&nbsp;</TD>
                <TD vAlign="bottom" noWrap >&nbsp;</TD>
                <TD vAlign="bottom" noWrap>&nbsp;</TD>
                <TD vAlign="bottom" noWrap >&nbsp;</TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap ><p><strong>IT Solutions PVT   Ltd</strong></p></TD>
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
              <TR>
                <TD vAlign="bottom" noWrap  colSpan="4"><p><strong>&nbsp;</strong></p></TD>
                <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap  colSpan="2"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
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
      </table>	</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
</table>
</td>
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
</p>
 <p>&nbsp;</p>
 <p align="right"><a href="javascript:window.print()">Print</a> </p>
</body>
</html>
