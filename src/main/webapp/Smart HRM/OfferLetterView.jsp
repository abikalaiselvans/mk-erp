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
<script language="JavaScript" src="../JavaScript/HRM/Offer.js"></script>
<script language="javascript">

function Add()
 	{		
		document.frm.action="Offerletter.jsp";
		
 	}	
	
	
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].rowid
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
			if (document.forms[0].rowid.checked) { count=1;}
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
	
</script>		
 
<style type="text/css">
<!--
.style3 {color: #000000}
-->
</style>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadOfferview('0'),document.getElementById('month').focus()">
<form  AUTOCOMPLETE = "off" method="get" name="frm" > 
<table width="100%" height="301" align="center"  >
  <tr>
    <td height="21" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td height="21" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td height="151" align="center">       
        <table width="95%" height="80" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign">
          <!--DWLayoutTable-->
           <tr align="center" valign="middle"   background="">
            <td height="28" class="whiteMedium">          RESULTS</td>
          </tr>     
            
          <tr>
       		 <td height="31" ><table width="90%"  border="0" align="center" cellpadding="2" cellspacing="3" class="boldEleven">
         		 <tr> 
				 <td class="whiteMedium">Office</td>
         		   <td class="whiteMedium"><select name="office" class="formText135" id="office"  onChange="LoadOfferview('0')" >
                     <option value="0">All</option>
                     <%
				   	String offdata[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(" SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office ORDER BY CHR_OFFICENAME ");
					for(int c=0;c<offdata.length;c++)
						out.println("<option value='"+offdata[c][0]+"'  >"+offdata[c][1]+"</option>");	
					
				
				   %>
                   </select></td>
            		<td class="whiteMedium"><span class="boldThirteen">Month ::</td>
            		<td class="whiteMedium"><span class="boldThirteen">
              			<select name="month" id="month" onChange="LoadOfferview('0')"  >
						<option value="0">All</option>
               				<%@ include file="../JavaScript/months.jsp" %>
              			</select>
       			   </span>            		</td>
            		<td class="whiteMedium">Year  ::</td>
            		<td class="whiteMedium"><span class="boldThirteen">
              			<select name="year" id="year" onChange="LoadOfferview('0')" >
                			
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
                     
       		        <td class="whiteMedium">Offer</td>
       		        <td class="whiteMedium"><select name="finalstatus" id="finalstatus" onChange="LoadOfferview('0')">
                        <option value="0">All</option>
                        <option value="Y">Issued</option>
                        <option value="N">Not Issued</option>
                   </select>                    </td>
       		        <td class="whiteMedium">Offer Accept</td>
       		        <td class="whiteMedium"> 
					<select name="offerstatus"  id="offerstatus" onChange="LoadOfferview('0')">
					<option value="0">All</option>
					<option value="Y">Accept offer</option>
					<option value="N">Accept offer pending </option>
				   </select></td>
       		   </tr>
        </table>        </td>
      </tr>         
           
          <tr bgcolor="#FFFFFF">
          <td height="28" valign="top">
          	<div  id="ResultTable" style="OVERFLOW: auto;width:100%;height:350px">		  </div>
			<br>
		    <div id="totalRec"></div><br>			</td>
      </table></td>
  </tr>        
  <tr>
    <td height="17">&nbsp;</td>
  </tr>
  <tr>
      <td height="17">
      <input name="filename" type="hidden" id="result" value="OfferLetter">
      <input name="actionS" type="hidden" id="actionS" value="HRMOfferLetterDelete">
		<table width="95%" border="0" align="center" cellpadding="1" cellspacing="1" class="TableDesign">
        <tr class="para">
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('0')">All</a></div></td>	
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('A')">A</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('B')">B</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('C')">C</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('D')">D</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('E')">E</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('F')">F</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('G')">G</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('H')">H</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('I')">I</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('J')">J</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('K')">K</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('L')">L</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('M')">M</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('N')">N</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('O')">O</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('P')">P</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('Q')">Q</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('R')">R</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('S')">S</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('T')">T</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('U')">U</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('V')">V</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('W')">W</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('X')">X</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('Y')">Y</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:LoadOfferview('Z')">Z</a></div></td>
        </tr>
      </table>    </td>
  </tr>
  <tr>
    <td height="17" align="center">  
  <tr>
      <td height="17" align="center"><center>
          <table  border="0" cellspacing="1" cellpadding="1">
            <tr>
              <td width="56"><input class="ButtonHead" name="submit2" type="submit" onClick="Add()" value="Add"></td>
              
			   
 
				 
			  <td  width="56"><input class="ButtonHead" type="Button" name="Button"  value="Close"   accesskey="c"  onClick="redirect('HRMmain.jsp')"></td>
            </tr>
		  </table>
	<tr><td height="20" ><%@ include file="../footer.jsp"%></td></tr>
</table>
</body>
</html>


