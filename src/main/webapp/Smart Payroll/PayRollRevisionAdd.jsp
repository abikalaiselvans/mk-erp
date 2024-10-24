<%@ page import="java.io.*,java.util.*"%>
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
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script language="javascript">
 
	 
	  
	 $(function() {
		var dates = $( "#doa1, #doa" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,  maxDate: "+0D" ,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
			numberOfMonths: 1,
			onSelect: function( selectedDate ) {
				var option = this.id == "doa" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});
	});
	 
	
	
	 $(function() {
		$( "#dor" ).datepicker({
			changeMonth: true,
			changeYear: true,  maxDate: "+10D" ,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	
	
	/* $(function() {
		$( "#doa" ).datepicker({
			changeMonth: true,
			changeYear: true,
			showOn: "button", maxDate: "+30D" ,
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	
	
	 $(function() {
		$( "#doa1" ).datepicker({
			changeMonth: true,
			changeYear: true,
			showOn: "button",maxDate: "+30D" ,
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	
	*/
	
</script>
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">





<script language="javascript">

 


 function pfchange()
{
	 
	if(document.getElementById('pf').value== "Y" )
	{
		setOptionValue('optpf','A');
		document.getElementById('optpf').disabled;
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}	
	else if (document.getElementById('pf').value== "N" )
	{
		setOptionValue('optpf','o');
		pf0.style.visibility="hidden";
		pf1.style.visibility="hidden";
		pf2.style.visibility="hidden";
	}	
	else if (document.getElementById('pf').value== "C" )
	{
		setOptionValue('optpf','P');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="hidden";
	}
	else if (document.getElementById('pf').value== "0" )
	{
		setOptionValue('optpf','0');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="hidden";
	}		
}


function pftypechange()
{
	 
	if(document.getElementById('optpf').value== "0" )
	{
		setOptionValue('pf','0');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}	
	else if (document.getElementById('optpf').value== "A" )
	{
		setOptionValue('pf','Y');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}	
	else if (document.getElementById('optpf').value== "P" )
	{
		setOptionValue('pf','C');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="hidden";
	}	
}



 function ESIchange()
{
	 
	if(document.getElementById('ESI').value== "Y" )
	{
		setOptionValue('optesi','A');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}	
	else if (document.getElementById('ESI').value== "N" )
	{
		setOptionValue('optesi','N');
		ppf0.style.visibility="hidden";
		ppf1.style.visibility="hidden";
		ppf2.style.visibility="hidden";
	}	
	else if (document.getElementById('ESI').value== "C" )
	{
		setOptionValue('optesi','P');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="hidden";
	}
	else if (document.getElementById('ESI').value== "0" )
	{
		setOptionValue('optesi','0');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="hidden";
	}		
}


function esitypechange()
{
	 
	if(document.getElementById('optesi').value== "0" )
	{
		setOptionValue('ESI','0');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}	
	else if (document.getElementById('optesi').value== "A" )
	{
		setOptionValue('ESI','Y');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}	
	else if (document.getElementById('optesi').value== "P" )
	{
		setOptionValue('ESI','C');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="hidden";
	}	
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
<form action="../SmartLoginAuth" method="post"   name="EmployeTransfer" onSubmit="return validateFields()"  AUTOCOMPLETE = "off">
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
							String Staffid= request.getParameter("staffid");
							String sql ="";
							sql=sql+" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_DESIGNAME, ";
							sql=sql+" DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y') ,DATE_FORMAT(a.DAT_RIVISION,'%d-%m-%Y')  ";
							sql=sql+" FROM com_m_staff a  ,com_m_company b,com_m_branch c, com_m_office d,com_m_depart e,com_m_desig f ";
							sql=sql+" WHERE a.INT_COMPANYID = b.INT_COMPANYID ";
							sql=sql+" AND a.INT_BRANCHID = c.INT_BRANCHID ";
							sql=sql+" AND a.INT_OFFICEID = d.INT_OFFICEID ";
							sql=sql+" AND a.INT_DEPARTID = e.INT_DEPARTID ";
							sql=sql+" AND a.INT_DESIGID = f.INT_DESIGID  AND a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y'   ";
							sql=sql+" AND  a.CHR_EMPID = '"+Staffid+"' ";
							sql=sql+" ORDER BY a.CHR_STAFFNAME ";    
							//out.println(sql);
							String datas[][] = CommonFunctions.QueryExecute(sql);
							  
							%>
							
							</div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
							<div align="right"><span class="bolddeepred">*</span>
							Mandatory</div>
							</td>
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
                              <td width="13%" class="bold1">Emp id</td>
                              <td width="27%" class="boldEleven"><%=datas[0][0]%></td>
                              <td width="20%" class="bold1">Company</td>
                              <td width="40%" class="boldEleven"><%=datas[0][2]%></td>
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
                              <td class="bold1">DOR</td>
                              <td class="boldEleven"><%=datas[0][8]%></td>
                              <td class="bold1">&nbsp;</td>
                              <td class="boldEleven">&nbsp;</td>
                            </tr>
                            <tr>
                              <td colspan="2" align="center" valign="top" class="bold1"><%
							  
			

String allowancefield[][] =  CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
String sumgrossallowancefield="";
String sumothersallowancefield="";
String allowancefields="";
String grossallowancefield="";
String othersallowancefield="";
String grossallowancename="";
String otherallowancename="";
String pfcalculationtype="";
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
String basicdata[][] = CommonFunctions.QueryExecute(bsql);

double pf=Double.parseDouble(basicdata[0][0]);
double esi=Double.parseDouble(basicdata[0][1]);
double cpypf=Double.parseDouble(basicdata[0][2]);
double cpypension=Double.parseDouble(basicdata[0][3]);
double cpyesi=Double.parseDouble(basicdata[0][4]);
double dbminimumpflimit=Double.parseDouble(basicdata[0][5]);
double dbpmaximumflimit=Double.parseDouble(basicdata[0][6]);
double dbesilimit=Double.parseDouble(basicdata[0][7]);			
double totalctc =0.0;

sql =  "SELECT a.CHR_EMPID,a.CHR_STAFFNAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y'),   "; 
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




//sql = sql +  " ## EMPLOYEE PF CALCULATION    "; 
sql = sql +  " FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE  )   staffpf, ";

//sql = sql +  " ## EMPLOYEE ESI CALCULATION    ";  
sql = sql +  "  FUN_GET_ESIAMOUNT('STAFF',a.CHR_ESI,FUN_PAY_GET_ORIGINAL_GROSS(a.CHR_EMPID) )   staffesi ,  ";
    
//sql = sql +  " ## EMPLOYEE PF  "+cpypf + " % CALCULATION   ";
sql = sql +  " ( FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE  )/"+pf+" * "+cpypf+" ) cpypf,   ";

//sql = sql +  " ## EMPLOYEE PF " + cpypension +" % CALCULATION  ";
sql = sql +  " (FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE  )/"+pf+"* "+cpypension+" ) cpypf,   ";
 
//sql = sql +  "## COMPANY ESI CALCULATION  ";  
sql = sql +  "  FUN_GET_ESIAMOUNT('COMPANY',a.CHR_ESI,FUN_PAY_GET_ORIGINAL_GROSS(a.CHR_EMPID) )    cpyesi ,a.CHR_PFCALCULATIONTYPE  ";
sql = sql +  " FROM com_m_staff a,pay_t_allowance b,pay_t_recovery c   ";  
sql = sql +  " WHERE  a.CHR_EMPID =  b.CHR_EMPID   "; 
sql = sql +  " AND a.CHR_EMPID =  c.CHR_EMPID    ";  
sql = sql +  " AND  a.CHR_EMPID='"+Staffid+"'   "; 
//out.println(sql);
String takeupdatas[][] = CommonFunctions.QueryExecute(sql);
double obasic=0;
double ogross=0;
String svalue="";
String mvalue="";
if(takeupdatas.length>0)  
	if(!"-".equals(takeupdatas[0][0]))
	{
		
		
		out.println("<center>");
		out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven'><b>PF</b></td>");
		out.println("<td class='boldEleven'>");
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
		out.println("<td class='boldEleven'>");
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
		out.println("<td class='boldEleven'>");
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
		out.println("<td class='boldEleven'>");
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
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven'><b>BASIC</td>");
		out.println("<td class='boldEleven' align='right'>");
		out.println("<input type='text' size=10 maxlength=8  name='basic' id='basic'  onKeyPress=\"return numeric_only(event,'basic','10')\" value='"+takeupdatas[0][7]+"'  style=\"text-align:right\"></td>");
		svalue =svalue+"basic,";
		mvalue =mvalue+"basic,";
		 
		obasic = Double.parseDouble(takeupdatas[0][7]);
		totalctc = totalctc+Double.parseDouble(takeupdatas[0][7]);
		out.println("</tr>");
		
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b>GROSS ALLOWANCE</b></td>");
		out.println("</tr>");
		
		String grossdata[] = grossallowancename.split(",");
		if(grossdata.length>0)
			for(int u=0;+u<grossdata.length;u++)
			{
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven'><b>"+grossdata[u]+"</td>");
				out.println("<td class='boldEleven' align='right'>");
				out.println("<input type='text' size=10 maxlength=8  name='allowance"+(u+1)+"' id='allowance"+(u+1)+"'  onKeyPress=\"return numeric_only(event,'allowance"+(u+1)+"','10')\" value='"+takeupdatas[0][(getrow+u)]+"'  style=\"text-align:right\"></td>");
				svalue =svalue+"allowance"+(u+1)+",";
				mvalue =mvalue+grossdata[u]+",";
				
				out.println("</tr>");
				
			}
		getrow = getrow+grossdata.length;	
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>SUM OF GROSS ALLOWANCE</td>");
		out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][getrow]+"</td>");
		out.println("</tr>");
		totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
		
		
		 
		
		getrow = getrow+1;	
		out.println("<tr class='MRow4'>");
		out.println("<td class='boldEleven'><b>GROSS</td>");
		out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][getrow]+"</td>");
		out.println("</tr>");
		ogross = Double.parseDouble(takeupdatas[0][getrow]);
		
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b> VARIABLE ALLOWANCE</b></td>");
		out.println("</tr>");
		
		getrow = getrow+1;
		String othersdata[] = otherallowancename.split(",");
		if(othersdata.length>0)
			for(int u=0;+u<othersdata.length;u++)
			{
				out.println("<tr class='ButtonHead26'>");
				out.println("<td class='boldEleven'><b>"+othersdata[u]+"</td>");
				out.println("<td class='boldEleven' align='right'><input type='text' size=10 maxlength=8  name='otherallowance"+(u+1)+"' id='otherallowance"+(u+1)+"'  onKeyPress=\"return numeric_only(event,'otherallowance"+(u+1)+"','10')\" value='"+takeupdatas[0][(getrow+u)]+"'  style=\"text-align:right\"> </td>");
				svalue =svalue+"otherallowance"+(u+1)+",";
				mvalue =mvalue+othersdata[u]+",";
				out.println("</tr>");
			}
			
			
		getrow = getrow+othersdata.length;	
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>SUM OF VARIABLE ALLOWANCE</td>");
		out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][getrow]+"</td>");
		out.println("</tr>");
		//totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
		
		getrow = getrow+1;	
		out.println("<tr class='MRow4'>");
		out.println("<td class='boldEleven'><b>TOTAL</td>");
		out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][getrow]+"</td>");
		out.println("</tr>");
		
		
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b>RECOVERY</b></td>");
		out.println("</tr>");
		
		getrow = getrow+1;	
		String recdata[] = recoveryname.split(",");
		if(recdata.length>0)
			for(int u=0;+u<recdata.length;u++)
			{
				out.println("<tr class='MRow2'>");
				out.println("<td class='boldEleven'><b>"+recdata[u]+"</td>");
				 
				out.println("<td class='boldEleven' align='right'>");
				out.println("<input type='text' size=10 maxlength=8  name='recovery"+(u+1)+"' id='recovery"+(u+1)+"'  onKeyPress=\"return numeric_only(event,'recovery"+(u+1)+"','10')\" value='"+takeupdatas[0][(getrow+u)]+"'  style=\"text-align:right\"></td>");
				svalue =svalue+"recovery"+(u+1)+",";
				mvalue =mvalue+recdata[u]+",";
				out.println("</tr>");
			}
		getrow = getrow+recdata.length;	
		out.println("<tr class='MRow4'>");
		out.println("<td class='boldEleven'><b>SUM OF RECOVERY</td>");
		out.println("<td class='boldEleven' align='right'>"+takeupdatas[0][getrow]+"</td>");
		out.println("</tr>");	
		
		
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b>EMPLOYEE PF & ESI DETAILS</b></td>");
		out.println("</tr>");
		
		
		getrow = getrow+1;		
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>PF  <span class='boldred'>"+pf+"%</span></td>");
		out.println("<td class='boldEleven' align='right'>"+CommonFunctions.keep2Digit(Double.parseDouble(takeupdatas[0][getrow]))+"</td>");
		out.println("</tr>");	
		
			
		getrow = getrow+1;		
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>ESI  <span class='boldred'>"+esi+"%</span> </td>");
		out.println("<td class='boldEleven' align='right'>"+CommonFunctions.keep2Digit(Double.parseDouble(takeupdatas[0][getrow]))+"</td>");
		out.println("</tr>");	
		
		
		
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b>EMPLOYEER PF & ESI DETAILS</b></td>");
		out.println("</tr>");
		
		getrow = getrow+1;		
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>EMPLOYER PF1  <span class='boldred'>"+cpypf+"%</span></td>");
		out.println("<td class='boldEleven' align='right'>"+CommonFunctions.keep2Digit(Double.parseDouble(takeupdatas[0][getrow]))+"</td>");
		out.println("</tr>");	
		totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
		
		getrow = getrow+1;		
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>EMPLOYER PF2  <span class='boldred'>"+cpypension+"%</span></td>");
		out.println("<td class='boldEleven' align='right'>"+CommonFunctions.keep2Digit(Double.parseDouble(takeupdatas[0][getrow]))+"</td>");
		out.println("</tr>");	
		totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
		
		
		getrow = getrow+1;		
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>EMPLOYER ESI  <span class='boldred'>"+cpyesi+"%</span> </td>");
		out.println("<td class='boldEleven' align='right'>"+CommonFunctions.keep2Digit(Double.parseDouble(takeupdatas[0][getrow]))+"</td>");
		out.println("</tr>");	
		totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
		
		getrow = getrow+1;	
		pfcalculationtype =takeupdatas[0][getrow];
		//PF  CALCULATION TYPE
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>PF CALCULATION TYPE</td>");
		out.println("<td class='boldEleven' align='right'> Type-"+pfcalculationtype+" </td>");
		out.println("</tr>");	
		
		//CTC CALCULATION
		out.println("<tr class='MRow4'>");
		out.println("<td class='boldEleven' colspan='2' align='center'><b>CTC</b></td>");
		out.println("</tr>");
		out.println("<tr class='MRow3'>");
		out.println("<td class='boldEleven'><b>CTC </td>");
		out.println("<td class='boldEleven' align='right'>"+CommonFunctions.keep2Digit(totalctc)+"</td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("</center>");
	}
  
   






							  %></td>
                              <td colspan="2" align="center" valign="top" class="bold1"><table width="100%" border="0" cellpadding="2" cellspacing="2" class="boldEleven">
                                <tr>
                                  <td colspan="2" class="boldEleven">
