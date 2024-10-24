<%@ page import="java.sql.*" isErrorPage="false" errorPage="./InValidSession.jsp"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page language="java"  %>
<%@ page import="java.util.*" %>
<%
try
{
%>
<head>

<title>:: HRM ::</title>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
 
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style2 {color: #CC00CC}
-->
</style>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste='return false;'>

<link href="../DropDown - Image/msdropdown/dd.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/uncompressed.jquery.dd.js"></script>


<form  AUTOCOMPLETE = "off" action="../SmartLoginAuth" name="report" method="post" >
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="1001"><%@ include file="indexhrm.jsp"%>	</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="229" align="center"><TABLE width=440 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
      <TBODY>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
          <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
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
          <TD width=425 valign="top"> <table width="99%" align="center">
            <tr>
              <td colspan="2" align="center" class="bold1">APPLICANT INFORMATIONS</td>
              </tr>
            <tr>
              <td class="boldEleven">Grade:</td>
              <td><select name="grade" onChange="Submit()"  style="width:170px">
                <option value="0">All</option>
                <option value="Top">Group-1</option>
                <option value="Middle">Group-2</option>
                <option value="Bottom">Group-3</option>
              </select></td>
            </tr>
            <tr>
              <td class="boldEleven">Job Title</td>
              <td><select name="title"  style="width:170px">
                <option value="0">All</option>
                <%
 
		String titleData[][] =  CommonFunctions.QueryExecute("SELECT INT_JOBID,CHR_JOBTITLE FROM hrm_m_jobdesign ");
		for(int u=0;u<titleData.length;u++)
			out.print("<option value='"+titleData[u][0]+"'>"+titleData[u][1]+"</option>"); 
	%>
              </select></td>
            </tr>
            <tr>
              <td class="boldEleven">Office</td>
              <td><select name="location"  style="width:170px">
                <option value="0">All</option>
                <%
 
		String locationData[][] =  CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM com_m_office");
		for(int u=0;u<locationData.length;u++)
			out.print("<option value='"+locationData[u][0]+"'>"+locationData[u][1]+"</option>"); 
	%>
              </select></td>
            </tr>
            <tr>
              <td class="boldEleven">Month:</td>
              <td><select name="month" id="month"  style="width:170px" >
                <option value="0">All</option>
                <%@ include file="../JavaScript/months.jsp"%>
              </select></td>
            </tr>
            <tr>
              <td class="boldEleven">Year:</td>
              <td><select name="year"  id="year" style="width:170px">
                <%@ include file="../JavaScript/years.jsp"%>
              </select>
                <script language='JavaScript' type="text/javascript">
				<!--			
					 
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						
						setOptionValue('month',month1);
						setOptionValue('year',year1);
						 
												
				//-->
            </script></td>
            </tr>
            <tr>
              <td class="boldEleven">Export Type:</td>
              <td><script language="javascript" type="text/javascript">
	$(document).ready(function() 
	{
		try 
		{
			$("#export").msDropDown();
			
		} 
		catch(e) 
		{
				
		}
	}
	)
        </script>
              <select name="export" id="export" style="width:170px;" >
                <option value="csv" title="../DropDown - Image/icons/csv.jpg">CSV </option>
                <option value="xls" title="../DropDown - Image/icons/excel.jpg">Excel </option>
                <option value="html" title="../DropDown - Image/icons/html.jpg">Html </option>
                <option value="pdf" selected title="../DropDown - Image/icons/pdf.jpg" selected>Pdf </option>
                <option value="rtf" title="../DropDown - Image/icons/rtf.jpg">Rtf </option>
              </select></td>
            </tr>
            <tr>
              <td colspan="2" align="center"><input name="filename" type="hidden" id="filename" value="JRept_Applicant">
                <input name="actionS" type="hidden" id="actionS" value="HRMJRept_Applicant">
                <input name="rptfilename" type="hidden" id="rptfilename" value="applicantlist1"></td>
            </tr>
            <tr>
              <td colspan="2" align="center"> <table width="150" border="0" align="center" cellpadding="1"
									cellspacing="1">
                <tr>
                  <td><input type="submit" value="Submit"  class="buttonbold13"/></td>
                  <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('HRMmain.jsp')"></td>
                </tr>
              </table></td>
            </tr>
          </table></TD>
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
    </TABLE></td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>

<tr><td><%@ include file="../footer.jsp"%></td></tr>
</table>
</form>
</body>
</html>
<%
}
catch(Exception e)
{
		System.out.println(e.getMessage());
}
%>