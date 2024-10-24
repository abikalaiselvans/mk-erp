<%@ page import="java.io.*,java.util.*" %>


<%!
	String stateName,stateId;
	String districtName,districtDes,districtId;
	String actionStu;
%>
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
 	if(checkNull("TxtTest","Enter the Test Value")
  	  	&& checkNull("TxtInterview","Enter the Interview Value")
  	  	  	&& checkNull("TxtMedical","Enter the Medical Value")
  	  	  	  	&& checkNull("TxtReference","Enter the Reference Value")
  	  	  	  	  	&& checkNull("TxtGD","Enter the GD Value")
  	  	  	  	  	&& Calc())
	{
		return true;
	}
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
<body  onpaste="return false;" >
<form  AUTOCOMPLETE = "off" method="get" name='frmDemand' action="../SmartLoginAuth" >
<%@ include file="indexhrm.jsp"%>	
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<%
		String jobId=request.getParameter("OptJobId");
		String query="select A.CHR_JOBGRADE,A.CHR_JOBTITLE,B.INT_TEST,INT_INTERVIEW,INT_MEDICAL,INT_REFERENCE,INT_GD from ";
		query=query+" hrm_m_jobdesign  A,hrm_m_jobperformance B where A.INT_JOBID=B.INT_JOBID AND A.INT_JOBID='"+jobId+"' ";
		String data[][]=com.my.org.erp.common.CommonInfo.KRecordSetArray(query);
		 String grade=data[0][0];
		%>
  <tr>
    <td></td>
  </tr>
  <tr>
    <td height="10">&nbsp;</td>
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
	<table width="286" border="0" align="center" cellpadding="2" cellspacing="2"   class="bolddeepblue">
        <!--DWLayoutTable-->
        <tr align="center" valign="middle"> 
          <td height="28" colspan="2" class="BackGround"  >Recruitment</td>
            </tr>
           <tr> 
          <td width="150" height="29" valign="middle" class="boldEleven">Job Grade</td>
            <td width='246' valign='middle' class="boldEleven"><font size='1'><b>&nbsp;&nbsp;<%=data[0][0]%></b></font></td>
        </tr>
       
         <tr> 
          <td width="150" height="29" valign="middle" class="boldEleven">Job Title</td>
            <td width='246' valign='top'><select name="OptJobTitle" class="formText135" id="OptJobTitle">
          <%
            String sql1="select INT_JOBID,CHR_JOBTITLE from hrm_m_jobdesign where CHR_JOBGRADE='"+grade+"' ";
            String query1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);           
            for(int j=0;j<query1.length;j++)
            {
            	if(data[0][1].trim().equals(query1[j][1].trim()))
            		out.println("<option value='"+query1[j][0]+"' selected='selected'>"+query1[j][1]+"</option>");                    
//            	else	
 //           		out.println("<option value='"+query1[j][0]+"'>"+query1[j][1]+"</option>");                    
            }            	
           %>                     
           </select>           </td>
        </tr> 
        <tr class="bolddeepblue"> 
          <td width="150" height="29" valign="middle" class="boldEleven">Test
             <span class="style3"><font color='red'>*</font></span></td>
          <td width="246" valign="top"><input name="TxtTest" type="text" class="formText135"  onKeyPress="numericValue('TxtTest','4')" value="<%=data[0][2]%>" size=20 maxlength="2" >         </td>
        </tr>
       
    <tr class="bolddeepblue"> 
          <td width="150" height="29" valign="middle" class="boldEleven">Interview
             <span class="style3"><font color='red'>*</font></span></td>
          <td width="246" valign="top"><input name="TxtInterview" type="text" class="formText135"  onKeyPress="numericValue('TxtInterview','4')" value="<%=data[0][3]%>" size=20 maxlength="2" >         </td>
    </tr>
     <tr class="bolddeepblue"> 
          <td width="150" height="29" valign="middle" class="boldEleven">Medical
             <span class="style3"><font color='red'>*</font></span></td>
          <td width="246" valign="top"><input name="TxtMedical" type="text" class="formText135"  onKeyPress="numericValue('TxtMedical','4')" value="<%=data[0][4]%>" size=20 maxlength="2" >         </td>
    </tr>
     <tr class="bolddeepblue"> 
          <td width="150" height="29" valign="middle" class="boldEleven">Reference
             <span class="style3"><font color='red'>*</font></span></td>
          <td width="246" valign="top"><input name="TxtReference" type="text" class="formText135"  onKeyPress="numericValue('TxtReference','4')" value="<%=data[0][5]%>" size=20 maxlength="2" >         </td>
    </tr>
     <tr class="bolddeepblue">
       <td height="29" valign="middle" class="boldEleven">G.D. <span class="style3"><font color='red'>*</font></span></td>
       <td valign="top"><input name="TxtGD" type="text" class="formText135" onBlur="Calc()"  onKeyPress="numericValue('TxtGD','4')" value="<%=data[0][6]%>" size=20 maxlength="2">
         <input type="hidden" name="filename" value="Recruitment">
         <input name="actionS" type="hidden" id="actionS" value="HRMRecruitmentEdit"></td>
     </tr>
     <tr class="bolddeepblue"> 
          <td colspan="2" valign="middle" class="bolddeepblue"><table align="center" cellpadding="3" cellspacing="3">
            <tr>
              <td width="56" align="center" valign="top"><input name="Submit" id="Submit" type="submit"  class="tMLAscreenHead" value="Submit"   accesskey="s"    onClick="return valid();"></td>
              <td width="56" valign="top"><input class="tMLAscreenHead" type="button" name="Close"  value="Close"   accesskey="c"  onClick="redirect('RecruitmentView.jsp')"></td>
            </tr>
          </table></td>
          </tr>     
  </table>   </TD>
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
  <tr>
  
    <td>&nbsp;</td>
  </tr>

<tr><td><%@ include file="../footer.jsp"%></td></tr>
</table>
</form>
</body>
</html>