<%

sql = "SELECT a.CHR_PF ,a.CHR_PFTYPE,a.INT_PFAMT,a.CHR_PFNO,a.CHR_ESI ,a.CHR_ESITYPE,a.INT_ESIAMT,a.CHR_ESINO FROM com_m_staff a WHERE  a.CHR_EMPID='"+Staffid+"' ";
String pdata[][] = CommonFunctions.QueryExecute(sql);

%>								  </td>
                                </tr>
                                <tr>
                                  <td width="49%" class="boldEleven">PF<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                  <td width="51%" class="boldEleven"><select name="pf" class="formText135" id="pf" onBlur="pfchange()">
                                      <option value="0">Select PF </option>
                                      <option value="Y">Yes</option>
                                      <option value="N">No</option>
                                      <option value="C">Common</option>
                                  </select>
								  							  </td>
                                </tr>
                                <tr id="pf0">
                                  <td class="boldEleven">PF TYPE</td>
                                  <td class="boldEleven"><select name="optpf" id="optpf" class="formText135" onBlur="pftypechange()">
                                      <option value="0">Select PF  TYPE</option>
                                      <option value="A">Amount</option>
                                      <option value="P">Percentage</option>
                                  </select>
                                 							  </td>
                                </tr>
                                
                                <tr id="pf1">
                                  <td class="boldEleven">PF Number</td>
                                  <td class="boldEleven">
								  <%
								  
								  if("-".equals(pdata[0][3]))
								  	pdata[0][3] ="0";
								  %>
								  <input name="TxtPfNo" type="text" class="formText135" id="TxtPfNo"  onkeypress="return numeric_only(event,'TxtPfNo','10');" value="<%=pdata[0][3]%>" size="25" maxlength="7"/>                                  </td>
                                </tr>
                                <tr id="pf2">
                                  <td class="boldEleven">PF Amount</td>
                                  <td class="boldEleven">
