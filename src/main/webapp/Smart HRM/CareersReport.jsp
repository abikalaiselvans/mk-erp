<%@ page import="java.sql.*,java.io.*,java.util.* "%>
<%@ include file="indexhrm.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions" %>
<%
try
{
%>

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

 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/HRM/CareereAjax.js"></script>
<script language="javascript">


function careersSendMail(Name,query)
{
		var r=confirm("ARE YOU SURE YOU WANT TO SEND   "+Name.toUpperCase() +" RESUME TO MAIL ...");
		if (r==true)
	  	{
	  		var mailid=prompt("Enter  Email id","test@test.net"); 
	  		if (mailid!=null && mailid!="")
  			{
	  			var d =query+"&email="+mailid;
	  			document.frm.action=""+d; 
				document.frm.submit(); 
			}	
	  	}
}
 
</script>
 
 
   
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
@import url("../bootstrap/css/bootstrap.min.css");

-->
</style>

 

  <script src="../bootstrap/js/jquery.min.js"></script>
 <script src="../bootstrap/js/bootstrap.min.js"></script>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadResume('0')" >
<form  AUTOCOMPLETE = "off"   method="post" name="frm" >
<table width="100%" height="285" align="center">
	<tr>
		<td height="151" align="center"><br>
		<table width="90%" height="87" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"  >
				<td height="28" 
					class="tablehead"><span class="whiteMedium">CAREERS RESUME </span></td>
			</tr>
			<tr>
				<td height="31">
				<table width="94%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="boldEleven">
					<tr>
					  <td class="whiteMedium">Year of Experience</td>
					  <td><select name="yearofexperience" id="yearofexperience" onChange="loadResume('0') " class="formText135">
					    <option value="0" selected="selected">All</option>
					    <option value="-1">Below one year</option>
					    <option value="-2">Below 6-months</option>
					    <option value="-3">Fresher</option>
					    <option value="1">1+</option>
					    <option value="2">2+</option>
					    <option value="3">3+</option>
					    <option value="4">4+</option>
					    <option value="5">5+</option>
					    <option value="6">6+</option>
					    <option value="7">7+</option>
					    <option value="8">8+</option>
					    <option value="9">9+</option>
					    <option value="10">10+</option>
					    <option value="11">11+</option>
					    <option value="12">12+</option>
					    <option value="13">13+</option>
					    <option value="14">14+</option>
					    <option value="15">15+</option>
					    <option value="16">16+</option>
					    <option value="17">17+</option>
					    <option value="18">18+</option>
					    <option value="19">19+</option>
					    <option value="20">20+</option>
					    <option value="21">21+</option>
					    <option value="22">22+</option>
					    <option value="23">23+</option>
					    <option value="24">24+</option>
                        <option value="25">25+</option>
					    </select></td>
					  <td class="whiteMedium">Day</td>
					    <td class="whiteMedium"><select name="day" id="day"  onBlur="loadResume('0') "  class="formText135">
                            <option value="0">All</option>
                            <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                          </select>                      </td>
						<td class="whiteMedium">Month </td>
						<td class="whiteMedium"><span class="boldThirteen"> 
						<select name="month" class="formText135"	id="month" onChange="loadResume('0')">
						<option value="0">All</option>
							<%@ include file="../JavaScript/months.jsp"%>
					  </select> </span></td>
						<td class="whiteMedium"><span class="boldThirteen">Year </span></td>
						<td class="whiteMedium"><span class="boldThirteen"> 
						<select name="year"	id="year" onBlur="loadResume('0')"  class="formText135">
							<%@ include file="../JavaScript/years.jsp"%>
					  </select> <script language='JavaScript' type="text/javascript">
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
          </script> </span></td>
					   
					</tr>
			  </table>				</td>
			</tr>
			<tr>
				<td height="28" valign="top" bgcolor="#FFFFFF">
				<div id="CareerTable" 	style="OVERFLOW: auto;width:100%;height:250px"></div>	
				<br>
				<div id="totalRec" ></div><br>	<br>			  </td>
		</table>		</td>
	</tr>
	<tr>
	  <td height="17">&nbsp;</td>
  </tr>
	<tr>
	  <td height="17"><table width="95%" border="0" align="center" cellpadding="1" cellspacing="1" class="TableDesign">
        <tr class="para">
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('0')">All</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('A')">A</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('B')">B</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('C')">C</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('D')">D</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('E')">E</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('F')">F</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('G')">G</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('H')">H</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('I')">I</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('J')">J</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('K')">K</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('L')">L</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('M')">M</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('N')">N</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('O')">O</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('P')">P</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('Q')">Q</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('R')">R</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('S')">S</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('T')">T</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('U')">U</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('V')">V</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('W')">W</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('X')">X</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('Y')">Y</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResume('Z')">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
		<td height="17">&nbsp; </td>
	</tr>
	<tr>
		<td height="17" align="center">
		 
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				 
				<td width="56">
				<input  class="TableDesign" type="Button"	name="Button"  value="Close"   accesskey="c" 
					onClick="redirect('HRMmain.jsp')"></td>
			</tr>
		</table>
	<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
<%
}
catch(Exception e)
{
}
%>
