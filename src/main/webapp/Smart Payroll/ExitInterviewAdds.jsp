<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
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
<script language="javascript">
function validate()
{
    try
	{
		if(
			checkNull("date","Date of Interview")
			&& checkNull("reason1","Reason 1")
			&& checkNull("reason2","Reason 2")
			&& checkNull("reason4","Reason 4") 
			&& checkNull("reason10","Reason 10")
			&& checkNull("reason11","Reason 11")
			&& checkNull("reason12","Reason 12") 
			&& checkNull("reason13","Reason 13")
			&& checkNull("reason14","Reason 14")
			&& checkNull("reason17","Reason 17") 
			&& checkNull("reason18","Reason 18")
			&& checkNull("reason19","Reason 19")
		)
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

<body  >
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="Cessation" action="../SmartLoginAuth" onSubmit="return validate()">
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
 
String rptodata1[][] =CommonFunctions.QueryExecute("SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,b.INT_EXITID FROM com_m_staff a, pay_t_exitinterview b  WHERE a.CHR_EMPID =b.CHR_EMPID AND b.CHR_STATUS='N' AND b.CHR_EMPID ='"+session.getAttribute("EMPID")+"' ");
if(rptodata1.length>0)
{

%>


		  <table width="749" border="0" align="center" cellpadding="0"
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
					<table width="731" border="0" cellspacing="0" cellpadding="0">
						<tr class="boldEleven">
							<td height="20">
							<div align="center" class="boldEleven"><span
								class="boldEleven"><strong>EXIT INTERVIEW</strong></span></div>							</td>
						</tr>
						<tr>
							<td>
							<div align="right"><span class="boldElevenlink">*  </span><span
								class="changePos"> - All Fields are Mandatory</span></div>							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>

						<tr>
							<td height="19">
							<table width="715" border="0" align="center" cellpadding="2"
								cellspacing="2">
								 
								<tr>
								  <td valign="middle"   class="boldEleven">Candidate Name </td>
								  <td>
<%
 
out.println(rptodata1[0][1] +" / "+rptodata1[0][0] );
%>
<input name="empid" id="empid" type="hidden" value="<%=rptodata1[0][0]%>">	
<input name="rowid" id="rowid" type="hidden" value="<%=rptodata1[0][2]%>">								  
 </td>
							  </tr>
								 
								<tr>
								  <td width="237" valign="middle"   class="boldEleven"><div align="left">Date</div></td>
									<td width="287"><input name="date" type="text" class="formText135"
										id="date" maxlength="11"> <a
										href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" alt="Click here to Pick Up the Date"></a> <script
										language="JavaScript">
			<!--
  			var cal2=new calendar1(document.forms['Cessation'].elements['date']);
  			cal2.year_scroll=true;
	  		cal2.time_comp=false;
	  		setCurrentDate('date');
	
	
	  			//--> 
		</script></td>
								</tr>
								<tr>
								  <td valign="middle"   class="boldEleven"><div align="left">1. What is your primary reason for leaving?</div></td>
								  <td><textarea name="reason1" cols="45" rows="3"
										class="formText135" id="reason1" onKeyPress="textArea('reason1','299')"></textarea></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">2. Can this Organization do anything to encourage you to stay?</div></td>
								  <td><textarea name="reason2" cols="45" rows="3"
										class="formText135" id="reason2" onKeyPress="textArea('reason2','299')"></textarea></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">3. Before deciding to leave, did you investigate a transfer within the Organization?</div></td>
								  <td><table width="200" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <th class="boldEleven" scope="col"><input name="reason3" type="radio" value="Y" checked> 
                                      Yes </th>
                                      <th class="boldEleven" scope="col"><input name="reason3" type="radio" value="N"> 
                                      No </th>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">4. Did anything trigger your decision to leave this organization?</div></td>
								  <td><textarea name="reason4" cols="45" rows="3"
										class="formText135" id="reason4"  onkeypress="textArea('reason4','299')"></textarea></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">5. Have you receive adequate support to do your job? </div></td>
								  <td><table width="200" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <th class="boldEleven" scope="col"><input name="reason5" type="radio" value="Y" checked>
                                        Yes </th>
                                      <th class="boldEleven" scope="col"><input name="reason5" type="radio" value="N">
                                        No </th>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">6. Did any Organization policies or procedures (or any other obstacles) make your job more difficult?</div></td>
								  <td><table width="200" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <th class="boldEleven" scope="col"><input name="reason6" type="radio" value="Y">
                                        Yes </th>
                                      <th class="boldEleven" scope="col"><input name="reason6" type="radio" value="N" checked>
                                        No </th>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">7. Did you receive enough training to do your job effectively?</div></td>
								  <td><table width="200" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <th class="boldEleven" scope="col"><input name="reason7" type="radio" value="Y" checked>
                                        Yes </th>
                                      <th class="boldEleven" scope="col"><input name="reason7" type="radio" value="N">
                                        No </th>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">8. 
                                  Did this Organization help you to fulfill your career goals?</div></td>
								  <td><table width="200" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <th class="boldEleven" scope="col"><input name="reason8" type="radio" value="Y" checked>
                                        Yes </th>
                                      <th class="boldEleven" scope="col"><input name="reason8" type="radio" value="N">
                                        No </th>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">9. Are you happy with your pay, benefits?</div></td>
								  <td><table width="200" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <th class="boldEleven" scope="col"><input name="reason9" type="radio" value="Y" checked>
                                        Yes </th>
                                      <th class="boldEleven" scope="col"><input name="reason9" type="radio" value="radiobutton">
                                        No </th>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">10. What does your new Organization offer that this Organization doesn't?</div></td>
								  <td><textarea name="reason10" cols="45" rows="3"
										class="formText135" id="reason10"  onkeypress="textArea('reason10','299')"></textarea></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">11. 
                                  What extra responsibility would you have welcome that you  were not given?</div></td>
								  <td><textarea name="reason11" cols="45" rows="3"
										class="formText135" id="reason11" onKeyPress="textArea('reason11','299')"></textarea></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">12. How would you describe the &lsquo;culture&rsquo; or &lsquo;feel&rsquo; of the  Organization?</div></td>
								  <td><textarea name="reason12" cols="45" rows="3"
										class="formText135" id="reason12" onKeyPress="textArea('reason12','299')"></textarea></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">13. 
                                  What has been good / enjoyable / satisfy for you in your time  with us?</div></td>
								  <td><textarea name="reason13" cols="45" rows="3"
										class="formText135" id="reason13" onKeyPress="textArea('reason13','299')"></textarea></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">14. 
                                  What has been frustrating / difficult / upsetting to you in your  time with us?</div></td>
								  <td><textarea name="reason14" cols="45" rows="3"
										class="formText135" id="reason14" onKeyPress="textArea('reason14','299')"></textarea></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">15. 
                                  Would you consider working again for this Organization in  the future?</div></td>
								  <td><table width="200" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <th class="boldEleven" scope="col"><input name="reason15" type="radio" value="Y" checked>
                                        Yes </th>
                                      <th class="boldEleven" scope="col"><input name="reason15" type="radio" value="N">
                                        No </th>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">16. 
                                  Would you recommend your friends to work in this  Organization?</div></td>
								  <td><table width="200" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <th class="boldEleven" scope="col"><input name="reason16" type="radio" value="Y" checked>
                                        Yes </th>
                                      <th class="boldEleven" scope="col"><input name="reason16" type="radio" value="N">
                                        No </th>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">17. 
                                  What could your immediate supervisor do to improve his or  her management style?</div></td>
								  <td><textarea name="reason17" cols="45" rows="3"
										class="formText135" id="reason17"  onkeypress="textArea('reason17','299')"></textarea></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">18.
                                  What improvements do you think that can be made to improve  customer service and relations?</div></td>
								  <td><textarea name="reason18" cols="45" rows="3"
										class="formText135" id="reason18"  onkeypress="textArea('reason18','299')"></textarea></td>
							  </tr>
								<tr>
                                  <td valign="middle"   class="boldEleven"><div align="left">19. Any other comments?</div></td>
								  <td><textarea name="reason19" cols="45" rows="3"
										class="formText135" id="reason19" onKeyPress="textArea('reason19','299')"></textarea></td>
							  </tr>
							</table>							</td>
						</tr>
						<tr>
						  <td height="19">
								<input name="filename" type="hidden"
								id="filename" value="ExitInterview" />
                              <input name="actionS"
								type="hidden" id="actionS" value="PAYExitInterviewAdds" />						<input name="reason20" type="hidden" id="reason20"></td>
						</tr>
						
						<tr>
							<td height="19">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Submit"   accesskey="s"    /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('ExitInterviewView.jsp')" /></td>
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
<%
	}
	else
	{
		out.println("<br><br><br><br>");
		out.println("<br><br><br><br><br>");
		out.println("<center>");
		%>
		<script language="javascript">
			alert("Hi, Exit interview is not possible for you...");
		</script>
		<%
		out.println("<font class='bolddeepred'>Hi, Exit interview is not possible for you...</font>");
		out.println("</center>");
		out.println("<br>");
		out.println("<br>");
		
	}
%>		      
		  
		  
		  </td>
	</tr>
	<tr>
		<td height="23">&nbsp;</td>
	</tr>
	<tr>
		<td height="40"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>