<%@ page
	import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%!
	ArrayList empdata = new ArrayList();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright"
	content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords"
	content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<style type="text/css">
<!--
a:visited {
	color: #663366;
}

a:hover {
	color: #FF0000;
}

a:active {
	color: #0000FF;
}
-->
</style>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
 	function sEdit()
 	{		
 	    var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].staffid.checked)
		    { 
		    	count=1;
		    }   
		    else{	    
		   	   alert("Select Record to Edit");
		   	   return false;
		   	 }
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false
 	    }
 	    if(count==1)
 	    {
		document.frmState.action="StaffRegistrationEdit.jsp";
		document.frmState.submit();
		return true;
		}
 	}
 	
	function View()
 	{		
		document.frmState.action="StaffView.jsp";
		document.frmState.submit();
 	}	
		
	function Add()
 	{		
		document.frmState.action="Staffadd.jsp";
		document.frmState.submit();
 	}		
	function mainPage()
	{
	    document.frmState.action="AttendanceMain.jsp";
		document.frmState.submit();
		return true;
    }
	function sDelete()
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
				document.frmState.action="../SmartLoginAuth";
				document.frmState.submit();
				
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

 

function createRequestObject() 
{
    var tmpXmlHttpObject;
    if (window.XMLHttpRequest) 
    { 
        tmpXmlHttpObject = new XMLHttpRequest();
	  }
    else if (window.ActiveXObject) 
    { 
        tmpXmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return tmpXmlHttpObject;
}


var http = createRequestObject();
function makeGetRequest(wordId) 
{
	if (wordId==0)
		var f ="BranchInsert.jsp?id=0";
	else
		var f ='BranchInsert.jsp?id=' + wordId.value;
			
	http.open('get', f);
    http.onreadystatechange = processResponse;
    http.send(null);
}

function processResponse() 
{
    if(http.readyState == 4){
        var response = http.responseText;
        document.getElementById('description').innerHTML = response;
    }
}

 
</script>



<script language="javascript"
	src="../JavaScript/common/StaffSearchByNameWise.js"></script>
<script language="javascript"
	src="../JavaScript/common/StaffSearchByIdWise.js"></script>


<style type="text/css">
<!--
.style3 {
	color: #000000
}
-->
</style>


<body onpaste="return false;" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="  makeGetRequest('0'), document.frmState.company.focus()">
<form AUTOCOMPLETE="off" method="get" name="frmState"><%@ include
	file="insert.jsp"%> <input name="path"
	id="path" type="hidden" value="<%=path%>"> <input name="qp"
	id="qp" type="hidden" value="<%=qp%>">


<table width="100%" height="437" align="center">
	<!--DWLayoutTable-->
	<tr>
		<td height="17" colspan="6" align="center">
		<tr>
			<td height="17" colspan="6" align="center">
			<tr>
				<td height="80" colspan="6" align="center">
				<table width="90%" height="327" border="0" align="center"
					cellpadding="0" cellspacing="0" class="TableDesign">
					<!--DWLayoutTable-->
					<tr align="center" valign="middle" background="">
						<td height="14" class="boldgre">
						<div align="center" class="whiteMedium">STAFF INFORMATION</div>
						</td>
					</tr>


					<tr>
						<td height="31">
						<table width="100%" border="0" align="center" cellpadding="0"
							cellspacing="2" class="whiteMedium">
							<tr>
								<td id="branch1">Company</td>
								<td id="branch1"><span class="style3"> <select
									name="company" class="formText135" id="company"
									onChange="makeGetRequest(this), loadStaff('0')">
									<option value="0">Select</option>
									<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			    	%>
								</select> </span></td>
								<td>&nbsp;</td>
								<td colspan="3">
								<div align="right"><span>Search by Name</span></div>
								</td>
								<td><input name="searchstaff" id="searchstaff"
									type="text" class="formText135" size="15" maxlength="10"
									onBlur="LoadSearchStaffs('searchstaff')"></td>
								<td>Search by Id</td>
								<td><input name="searchstaffid" id="searchstaffid"
									type="text" class="formText135" size="15" maxlength="10"
									onBlur="LoadSearchStaffids('searchstaffid')"></td>
							</tr>
							<tr>
								<td id="branch1">Branch</td>
								<td id="branch1">
								<div id="description"></div>
								</td>

								<td>Designation</td>
								<td><select name="designation" class="formText135"
									id="designation" onChange="loadStaff('0')">
									<option value="0">All</option>
									<%
     String query="SELECT * FROM  com_m_desig  ORDER BY CHR_DESIGNAME";
     String	designation[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(query);
     for(int j=0;j<designation.length;j++)	
     out.println("<option value='"+designation[j][0]+"'>"+designation[j][1]+"</option>");
 	         %>
								</select></td>
								<td>Department</td>
								<td colspan="4"><select name="depart" class="formText135"
									id="depart" onChange="loadStaff('0')">
									<option value="0">All</option>
									<%
     String sql="SELECT * FROM   com_m_depart   ORDER BY CHR_DEPARTNAME";
     String	department[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
     for(int i=0;i<department.length;i++)
 	 out.println("<option value='"+department[i][0]+"'>"+department[i][1]+"</option>");
 			    	%>
								</select></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="31" align="left" valign="middle">
						<table width="100%" border="0" class="whiteMedium">
							<tr>
								<td width="138">
								<div align="center">Staff Id</div>
								</td>
								<td width="218">
								<div align="center">Staff Name</div>
								</td>
								<td width="218">Middle Name</td>
								<td width="125">
								<div align="center">Company Name</div>
								</td>
								<td width="76">
								<div align="center">Branch</div>
								</td>
								<td width="91">
								<div align="center">Department</div>
								</td>
								<td width="94">
								<div align="center">Designation</div>
								</td>
								<td width="88">
								<div align="center">Mobile</div>
								</td>
								<td width="88">
								<div align="center">Print</div>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="21" valign="top" bgcolor="#FFFFFF">
						<div id="staffTable"
							style="OVERFLOW: auto; width: 100%; height: 300px"></div>
						<br>
						<div id="totalrecord" align="center"></div>
						<br>
				</table>
				<tr>
					<td height="17" colspan="6"><!--DWLayoutEmptyCell-->&nbsp;</td>
				</tr>
				<tr>
					<td height="17" colspan="6">
					<table width="90%" border="0" align="center" cellpadding="1"
						cellspacing="1" class="TableDesign">
						<tr class="para">
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('0')">ALL</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('A')">A</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('B')">B</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('C')">C</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('D')">D</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('E')">E</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('F')">F</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('G')">G</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('H')">H</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('I')">I</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('J')">J</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('K')">K</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('L')">L</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('M')">M</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('N')">N</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('O')">O</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('P')">P</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('Q')">Q</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('R')">R</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('S')">S</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('T')">T</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('U')">U</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('V')">V</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('W')">W</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('X')">X</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('Y')">Y</a></div>
							</td>
							<td>
							<div align="center"><a class="whiteMedium"
								href="javascript:loadStaff('Z')">Z</a></div>
							</td>
						</tr>
					</table>
					<a href=javascript:; onClick="windowSave('sample.txt')"></a></td>
				</tr>
				<tr>
					<td id="tables" height="5" colspan="6">
					<tr>
						<td height="17" colspan="6">
						<table border="0" align="center" cellpadding="2" cellspacing="2">
							<tr>
								<td width="56"><input class="ButtonHead" name="submit2"
									type="submit" onClick=Add() value="Add"></td>
								<td width="56"><input name="Edit" type="button"
									class="ButtonHead" id="Edit" onClick="sEdit()" value="Edit"></td>

								<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
								<td width="56"><input name="Delete" type="Button"
									class="ButtonHead" id="Delete" onClick="sDelete()"
									value="Delete"></td>

								<%
		}
		else
		{
			out.println("<input type='hidden' id='Delete'>");
		}
		%>
								<td width="56"><input class="ButtonHead" type="button"
									name="Button" value="Close" accesskey="c"
									onClick="redirect('<%=closefile%>')"></td>
								<td width="56"><input name="filename" type="hidden"
									id="filename" value="StaffRegistration"> <input
									name="actionS" type="hidden" id="actionS"
									value="COM_ATTStaffRegistrationDelete"></td>
							</tr>
						</table>
						<tr>
							<td height="17" colspan="6">
							<center><font color="#FF0000"> <%
	String error=""+request.getParameter("staff");
	
	if(error.equals("") || error.equals("null"))
	{
		error ="";	
	}
	else
	{
		error ="Sorry record not found ...  Staff id := "+ error;
	}
	out.println(error);
	%> </font> <% 
	String msg=""+request.getParameter("message");
	if(!msg.equals("null")){
 %> <%=msg%> <% } %> <%@ include file="../footer.jsp"%>
							</center>
</table>
</form>
</body>
</html>
