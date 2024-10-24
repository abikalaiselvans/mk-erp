<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>
<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%
try
{
%>
  <html>
<head>

<title> :: MANAGEMENT ::</title>

<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

 

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking" />

<script language="javascript" src="../JavaScript/Management/ContractorStaffSearch.js"></script>
<script language="javascript" src="../JavaScript/Management/ContractorStaffSearchAjax.js"></script> 

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
		document.frmState.action="ContractorEdit.jsp";
		document.frmState.submit();
		return true;
		}
 	}
		
	function Add()
 	{		
		document.frmState.action="Contractoradd.jsp";
		document.frmState.submit();
 	}		
	 
	 function close1()
 	{		
		document.frmState.action="ManagementMain.jsp";
		document.frmState.submit();
 	}
	
	
	function Delete()
	{
	var chkbox=document.forms[0].staffid;
	var len=0;
	for(i=0;i<chkbox.length;i++)
	{
		if(chkbox[i].checked)
			len++;
	}
	if(!document.forms[0].staffid){
		alert("Select Any One Value");
		return false;
	}
	else if(len==0)
	{
		if(chkbox.checked)
		{
		    var name=confirm("Confirm to Delete?");
				if(name == true){
					document.frmState.action="../SmartLoginAuth";
					return true;
				}
				else
					{
					return false;
				}
		}
		else
		{
			alert("Select Any One Value");
			return false;
		}
	}
	else if(len>=1)
	{
		var name=confirm("Confirm to Delete?");
		if(name == true)
		{
				document.frmState.action="../SmartLoginAuth";
				return true;
		}
		else
		{
			return false;
		}
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
 

  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<style type="text/css">
<!--
	.progressBarContainerClass
	{
	 height: 15px;
	 width: 50px;
	 border: 1px solid black;
	 border-radius: 3px 3px 3px 3px;
	 -moz-border-radius: 3px 3px 3px 3px;
	 -webkit-box-shadow: 0px 0px 5px #999;
	 -moz-box-shadow: 0px 0px 5px #999;
	 box-shadow:0px 0px 3px 1px rgba(0,0,0,0.3);
	 background: -webkit-gradient(linear, center top, center bottom, color-stop(0.2, #D8D6D5), color-stop(0.8, #999999));
	 background: -moz-linear-gradient(top, #D8D6D5 20%, #999999 80%);
	 filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#D8D6D5', endColorstr='#999999');
	}
	 
-->
</style>
  <body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadContractStaff('0')">
  <jsp:include page="index.jsp" flush="true" />
<form  AUTOCOMPLETE = "off"   method="post" name="frmState"> 
 

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
				<td height="14" class="boldgre"   > <div align="center" class="whiteMedium">CONTRACT STAFF INFORMATION</div></td>
			</tr>

			
			<tr  >
				<td height="31"  >
				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="2" class="whiteMedium">
					<tr>
					  <td  id="branch1">&nbsp;</td>
					  <td  id="branch1">&nbsp;</td>
					  <td > <label></label></td>
					  <td colspan="3" ><div align="right"><span >Search by Name / ID </span></div></td>
					  <td   ><input name="searchstaff"
							id="searchstaff" type="text" class="formText135" size="15"
							maxlength="10" onBlur="LoadContractorSearchStaff('searchstaff')" tabindex="1">  </td>
			        </tr>
					<tr>
						<td id="branch1">Company </td>
						<td    id="branch1"><span class="style3">
						  <select  name="company" class="formText135" id="company" onChange="makeGetRequest(this), loadContractStaff('0')">
                            <option value="0">All</option>
                            <%                  
							String queryBranch1="SELECT * FROM  com_m_company ";
							String	branch1[][]= CommonFunctions.QueryExecute(queryBranch1);
							for(int i=0;i<branch1.length;i++)
								out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			    		%>
                          </select>
						</span>												</td>

						<td  >Designation</td>
						<td  ><select name="designation"
							class="formText135" id="designation" onChange="loadContractStaff('0')">
                          <option value="0">All</option>
                          <%
     
     String	designation[][]= CommonFunctions.QueryExecute("SELECT INT_DESIGID,CHR_DESIGNAME FROM  com_m_desig  ORDER BY CHR_DESIGNAME");
     for(int j=0;j<designation.length;j++)	
     out.println("<option value='"+designation[j][0]+"'>"+designation[j][1]+"</option>");
 	         %>
                        </select></td>
						<td> Department</td>
						<td colspan="2" ><select name="depart"
							class="formText135" id="depart" onChange="loadContractStaff('0')">
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
						<td width="11%"><div align="center"> Department</div></td>
						<td width="11%"><div align="center">Designation</div></td>
						<td width="11%"><div align="center">Mobile</div></td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td height="21" valign="top" bgcolor="#FFFFFF">
				<div id="ContractstaffTable" style="OVERFLOW:auto;width:100%;height:300px"></div>
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
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('0')">ALL</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadContractStaff('Z')">Z</a></div>				</td>
			</tr>
		</table>		 </td>
	</tr>
	<tr>
	  <td id="tables" height="5" colspan="6"><input name="filename" type="hidden"
					id="filename" value="ContractStaff">
        <input
					name="actionS" type="hidden" id="actionS"
					value="MGTContractStaffDELETE"></td>
    <tr>
		<td id="tables" height="5" colspan="6"><div align="center">
          <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_MGT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_MGT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return sEdit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_MGT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'ManagementMain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
        </div></td>
	<tr>
		<td height="17" colspan="6">
		<tr>
		<td height="17" colspan="6">
		  <%@ include file="../footer.jsp"%>
</table>
</form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());}
%>