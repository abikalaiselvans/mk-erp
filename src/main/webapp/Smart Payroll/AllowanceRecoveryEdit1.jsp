<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<%
try
{
%>

<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
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

function closed()
{
	history.back(1);
  	window.close();
 } 	
  
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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<%
try
{
	Connection con ;
	Statement st=null; 
	ResultSet rs;
	ResultSet rsMenu;
%>
<form  AUTOCOMPLETE = "off"   name="allowance" method="post" action="../SmartLoginAuth">
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
		
        <%
				   String staff =""+request.getParameter("staffid");
                   staff = staff.trim();
                   boolean aflag =StaffRegistration.allowanceRecordExist(staff.trim()) ;
				   boolean rflag =StaffRegistration.recoveryRecordExist(staff.trim()) ;
				    
				    
				if((aflag==false) && (rflag ==false))
				{
					out.println("<center><br><br><br><br>");
					out.println("<font class='bolddeepred'>Allowance not allocated</font><br><br><br>");	
					out.println("<input type='button' name='submit' class='ButtonHead' value='Close' onClick='closed()' />");
					out.println("</center>");
				}
				else
				{	   
					    
        %>
                   
        
        <table width="564" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../SmartGovernment/Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../SmartGovernment/Image/General/TRCorner.gif" width="7" /></td>
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
							<td height="19" colspan="2" class="boldEleven">
							<div align="center">Staff id : <%=staff%> <input
								name="staffid" type="hidden" id="staffid" value="<%=staff%>">
							<input name="staffid" type="hidden" id="staffid" value="staffid">
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
								id="effectdt" size="15" readonly onKeyPress="dateOnly(this)" /> <a
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
					ResultSetMetaData rsmd;
					String query = "";
					query = "Select count(*) from pay_m_allowance";
					pstm = con1.prepareStatement(query);
					rst = pstm.executeQuery();
					String txtname="";
					String txtfield="";
					int rcount=0;
					if(rst.next())
						rcount =rst.getInt(1);
					////System.out.println("ooooooooo"+rcount);
					
					
					

					query = "Select * from pay_t_allowance WHERE CHR_EMPID = '"+staff+"'  ";
					
					pstm = con1.prepareStatement(query);
					rst = pstm.executeQuery();
					rsmd = rst.getMetaData();
					String s="";
					int u=0;
					String x ="";				
					if (aflag)
					if(rst.next())
					{	
						for(int i=1; i<=rsmd.getColumnCount();i++) {
							x = ""+rst.getString(i);
							if (x.equals("0") || "null".equals(x))
								x = "0";
						s = s +x+" ~ ";
						}
					}
					else
						s = s +"0~0~0~0~0~0~0~0~0~0~0~0~0~0~0~" ;					
					String asval[] = s.split("~");
					//-------------
					if(rcount > 0)
					{	
						out.println("<table   align='center'  cellpadding='2' cellspacing='2'  class='TableDesign'  ><tr>");
						out.println("<td colspan='2'  class='whiteMedium'><div align='center'>Allowance</div></td>");
						out.println("</tr>");
						out.println(" <tr class='MRow1'>");
						query = "Select  CHR_ACODE,CHR_ANAME  from pay_m_allowance  order by INT_ALLOWANCEID";
						pstm = con1.prepareStatement(query);
						rst = pstm.executeQuery();
						u=1;
						String fun1="";
						while(rst.next())
						{
							
							txtfield=rst.getString("CHR_ACODE");
							txtname=rst.getString("CHR_ANAME");
							if(u%2==0)
								out.println("<tr  class='MRow1'> ");
							else
								out.println("<tr  class='MRow2'> ");
							out.println(" <td class='boldEleven' align='left'>"+txtname+"</td>");
							
							fun1 = "onKeyPress="+"\"return numeric_only(event,'"+txtfield+"','7')\"";
							 
							out.println("<td width='80' align='left'><input value='"+asval[u].trim()+"' class='formText135' maxlength='6' type='text' "+ fun1 +" name='"+txtfield+"'  id='"+txtfield+"'></td>" );
							out.println("</tr>");
							u =u+1;
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
					////System.out.println("Recovery" +rcount);
					
					
					//-------------------------
					query = "Select * from pay_t_recovery WHERE CHR_EMPID = '"+staff+"' ";
					pstm = con1.prepareStatement(query);
					rst = pstm.executeQuery();
					rsmd = rst.getMetaData();
					 s="";
					 u=1;
					 if (rflag)
							if(rst.next())
							{	
								for(int i=1; i<=rsmd.getColumnCount();i++) {
									x = ""+rst.getString(i);
									if (x.equals("0") || "null".equals(x))
										x="0";
									s = s + x +" ~ ";
								}
							}
						else
							s = s +"0~0~0~0~0~0~0~0~0~0~0~0~0~0~0~" ;					
					String rsval[] = s.split("~");
					//---------------------------
					
					if(rcount >0 )
					{	
						out.println("<table   align='center' cellpadding='2' cellspacing='2'   class='TableDesign' ><tr>");
						out.println("<td colspan='2' maxlength='7' class='whiteMedium'><div align='center'>Recovery</div></td>");
						out.println("</tr>");
						 
						query = "Select  CHR_RCODE,CHR_RNAME  from pay_m_recovery order by INT_RECOVERYID";
						pstm = con1.prepareStatement(query);
						rst = pstm.executeQuery();
						u=1;
						String fun2="";
						while(rst.next())
						{
							txtfield=rst.getString(1);
							txtname=rst.getString(2);
                            if(u%2==0)
								out.println("<tr  class='MRow1'> ");
							else
								out.println("<tr  class='MRow2'> ");
							
							fun2 = "onKeyPress="+"\"return numeric_only(event,'"+txtfield+"','7')\"";
							 
							out.println("<td class='boldEleven' align='left'>"+txtname+"</td>");
						out.println("<td width='80' align='left'><input value='"+rsval[u].trim()+"' class='formText135' type='text' "+fun2+" maxlength='6' name='"+txtfield.trim()+"'  id='"+txtfield.trim()+"'></td>" );
							u = u+1;
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
							<td><input name="filename" type="hidden" id="filename"
								value="StaffAllowanceRecovery" /> <input name="actionS"
								type="hidden" id="actionS"
								value="PAYStaffAllowanceRecoveryUpdate" /></td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="ButtonHead" value="Update" /></td>
									<td width="56"><input type="button" name="submit"
										class="ButtonHead"  value="Close"   accesskey="c"  onClick="closed()" /></td>
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
						src="../SmartGovernment/Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block"></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../SmartGovernment/Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>

			</tbody>
		</table>
        
        <%
				}
		%>
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
<%
}
catch(Exception e)
{
}
%>
</body>

</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
