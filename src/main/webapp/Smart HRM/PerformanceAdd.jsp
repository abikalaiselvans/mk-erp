<%@ page import="java.io.*,java.util.*" %>


<%@page import="com.my.org.erp.common.CommonInfo"%>
<html>
<head>

<title>:: HRM ::</title>


 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/HRM/HrmAjax.js"></script>
<script language="JavaScript">


function Calc()
{
	val1 = parseInt(document.getElementById("TxtTest").value);
	val2 = parseInt(document.getElementById("TxtInterview").value);
	val3 = parseInt(document.getElementById("TxtMedical").value);
	val4 = parseInt(document.getElementById("TxtReference").value);	
	val5 = parseInt(document.getElementById("TxtGD").value);	
	
	tot = val1 + val2 + val3 + val4 + val5;
	
	if (tot>100)
	{
		alert('Total Marks Should not Exceed 100');
		document.getElementById("TxtTest").focus();
		return false;
	}
	return true;
}






function valid()
{
  	if(

		checkNullSelect("selAppCode", "Select the Application Code", "0")	
  		&& checkNull("TxtTest","Enter the Test Value")
  	  	&& checkNull("TxtInterview","Enter the Interview Value")
  	  	&& checkNull("TxtMedical","Enter the Medical Value")
  	  	&& checkNull("TxtReference","Enter the Test Value")
  	  	&& checkNull("TxtGD","Enter the GD Value")
 		&& Calc() 	
  	
  	)
		return true;
	else
		return false;	
	 	
  }  	
</script>
 <link href="../Styles/styles.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {color: #FF0000}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
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
</head>
<body  onpaste="return false;" onLoad="document.frmPerformance.selAppCode.focus()">
<form  AUTOCOMPLETE = "off" method="post" name='frmPerformance' action="../SmartLoginAuth" >
<%@ include file="indexhrm.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>	</td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
  </tr>
  <tr>
    <td>
	
		<TABLE width=440 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
          <TBODY>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
              <TD class=BorderLine height=1><SPACER height="1" 
                        width="1" type="block" /></TD>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TRCorner.gif" width=7></TD>
            </TR>
            <TR>
              <TD height=6><SPACER height="1" width="1" type="block"/></TD>
            </TR>
            <TR>
              <TD class=BorderLine width=1><SPACER height="1" 
                        width="1" type="block" /></TD>
              <TD width=6><SPACER height="1" width="1" type="block" 
                      /></TD>
              <TD width=425 valign="top">
	<table width="600" border="0" align="center" cellpadding="2" cellspacing="2"   class="bolddeepblue">
        <!--DWLayoutTable-->
        <tr align="center" valign="middle"> 
          <td height="28" colspan="2" class="BackGround"  >Performance</td>       
            </tr>
            
        <tr class="bolddeepblue"> 
          <td width="200" height="29" valign="middle" class="boldEleven">Application Code <span class="style3"><font color='red'>*</font></span>
          <input type="hidden" name="TxtAppId" id="TxtAppId">          </td>

          <td width="211" valign="top">
		  
		  
<select name="selAppCode" size="1" style="width:auto" class="formText135" id="selAppCode" tabindex="1" onChange="loadComboPerformance(this)">
		  <option value="0">Select</option>
<%

	String sql1= "select a.INT_APPID, a.CHR_APPCODE,a.CHR_APPNAME from hrm_m_application a WHERE CHR_OFFERORDERSTATUS='N' AND    a.INT_APPID not in(SELECT b.INT_APPID FROM hrm_t_jobperformance b)";
  	String datas1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);
   
	
  	for (int i=0; i<datas1.length; i++)
  			out.println("<option value="+datas1[i][0]+">"+ datas1[i][1] + " / "+ datas1[i][2] +"</option>");