<input name="TxtPfValue" id="TxtPfValue" type="text" class="formText135" onKeyPress="return numeric_only(event,'TxtPfValue','10');"  value="<%=pdata[0][2]%>" size="25" maxlength="7" /></td>
                                </tr>
                                
                                <tr>
                                  <td height="21" class="boldEleven">PF Calculation Type <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                  <td class="boldEleven">
                                  <select name="pfcalculationtype" id="pfcalculationtype" class="formText135"  style="width:200" tabindex="30">
                  <option value="0">PF Calculation Cycle</option>
                  
<%
String pfcalculationData[][] =  CommonFunctions.QueryExecute("SELECT INT_ROWID,INT_PFMINIMUM_LIMIT,INT_PFMAXIMUM_LIMIT FROM m_pf_setting WHERE CHR_STATUS ='Y'" );
if(pfcalculationData.length>0)
	for(int u=0;u<pfcalculationData.length;u++)
		out.print("<option value='"+pfcalculationData[u][0]+"'> Type-"+pfcalculationData[u][0]+" [ Rs."+pfcalculationData[u][1]+"  to  Rs."+pfcalculationData[u][2]+"] </option>");

%>
    </select>
<script language="javascript" >setOptionValue('pfcalculationtype','<%=pfcalculationtype%>')</script>    
    
    
    
                                  </td>
                                </tr>
                                <tr>
                                  <td height="21" class="boldEleven">ESI<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                  <td class="boldEleven"><select name="ESI" class="formText135" id="ESI"  onBlur="ESIchange()">
                                      <option value="0"  >Select ESI </option>
                                      <option value="Y">Yes</option>
                                      <option value="N">No</option>
                                      <option value="C">Common</option>
                                  </select> 
                                  						  </td>
                                </tr>
                                <tr id="ppf0">
                                  <td height="21" class="boldEleven">ESI TYPE</td>
                                  <td class="boldEleven"><select name="optesi" class="formText135" id="optesi" onBlur="esitypechange()">
                                      <option value="0">Select ESI  TYPE</option>
                                      <option value="A">Amount</option>
                                      <option value="P">Percentage</option>
                                  </select>
								  								  </td>
                                </tr>
                                
                                <tr id="ppf1">
                                  <td class="boldEleven">ESI Number</td>
                                  <td class="boldEleven">

