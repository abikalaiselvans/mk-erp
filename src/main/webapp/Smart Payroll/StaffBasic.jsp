<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>
<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
  <html>
<head>

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
 <script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
 	function sEdit()
 	{		
		var count=0;
 	    var sel=document.forms[0].staffid;
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
		document.frmState.action="StaffBasicAction.jsp";
		document.frmState.submit();
		return true;
		}
 	}
 	
	 
		
	function Add()
 	{		
		document.frmState.action="StaffBasicAction.jsp";
		document.frmState.submit();
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
		var f ="../Smart Common/BranchInsert.jsp?id=0";
	else
		var f ='../Smart Common/BranchInsert.jsp?id=' + wordId.value;
			
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



<script language="javascript" src="../JavaScript/Payroll/PayrollStaffSearch.js"></script>
<script language="javascript" src="../JavaScript/Payroll/PayrollStaffSearchAjax.js"></script> 
  <%@ include file="index.jsp"%>
 

  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="makeGetRequest('0'), loadStaff('0'),document.frmState.company.focus()">
<form  AUTOCOMPLETE = "off"   method="get" name="frmState"> 
 

<table width="100%" height="437" align="center">
	<!--DWLayoutTable-->
	<tr>
		<td height="17" colspan="6" align="center">
	<tr>
		<td height="17" colspan="6" align="center">
	<tr>
		<td height="80" colspan="6" align="center">
		<table width="90%" height="327" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" 
			 background="">
				<td height="14" class="boldgre"   > <div align="center" class="whiteMedium">STAFF INFORMATION</div></td>
			</tr>

			
			<tr  >
				<td height="31"  >
				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="2" class="whiteMedium">
					<tr>
					  <td  id="branch1">Company					  </td>
					  <td  id="branch1"><span class="style3">
					    <select  name="company" class="formText135" id="company" onChange="makeGetRequest(this), loadStaff('0')"  style=" width:200">
                          <option value="0">All</option>
                          <%                  
							String queryBranch1="SELECT * FROM  com_m_company ";
							String	branch1[][]= CommonFunctions.QueryExecute(queryBranch1);
							for(int i=0;i<branch1.length;i++)
								out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			    		%>
                        </select>
					  </span></td>
					  <td > <label>
					    <input name="resigned" type="checkbox" id="resigned" value="Y" onClick="loadStaff('0')">
				      Resigned Peoples </label></td>
					  <td colspan="3" ><div align="right"><span >Search by Name / ID </span></div></td>
					  <td   ><input name="searchstaff"
							id="searchstaff" type="text" class="formText135" size="15"
							maxlength="10" onBlur="LoadSearchStaff('searchstaff')" tabindex="1">  </td>
			        </tr>
					<tr>
						<td id="branch1">Branch</td>
						<td    id="branch1">
						<div id="description"><input id="branch"  name="branch" type="hidden" value="0"></div>						</td>

						<td  >Designation</td>
						<td  ><select name="designation"
							class="formText135" id="designation" onChange="loadStaff('0')"  style=" width:200">
                          <option value="0">All</option>
                          <%
     
     String	designation[][]= CommonFunctions.QueryExecute("SELECT INT_DESIGID,CHR_DESIGNAME FROM  com_m_desig  ORDER BY CHR_DESIGNAME");
     for(int j=0;j<designation.length;j++)	
     out.println("<option value='"+designation[j][0]+"'>"+designation[j][1]+"</option>");
 	         %>
                        </select></td>
						<td>Department</td>
						<td colspan="2" ><select name="depart"
							class="formText135" id="depart" onChange="loadStaff('0')"  style=" width:200">
                            <option value="0">All</option>
                            <%
     
     String	department[][]= CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY CHR_DEPARTNAME");
     for(int i=0;i<department.length;i++)
 	 out.println("<option value='"+department[i][0]+"'>"+department[i][1]+"</option>");
 			    	%>
                          </select></td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td height="31" align="left" valign="middle">
				<table width="100%" border="0" class="whiteMedium" >
					<tr>
						<td width="11%"><div align="center">Staff Id</div></td>
						<td width="11%"><div align="center">Staff Name</div></td>
						<td width="11%"><div align="center">Company Name</div></td>
						<td width="11%"><div align="center"> Branch</div></td>
						<td width="11%"><div align="center"> Department</div></td>
						<td width="11%"><div align="center">Designation</div></td>
						<td width="11%"><div align="center">Mobile</div></td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td height="21" valign="top" bgcolor="#FFFFFF">
				<div id="staffTable" style="OVERFLOW:auto;width:100%;height:300px"></div>
				<div id="totRec" align="center"></div>
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
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('0')">ALL</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('Z')">Z</a></div>				</td>
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
				<%			
					
					 String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input name="action1" type="submit" id="action1"
					class="ButtonHead"  onClick= "return sEdit()" value="Edit" tabindex="2">  </td>
	  <%
		}
		else
		{
			//out.println("<input type='hidden' id='Edit'  name='Edit'>");
			//out.println("<input type='hidden' id='Delete'  name='Delete'>");
		}
		%>
	 
	 
	 
	 
				<td width="56"><input class="ButtonHead" type="button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
				<td width="56"><input name="filename" type="hidden"
					id="filename" value="StaffBasic"> 
				<input
					name="actionS" type="hidden" id="actionS"
					value="PAYStaffBasicDelete"></td>
			</tr>
		</table>
	<tr>
		<td height="17" colspan="6">
		  <%@ include file="../footer.jsp"%>
		 
</table>
</form>
</body>
</html>