%>
		  </select>
		  <div id ="ErrMsgId"></div>		  </td>
        </tr>
       
        <tr class="bolddeepblue">
		<input type="hidden" name="TxtAppId" id="TxtAppId">
          <td height="29" valign="middle" class="boldEleven">Applicant Name</td>
    <td valign="top"><input name="TxtAppName" type="text" disabled='true' class="formText135" id="TxtAppName" size=30></td>
        </tr>
        <tr class="bolddeepblue">
          <td height="29" valign="middle" class="boldEleven">Job Title</td>
          <td valign="top"><input name="TxtJobTitle" type="text" disabled='true' class="formText135" id="TxtJobTitle" size=30></td>
        </tr>
        <tr class="bolddeepblue">
          <td height="29" valign="middle" class="boldEleven" >Test <span class="style3"><font color='red'>*</font></span></td>
          <td valign="top"><input name="TxtTest" type="text" class="formText135" id="TxtTest" tabindex="2" onKeyPress="numericValue('TxtTest','4')" size=20  ></td>
        </tr>
        <tr class="bolddeepblue"> 
          <td width="200" height="29" valign="middle" class="boldEleven">Interview
             <span class="style3"><font color='red'>*</font></span></td>
          <td width="211" valign="top">
        <input name="TxtInterview" type="text" class="formText135" id="TxtInterview" tabindex="3" onKeyPress="numericValue('TxtInterview','4')" size=20  >         </td>
    </tr>
     <tr class="bolddeepblue"> 
          <td width="200" height="29" valign="middle" class="boldEleven">Medical
             <span class="style3"><font color='red'>*</font></span></td>
          <td width="211" valign="top">
        <input name="TxtMedical" type="text" class="formText135"  id="TxtMedical" tabindex="4" onKeyPress="numericValue('TxtMedical','4')" size=20  >         </td>
    </tr>
     <tr class="bolddeepblue"> 
          <td width="200" height="29" valign="middle" class="boldEleven">Reference
             <span class="style3"><font color='red'>*</font></span></td>
          <td width="211" valign="top">
        <input name="TxtReference" type="text" class="formText135"  id="TxtReference" tabindex="5" onKeyPress="numericValue('TxtReference','4')" size=20  >         </td>
    </tr>
     <tr class="bolddeepblue">
       <td height="29" valign="middle" class="boldEleven">G.D. <span class="style3"><font color='red'>*</font></span></td>
       <td valign="top"><input name="TxtGD" type="text" class="formText135"  id="TxtGD"  tabindex="6"  onBlur="Calc()" onKeyPress="numericValue('TxtGD','4')" size=20>
         <input type="hidden" name="filename" value="Performance">
         <input name="actionS" type="hidden" id="actionS" value="HRMPerformanceAdd"></td>
     </tr>
     <tr class="bolddeepblue"> 
          <td height="29" colspan="2" valign="middle" class="bolddeepblue"><table align="center" cellpadding="3">
            <tr>
              <td width="56" align="center" valign="top"><input name="Submit" id="Submit" type="submit"  class="tMLAscreenHead" tabindex="7" value="Submit"   accesskey="s"    onClick="return valid();"></td>
              <td width="56" valign="top"><input class="tMLAscreenHead" type="button" name="Close"  value="Close"   accesskey="c"  tabindex="8" onClick="redirect('PerformanceView.jsp')"></td>
            </tr>
          </table></td>
          </tr>     
  </table>  </TD>
              <TD noWrap width=7><SPACER height="1" width="1" 
                        type="block" /></TD>
              <TD class=BorderLine width=1><SPACER height="1" width="1" type="block" /></TD>
            </TR>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/BLCorner.gif" width=7></TD>
              <TD height=6><SPACER height="1" width="1" type="block"/></TD>
              <TD colSpan=2 rowSpan=2 valign="bottom"><div align="right"><IMG height=7 src="../Image/General/BRCorner.gif" width=7></div></TD>
            </TR>
            <TR>
              <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
            </TR>
          </TBODY>
        </TABLE>  </td>
  </tr>
<tr><td>&nbsp; </td></tr>
<tr><td>&nbsp;  </td></tr>
<tr><td><%@ include file="../footer.jsp"%></td></tr>
</table>
</form>
</body>
</html>
