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
<script language="javascript" src="../JavaScript/Management/ComplaintsResponse.js"></script>
<script language="javascript">
 	
	 		
 
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
					document.frm.action="ComplaintsResponseAdd.jsp";
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
				document.frm.action="ComplaintsResponseAdd.jsp";
				return true;
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
  <body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadComplaintsResponse('0')">
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
				<td height="14" class="boldgre"   > <div align="center" class="whiteMedium">CCOMPLAINTS RESPONSE </div></td>
			</tr>

			
			 
			<tr>
				<td height="31" align="left" valign="middle"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteMedium">
                  <tr>
                    <td >Priority</td>
                    <td ><span class="boldEleven">
                      <select name="priority" class="formText135" id="priority"   onChange="loadComplaintsResponse('0') "   style="width:200">
                        <option value='0' selected="selected">All
                        <option value='1'>Normal
                        <option value='2'>Medium
                        <option value='3'>Urgent
                        <option value='4'>Most Urgent
                    </select>
                    </span></td>
                    <td height="19" >Status</td>
                    <td >
<select	name="status" class="formText135" id="status" tabindex="1"   onChange="loadComplaintsResponse('0') "   style="width:200">
	<option value='0'>All</option>
	<option value="Y">Solved</option>
	<option value="N">Pending</option>
</select>					</td>
                     
                    <td>Day</td>
                    <td><select name="day" id="day"   onChange="loadComplaintsResponse('0') " style="width:50">
                        <option value="0">All</option>
                        <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                    </select></td>
                    <td >Month</td>
                    <td ><select name="month" id="month" onChange="loadComplaintsResponse('0')">
                        <option value="0">All</option>
                        <%
java.util.Date dt = new java.util.Date();
int m = dt.getMonth();
%>

<%@ page import="java.util.Date"%>
<option value="01">January</option>
<option value="02">February</option>
<option value="03">March</option>
<option value="04">April</option>
<option value="05">May</option>
<option value="06">June</option>
<option value="07">July</option>
<option value="08">August</option>
<option value="09">September</option>
<option value="10">October</option>
<option value="11">November</option>
<option value="12">December</option>

                    </select></td>
                    <td >Year</td>
                    <td ><select name="year" id="year"
					onChange="loadComplaintsResponse('0')">
                        <%
java.util.Date dts = new java.util.Date();
int ms = dts.getYear();
int myear = ms+1900;
int startyear=2006;
int endyear = myear+2;

for(int u=startyear;u<=endyear;u++)
	out.println("<option value='"+u+"'>"+u+"</option>");
  %>

                      </select>
                        <script language='JavaScript' type="text/javascript">
						 	
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						setOptionValue('day',day);	
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
				  </script>                    </td>
                  </tr>
                </table></td>
			</tr>
			<tr>
				<td height="21" valign="top" bgcolor="#FFFFFF">
				<div id="ContractstaffTable" style="OVERFLOW:auto;width:100%;height:300px"></div>
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
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('0')">ALL</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadComplaintsResponse('Z')">Z</a></div>				</td>
			</tr>
		</table>		 </td>
	</tr>
	<tr>
	  <td id="tables" height="5" colspan="6"><input name="filename" type="hidden"
					id="filename" value="Complaints">
        <input
					name="actionS" type="hidden" id="actionS"
					value="MGTComplaintsDELETE"></td>
    <tr>
		<td id="tables" height="5" colspan="6"><div align="center">
          <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
 			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_MGT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Response'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
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