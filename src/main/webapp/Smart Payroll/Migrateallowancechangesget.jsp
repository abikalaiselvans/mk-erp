<%@ page import="java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<title> :: PAYROLL ::</title>

<%
try
{
%>
 
 
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
		<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">

					<table width="700" height="33" border="0" align="center"
						  class="bolddeepblue">
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
						  <td height="29" valign="middle" class="BackGround"
								 >
								
								<p>
<%
	String ename= request.getParameter("ename");
	String Month= request.getParameter("Month");
	String Year= request.getParameter("Year");
	String sql="SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+ename+"'";
	String name =  CommonFunctions.QueryExecute(sql)[0][0];
	sql= "SELECT INT_SALARY FROM pay_t_salarybasic WHERE CHR_EMPID='"+ename+"' AND CHR_MONTH='"+Month+"'  AND INT_YEAR= "+Year;
	String Basic="0";
	if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		Basic =  CommonFunctions.QueryExecute(sql)[0][0];
	boolean aflag = true;
	boolean rflag = true;	
	
	//ALLOWANCE VALUES
	sql="SELECT CHR_ACODE,CHR_ANAME FROM pay_m_allowance  ORDER BY INT_ALLOWANCEID";
	String allowancedata[][]= CommonFunctions.QueryExecute(sql);
	String allowancecode="";
	String allowancename="";
	for(int u=0;u<allowancedata.length;u++)
	{
		allowancecode=allowancecode+allowancedata[u][0]+",";
		allowancename=allowancename+allowancedata[u][1]+",";
	}
	allowancecode = allowancecode.substring(0,allowancecode.length()-1);
	allowancename = allowancename.substring(0,allowancename.length()-1);
	 
	 sql= "SELECT "+allowancecode+"  FROM pay_t_salaryallowance WHERE CHR_EMPID='"+ename+"' AND CHR_MONTH='"+Month+"'  AND INT_YEAR= "+Year;
	 String salaryallowancedata[][]= CommonFunctions.QueryExecute(sql);
	
	//RECOVERY VALUES
	sql="SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery  ORDER BY INT_RECOVERYID";
	String recoverydata[][]= CommonFunctions.QueryExecute(sql);
	String recoverycode="";
	String recoveryname="";
	for(int u=0;u<recoverydata.length;u++)
	{
		recoverycode=recoverycode+recoverydata[u][0]+",";
		recoveryname=recoveryname+recoverydata[u][1]+",";
	}
	recoverycode = recoverycode.substring(0,recoverycode.length()-1);
	recoveryname = recoveryname.substring(0,recoveryname.length()-1);
	 
	 sql= "SELECT "+recoverycode+"  FROM pay_t_salaryrecovery WHERE CHR_EMPID='"+ename+"' AND CHR_MONTH='"+Month+"'  AND INT_YEAR= "+Year;
	String salaryrecoverydata[][]= CommonFunctions.QueryExecute(sql);

	String validname="basic,";
	
		
%>
						    </p>
								<table width="100%"  border="0" cellpadding="0" cellspacing="0">
                                   
                                  <tr>
                                    <td colspan="2"><table width="90%" border="0" align="center" cellpadding="1" cellspacing="2">
                                      <tr>
                                        <td colspan="2"><table width="270" border="0" align="center" cellpadding="1" cellspacing="2">
                                          <tr>
                                            <td><div align="left"><b>Name</b></div></td>
                                            <td><div align="left"><%=name%></div></td>
                                          </tr>
                                          <tr>
                                            <td><div align="left"><b>Emp id</b></div></td>
                                            <td><div align="left"><%=ename%>
                                             
                                            </div></td>
                                          </tr>
                                          <tr>
                                            <td><div align="left"><b>Basic </b></div></td>
                                            <td><div align="left">
											
<input name="empid" type="hidden" id="empid" value="<%=ename%>">
<input name="basic" type="text" class="formText135" id="basic" value="<%=Basic%>" size="9" maxlength="9" style="text-align:right" >
<input name="allowancelength" type="hidden" id="allowancelength" value="<%=allowancedata.length%>">
<input name="recoverylength" type="hidden" id="recoverylength" value="<%=recoverydata.length%>">
<input name="Month" type="hidden" id="Month" value="<%=Month%>">
<input name="Year" type="hidden" id="Year" value="<%=Year%>">

                                            <font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1">
                                            <input
										type="hidden" name="filename" value="MigrateWages" />
                                            <strong><font
										color="#000000"><font size="1">
                                            <input
										type="hidden" name="actionS" value="PAYMigrateWagesUpdate" />
                                            </font></font></strong></font></font></strong></font></font></strong></font></div></td>
                                          </tr>
                                        </table></td>
                                      </tr>
                                      <tr>
                                        <td valign="top"><div align="center">
			  <%
		out.println("<center><table width='90%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'><td colspan='3'class='boldEleven'><center><b> ALLOWANCES</b></center>");
		out.println("<tr class='MRow1'><td class='boldEleven' align='center'><b>S.No</td>");
		out.println("<td class='boldEleven' align='center'><b>Allowance Name</td>");
		out.println("<td class='boldEleven' align='center'><b>Amount</td>");
		out.println("</tr>");
		if(salaryallowancedata.length>0)
		{
			for(int u=0;u<allowancedata.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");	
				out.println(" <td align='left'>"+(u+1)+"</td>");
				out.println("<td class='boldEleven'  align='left'>"+allowancedata[u][1]+"</td>");
				out.println("<td class='boldEleven'  align='right'>");
				out.println("<input name='allowance"+(u+1)+"' type='text' class='formText135' id='allowance"+(u+1)+"'   onKeyPress=\"numericValue('allowance"+(u+1)+"','6')\" ");
				out.println("value='"+salaryallowancedata[0][u]+"' size='9' maxlength='9' style='text-align:right' ></td>");
				validname = validname+"allowance"+(u+1)+",";
			}
		}
		else
		{
			aflag = false;
			out.println("<tr class='MRow1'>");
			out.println("<td colspan='3' class='bolddeepred'>Allowance not found in "+Month +"/"+Year+"</td>");
			out.println("</tr>");
		}
		out.println("</table></center>");
		
		%>
                                        </div></td>
                                        <td valign="top"><div align="center">
		  <%
	out.println("<center><table width='90%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'><td colspan='3'class='boldEleven'><center><b> RECOVERY</b></center>");
	out.println("<tr class='MRow1'><td class='boldEleven' align='center'><b>S.No</td>");
	out.println("<td class='boldEleven' align='center'><b>Recovery Name</td>");
	out.println("<td class='boldEleven' align='center'><b>Amount</td>");
	out.println("</tr>");
	if(salaryrecoverydata.length >0)
	{
		for(int u=0;u<recoverydata.length;u++)
		{
			if(u%2==0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");	
			out.println(" <td align='left'>"+(u+1)+"</td>");
			out.println("<td class='boldEleven'  align='left'>"+recoverydata[u][1]+"</td>");
			out.println("<td class='boldEleven'  align='right'>");
			out.println("<input name='recovery"+(u+1)+"' type='text' class='formText135' id='recovery"+(u+1)+"'  onKeyPress=\"numericValue('recovery"+(u+1)+"','6')\" ");
			out.println("value='"+salaryrecoverydata[0][u]+"' size='9' maxlength='9' style='text-align:right' ></td>");
			validname = validname+"recovery"+(u+1)+",";
		}
	}
	else
	{
		rflag = false;
		out.println("<tr class='MRow1'>");
		out.println("<td colspan='3' class='bolddeepred'>Recovery not found in "+Month +"/"+Year+"</td>");
		out.println("</tr>");
	}
	out.println("</table></center>");
	%>
                                        </div></td>
                                      </tr>
                                    </table></td>
                                  </tr>
                                </table>								
								<table border="0" align="center" cellpadding="3" cellspacing="3">
                                  <tr>
                                    <td width="56">
                                    <%
									 if(aflag && rflag)
									 	out.println("<input name='Submit' type='submit' class='buttonbold14' value='Submit' accesskey='s'>");
									%>
                                    </td>
                                    <td width="56"><input name="Button" type="Button"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('Payrollmain.jsp')"></td>
                                  </tr>
                                </table>								</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>

		</td>
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

 function Validate()
  {
	var name="<%=validname%>";
	var textname= name.split(",");
	for( i=0; i<textname.length-1; i++)
	{
		
		var ck = "Enter Data...  ";
		if(checkNull(textname[i],ck)  )
			d=1;
		else
			return false;				
	}  	  
  }
  


</script>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
