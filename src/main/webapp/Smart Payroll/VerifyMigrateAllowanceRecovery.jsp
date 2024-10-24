<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

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

</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	 >

<%@ include file="index.jsp"%>
<!--PaySlipView.jsp-->
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" 	onSubmit="return Validate()">

<table width="100%" height="412" border="0" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="31">&nbsp;</td>
	</tr>
	<tr>
		<td>
		
		<%
		try
		{
			//ALLOWANCE VALUES
			String sql="SELECT CHR_ACODE,CHR_ANAME FROM pay_m_allowance  ORDER BY INT_ALLOWANCEID";
			String allowancedata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			String allowancecode="";
			String allowancename="";
			for(int u=0;u<allowancedata.length;u++)
			{
				allowancecode=allowancecode+"c."+allowancedata[u][0]+", ";
				allowancename=allowancename+allowancedata[u][1]+", ";
			}
			//allowancecode = allowancecode.substring(0,allowancecode.length()-1);
			//allowancename = allowancename.substring(0,allowancename.length()-1);
			
			//RECOVERY VALUES
			sql="SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery  ORDER BY INT_RECOVERYID";
			String recoverydata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			String recoverycode="";
			String recoveryname="";
			for(int u=0;u<recoverydata.length;u++)
			{
				recoverycode=recoverycode+"d."+recoverydata[u][0]+",";
				recoveryname=recoveryname+recoverydata[u][1]+",";
			}
			recoverycode = recoverycode.substring(0,recoverycode.length()-1);
			recoveryname = recoveryname.substring(0,recoveryname.length()-1);
						 
			 sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,b.INT_SALARY , "+allowancecode+recoverycode ;
			sql = sql + " FROM com_m_staff a, pay_t_salarybasic b,pay_t_salaryallowance c,pay_t_salaryrecovery d  ";
			sql = sql + " WHERE a.CHR_EMPID=b.CHR_EMPID ";
			sql = sql + " AND  a.CHR_EMPID=c.CHR_EMPID ";
			sql = sql + " AND  a.CHR_EMPID=d.CHR_EMPID ";
			sql = sql + " AND b.CHR_MONTH='October' ";
			sql = sql + " AND b.INT_YEAR= 2008  ";
			sql = sql + " AND c.CHR_MONTH='October' ";
			sql = sql + " AND c.INT_YEAR= 2008  ";
			sql = sql + " AND d.CHR_MONTH='October' ";
			sql = sql + " AND d.INT_YEAR= 2008  ";
			sql = sql + " AND a.CHR_TYPE !='Y' AND a.CHR_HOLD!='Y' ";
			sql = sql + " ORDER BY a.CHR_STAFFNAME ";
			out.println(sql);
		}
		catch(Exception e)
		{
		}
		
		%></td>
	</tr>
	<tr>
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
		<td height="37">&nbsp;</td>
	</tr>
</table>
</form>
<script language="javascript">

 /*function Validate()
  {
	var name="";
	var textname= name.split(",");
	for( i=0; i<textname.length-1; i++)
	{
		
		var ck = "Enter Data...  ";
		if(checkNull(textname[i],ck)  )
			d=1;
		else
			return false;				
	}  	  
  }*/
  


</script>
<%@ include file="../footer.jsp"%>
</body>
</html>
