<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>
<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
<%-- <%@ page import="sun.net.smtp.SmtpClient"%> --%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<html>
<head>

<title> :: COMMON ::</title>


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

<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"  ></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
 	function  Edit()
 	{		
 	    obj = findObj("staffid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}


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
 	
	 
		
	function Add()
 	{		
		document.frmState.action="Staffadd.jsp";
		document.frmState.submit();
 	}		
	 
 


 
</script>



<script language="javascript" src="../JavaScript/smartcommon/StaffSearch.js"></script>
<script language="javascript" src="../JavaScript/smartcommon/StaffSearchAjax.js"></script> 
  <%@ include file="index.jsp"%>
 

  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
@import url("../bootstrap/css/bootstrap.min.css");

-->
</style>


  <script src="../bootstrap/js/jquery.min.js"></script>
 <script src="../bootstrap/js/bootstrap.min.js"></script>
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
  <body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadStaff('0')" >
<form  AUTOCOMPLETE = "off"   method="get" name="frmState"> 
 

<table width="100%" height="437" align="center">
	<!--DWLayoutTable-->
	<tr>
		<td height="17" colspan="6" align="center">
		<%

String	approveData[][]=CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME,DATE_FORMAT(DT_CREATION_DATE,'%d-%b-%Y')  FROM com_m_staff  WHERE CHR_APPROVED ='N' ORDER BY  DATEDIFF(NOW(),DT_CREATION_DATE) desc");
if(approveData.length>0)
	out.println("<br><center><button type='button' class='btn btn-warning'><span class='badge'> "+approveData.length+"</span>  - Employees have been waiting for an approval.</button></center>");
//"+approveData[0][2]+"
 
%>
		</td>
	<tr>
		<td height="17" colspan="6" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
	<tr>
		<td height="80" colspan="6" align="center">
		<table width="90%" height="327" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" 
			 background="">
				<td height="14" class="boldgre"   > <div align="center" class="whiteMedium">STAFF INFORMATION </div></td>
			</tr>

			
			<tr  >
				<td height="31"  >
				<table width="100%" border="0" align="center" cellpadding="2"
					cellspacing="5" class="whiteMedium">
					 
					 
					<tr>
					  <td width="10%" height="26" id="branch2">Company</td>
					  <td width="21%"    id="branch2"><select name="company"
								id="company" onChange="loadBranch() " class="formText135"
								style="width:150px" autofocus onBlur="loadStaff('0')">
					    <option value="0">All</option>
					    <%                  
     					 
     					String	branch1[][]=CommonFunctions.QueryExecute("SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company ORDER BY CHR_COMPANYNAME");
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
				      </select></td>
					  <td width="12%"  >Department</td>
					  <td  ><select name="depart"
							class="formText135" id="depart" onChange="loadStaff('0')" style="width:150px" >
					    <option value="0">All</option>
					    <%
     
     String	department[][]= CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY CHR_DEPARTNAME");
     for(int i=0;i<department.length;i++)
 	 out.println("<option value='"+department[i][0]+"'>"+department[i][1]+"</option>");
 			    	%>
				      </select></td>
					  <td width="40%" colspan="2" rowspan="2" align="right"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteMedium">
                        <tr>
                          <td width="18%"><div align="right">Modified</div></td>
                          <td width="14%"><div align="left">
                              <input name="modified" type="checkbox" id="modified" value="Y" onClick="LoadSearchStaff( )" >
                          </div></td>
                          <td width="19%"><div align="right">Resigned</div></td>
                          <td width="15%"><div align="left">
                              <input name="resigned" type="checkbox" id="resigned" value="Y" onClick="LoadSearchStaff( )" >
                          </div></td>
                          <td width="18%"><div align="right">Approval</div></td>
                          <td width="16%"><div align="left">
                              <input name="confirmation" type="checkbox" id="confirmation" onClick="LoadSearchStaff( )" value="Y" >
                          </div></td>
                        </tr>
                        <tr>
                          <td colspan="4"><div align="right"><span >Search by Name / ID </span></div></td>
                          <td colspan="2"><input name="searchstaff"
							id="searchstaff" type="text" class="formText135" size="15"
							maxlength="10" onBlur="LoadSearchStaff()"></td>
                        </tr>
                      </table>					    </td>
				    </tr>
					<tr>
						<td id="branch1">Branch</td>
						<td    id="branch1"><select name="branch" id="branch" class="formText135"
								style="width:150px" onChange="loadStaff('0')" >
						  <option value="0">All</option>
					    </select></td>

						<td  >Designation</td>
						<td width="17%"  ><select name="designation"
							class="formText135" id="designation" onChange="loadStaff('0')" style="width:150px" >
                          <option value="0">All</option>
                          <%
     
     String	designation[][]= CommonFunctions.QueryExecute("SELECT INT_DESIGID,CHR_DESIGNAME FROM  com_m_desig  ORDER BY CHR_DESIGNAME");
     for(int j=0;j<designation.length;j++)	
     out.println("<option value='"+designation[j][0]+"'>"+designation[j][1]+"</option>");
 	         %>
                        </select></td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td height="31" align="left" valign="middle">
				<table width="100%" border="0" class="whiteMedium" >
					<tr>
						<td width="10%"><div align="center">Staff Id</div></td>
						<td width="10%"><div align="center">Staff Name</div></td>
						<td width="10%"><div align="center">Father Name</div></td>
						<td width="10%"><div align="center"> Branch</div></td>
						<td width="10%"><div align="center"> Department</div></td>
						<td width="10%"><div align="center">Designation</div></td>
						<td width="10%"><div align="center">Mobile</div></td>
                        <td width="10%"><div align="center">&nbsp;</div></td>
                        <td width="10%"><div align="center">&nbsp;</div></td>
                        <td width="10%"><div align="center">&nbsp;</div></td>
					     
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td height="21" valign="top" bgcolor="#FFFFFF">
				<div id="staffTable" style="OVERFLOW:auto;width:100%;height:300px"></div><br>
				<div id="totRec" align="center"></div><br>
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
		</table>		 </td>
	</tr>
	<tr>
		<td id="tables" height="5" colspan="6">
	<tr>
	  <td height="17" colspan="6"><input name="filename" type="hidden"
					id="filename" value="StaffRegistration">    <input
					name="actionS" type="hidden" id="actionS"
					value="GENStaffRegistrationDelete">
        
	  <tr>
		<td height="17" colspan="6">
		  <div align="center">
            <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_GEN FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_GEN FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			 
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('commonmain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
          </div>
	<tr>
		<td height="17" colspan="6">
		  <%@ include file="../footer.jsp"%>
</table>
</form>
</body>
</html>
