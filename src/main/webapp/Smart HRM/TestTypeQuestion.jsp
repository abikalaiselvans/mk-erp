<%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


<html>
 

<title>:: HRM ::</title>

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

<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
.style9 {color: #FFFFFF}
.style10 {font-family: Verdana; font-size: 12px; color: #FFFFFF; }
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript" src="../JavaScript/HRM/TesttypeQuestionAjax.js"></script>

<script language="javascript">    
	function  Delete()
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
	
	
 	function  Edit()
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
			document.frm.action="TestTypeQuestionAction.jsp";
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
		document.frm.action="TestTypeQuestionAction.jsp";
		 
 	}
 	 
</script>
<!--frmMain-->
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<form  AUTOCOMPLETE = "off"   method="get" name='frm' action="../SmartLoginAuth" >
<body  onpaste="return false;" onLoad="loadTestTypeQuestion('0')"  >
<%@ include file="indexhrm.jsp"%>
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
			  <td height="30" align="center"  class="whiteMedium">QUESTION </td>
		  </tr>
			<tr>
			  <td height="30" align="center"> 
			    <table width="169" border="0" cellspacing="2" cellpadding="2">
                    <tr>
                      <td class="whiteMedium">TYPE</td>
                      <td>
					  <select name="type" class="formText135" id="type" onChange="loadTestTypeQuestion('0')">
					  <option value="0">All</option>
					  <%
					  String sql = " SELECT INT_TESTTYPEID,CHR_TESTNAME,CHR_DESC FROM hrm_m_testtype ORDER BY CHR_TESTNAME   " ;
				      String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					  for(int i=0;i<data.length;i++) 
                        out.println("<option value="+data[i][0]+">"+data[i][1]+"</option>");
						
					  %>
                      </select>
					  
					  <script language="javascript">setOptionValue('type','<%=request.getParameter("type")%>')</script>                      </td>
                    </tr>
              </table></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td >
				
				<div id="TestTypeTable" style="OVERFLOW:auto;width:100%;height:300px"></div>
				<br><br>
				<div id="totalRec" align="center"  ></div>			  </td>
			</tr>
		</table>		</td>
	</tr>

	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table   border="0" align="center" cellpadding="1" cellspacing="1" class="TableDesign">
        <tr class="para">
          <td height="22" ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('0')">ALL</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('A')">A</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('B')">B</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('C')">C</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('D')">D</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('E')">E</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('F')">F</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('G')">G</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('H')">H</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('I')">I</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('J')">J</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('K')">K</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('L')">L</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('M')">M</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('N')">N</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('O')">O</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('P')">P</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('Q')">Q</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('R')">R</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('S')">S</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('T')">T</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('U')">U</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('V')">V</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('W')">W</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('X')">X</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadTestTypeQuestion('Y')">Y</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadSkill('Z')">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
	  <td><input type="hidden" name="filename"	value="TestTypeQuestion">
        <input type="hidden" name="actionS"	value="HRMTestTypeQuestionDelete"></td>
  </tr>
	<tr>
	  <td><div align="center">
        <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_HRM FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_HRM FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_HRM FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('HRMmain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
      </div></td>
  </tr>
	<tr>
		<td>		 		</td>
	</tr>
</table>



<%@ include file="../footer.jsp"%>

</body>
</html>


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>


