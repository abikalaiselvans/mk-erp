<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<%
try
{

%>
    <html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>

<script language="javascript">
function validate()
{
    if(checkNull("ename","Select Staff"))
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

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<!-- onLoad="init()"-->

</head>

<body  onpaste="return false;">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="allowance" action="../SmartLoginAuth" onSubmit="return validate()">
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
		<table width="564" border="0" align="center" cellpadding="0"
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
					<td width="545" valign="top">
					<table width="549" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="2">
							<div align="right"><span class="boldEleven">* </span><span
								class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center">
							
							
<%
	String staffid = ""+request.getParameter("ename");
	String  flag = ""+request.getParameter("flag");
	String name = CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME  FROM com_m_staff WHERE CHR_EMPID='"+staffid+"'")[0][0];
	out.println("Employee Id :"+staffid + "/ Name : "+ name);
%>

<input name="staffid" type="hidden" id="staffid" value="<%=staffid%>">
<input name="ename" type="hidden" id="ename" value="<%=staffid%>">
<input name="flag" type="hidden" id="flag" value="<%=flag%>">

							</div>
							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td height="19" class="boldEleven">
							<div align="right">Effective Date</div>
							</td>
							<td><input name="effectdt" type="text" class="formText135"
								id="effectdt" size="15" readonly /> <a
								href="javascript:cal1.popup();"> <img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" /> </a> <script language='JavaScript'
								type="text/javascript">
						<!--			
							var cal1 = new calendar1(document.forms['allowance'].elements['effectdt']);
							cal1.year_scroll = true;
							cal1.time_comp = false;
							setCurrentDate('effectdt'); 
						//-->
                       </script></td>
						</tr>
						<tr>
							<td width="49%" height="19">&nbsp;</td>
							<td width="51%">&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">

							<div align="center">
							  <%
				  	Connection con1 ;
					PreparedStatement pstm;
					ResultSet rst;
					con1 = conbean.getConnection();
					String query = "Select count(*) from pay_m_allowance";
					pstm = con1.prepareStatement(query);
					rst = pstm.executeQuery();
					String txtname="";
					String ts="";
					int rcount=0;
					int u=0;
					if(rst.next())
						rcount =rst.getInt(1);
					
					if(rcount > 0)
					{	
						out.println("<table   align='center'  class='TableDesign'  cellpadding='2' cellspacing='2'><tr>");
						out.println("<td colspan='2'   class='whiteMedium'><div align='center'>Allowance</div></td>");
						out.println("</tr>");
						out.println(" <tr class='MRow1'>");
						query = "Select CHR_ACODE,CHR_ANAME from pay_m_allowance ORDER BY INT_ALLOWANCEID";
						pstm = con1.prepareStatement(query);
						rst = pstm.executeQuery();
						String fun1="";
						u=1;
						while(rst.next())
						{
							ts=rst.getString(1);
							txtname=rst.getString(2);
							if(u%2==0)
								out.println("<tr  class='MRow1'> ");
							else
								out.println("<tr  class='MRow2'> ");
							
							out.println(" <td class='boldEleven' align='left' >"+txtname+"</td>");
							fun1= "onkeypress="+"\"numericValue('"+ts+"', '7')\"";
							out.println("<td ><input class='formText135' value=0 type='text' name='"+ts+"'  id='"+ts+"' "+fun1+" maxlength='7'></td>" );
							u++;
							out.println("</tr>"); 
						}
						out.println("</table>");
					}	
				%>
							</div>
							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center">
							  <%
				  
				  	query = "Select count(*) from pay_m_recovery";
					pstm = con1.prepareStatement(query);
					rst = pstm.executeQuery();
					txtname="";
					
					rcount=0;
					if(rst.next())
						rcount =rst.getInt(1);
					
					if(rcount >0 )
					{	
						out.println("<table align='center' cellpadding='2' cellspacing='2' class='TableDesign'  ><tr>");
						out.println("<td colspan='2'  class='whiteMedium'><div align='center'>Recovery</div></td>");
						out.println("</tr>");
						out.println(" <tr class='MRow1'>");
						query = "Select  CHR_RCODE,CHR_RNAME from pay_m_recovery order by INT_RECOVERYID";
						pstm = con1.prepareStatement(query);
						rst = pstm.executeQuery();
						String fun2="";
						u=1;
						while(rst.next())
						{
							ts=rst.getString(1);
							txtname=rst.getString(2);
							if(u%2==0)
								out.println("<tr  class='MRow1'> ");
							else
								out.println("<tr  class='MRow2'> ");
							fun2 = "onKeyPress="+"\"numericValue('"+ts+"', '7')\"" ;
							out.println(" <td class='boldEleven'  align='left'>"+txtname+"</td>");
							out.println("<td><input class='formText135' value=0 type='text' name='"+ts+"' "+fun2+" maxlength='7'></td>" );
							out.println("</tr>");
							u++;
						}
						out.println("</table>");
					}	
				  %>
							</div>
							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
							<td><input name="filename" type="hidden" id="filename"
								value="StaffAllowanceRecovery" /> <input name="actionS"
								type="hidden" id="actionS" value="PAYStaffAllowanceRecoveryAddManual" /></td>
						</tr>
						<tr align='center'>
							<td colspan="2" align='center'>
							<table align='center' border="0" width="400">
								<tr>
									<td>

									<div id="disp" style="OVERFLOW:auto; width:400px; height:95px;">

									<%
					String id = request.getParameter("ID");	
					if (!(id==null || id==""))
					{
						out.print("<table width='400' border='3' cellspacing='2' cellpadding='2' bordercolor='#EEEAFE'>");
						out.print("<tr  class='MRow2'>");
						out.print("<td colspan='5' class='boldEleven'><font color='red'><b>The following Person Allowance & Recovery Already Avilable....</b></font></td>");
						out.print("<tr  class='MRow1'>");
						out.print("<td class='boldEleven'>&nbsp;<b>ID</b></td> <td><b>Name</b></td></td>");
						out.print("<tr  class='MRow2'>");
						out.print("<td class='boldEleven'>&nbsp;"+request.getParameter("ID")+"</td>");
						out.print("<td class='boldEleven'>&nbsp;"+request.getParameter("Name")+"</td>");
						out.print("</tr></table>");
						
					}
			%>
									</div>

									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="ButtonHead" value="Submit"   accesskey="s"    /></td>
									<td width="56"><input type="hidden" name="submit"
										class="ButtonHead"  value="Close"   accesskey="c" 
										 /></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="5"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="2"><spacer height="1" width="1"
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
<%@ include file="../footer.jsp"%></form>
</body>

</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>