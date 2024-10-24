<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<%@ page import="com.my.org.erp.common.CommonInfo"%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">

function list()
  {   
     if(checkNull("ename","Select Staff"))
	 {
        return true;
     }
     else
     {
     	return false;
     }     
   }
function mainPage()
	{
	    document.allow.action="Payrollmain.jsp";
		document.allow.submit();
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
-->
</style>
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="allowance" action="../SmartLoginAuth"
	onSubmit="return validate()">
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
					<table width="549" border="0" cellspacing="2" cellpadding="0">
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
							<%
				  	String staffid = ""+request.getParameter("staffid");
					out.print("<input type='hidden' value='"+staffid+"' name='staffid'>");
				  	String sql="";
				  	sql =" SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,E.CHR_COMPANYNAME,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME 	from  com_m_staff  A, com_m_branch  B,  com_m_depart   C, com_m_desig  D,  com_m_company  E where A.INT_BRANCHID=B.INT_BRANCHID	AND A.INT_COMPANYID =  E.INT_COMPANYID 	AND A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_DESIGID=D.INT_DESIGID AND a.CHR_EMPID ='"+staffid+"'";
					String Datas[][] = CommonInfo.RecordSetArray(sql);
						
				  %>
							</td>
						</tr>

						<tr>
							<td height="19" colspan="2">
							<table width="494" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="129" class="bold">Staff id</td>
									<td width="17" class="boldthikass">
									<div align="center"><strong>:</strong></div>
									</td>
									<td width="338" class="bold"><%=Datas[0][0]%></td>
								</tr>
								<tr>
									<td class="bold">Staff Name</td>
									<td class="boldthikass">
									<div align="center"><strong>:</strong></div>
									</td>
									<td class="bold"><%=Datas[0][1]%></td>
								</tr>
								<tr>
									<td class="bold">Company Name</td>
									<td class="boldthikass">
									<div align="center"><strong>:</strong></div>
									</td>
									<td class="bold"><%=Datas[0][2]%></td>
								</tr>
								<tr>
									<td class="bold">Branch Name</td>
									<td class="boldthikass">
									<div align="center"><strong>:</strong></div>
									</td>
									<td class="bold"><%=Datas[0][3]%></td>
								</tr>
								<tr>
									<td class="bold">Department Name</td>
									<td class="boldthikass">
									<div align="center"><strong>:</strong></div>
									</td>
									<td class="bold"><%=Datas[0][4]%></td>
								</tr>
								<tr>
									<td class="bold">Designation Name</td>
									<td class="boldthikass">
									<div align="center"><strong>:</strong></div>
									</td>
									<td class="bold"><%=Datas[0][5]%></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="right" class="boldElevenlink">* All fields
							should be in numeric format</div>
							</td>
						</tr>
						<tr>
							<td width="49%" height="19">
							<div align="right"><span class="boldEleven">Increment
							&nbsp;&nbsp;&nbsp;&nbsp;</span></div>
							</td>
							<td width="51%">
							<%

	String Q =" SELECT INT_INCREMENT from  pay_t_rivision where INT_RIVISIONID = ( SELECT max(INT_RIVISIONID) from  pay_t_rivision where CHR_EMPID='"+staffid+"') and  CHR_EMPID='"+staffid+"'";
	
	String incdata[][] = CommonInfo.RecordSetArray(Q);
%> <input name="increment" value="<%=incdata[0][0]%>"
								onKeyPress="numericValue('increment','6')" type="text"
								class="formText135" id="increment" maxlength="5"></td>
						</tr>
						<tr>
							<td height="19" colspan="2">

							<div align="center">
							<table width="268" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#FFFF00">
								<tr>
									<td width="321">
									<div align="center" o>
									<%
						String val="";
						String all ="Alowance";
						String sv ="";
						String sv1 ="";
				  		String query = "Select CHR_ACODE,CHR_ANAME from pay_m_allowance order by CHR_ACODE";
						String datas[][] = CommonInfo.RecordSetArray(query);
						String fields="";
						for(int u=0; u<datas.length; u++)
							fields = fields+datas[u][0]+",";
						String Recdatas[][] = CommonInfo.RecordSetArray("Select CHR_RCODE,CHR_RNAME from pay_m_recovery order by CHR_RCODE");
						for(int u=0; u<Recdatas.length; u++)
							fields = fields+Recdatas[u][0]+",";
						fields = fields.substring(0, fields.trim().length()-1);
						String rivisionDatas[][] = CommonInfo.RecordSetArray(" SELECT " +fields +" FROM pay_t_rivision WHERE CHR_EMPID='"+staffid+"' AND INT_RIVISIONID="+Integer.parseInt(request.getParameter("maxid")));
						out.print("<input type='hidden' name='maxid' value='"+request.getParameter("maxid")+"'>");
						out.println("<table width='300'  align=1center1 cellpadding='2' cellspacing='2'><tr>");
						out.println("<td colspan='2' bgcolor='#202B78' class='tablehead'><div align='center'>Allowance</div></td>");
						out.println("</tr>");
						out.println(" <tr>");
						
						for(int u=0; u<datas.length; u++)
						{
							out.println("<tr><td class='boldEleven' width=119>"+datas[u][1]);
							sv ="onKeyPress=\"numericValue('"+(all+(u+1))+"','6')\"";
							sv1 = " onBlur=\"checkFloat('"+(all+(u+1))+"','6')\"";

							if (rivisionDatas[0][u].equals("0"))
								val="";
							else
								val=rivisionDatas[0][u];
							
							out.println("<td><input  value='"+val+"' class='formText135' type='text' name='"+(all+(u+1))+"' id='"+(all+(u+1))+"' maxlength='4' "+sv+" />" );
							out.println("<input  type='hidden' name='Aname"+(u+1)+"' value='"+datas[u][0]+ "' />" );
						}
						out.println("</table>");
						out.println("<input type='hidden' name='allowancelength' value='"+datas.length+"' />");
					%>
									</div>
									</td>
								</tr>
							</table>
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
							<table width="268" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#FFFF00">
								<tr>
									<td>
									<div align="center">
									<%

                  		String rec ="Recovery";
			  			query = "Select CHR_RCODE,CHR_RNAME from pay_m_recovery order by CHR_RCODE";
						String datas1[][] = CommonInfo.RecordSetArray(query);
						out.println("<table width='300'  align=1center1 cellpadding='2' cellspacing='2'><tr>");
						out.println("<td colspan='2' bgcolor='#202B78' class='tablehead'><div align='center'>Recovery</div></td>");
						out.println("</tr>");
						out.println(" <tr>");
						int rivisionid=datas.length; 
						
						for(int u=0; u<datas1.length; u++)
						{
							out.println("<tr><td class='boldEleven' width=119>"+datas1[u][1]);
							sv ="onKeyPress=\"numericValue('"+(rec+(u+1))+"','6')\"";
							
							if (rivisionDatas[0][rivisionid].equals("0"))
								val="0";
							else
								val=rivisionDatas[0][rivisionid];
							
							
							out.println("<td><input  value='"+val+"' class='formText135' type='text' name='"+(rec+(u+1))+"' id='"+(rec+(u+1))+"' id='"+(rec+(u+1))+"' maxlength='4' "+sv+" />" );
							rivisionid=rivisionid+1;
							
							
							
							out.println("<input type='hidden' name='Rname"+(u+1)+"' value='"+datas1[u][0]+"' />" );
						}
						out.println("</table>");
						out.println("<input type='hidden' name='recoverylength' value='"+datas1.length+"' />");
				  %>
									</div>
									</td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
							<td><input name="filename" type="hidden" id="filename"
								value="StaffAllowanceRecovery" /> <input name="actionS"
								type="hidden" id="actionS"
								value="PAYAllowanceRecoveryRivisionUpdate" /></td>
						</tr>
						<tr>
							<td height="19" colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Submit"   accesskey="s"    /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('Rivision.jsp')" /></td>
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
<%@ include file="../footer.jsp"%> <script
	language="javascript">
function validate()
{
    var l1 = "<%=datas.length%>";
	var l2 = "<%=datas.length%>";
	var s = "staffid,";
	for(i=1;i<=parseInt(l1);i++)
		s = s+"Alowance"+i+",";
	for(i=1;i<=parseInt(l2);i++)
		s = s+"Recovery"+i+",";
	var v = s.split(",");
   	var flag =false;
	for( i=0; i<v.length-1; i++)
	{
		var chk =document.getElementById(v[i]).value;
		var ck = "Enter Data..."+v[i];
		if(checkNull(v[i],ck))
		{
		d=1;
		}
		else
		{
				return false;				
		}	
	}
}
</script></form>
</body>

</html>
