 <%
 try
 {
	 
String selfmarking="R" ;
String actionS ="AttendanceMarkingResponse.jsp";
String rData[][] = CommonFunctions.QueryExecute("SELECT CHR_ATTENDANCE_SELFMARKING FROM att_m_basicsettings WHERE INT_ID=1 ");
if(rData.length>0)
	selfmarking = rData[0][0];
	
if("I".equals(selfmarking))	
	actionS ="AttendanceMarkingResponseIndividual.jsp";

 %>
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='ATT' ")[0][0]%></title>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<%@include file="Redirect.jsp" %>


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<script language="javascript">
function  validate()
{
	try
	{
		if(
			checkNull('month' ,'Select Month')
			&& checkNull('year','Select Year')
		  )
		  	return true;
		else
			return false;
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
</script>
</head>
<body  onpaste='return false;'>
<form  AUTOCOMPLETE = "off"   name="a" action="<%=actionS%>" onSubmit="return validate()" >
<p>&nbsp;</p>
<p>&nbsp;</p>
<table border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
  <tbody>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
      <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
    </tr>
    <tr>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
    </tr>
    <tr>
      <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
      <td width="6"><spacer height="1" width="1" type="block"></td>
      <td width="577" valign="top"><table width="350" align="center" border="0"  >
        <!--DWLayoutTable-->
        <tr align="center" valign="middle" class="tabledata">
          <td height="32" colspan="2" class="boldEleven"><%
		String comId=request.getParameter("compId");
		String branchId=request.getParameter("branchId");
		out.println("<input type='hidden' name='company' value='"+comId+"'>");
		out.println("<input type='hidden' name='branch' value='"+branchId+"'>");	
		String empid = ""+session.getAttribute("EMPID");
	  %>
            Attendance
            Marking View</td>
        </tr>
        <tr>
          <td width="136" height="32" valign="middle" class="bolddeepblue"><span
								class="tabledata">Month</span></td>
          <td width="288" valign="middle" align="left"><strong> <font size="1"><font size="1">
            <select name="month"  id="month" 	class="formText135">
              <option value="">Select Month</option>
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
            </select>
          </font></font> </strong></td>
        </tr>
        <tr>
          <td height="33" valign="middle" class="bolddeepblue"><span
								class="tabledata">Year </span></td>
          <td valign="middle" align="left"><strong>
            <select
								name="year" id="year" class="formText135">
              <option value="">Select Year</option>
              <%
								java.util.Date d = new java.util.Date();
								int y = 1900+d.getYear();
								int styear = y-20;
								int edyear = y+20;
			         for(int i=styear;i<=edyear;i++)
			      {
			       out.println("<option value="+i+">"+i+"</option>");
			      }
			     %>
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
            <input type="hidden" name="filename" value="Attendance">
            <input type="hidden" name="actionS"
								value="ATTAttendanceStaffMonth">
            <input name="empid" type="hidden" id="empid" value="<%=empid%>">
          </strong></td>
        </tr>
        <tr>
          <td height="33" colspan="2" valign="middle" class="bolddeepblue"><table width="100" border="0" align="center" cellpadding="2"
								cellspacing="2">
            <tr>
              <td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"   ></td>
              <td width="56"><input name="Button" type="Button"
										class="buttonbold"  value="Close"   accesskey="c" 
										 onClick="redirect('iframeStaffMain.jsp')"></td>
            </tr>
          </table>
                <p class="tabledata">&nbsp;</p></td>
        </tr>
      </table></td>
      <td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
      <td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
    </tr>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
      <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div></td>
    </tr>
    <tr>
      <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
    </tr>
  </tbody>
</table>

</form>

</body>


</html>
<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
	out.println(e.getMessage());
}
%>