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
 		checkNull("TxtTest","Enter the Test Value")
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
<body  onpaste="return false;" onLoad="document.frmPerformance.TxtTest.focus()">
<form  AUTOCOMPLETE = "off" method="post" name='frmPerformance' action="../SmartLoginAuth" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="indexhrm.jsp"%>	</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td>
	
	<TABLE width=425 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
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
              <TD width=772 valign="top">
	<table width="425" border="0" align="center" cellpadding="2" cellspacing="2"   class="bolddeepblue">
        <!--DWLayoutTable-->
        <tr align="center" valign="middle"> 
          <td height="28" colspan="2" class="BackGround"  >Performance</td>       
            </tr>
<%

	String id = request.getParameter("appId");
	System.out.println("ID : "+id);

	String sql="SELECT ";
	sql = sql + "A.INT_APPID, A.INT_TEST, A.INT_INTERVIEW, A.INT_MEDICAL, A.INT_REFERENCE, A.INT_GD, ";
	sql = sql + "B.CHR_APPCODE, B.CHR_APPNAME, C.CHR_JOBTITLE ";
	sql = sql + "from hrm_t_jobperformance A, hrm_m_application B, hrm_m_jobdesign C ";
	sql = sql + "where A.INT_APPID= '"+id+"' and B.INT_APPID= '"+id+"' and B.INT_JOBID=C.INT_JOBID";

	String datas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	System.out.println("Data in the Query : " + datas.length);

    	    	    	         
%>
            
        <tr class="bolddeepblue"> 
          <td width="150" height="29" valign="middle" class="bolddeepblue">&nbsp;Application Code <span class="style3"></span>
          <input type="hidden" name="TxtAppId" id="TxtAppId" value="<%=datas[0][0]%>"></td>

          <td width="246" valign="middle"><font size='1'>&nbsp;<b><%=datas[0][6]%></b></font></td>
        </tr>
       
        <tr class="bolddeepblue">
          <td height="29" valign="middle" class="bolddeepblue">&nbsp;Applicant Name</td>
<!--      <td valign="top"><input size=30 type="text" name="TxtAppName" id="TxtAppName" value="<%=datas[0][7]%>" readonly></td> -->
     <td valign="middle"><font size='1'>&nbsp;<%=datas[0][7]%></font></td>
        </tr>
        <tr class="bolddeepblue">
          <td height="29" valign="middle" class="bolddeepblue">&nbsp;Job Title</td>
<!--      <td valign="top"><input size=30 type="text" name="TxtJobTitle" id="TxtJobTitle" value="<%=datas[0][8]%>" readonly></td> --> 
         <td valign="middle"><font size='1'>&nbsp;<%=datas[0][8]%></font></td>
        </tr>
        <tr class="bolddeepblue">
          <td height="29" valign="middle" class="bolddeepblue" >&nbsp;Test <font color='red'>*</font></td>
          <td valign="top">&nbsp;<input size=20 type="text" name="TxtTest" id="TxtTest" tabindex="2" onKeyPress="numericValue('TxtTest','4')" value="<%=datas[0][1]%>"  ></td>
        </tr>
        <tr class="bolddeepblue"> 
          <td width="150" height="29" valign="middle" class="bolddeepblue">&nbsp;Interview <font color='red'>*</font></td>
          <td width="246" valign="top">&nbsp;<input size=20 type="text" name="TxtInterview" id="TxtInterview" tabindex="3" onKeyPress="numericValue('TxtInterview','4')"  value="<%=datas[0][2] %>" >         </td>
    </tr>
     <tr class="bolddeepblue"> 
          <td width="150" height="29" valign="middle" class="bolddeepblue">&nbsp;Medical <font color='red'>*</font></td>
          <td width="246" valign="top">&nbsp;<input size=20 type="text" name="TxtMedical"  id="TxtMedical" tabindex="4" onKeyPress="numericValue('TxtMedical','4')" value="<%=datas[0][3]%>"  >         </td>
    </tr>
     <tr class="bolddeepblue"> 
          <td width="150" height="29" valign="middle" class="bolddeepblue">&nbsp;Reference <font color='red'>*</font></td>
          <td width="246" valign="top">&nbsp;<input size=20 type="text" name="TxtReference"  id="TxtReference" tabindex="5" onKeyPress="numericValue('TxtReference','4')" value="<%=datas[0][4]%>"  >         </td>
    </tr>
     <tr class="bolddeepblue">
       <td height="29" valign="middle" class="bolddeepblue">&nbsp;G.D. <font color='red'>*</font></td>
       <td valign="top"><input size=20 type="text" name="TxtGD"  id="TxtGD"  tabindex="6" onKeyPress="numericValue('TxtGD','4')"  value="<%=datas[0][5]%>" onBlur="Calc()"></td>
     </tr>
     <tr class="bolddeepblue"> 
          <td height="29" colspan="2" valign="middle" class="bolddeepblue"><table align="center" cellpadding="3" cellspacing="3">
            <tr>
              <td width="56" align="center" valign="top"><input type="hidden" name="filename" value="Performance">
                  <input name="actionS" type="hidden" id="actionS" value="HRMPerformanceEdit">
                  <input name="Submit" id="Submit" type="submit"  class="tMLAscreenHead" tabindex="7" value="Submit"   accesskey="s"    onClick="return valid();"></td>
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
<tr><td>&nbsp; </td></tr>
<tr><td>&nbsp; </td></tr>
<tr><td>&nbsp; </td></tr>
<tr><td><%@ include file="../footer.jsp"%></td></tr>
</table>
</form>
</body>
</html>
