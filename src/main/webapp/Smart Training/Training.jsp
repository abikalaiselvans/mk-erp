 <%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%
try
{
%>
<html>
 

<title> :: TRAINNING ::</title>
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Trainning/TrainingDetailsAjax.js"></script>

<script language="javascript">    
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
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
	
	
 	function CEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id;
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].id.checked) { count=1;}
		}
		
		if(count==1)
		{			
			document.frm.action="TrainingActionEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}
	
	function Add()
 	{				
		document.frm.action="TrainingAction.jsp";
 	}
 	 
</script>
<!--frmMain-->
 
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style> 
<form  AUTOCOMPLETE = "off"   method="get" name='frm' >
<body  onpaste="return false;" onLoad="loadTrainingDetails('0')">
<%@ include file="index.jsp"%>
<jsp:include page="../JavaScript/dynamicStylesheet.jsp" flush="true" />

<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>

		<table width="90%" height="220" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign">
			<tr>
			  <td height="30" align="center" class="whiteMedium">TRAINING</td>
		  </tr>
			<tr>
			  <td height="30" align="center" class="whiteMedium"><table width="300" border="0" cellpadding="5" cellspacing="5" class="whiteMedium">
                <tr>
                  <td>Test Type </td>
                  <td><select name="type" class="formText135" id="type" onChange="loadTrainingDetails('0')" style="width:100px">
                    <option value="0">All</option>
                    <%
					 String data[][]=CommonFunctions.QueryExecute("SELECT INT_TESTTYPEID,CHR_TESTNAME FROM internal_training_m_testtype ORDER BY CHR_TESTNAME ");
					 for(int i=0;i<data.length;i++) 
                        out.println("<option value="+data[i][0]+">"+data[i][1]+"</option>");
					%>
                  </select></td>
                  <td>Office</td>
                  <td><select name="office" class="formText135" id="office" onChange="loadTrainingDetails('0')" style="width:100px">
                    <option value="0">All</option>
                    <%
					 String officedata[][]=CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM com_m_office ORDER BY CHR_OFFICENAME ");
					 for(int i=0;i<officedata.length;i++) 
                        out.println("<option value="+officedata[i][0]+">"+officedata[i][1]+"</option>");
					%>
                  </select></td>
                  <td>Day</td>
                  <td><select name="day" id="day"    style="width:100px" onChange="loadTrainingDetails('0')">
                    <option value="0">All</option>
                    <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                  </select></td>
                  <td>Month</td>
                  <td><select name="month" id="month"  style="width:100px" onChange="loadTrainingDetails('0')">
                    <option value="0">All</option>
					<%@ include file="../JavaScript/smonth.jsp"%>
                  </select></td>
                  <td>Year</td>
                  <td><select name="year" id="year"    style="width:100px" onChange="loadTrainingDetails('0')">
                      <%@ include file="../JavaScript/syear.jsp"%>
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
              </table>		      </td>
		  </tr>
			 
			<tr bgcolor="#FFFFFF">
				<td >
				
				<div id="recordTable" style="OVERFLOW:auto;width:100%;height:300px"></div>
				<br>
				<div id="totalRec" align="center"  ></div>			  </td>
			</tr>
		</table>		</td>
	</tr>

	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('0')">All</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('A')">A</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('B')">B</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('C')">C</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('D')">D</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('E')">E</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('F')">F</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('G')">G</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('H')">H</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('I')">I</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('J')">J</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('K')">K</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('L')">L</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('M')">M</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('N')">N</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('O')">O</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('P')">P</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('Q')">Q</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('R')">R</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('S')">S</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('T')">T</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('U')">U</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('V')">V</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('W')">W</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('X')">X</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('Y')">Y</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadTrainingDetails('Z')">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>
		<table width="317" align="center">
			<tr>
				<td width="56"><div align="center">
					<input  class="ButtonHead" type="submit" onClick="Add()" name="action1" value="Add"></div></td>
				<td width="56">
				<div align="center">
					<input  class="ButtonHead" type="submit" name="Edit" id="Edit" value="Edit" onClick="return CEdit()">
				</div></td>
				<%
		 if("F".equals(""+session.getAttribute("USRTYPE")) || ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
		  {
	  %>
				<td width="56">
				<input type="submit" class="ButtonHead" name="Submit3" id="btnDelete" value="Cancel" onClick="return Delete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}
%>
				<td width="56">
				<div align="center"><input  class="ButtonHead" type="button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('TrainingMain.jsp')"></div>				</td>
		      <td width="69"  ><input type="hidden" name="filename"	value="Training">
		        <input type="hidden" name="actionS"	value="TRATrainingDelete"></td>
			</tr>
		</table>		</td>
	</tr>
</table>

<%@ include file="../footer.jsp"%>

</body>
</form>
</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

