 <%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript" >
function validateFields()
{
	if ( checkNull('dor','Enter Revision Date...') )
		return true;
	else
		return false;
}
</script>
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
 
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth" onSubmit="return validateFields()">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="54">
		<table width="563" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block"></td>
					<td width="549" valign="top">
					<table width="700" border="0" cellspacing="0" cellpadding="0">
						<tr class="boldEleven">
							<td height="20" colspan="2">
							<div align="center" class="tabledata">EMPLOYEE REVISION 
	<%
    String Apparaisalid= request.getParameter("Apparaisalid");
    String month= request.getParameter("month");
    String year= request.getParameter("year");
    String sql ="";
    sql=sql+" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_DESIGNAME, ";
    sql=sql+" DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y') ,DATE_FORMAT( g.DAT_RIVISION,'%d-%m-%Y')  ";
    
    sql=sql+" FROM com_m_staff a  ,com_m_company b,com_m_branch c, com_m_office d,com_m_depart e,com_m_desig f, pay_t_appraisal_basic g ";
    sql=sql+" WHERE a.INT_COMPANYID = b.INT_COMPANYID ";
    sql=sql+" AND a.INT_BRANCHID = c.INT_BRANCHID ";
    sql=sql+" AND a.INT_OFFICEID = d.INT_OFFICEID ";
    sql=sql+" AND a.INT_DEPARTID = e.INT_DEPARTID ";
    sql=sql+" AND a.INT_DESIGID = f.INT_DESIGID  AND a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y'   ";
    sql=sql+" AND  a.CHR_EMPID = g.CHR_EMPID  AND  g.INT_APPRAISALID =  "+Apparaisalid ;
    if(!"0".equals(month))
        sql=sql+" AND CHR_MONTH = '"+DateUtil.getMonth(Integer.parseInt(month))+"'";
    sql=sql+" AND INT_YEAR ="+year;
    sql=sql+" ORDER BY a.CHR_STAFFNAME "; 
    //out.println(sql);
    String datas[][] =  CommonFunctions.QueryExecute(sql);
    String Staffid = datas[0][0];
	sql = " SELECT CONCAT('Type - ',CHR_PFCALCULATIONTYPE) FROM pay_t_appraisal WHERE INT_APPRAISALID="+Apparaisalid ;
    %>
							</div>							</td>
						</tr>
						<tr>
							<td colspan="2">
							<div align="right"><span class="bolddeepred">*</span>
							Mandatory</div>							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>

						 
						<tr>
						  <td height="19" colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="23%" class="bold1">Emp id</td>
                              <td width="32%" class="boldEleven"><%=datas[0][0]%></td>
                              <td width="14%" class="bold1">Company</td>
                              <td width="31%" class="boldEleven"><%=datas[0][2]%></td>
                            </tr>
                            <tr>
                              <td class="bold1">Emp Name </td>
                              <td class="boldEleven"><%=datas[0][1]%></td>
                              <td class="bold1">Branch</td>
                              <td class="boldEleven"><%=datas[0][3]%></td>
                            </tr>
                            <tr>
                              <td class="bold1">Department</td>
                              <td class="boldEleven"><%=datas[0][5]%></td>
                              <td class="bold1">Office</td>
                              <td class="boldEleven"><%=datas[0][4]%></td>
                            </tr>
                            <tr>
                              <td class="bold1">Dsignation</td>
                              <td class="boldEleven"><%=datas[0][6]%></td>
                              <td class="bold1">DOJ</td>
                              <td class="boldEleven"><%=datas[0][7]%></td>
                            </tr>
                            <tr>
                              <td class="bold1">PF CALCULATION TYPE</td>
                              <td class="boldEleven"><%=CommonFunctions.QueryExecute(sql)[0][0]%></td>
                              <td class="bold1">&nbsp;</td>
                              <td class="boldEleven">&nbsp;</td>
                            </tr>
                            <tr>
                              <td class="bold1">Next effective DOR</td>
                              <td class="boldEleven"> 
							  <input onKeyPress="numericHypenOnly('dor','10')"
																name="dor" id="dor"  type="text" class="formText135" size="12"
																maxlength="10"   value="<%=datas[0][8]%>"  
																title="dd/mm/yyyy" readonly />
<a href="javascript:cal1.popup();"><img src="../JavaScript/img/cal.gif" width="16" border="0" alt="Click here to Pick Up the Date" /></a>
                                              <span class="boldred">(dd/mm/yyyy) </span>
											  
											  <script language="JavaScript">
<!--
  var cal1=new calendar1(document.forms['frm'].elements['dor']);
  cal1.year_scroll=true;
  cal1.time_comp=false;
  
   
