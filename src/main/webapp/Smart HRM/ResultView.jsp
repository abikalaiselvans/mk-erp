  <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*" %>
<%@ include file="indexhrm.jsp"%>
<%!	ArrayList empdata = new ArrayList();%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

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
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/HRM/Results.js"></script>
<script language="javascript">
</script>		
 
<style type="text/css">
<!--
.style3 {color: #000000}
-->
</style>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadResult('0'),document.getElementById('month').focus()">
<form  AUTOCOMPLETE = "off" method="get" name="Performance" > 
<table width="100%" height="408" align="center"  >
  <tr>
    <td height="21" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td height="21" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td height="21" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td height="151" align="center">       
        <table width="90%" height="80" align="center" cellpadding="0" cellspacing="0" class="TableDesign">
          <!--DWLayoutTable-->
           <tr align="center" valign="middle"   background="">
            <td height="28" class="tablehead">
          <span class="whiteMedium">RESULTS</span></td>
          </tr>     
            
          <tr>
       		 <td height="31" ><table width="54%" border="0" align="center" cellpadding="1" cellspacing="1" class="boldEleven">
         		 <tr>
            		<td class="whiteMedium"><span class="boldThirteen">Month </td>
            		<td class="whiteMedium"><span class="boldThirteen">
              			<select name="month" id="month" onChange="loadResult('0')"  >
						<option value="0">All</option>
               				<%@ include file="../JavaScript/months.jsp" %>
              			</select>
       			   </span>            		</td>
            		<td class="whiteMedium">Year </td>
            		<td class="whiteMedium"><span class="boldThirteen">
              			<select name="year" id="year" onChange="loadResult('0')" >
                			
                			<%@ include file="../JavaScript/years.jsp" %>
              			</select>
           			   <script language='JavaScript' type="text/javascript">
							<!--			
								var d=new Date()
								var month1=d.getMonth() + 1
								if(month1<10) month1="0"+month1;
								var year1=d.getFullYear();
								setOptionValue('month',month1);
								setOptionValue('year',year1);							
							//-->
         			  </script>
				   </span>				  </td>
                    <td class="whiteMedium">Result</td>
       		        <td class="whiteMedium"><select name="finalstatus" id="finalstatus" onChange="loadResult('0')">
     		          <option value="0">All</option>
					  <option value="Y">Selected</option>
					  <option value="N">Not Selected</option>
					  
					  </select>   		           </td>
       		   </tr>
        </table>        </td>
      </tr>         
           
          <tr bgcolor="#FFFFFF">
          <td height="28" valign="top">
          	<div  id="ResultTable" style="OVERFLOW: auto;width:100%;height:300px">		  </div>
			<br>			</td>
      </table></td>
  </tr>        
  <tr>
    <td height="17">&nbsp;</td>
  </tr>
  <tr>
      <td height="17">
      <input name="filename" type="hidden" id="result" value="Q">
      <input name="actionS" type="hidden" id="actionS" value="HRMdemandDelete">
		<table width="90%" border="0" align="center" cellpadding="1" cellspacing="1" class="TableDesign">
        <tr class="para">
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('0')">All</a></div></td>	
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('A')">A</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('B')">B</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('C')">C</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('D')">D</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('E')">E</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('F')">F</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('G')">G</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('H')">H</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('I')">I</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('J')">J</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('K')">K</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('L')">L</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('M')">M</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('N')">N</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('O')">O</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('P')">P</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('Q')">Q</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('R')">R</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('S')">S</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('T')">T</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('U')">U</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('V')">V</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('W')">W</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('X')">X</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('Y')">Y</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadResult('Z')">Z</a></div></td>
        </tr>
      </table>    </td>
  </tr>
  <tr>
    <td height="17" align="center">  
  <tr>
      <td height="17" align="center"><center>
          <table  border="0" cellspacing="1" cellpadding="1">
            <tr>
              <td  width="56"><input class="ButtonHead" type="Button" name="Button"  value="Close"   accesskey="c"  onClick="redirect('HRMmain.jsp')"></td>
            </tr>
		  </table>
	<tr><td height="20" ><%@ include file="../footer.jsp"%></td></tr>
</table>
</body>
</html>


