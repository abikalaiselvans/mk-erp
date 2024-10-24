<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%!
	String userState,userDis,userCons,userName,userPass,userType,userLive,add,edit,delete;
	String sql="";
%>
<html>
<head>

<title> :: UTILITY :: </title>

<%@include file="Redirect.jsp" %>
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
@import url("../JavaScript/SmartStyles.css");
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
</head>
<body  onpaste='return false;'>
<form name="frm" method="get" action="UserEditAction.jsp">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 
	<tr>
		<td height="100">
		<%
    		try{
    			
    		
    		userName=request.getParameter("loginName");				  	
   			Connection con=conbean.getConnection();
	 		Statement st=con.createStatement();  
			String sessiontime = "10";
			sql="SELECT (decode(CHR_USRPWD,'9865043008')),CHR_TYPE,CHR_LIVE,CHR_ADD,CHR_EDIT,CHR_DELETE,ROUND((INT_SESSIONTIME/60),0) FROM m_user  WHERE CHR_USRNAME='"+userName+"'";	 	
			ResultSet rs=st.executeQuery(sql);
			if(rs.next()){

				userPass=rs.getString(1);
				userType=rs.getString(2);
				userLive=rs.getString(3);
				add=rs.getString(4);
				edit=rs.getString(5);
				delete=rs.getString(6);
				sessiontime=rs.getString(7);
				
			}
			else
			{			
				userPass="";
				userType="";
				userLive="";
				add="N";
				edit="N";
				delete="N";
				sessiontime="10";
			}    		
    %>
		</td>
	</tr>
	<tr align="center">
		<td align="center">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="400"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table width="500" border="0" align="center"
						cellpadding="2" cellspacing="3"  >
						<tr>
							<td colspan="3" align="center" class="copyright">User Edit</td>
						</tr>
						<tr>
							<td width="131" class="boldEleven">User Name</td>
							<td colspan="2" class="boldEleven"><%=userName %> <input
								type="hidden" name="userName" value="<%=userName %>"></td>
						</tr>
						<tr>
							<td class="boldEleven">Password</td>
							<td width="114" class="boldEleven"><%=userPass %></td>
							<td width="231" class="boldEleven"><a
								href='../SmartLoginAuth?filename=PasswordReSet&actionS=UTIPasswordReset&userid=<%=userName %>'>Reset</a></td>
						</tr>
						<tr>
						  <td class="boldEleven">Chanage Password </td>
						  <td colspan="2" class="boldEleven"><input name="changepassword" type="text" class="formText135" id="changepassword" value="<%=userPass %>" maxlength="12"></td>
					  </tr>
						<tr>
							<td class="boldEleven">User Type 
						    <%
		  String Fchk="";
		  String Bchk="";
		  String Achk="";
		  String Schk="";
		   
		  	if("F".equals(userType ))
		  		Fchk = " checked='checked' ";
			else if("B".equals(userType ))
		  		Bchk = " checked='checked' ";
			else if("A".equals(userType ))
		  		Achk = " checked='checked' ";
			else if("S".equals(userType ))
		  		Schk = " checked='checked' ";
			
				
				
		  %></td>
							<td colspan="2" class="boldEleven">
							<table width="350" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="6%"><input name="grade" type="radio" value="F" <%=Fchk%> /></td>
									<td width="21%" class="boldEleven">Super Admin</td>
									<td width="6%" class="boldEleven"><input name="grade" type="radio" value="B" <%=Bchk%> /></td>
									<td width="25%" class="boldEleven">Branch Admin</td>
									<td width="6%" class="boldEleven"><input name="grade" type="radio" value="A" <%=Achk%> /></td>
									<td width="11%" class="boldEleven">Admin</span></td>
									<td width="6%" class="boldEleven"><input name="grade" type="radio" value="S" <%=Schk%> /></td>
									<td width="19%" class="boldEleven">Employee</span></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
						  <td class="boldEleven">Session Time</td>
						  <td colspan="2" class="boldEleven">
                          <select name="sessiontime" class="formText135"  id="sessiontime">
                          <%
						  for(int u=10; u<150; u++)
						  	out.println("<option value='"+u+"'>"+(u)+" - Minutes</option>");
						  %>
                          </select> 
                          <script language="javascript">setOptionValue('sessiontime','<%=sessiontime%>')</script>                          </td>
					  </tr>
						<tr>
						  <td class="boldEleven">Active
                          <%
		  String achk="";
		  String ochk="";
		  
		  if("Y".equals(userLive ))
		  		achk = " checked='checked' ";
		
		  if("N".equals(userLive ))
		  		ochk = " checked='checked' ";
				
		  %></td>
						  <td colspan="2" class="boldEleven"><table width="79" border="0" cellspacing="0" cellpadding="0">
						    <tr>
						      <td width="20"><input name="Live" type="radio" value="Y" <%=achk%> /></td>
						      <td width="22" class="boldEleven">Yes</span></td>
						      <td width="20" class="boldEleven"><input name="Live" type="radio"
										value="N" <%=ochk%> /></td>
						      <td width="17" class="boldEleven">No</span></td>
					        </tr>
					      </table></td>
					  </tr>
						<tr>
						  <td class="boldEleven">Add
					      <%
		  achk="";
		  ochk="";
		  
		  if("Y".equals(add ))
		  		achk = " checked='checked' ";
		
		  if("N".equals(add ))
		  		ochk = " checked='checked' ";
				
		  %></td>
						  <td colspan="2" class="boldEleven"><table width="77" border="0" cellspacing="0" cellpadding="0">
						    <tr>
						      <td width="20"><input name="add" type="radio" value="Y" <%=achk%> /></td>
						      <td width="20" class="boldEleven">Yes</span></td>
						      <td width="20" class="boldEleven"><input name="add" type="radio"
										value="N" <%=ochk%> /></td>
						      <td width="40" class="boldEleven">No</span></td>
					        </tr>
					      </table></td>
					  </tr>
						<tr>
						  <td class="boldEleven">Edit
					      <%
		  achk="";
		  ochk="";
		  
		  if("Y".equals(edit ))
		  		achk = " checked='checked' ";
		
		  if("N".equals(edit ))
		  		ochk = " checked='checked' ";
				
		  %></td>
						  <td colspan="2" class="boldEleven"><table width="76" border="0" cellspacing="0" cellpadding="0">
						    <tr>
						      <td width="20"><input name="edit" type="radio" value="Y" <%=achk%> /></td>
						      <td width="20" class="boldEleven">Yes</span></td>
						      <td width="20" class="boldEleven"><input name="edit" type="radio"
										value="N" <%=ochk%> /></td>
						      <td width="40" class="boldEleven">No</span></td>
					        </tr>
					      </table></td>
					  </tr>
						<tr>
							<td class="boldEleven">Delete
						    <%
		  achk="";
		  ochk="";
		  
		  if("Y".equals(delete ))
		  		achk = " checked='checked' ";
		
		  if("N".equals(delete ))
		  		ochk = " checked='checked' ";
				
		  %></td>
							<td colspan="2" class="boldEleven"><table width="74" border="0" cellspacing="0" cellpadding="0">
							  <tr>
							    <td width="20"><input name="delete" type="radio" value="Y" <%=achk%> /></td>
							    <td width="20" class="boldEleven">Yes</span></td>
							    <td width="20" class="boldEleven"><input name="delete" type="radio"
										value="N" <%=ochk%> /></td>
							    <td width="40" class="boldEleven">No</span></td>
						      </tr>
						    </table></td>
						</tr>
						<tr>
							<td colspan="3" class="boldEleven">
							<table width="173" align="center">
								<tr>
									<td width="54"><input name="submit" type="submit"
										class="buttonbold" value="Update"></td>
									<td width="54"><input name="submit" type="button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="redirect('UserList.jsp')"></td>
								</tr>
							</table>							</td>
						</tr>
						<%
    		}catch(Exception e)
    		{
    			out.println("<tr><td align=center height=220> <font color='#FF0000'>Error :"+e.getMessage()+"</font></td></tr>");
    		}
		%>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr align="center">
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td height="100" align="center"><font color="#ACACAC">&nbsp;
		</font></td>
	</tr>
</table>
 </form>
</body>
</html>