<input name="TxtEsiNo" type="text" class="formText135" id="TxtEsiNo" onKeyPress="return numeric_only(event,'TxtEsiNo','12')"    
onkeyup="upperMe(this),CheckUnique(this,'ESIDiv','com_m_staff','CHR_ESINO') "  value="<%=pdata[0][7]%>" size="25" maxlength="11" />
                                      <div id="ESIDiv"></div></td>
                                </tr>
                                <tr id="ppf2">
                                  <td class="boldEleven">ESI Amount</td>
                                  <td class="boldEleven">
<input name="TxtEsiValue"  id="TxtEsiValue"  type="text" class="formText135" onKeyPress="return numeric_only(event,'TxtEsiValue','10')"  value="<%=pdata[0][6]%>" size="25" maxlength="7" /></td>
                                </tr>
                                
                                <tr>
                                  <td class="boldEleven">Revision</td>
                                  <td><table width="27%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td><input name="Revision" id="Revision1" type="radio" value="Y" checked ><!--onClick="enableRevision()"--></td>
                                      <td class="boldEleven">Yes</td>
                                      <td><input name="Revision" id="Revision2" type="radio" value="N"  ><!--onClick="disableRevision()"--></td>
                                      <td class="boldEleven">No</td>
                                    </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td align="left" valign="top" class="boldEleven">Revision Type </td>
                                  <td><table width="27%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td><input name="rivisiontype" id="rivisiontype1" type="radio" value="A" checked >
                                          <!--onClick="enableRevision()"--></td>
                                      <td class="boldEleven">Automatic</td>
                                      <td><input name="rivisiontype" id="rivisiontype2" type="radio" value="M"  >
                                          <!--onClick="disableRevision()"--></td>
                                      <td class="boldEleven">Manual</td>
                                    </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td align="left" valign="top" class="boldEleven">Description <span class="boldred">*</span> </td>
                                  <td><textarea name="rdescription" cols="30" rows="5" class="formText135" id="rdescription"></textarea></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Date of Joinning </td>
                                  <td><%=datas[0][7]%>
                                  <input name="doj" type="hidden" id="doj" value="<%=datas[0][7]%>"></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Date of Revision Entry <span class="boldred">*</span> </td>
                                  <td><input  
																name="dor" id="dor"  type="text" class="formText135" size="12"
																maxlength="10" readonly  
																title="dd/mm/yyyy" />
																<script language="javascript">setCurrentDate('dor')</script>																</td>
                                </tr>
                                 
                                <tr>
								 
                                  <td class="ButtonHead11"> Arrears Calculated from <span class="boldred">*</span></td>
                                  <td><span class="TableDesign10">
                                  <input  required 
																name="doa" id="doa"  type="text" class="formText135" size="12"
																maxlength="10" readonly value="<%=datas[0][8]%>"  
																title="dd/mm/yyyy" />
                                  </span></td>
								  
								   
                                </tr>
                                <tr>
                                  <td class="ButtonHead11">Arrears Calculated to <span class="boldred">*</span></td>
                                  <td><span class="TableDesign10">
                                  <input required  
																name="doa1" id="doa1"  type="text" class="formText135" size="12"
																maxlength="10" readonly value="<%=datas[0][8]%>"  
																title="dd/mm/yyyy" />
                                  </span></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Basic</td>
                                  <td><%=takeupdatas[0][7]%></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Gross</td>
                                  <td><%=ogross%>  
