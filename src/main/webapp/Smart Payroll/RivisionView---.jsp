<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/Payroll/PayrollAjax.js"></script>
<script language="javascript">
function disable()
{
    document.getElementById('Edit').disabled=true; 
	document.getElementById('Delete').disabled=true;
}


function validate()
{
    if(checkNull("ename","Select Staff"))
    	return true;
    else
    	return false;
}
	
function RAdd()
{		
	document.allowancefrm.action="AllowanceRecoveryRivisionAdd.jsp";
	document.allowancefrm.submit();
}	
function RDelete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].staffid
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].staffid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.allowancefrm.action="../SmartLoginAuth";
				document.allowancefrm.submit();
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
	 	
	function mainPage()
	{
	    document.allowancefrm.action="Payrollmain.jsp";
		document.allowancefrm.submit();
		return true;
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

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style3 {
	COLOR: #000000;
	LINE-HEIGHT: 15px;
	FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif;
	TEXT-DECORATION: none;
	font-size: 10px;
	font-weight: bold;
}
-->
</style>
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="allowancefrm">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="3" cellpadding="2">
			<tr>
				<td>
				<table width="800" align="center" border="1" cellspacing="1"
					cellpadding="1"  >
					<!--DWLayoutTable-->
					<tr align="center" valign="middle">
						<td class="boldgre"   >
						<div align="center" class="bold1">
						<div align="center">Rivision</div>

						<%
		
			String mth = com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(""+request.getParameter("Month")));
            String yr = request.getParameter("Year");
		%>
						</div>
						</td>
					</tr>
					<tr align="center" valign="middle">
						<td height="31" class="boldgre"
							  >
						<table width="28%" border="0" align="center" cellpadding="1"
							cellspacing="1" class="boldEleven">
							<tr>
								<td class="boldThirteen">Month ::</td>
								<td><span class="boldThirteen"><%=mth%></span></td>
								<td><span class="boldThirteen">Year ::</span></td>
								<td><span class="boldThirteen"><%=yr%></span></td>
							</tr>
						</table>
						</td>
					</tr>

					<tr>
						<td height="23"   >
						<table width="893" border="0">
							<tr>
								<td width="110"><strong class="bold1">Staff Id</strong></td>
								<td width="150"><strong class="bold1">Name</strong></td>
								<td width="100"><strong class="bold1">Revision Id
								</strong></td>
								<td width="100"><strong class="bold1">Basic</strong></td>
								<td width="100"><strong class="bold1">Increment</strong></td>
							</tr>



						</table>
						</td>
					</tr>
					<tr>
						<td height="23">
						<div id="rivTable" style="OVERFLOW:auto;width:900px;height:170px">

						<%
           
           	String id = request.getParameter("staffid");
//            String mth = com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(""+request.getParameter("Month")));
//            String yr = request.getParameter("Year");
            
	String sql = "SELECT A.CHR_EMPID, A.CHR_STAFFNAME, B.INT_RIVISIONID, B.INT_BASIC, B.INT_INCREMENT from  com_m_staff  A, pay_t_rivision B ";
	sql=sql+ " where A.CHR_EMPID=B.CHR_EMPID AND B.CHR_EMPID='"+id+"'";
	sql=sql+ " AND B.CHR_MONTH='"+mth+"' AND B.INT_YEAR="+yr;
			//System.out.println(sql);
			String Datas[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

			str="";
			str=str+"<table width='900' border='0' class='boldEleven' cellpadding='2' cellspacing='2'>";

			for (int i=0; i<Datas.length; i++)
			{
		    	if(i%2==1)
		    		str=str+"<tr class='MRow2'>";
				else
					str=str+"<tr  class='MRow1'>";		
				
		    	str=str+"<td height='30' width='130' class='boldEleven'><input type='checkbox' name='staffid' value='"+Datas[i][0]+"'>&nbsp;"+Datas[i][0];
		    	if (Datas.length==(i+1))
			    	str=str+"<td width='180' class='boldEleven'>&nbsp;<a href='RivisionEdit.jsp?staffid="+Datas[i][0]+"&maxid="+Datas[i][2]+"'>"+Datas[i][1]+"</a>";
		    	else
		    		str=str+"<td width='180' class='boldEleven'>&nbsp;"+Datas[i][1];	

		    	str=str+"<td width='150' class='boldEleven' align='center'>"+Datas[i][2];
		    	str=str+"<td width='150' class='boldEleven'>&nbsp;"+Datas[i][3];
		    	str=str+"<td width='150' class='boldEleven'>&nbsp;"+Datas[i][4];
		    	str=str+"</td></tr>";
			}

		str=str+"</table>";
		
		     	out.println(str);

           %>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="900" border="0" align="center" cellpadding="2"
					cellspacing="2"  >
					<tr class="boldEleven">
						<td>
						<div align="center"><a href="javascript:loadRivision('0')">All</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('A')">A</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('B')">B</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('C')">C</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('D')">D</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('E')">E</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('F')">F</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('G')">G</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('H')">H</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('I')">I</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('J')">J</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('K')">K</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('L')">L</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('M')">M</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('N')">N</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('O')">O</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('P')">P</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('Q')">Q</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('R')">R</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('S')">S</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('T')">T</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('U')">U</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('V')">V</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('W')">W</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('X')">X</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('Y')">Y</a>
						</div>
						</td>
						<td>
						<div align="center"><a href="javascript:loadRivision('Z')">Z</a>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table border="0" align="center" cellpadding="2" cellspacing="2">
					<tr>
						<td width="56"><input class="buttonbold14" name="button"
							type="submit"  value="Add"   accesskey="s"   onClick="RAdd()"></td>
						<td width="56"><input name="Delete" type="Button"
							class="buttonbold14" id="Delete" value="Delete"
							onClick="RDelete()"></td>
						<td width="56"><input class="buttonbold14" type="button"
							name="Button"  value="Close"   accesskey="c"  onClick="redirect('Rivision.jsp')"></td>
						<td width="56"><input name="Edit" type="hidden"
							class="buttonbold" id="Edit" value="Edit" onClick="REdit()">
						</td>

					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td><input name="filename" type="hidden" id="filename"
					value="StaffAllowanceRecovery"> <input name="actionS"
					type="hidden" id="actionS" value="PAYRivisionDelete"></td>
			</tr>
		</table>

		<%@ include file="../footer.jsp"%>
		</form>
</body>

</html>
