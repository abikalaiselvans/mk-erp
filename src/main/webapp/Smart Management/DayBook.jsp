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
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Management/Daybook.js"></script>
<script language="javascript">
 	
	function Add()
	{		
		document.frm.action="DayBookAction.jsp";
		document.frm.submit();
	}		
 
	function Edit()
	{	
		
		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}	
		
		var chkbox=document.forms[0].rowid;
		var len=0;
		var ch=0;
		for(i=0;i<chkbox.length;i++)
		{
			if(chkbox[i].checked)
			{
				len++;
			}
		}
			if(len>1)
			{
				alert("Select Only One Value");
				return false;
			}
			else if(len==0)
			{
				if(chkbox.checked)
				{
					document.frm.action="DayBookAction.jsp";
					return true;
				}
				else
				{
					alert("Select Any One Value");
					return false;
				}
			}
			else
			{
				document.frm.action="DayBookAction.jsp";
				return true;
			}
	}
 	function Delete()
	{

		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}	
	var chkbox=document.forms[0].rowid;
	var len=0;
	for(i=0;i<chkbox.length;i++)
	{
		if(chkbox[i].checked)
		{
			len++;
		}
	}

	if(len==0)
	{
		if(chkbox.checked)
		{
			document.frm.action="../SmartLoginAuth";
			return true;
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
				document.frm.action="../SmartLoginAuth";
				return true;
		}
		else
		{
			return false;
		}
	}	
}
</script>
 

  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



 
  <body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadDayBook('0')">
  <jsp:include page="index.jsp" flush="true" />
<form   method="get" name="frm" id="frm"  AUTOCOMPLETE = "off"> 
 

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
			  <td height="14" class="boldgre"   ><div align="center" class="whiteMedium">DAY BOOK</div></td>
		  </tr>
			<tr align="center" valign="middle" 
			 background="">
			  <td height="14" class="boldgre"   ><table width="100%" border="0" cellpadding="0" cellspacing="0">
			    <tr>
			      <td class="whiteMedium">Branch</td>
			      <td class="whiteMedium"><select name="branch"
										class="formText135" id="branch" tabindex="6" style="width:200"  onBlur="LoadPettyCashExpense('0') ">
			        <option value="0">All</option>
			        <%
								
												
				 String sql ="Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  AND b.INT_ACTIVE =1";	
				 String branchdata[][] =  CommonFunctions.QueryExecute(sql);
								for(int u=0; u<branchdata.length; u++)
									out.print("<option value='"+branchdata[u][0]+"'>"+branchdata[u][2]+ "  @  " +branchdata[u][1] +"</option>");
							%>
			        </select></td>
			      <td class="whiteMedium">Day</td>
			      <td class="whiteMedium"><select name="day" class="formText135" id="day" style="width:50"  onBlur="loadDayBook('0') ">
			        <option value="0" selected>All</option>
			        <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
			        </select></td>
			      <td class="whiteMedium">Month</td>
			      <td class="whiteMedium"><select name="month" class="formText135" id="month"	onBlur="loadDayBook('0')" style="width:100">
			        <option value="0">All</option>
			        <%@ include file="../JavaScript/Inventory/month.jsp"%>
			        </select></td>
			      <td class="whiteMedium" >Year </td>
			      <td class="whiteMedium"><select name="year" class="formText135" id="year"
							onBlur="loadDayBook('0')" style="width:100">
			        <%@ include file="../JavaScript/Inventory/year.jsp"%>
			        </select>
			        <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						setOptionValue('day',day);	
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
				//-->
                      </script></td>
		        </tr>
		      </table></td>
		  </tr>
			<tr align="center" valign="middle" 
			 background="">
				<td height="14" class="boldgre"   ><!--DWLayoutEmptyCell-->&nbsp;</td>
			</tr>
  
			<tr>
				<td height="21" valign="top" bgcolor="#FFFFFF">
				<div id="divTable" style="OVERFLOW:auto;width:100%;height:300px"></div>
				<br>
				<div id="totRec" align="center"></div>
				<br><br>
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
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('0')">ALL</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadDayBook('Z')">Z</a></div>				</td>
			</tr>
		</table>		 </td>
	</tr>
	<tr>
	  <td id="tables" height="5" colspan="6"><input name="filename" type="hidden"
					id="filename" value="DayBookAction">
      <input
					name="actionS" type="hidden" id="actionS"
					value="MGTDayBookActionDelete"></td>
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
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
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