<%
		if(totalctc>15000)
		{
		 %>
		 <script language="javascript">setOptionValue('ESI','N');ESIchange();</script>
		 <%	
		}
%>								  </td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Current Cost To Cost</td>
                                  <td><img src="../Image/report/Rupee.gif" width="20" height="20"><%=Math.round(totalctc)%>
                                    
									
									 
									
									
									<input name="totalctc" type="hidden" id="totalctc" value="<%=totalctc%>">
                                    <input name="param" type="hidden" id="param" value="<%=svalue%>">
									
									<input name="gross" type="hidden" id="gross" value="<%=ogross%>">
									<input name="cpypf" type="hidden" id="cpypf" value="<%=cpypf%>">
									<input name="cpypension" type="hidden" id="cpypension" value="<%=cpypension%>">
									<input name="cpyesi" type="hidden" id="cpyesi" value="<%=cpyesi%>">	
                                     								</td>
                                </tr>
                                <tr id="rivisionrow1">
                                  <td class="boldEleven">Revision % <span class="boldred">*</span> </td>
                                  <td>
								  <select name="rpercentage" class="formText135" id="rpercentage" onChange="calculateNewCTC()">
								  <option value="Select">Select Percentage</option>
                                  <%
								  	for(int u=0;u<=100;u=u+1)
										out.println("<option value='"+(u)+"'>"+u+" - [ % ]</option>");
								  %>
								  </select>
								  
								   <script language="javascript">
								  	
									 
									function calculateNewCTC()
									{
										try
										{
											/*var gross = parseFloat(document.getElementById('gross').value);
											var cpypf = parseFloat(document.getElementById('cpypf').value);
											var cpypension = parseFloat(document.getElementById('cpypension').value);
											var cpyesi = parseFloat(document.getElementById('cpyesi').value);
											
											
											
											var oldctc = parseFloat(document.getElementById('totalctc').value);
											var rpercentage = parseFloat(document.getElementById('rpercentage').value);
											var revionamount =  parseFloat(oldctc * rpercentage/100);
											var tb=document.getElementById('newctc');
											var str="<font   class='ButtonHead' >Increment is <img src=\"../Image/report/Rupee.gif\" width='20' height='20'> "+Math.round(revionamount)+"</font><br><br> <font   class='ButtonHead' >New Cost to Cost <img src=\"../Image/report/Rupee.gif\" width='20' height='20'> "+Math.round(revionamount+oldctc)+"</font>";   tb.innerHTML=str;*/
										}
										catch(err)
										{
											alert(err);
										}
									}
								 	 
								  </script>                                  </td>
                                </tr>
                                
                                
                                <tr>
                                  <td>&nbsp;</td>
                                  <td>&nbsp;</td>
                                </tr>
                                <tr>
                                  <td colspan="2">
								  <div id='newctc'></div>
								  <br> <br>
								  <div id='newgross'></div>
								  <script language="javascript">
								  	function enableRevision()
									{
										rivisionrow1.style.visibility="Visible";
										 
										
										 
									}
									
									function disableRevision()
									{
										rivisionrow1.style.visibility="hidden";
										 
									}
								  </script>								  </td>
                                </tr>
                              </table></td>
                            </tr>
                            <tr>
                              <td colspan="4" class="bold1">&nbsp;</td>
                            </tr>
                          </table></td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center"><input name="filename" type="hidden" id="filename" value="PayRollRevision" /> 
							<input name="actionS" type="hidden" id="actionS" value="PAYPayRollRevisionAdd" /> 
							 <input name="Staffid" type="hidden" id="Staffid" value="<%=Staffid%>">
							</div>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="Submit" class="buttonbold14" value="Revision" /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('PayRollRevision.jsp')" /></td> 
								</tr>
							</table>
							</td>
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
<script language="javascript">