//-->
 </script>							  </td>
                              <td class="bold1">&nbsp;</td>
                              <td class="boldEleven">&nbsp;</td>
                            </tr>
                            
                          </table></td>
						</tr>
						<tr>
						  <td height="19" colspan="2">&nbsp;</td>
					  </tr>
						<tr>
						  <td height="19" colspan="2">
						  
						  
						    <div align="center">
						      <%
							  
			

String allowancefield[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
String sumgrossallowancefield="";
String sumothersallowancefield="";
String allowancefields="";
String grossallowancefield="";
String othersallowancefield="";
String grossallowancename="";
String otherallowancename="";
if(allowancefield.length>0)
{
	for(int u=0;u<allowancefield.length;u++)
	{
		if("Y".equals(allowancefield[u][2]))
		{
			sumgrossallowancefield =sumgrossallowancefield+ " ROUND(b."+allowancefield[u][0]+",2)+";
			grossallowancefield =grossallowancefield+ " ROUND(b."+allowancefield[u][0]+",2),";
			grossallowancename = grossallowancename +allowancefield[u][1]+",";
		}
		else
		{
			sumothersallowancefield =sumothersallowancefield+ " ROUND(b."+allowancefield[u][0]+",2)+";
			othersallowancefield =othersallowancefield+ " ROUND(b."+allowancefield[u][0]+",2),";	
			otherallowancename = otherallowancename +allowancefield[u][1]+",";
		}	
		allowancefields =allowancefields+ " ROUND( b."+allowancefield[u][0]+",2),";
	}
}
				
				
				 
				 
String recoveryfield[][] =  CommonFunctions.QueryExecute("SELECT CHR_RCODE,CHR_RNAME  FROM  pay_m_recovery ORDER BY INT_RECOVERYID");
String sumrecoveryfield="";
String recoveryfields="";
String recoveryname="";
if(recoveryfield.length>0)
{
	for(int u=0;u<recoveryfield.length;u++)
	{
		sumrecoveryfield =sumrecoveryfield+ "ROUND( c."+recoveryfield[u][0]+",2)+";
		recoveryfields =recoveryfields+ " ROUND(c."+recoveryfield[u][0]+",2),";
		recoveryname =recoveryname+ recoveryfield[u][1]+",";
		
	}
}

String bsql="SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,INT_PFLIMITMINIMUM ,  INT_PFLIMIT,INT_ESILIMIT FROM m_institution WHERE INT_ID=1";
String basicdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(bsql);

double pf=Double.parseDouble(basicdata[0][0]);
double esi=Double.parseDouble(basicdata[0][1]);
double cpypf=Double.parseDouble(basicdata[0][2]);
double cpypension=Double.parseDouble(basicdata[0][3]);
double cpyesi=Double.parseDouble(basicdata[0][4]);
double dbminimumpflimit=Double.parseDouble(basicdata[0][5]);
double dbpmaximumflimit=Double.parseDouble(basicdata[0][6]);
double dbesilimit=Double.parseDouble(basicdata[0][7]);			
double totalctc =0.0;

sql =  "SELECT a.CHR_EMPID,a1.CHR_STAFFNAME,DATE_FORMAT(a1.DT_DOJCOLLEGE,'%d-%m-%Y'),   "; 
sql = sql +  "a.CHR_PF,a.CHR_PFTYPE,a.CHR_ESI,a.CHR_ESITYPE,      ";
sql = sql +  " ROUND(a.INT_SALARY,2) ,        ";
sql = sql +  "  "+grossallowancefield;
sql = sql +  "  ( "+sumgrossallowancefield+" 0) ,   ";
sql = sql +  "  ( a.INT_SALARY +  "+sumgrossallowancefield+" 0),     ";
sql = sql +  "    "+othersallowancefield;
sql = sql +  "   (  "+sumothersallowancefield+"0),     ";
sql = sql +  "(a.INT_SALARY +  ("+sumgrossallowancefield+" 0)   ";
sql = sql +  "  +   ("+sumothersallowancefield+"0)  ),    ";
sql = sql +  " "+recoveryfields;
sql = sql +  " ( "+sumrecoveryfield+"0) ,    ";



//FUN_GET_PFAMOUNT(a.CHR_PFTYPE,a.INT_SALARY)
//sql = sql +  " ## EMPLOYEE PF CALCULATION    "; 
sql = sql +  " FUN_PAY_GET_REVISION_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE ,a.INT_APPRAISALID  )   staffpf, "; 
 
  
//sql = sql +  " ## EMPLOYEE ESI CALCULATION    ";  
sql = sql +  "  FUN_GET_ESIAMOUNT('STAFF',a.CHR_ESI,d.INT_GROSS )   staffesi ,  ";

    

//sql = sql +  " ## EMPLOYEE PF  "+cpypf + " % CALCULATION   ";
sql = sql +  " ( FUN_PAY_GET_REVISION_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE,a.INT_APPRAISALID   )/"+pf+" * "+cpypf+" ) cpypf,   ";
 
 
//sql = sql +  " ## EMPLOYEE PF " + cpypension +" % CALCULATION  ";
sql = sql +  " (FUN_PAY_GET_REVISION_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE ,a.INT_APPRAISALID  )/"+pf+"* "+cpypension+" ) cpypf,   ";
 
  
    
//sql = sql +  "## COMPANY ESI CALCULATION  ";        
sql = sql +  "  FUN_GET_ESIAMOUNT('COMPANY',a.CHR_ESI,d.INT_GROSS )    cpyesi ,a.CHR_PFCALCULATIONTYPE  ";

sql = sql +  " FROM com_m_staff a1 ,pay_t_appraisal_basic a,pay_t_appraisal_allowance b,pay_t_appraisal_recovery c , pay_t_appraisal d   ";  
sql = sql +  " WHERE  a1.CHR_EMPID =  b.CHR_EMPID  AND a.CHR_EMPID =  b.CHR_EMPID   "; 
sql = sql +  " AND a.CHR_EMPID =  c.CHR_EMPID    ";  
sql = sql +  "  AND d.INT_APPRAISALID = a.INT_APPRAISALID ";
sql = sql +  "  AND d.INT_APPRAISALID = b.INT_APPRAISALID ";
sql = sql +  "  AND d.INT_APPRAISALID = c.INT_APPRAISALID ";
sql = sql +  " AND  a.CHR_EMPID='"+Staffid+"'   "; 
sql = sql +  " AND  a.INT_APPRAISALID =  "+Apparaisalid;
sql = sql +  " AND  d.INT_APPRAISALID =  "+Apparaisalid;
sql = sql +  " AND  b.INT_APPRAISALID =  "+Apparaisalid;
sql = sql +  " AND  c.INT_APPRAISALID =  "+Apparaisalid;

//out.println(sql);
String takeupdatas[][] =  CommonFunctions.QueryExecute(sql);
if(takeupdatas.length>0)  
	if(!"-".equals(takeupdatas[0][0]))
	{
		
		
		out.println("<center>");
		out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow4'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b>NEW TAKEUPS...</b></td>");
		out.println("</tr>");
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven'><b>PF</b></td>");
		out.println("<td class='boldEleven' align='right'>");
		if("C".equals(takeupdatas[0][3]))
			out.println("COMMON");
		else if("Y".equals(takeupdatas[0][3]))
			out.println("YES");
		else
			out.println("N0");
		out.println("</td>");	
		out.println("</tr>");
		
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven'><b>ESI</td>");
		out.println("<td class='boldEleven' align='right'>");
		if("C".equals(takeupdatas[0][5]))
			out.println("COMMON");
		else if("Y".equals(takeupdatas[0][5]))
			out.println("YES");
		else
			out.println("N0");
		out.println("</td>");
		out.println("</tr>");
		 
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven'><b>PF TYPE</td>");
		out.println("<td class='boldEleven' align='right'>");
		if("A".equals(takeupdatas[0][4]))
			out.println("AMOUNT");
		else if("P".equals(takeupdatas[0][4]))
			out.println("PERCENTAGE");
		else
			out.println("N0");
		out.println("</td>");
		out.println("</tr>");
		
		
		out.println("<tr class='MRow1'>"); 
		out.println("<td class='boldEleven'><b>ESI TYPE</td>");
		out.println("<td class='boldEleven' align='right'>");
		if("A".equals(takeupdatas[0][6]))
			out.println("AMOUNT");
		else if("P".equals(takeupdatas[0][6]))
			out.println("PERCENTAGE");
		else
			out.println("N0");
		out.println("</td>");
		out.println("</tr>");
		int getrow=8;
		totalctc =0.0;
		out.println("<tr class='MRow2'>");
		out.println("<td class='boldEleven'><b>BASIC</td>");
		out.println("<td class='boldEleven' align='right'>");
		out.println(takeupdatas[0][7]);
		totalctc = totalctc+Double.parseDouble(takeupdatas[0][7]);
		out.println("</td>");
		out.println("</tr>");
		
		out.println("<tr class='MRow4'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b>GROSS ALLOWANCE</b></td>");
		out.println("</tr>");
		
		String grossdata[] = grossallowancename.split(",");
		if(grossdata.length>0)
			for(int u=0;+u<grossdata.length;u++)
			{
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven'><b>"+grossdata[u]+"</td>");
				out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][(getrow+u)]+"</td>");
				out.println("</tr>");
			}
		getrow = getrow+grossdata.length;	
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>SUM OF GROSS ALLOWANCE</td>");
		out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][getrow]+"</td>");
		out.println("</tr>");
		totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
		
		
		
		
		getrow = getrow+1;	
		out.println("<tr class='MRow2'>");
		out.println("<td class='boldEleven'><b>GROSS</td>");
		out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][getrow]+"</td>");
		out.println("</tr>");
		
		
		out.println("<tr class='MRow4'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b>VARIABLE ALLOWANCE</b></td>");
		out.println("</tr>");
		

		getrow = getrow+1;
		String othersdata[] = otherallowancename.split(",");
		if(othersdata.length>0)
			for(int u=0;+u<othersdata.length;u++)
			{
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven'><b>"+othersdata[u]+"</td>");
				out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][(getrow+u)]+"</td>");
				out.println("</tr>");
			}
			
			
		getrow = getrow+othersdata.length;	
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>SUM OF VARIABLE ALLOWANCE</td>");
		out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][getrow]+"</td>");
		out.println("</tr>");
		totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
		
		getrow = getrow+1;	
		out.println("<tr class='MRow2'>");
		out.println("<td class='boldEleven'><b>TOTAL</td>");
		out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][getrow]+"</td>");
		out.println("</tr>");
		
		
		out.println("<tr class='MRow4'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b>RECOVERY</b></td>");
		out.println("</tr>");
		
		getrow = getrow+1;	
		String recdata[] = recoveryname.split(",");
		if(recdata.length>0)
			for(int u=0;+u<recdata.length;u++)
			{
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven'><b>"+recdata[u]+"</td>");
				out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][(getrow+u)]+"</td>");
				out.println("</tr>");
			}
		getrow = getrow+recdata.length;	
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>SUM OF RECOVERY</td>");
		out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][getrow]+"</td>");
		out.println("</tr>");	
		
		
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b>EMPLOYEE PF & ESI DETAILS</b></td>");
		out.println("</tr>");
		
		
		getrow = getrow+1;		
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>PF  <span class='boldred'>"+pf+"%</span></td>");
		out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.keep2Digit(Double.parseDouble(takeupdatas[0][getrow]))+"</td>");
		out.println("</tr>");	
		
			
		getrow = getrow+1;		
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>ESI  <span class='boldred'>"+esi+"%</span> </td>");
		out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.keep2Digit(Double.parseDouble(takeupdatas[0][getrow]))+"</td>");
		out.println("</tr>");	
		
		
		
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b>EMPLOYEER PF & ESI DETAILS</b></td>");
		out.println("</tr>");
		
		getrow = getrow+1;		
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>EMPLOYER PF1  <span class='boldred'>"+cpypf+"%</span></td>");
		out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.keep2Digit(Double.parseDouble(takeupdatas[0][getrow]))+"</td>");
		out.println("</tr>");	
		totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
		
		getrow = getrow+1;		
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>EMPLOYER PF2  <span class='boldred'>"+cpypension+"%</span></td>");
		out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.keep2Digit(Double.parseDouble(takeupdatas[0][getrow]))+"</td>");
		out.println("</tr>");	
		totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
		
		
		getrow = getrow+1;		
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>EMPLOYER ESI  <span class='boldred'>"+cpyesi+"%</span> </td>");
		out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.keep2Digit(Double.parseDouble(takeupdatas[0][getrow]))+"</td>");
		out.println("</tr>");	
		totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
		
		
		
		//CTC CALCULATION
		out.println("<tr class='MRow4'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b>CTC</b></td>");
		out.println("</tr>");
		out.println("<tr class='MRow2'>");
		out.println("<td class='boldEleven'><b>CTC </td>");
		out.println("<td class='boldEleven' align='right'>"+com.my.org.erp.common.CommonFunctions.keep2Digit(totalctc)+"</td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("</center>");
	}
  
   






							  %>
				            </div></td>
					  </tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center"><input name="filename" type="hidden" id="filename" value="PayRollRevision" /> 
							<input name="actionS" type="hidden" id="actionS" value="PAYPayRollRevisionAccept" /> 
							 <input name="Staffid" type="hidden" id="Staffid" value="<%=Staffid%>">
							 <input name="month" type="hidden" id="month" value="<%=month%>">
							 <input name="year" type="hidden" id="year" value="<%=year%>">
                             <input name="Apparaisalid" type="hidden" id="Apparaisalid" value="<%=Apparaisalid%>">
							</div>							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Accept" /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('PayRollRevisionAccept.jsp')" /></td> 
								</tr>
							</table>							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block"></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td height="23">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
</table>
</form>
 <%@ include file="../footer.jsp"%>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script language="javascript">
 
/* $(function() {
		$( "#dor" ).datepicker({
			changeMonth: true,
			changeYear: true,
			'setDate', 
			(new Date(queryDate)) ,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 	
	
  	*/
	 
</script>
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>