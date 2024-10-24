<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>

<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
function createRequestObject() 
{
    var tmpXmlHttpObject;
    if (window.XMLHttpRequest) 
       tmpXmlHttpObject = new XMLHttpRequest();
	else if (window.ActiveXObject) 
       tmpXmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP");
  
    return tmpXmlHttpObject;
}


var http = createRequestObject();


function processResponse() 
{
    if(http.readyState == 4){
        var response = http.responseText;
        document.getElementById('description').innerHTML = response;
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

 
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="staffleavefrm" action="../SmartLoginAuth"	onSubmit="return validate()">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="54"></td>
	</tr>
	<tr>
		<td height="23">
		<table width="561" border="0" align="center" cellpadding="0"
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
					<table width="549" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="2" class="boldEleven">
							<div align="right"><span class="boldEleven">* </span><span
								class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="boldEleven"></td>
						</tr>
						<tr>
							<td colspan="2" class="boldEleven"></td>
						</tr>
						<tr>
							<td height="19" colspan="2" class="boldEleven">
							<table width="268" border="0" align="center" cellpadding="0"
								cellspacing="0">
								<tr>
									<td width="95" class="boldEleven">Staff id : <%
				   String staff =request.getParameter("staffid");
				   boolean flag =StaffRegistration.LRecordExist(staff.trim()) ;
				   if(flag==false)
					   response.sendRedirect("Leave MasterView.jsp?staffid="+staff);
					   
				   String staffname= StaffRegistration.staffName(staff.trim());
				  %>
									</td>
									<td width="134" class="boldEleven"><%=staff%></td>
								</tr>
								<tr>
									<td class="boldEleven">Staff Name :</td>
									<td class="boldEleven"><%=staffname %> <input
										name="staffid" type="hidden" id="staffid" value="<%=staff%>">
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td width="49%" height="19" class="boldEleven">&nbsp;</td>
							<td width="51%" class="boldEleven">&nbsp;</td>
						</tr>
						<tr>
							<td height="43" colspan="2" class="boldEleven">
							<div align="center">
							<table width="362" border="0" cellpadding="5" cellspacing="0">
								<tr>
									<td width="321">
									<div align="center">
									<%
						  	String column[] = StaffRegistration.leaveTypeValue().split("~");
							int l =column.length;
							String  fs=" (true)";
							for(int i=0;i<l;i++)
							{
								String d ="tx"+i;
								String d1 ="txt"+i;
								
								fs = fs +" && checkNull('" + d + "', 'Enter  Eligible "+column[i]+" the Value')  ";
								fs = fs +" && checkNull('" + d1 + "', 'Enter  Leave Taken  "+column[i]+" the Value')  ";
							}
							
							String  cfs="";
							
							for(int i=0;i<l;i++)
							{
								String d ="tx"+i;
								String field1="INT_NOD"+(i+1);
								String field2="INT_NOD"+(i+1)+"BALANCE";
								String leave1[] =StaffRegistration.leaveRecordExist(staff,field1,field2).split("~");
								cfs = cfs +  field1 +"=" +leave1[0]+"&";
							}
							 
						  	out.println("<table border=0 width='100%'>");
							out.println("<tr>");
							out.println("<tr><td class='boldEleven'>Type of Leave<td class='boldEleven'>Eligible <td class='boldEleven'> Leave Taken");
						  	for(int i=0; i<column.length;i++)
						  	{
							out.println("<tr><td class='boldEleven' cellspacing=2 cellpadding=5>"+column[i]);
							String field1="INT_NOD"+(i+1);
							String field2="INT_NOD"+(i+1)+"BALANCE";
							String leave1[] =StaffRegistration.leaveRecordExist(staff,field1,field2).split("~");
			    			String m1 =leave1[0];
			    			String u1 =leave1[1];
			    			if(Double.parseDouble(m1)<1)m1="0";
			    			if(Double.parseDouble(u1)<1)u1="0";
						 
							out.println("<td  class='boldEleven'>");
							String val="txt"+i;	
							String vl = "tx"+i;
							%> 
<input class='formText135' type='text' maxlength="4" size="6"   name='<%=vl%>' id='<%=vl%>' value='<%=m1%>'  onKeyPress=" return numeric_only(event,'<%=vl%>','11')" /> <%
							out.println("<td  class='boldEleven'>");
							
							%> 
<input maxlength="4"  class='formText135' name='<%=val%>'  id='<%=val%>' type='text' size='6' value="<%=u1%>"   onBlur="Valid('<%=vl%>','<%=val%>')"   onKeyPress=" return numeric_only(event,'<%=val%>','11')" /> <%
							 
							}
							out.println("<tr>");
							out.println("<tr>");
							out.println("</table>");	
						  %>
									</div>
									</td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
						<tr>
							<td height="19" class="boldEleven">&nbsp;</td>
							<td class="boldEleven">&nbsp;</td>
						</tr>

						<tr>
							<td height="19" colspan="2" class="boldEleven"><input
								name="filename" type="hidden" id="filename" value="StaffLeave" />
							<input name="actionS" type="hidden" id="actionS"
								value="ATTStaffLeaveUpdate" /></td>
						</tr>
						<tr>
							<td height="19" colspan="2" class="boldEleven">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold" value="Update" /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="javascript:history.back()" /></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td width="4" nowrap="nowrap"><spacer height="1" width="1"
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
		<td height="40">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">
		<div align="center"></div>
		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
<script language="JavaScript">
function validate()
{
	if(<%=fs%> )
	{
    		return true;
	}		
	else
    {
		return false;
	}	
}

function Valid(f1,f2)
{
	var s1 = parseFloat(document.getElementById(f1).value);
	var s2 = parseFloat(document.getElementById(f2).value);
	if((s1-s2)<0)
	{
		alert("Exceed the limit...");
		document.getElementById(f2).value ="0";	
	
	}
		
}

function makeGetRequest(wordId) 
{
	var f ='LeaveCheck.jsp?Available=' + wordId.value;
	f = f+"&staffid="+document.getElementById('staffid').value;
	http.open('get', f);
    http.onreadystatechange = processResponse;
    http.send(null);
}
</script>
</html>