function  validateFields()
{
	try
	{
		if(document.getElementById('rivisiontype2').checked)
			manualCheck()
			
		if(
			checkNull('rdescription','Enter Revision Description') 
			&& checkNull('dor','Enter Revision Date')
			&& checkNull('doa','Enter Arrears Date')
			&& checkNullSelect('rpercentage','Select Revision Percentage%','Select')
			&& checkNullSelect('pf','Select PF %','0')
			&& checkNullSelect('ESI','Select ESI %','0')
			)
		  {   	 	
			   return true;
		   }
		 else
		 {
				return false;	  
		 }
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}


function manualCheck()
{
	try
	{
		var svalue ="<%=svalue%>";
		var mvalue = "<%=mvalue%>";
		var s = svalue.split(",");
		var m = mvalue.split(",");
		var f = false;
		for( i=0; i<s.length-1; i++)
		{
				var ck = "Check "+m[i] +"...";
				if(checkNull(s[i],ck))
					f = true;			 
				else
					f= false;				
		}
		if(f)
			return true;
		else
			return false;	
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}



setOptionValue('pf','<%=pdata[0][0]%>');
setOptionValue('optpf','<%=pdata[0][1]%>');	
setOptionValue('ESI','<%=pdata[0][4]%>');
setOptionValue('optesi','<%=pdata[0][5]%>');
 pfchange();
pftypechange();
ESIchange();
esitypechange(); 
 </script>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>