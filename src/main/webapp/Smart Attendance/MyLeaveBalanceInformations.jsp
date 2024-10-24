<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: ATTENDANCE ::</title>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
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

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Attendance/AttendanceLeaveReport.js"></script>
</head><body  onpaste="return false;" onLoad="loadAttendanceReport( ) ">

 <%@ include file="index.jsp"%>
<br>
 
  
 
<table border="0" align="center" cellpadding="0"
	cellspacing="0">
  <tr>
    <td width="489">&nbsp;</td>
  </tr>
  <tr>
    <td><span class="tablehead"><span class="boldEleven"> </span></span></td>
  </tr>
  <tr>
    <td><table width="800" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
          <td width="222" height="1" class="BorderLine"><spacer
						height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block" /></td>
          <td valign="top"><table width="800" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="100%"><div align="center" class="boldEleven"><strong> </strong>
                           
                  <%
	try
	{
	
	String empid= session.getAttribute("EMPID").toString();
	String sql = "SELECT INT_LEAVEID,CHR_LEAVENAME,CHR_SYMBOL FROM att_m_leavetype ORDER BY INT_LEAVEID";
	String Leaves[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	sql = "SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+empid+"'";
	 
	
	 if(Leaves.length>0)
	{
		
		//out.println("<tr bgcolor='#ffffff'><td class='boldEleven' colspan=2  >");
		out.println("<center>");
		out.println("<table  width='80%'  class='boldEleven' cellpadding=5 cellspacing=3 bgcolor='#9900CC' >");
		out.println("<tr bgcolor='#ffffff'><td class='boldEleven' colspan='4' align='center' ><b>Leave Details for the current year</b></td></tr>");
		
		out.println("<tr bgcolor='#ffffff'><td class='boldEleven'  ><b>Leave name</b>");
		out.println("<td class='boldEleven'  ><b>No of Leave</b>");
		out.println("<td class='boldEleven'  ><b>Leave Taken</b>");
		out.println("<td class='boldEleven'  ><b>Balance Leave</b>");
		
		for(int u=0; u<Leaves.length; u++)
		{
			if(u%2==0)
				out.println("<tr  class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");
			
			out.println("<td class='boldEleven' >"+Leaves[u][1]+"&nbsp;</td>");
			sql="SELECT INT_NOD"+Leaves[u][0]+",INT_NOD"+Leaves[u][0]+"BALANCE ,(INT_NOD"+Leaves[u][0]+" -INT_NOD"+Leaves[u][0]+"BALANCE) FROM att_m_leave  WHERE CHR_EMPID='"+empid+"' AND INT_YEAR =year(now())";
			String LData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			
			if(LData.length>0)
			{
				out.println("<td class='boldEleven' >"+LData[0][0]+"&nbsp;</td>");
				out.println("<td class='boldEleven' >"+LData[0][1]+"&nbsp;</td>");
				out.println("<td class='boldEleven' >"+LData[0][2]+"&nbsp;</td>");
			}
			else
			{
				out.println("<td class='boldEleven' >&nbsp;</td>");
				out.println("<td class='boldEleven' >&nbsp;</td>");
				out.println("<td class='boldEleven' >&nbsp;</td>");
			
			}	
		
		}
		out.println("</table>");
		out.println("</center>");
		
		
		
		
		/*//out.println("<tr bgcolor='#ffffff'><td class='boldEleven' colspan=2  >");
		out.println("<center>");
		out.println("<table  width='80%'  class='boldEleven' cellpadding=3 cellspacing=2 bgcolor='#9900CC' >");
		out.println("<tr bgcolor='#ffffff'><td class='boldEleven'  colspan='5' align='center' ><b>"+empid+" / " + com.my.org.erp.common.CommonFunctions.employeeName(EMPID)+"  :: Leave Balance Informations for the current year</b>");
		out.println("<tr bgcolor='#ffffff'><td class='boldEleven'  ><b>S.No</b><td class='boldEleven'  ><b>Leave name</b>");
		out.println("<td class='boldEleven'  ><b>No of Leave</b>");
		out.println("<td class='boldEleven'  ><b>Leave Taken</b>");
		out.println("<td class='boldEleven'  ><b>Balance Leave</b>");
		double lc=0;
		double lt=0;
		for(int u=0; u<Leaves.length; u++)
		{
			
			lc=0;
			lt=0;
			if(u%2==0)
				out.println("<tr  class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");
			
			out.println("<td class='boldEleven'  align='left'>"+(u+1)+".");
			out.println("<td class='boldEleven' align='left' >"+Leaves[u][1]+"");
			 
			
			//LEAVE CREDIT
			sql="SELECT INT_NOD"+Leaves[u][0]+" FROM att_m_leave  WHERE CHR_EMPID='"+empid+"' AND INT_YEAR =year(now())";
			lc= Double.parseDouble(com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]); 
			out.println("<td class='boldEleven'  align='right' >"+lc);
			
			//LEAVE TAKEN
			sql = "SELECT SUM(DOU_VALUE) FROM att_t_leave WHERE CHR_EMPID='"+empid+"' ";
			sql = sql +" AND YEAR(DT_LDATE)=year(now())  AND CHR_LEAVETYPE='"+Leaves[u][2]+"' ";
			if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
				lt= Double.parseDouble(com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]); 
			else
				lt=0;
			
			
			out.println("<td class='boldEleven' align='right' >"+ lt);
			out.println("<td class='boldEleven'  align='right' >"+(lc-lt));
		
		}
		out.println("</table>");
		out.println("</center>");*/
		
		
	}	
	 
	}
	catch(Exception e)
	{
	}
			%>
              </div></td>
            </tr>
            <tr> </tr>
            <tr>
              <td height="18">&nbsp;</td>
            </tr>
            <tr>
              <td height="18"><table width="300" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td class="bold1">Month</td>
                  <td><span class="boldThirteen">
                    <select name="month"   class="formText135" onChange="loadAttendanceReport( ) "  
							id="month"   onBlur="loadAttendanceReport( )  ">
                      <option value="0">All</option>
                      <%@ include file="../JavaScript/months.jsp"%>
                    </select>
                  </span></td>
                  <td class="bold1">Year</td>
                  <td><span class="boldThirteen">
                    <select name="year" class="formText135" onChange="loadAttendanceReport( ) "
							id="year"    onBlur="loadAttendanceReport( )  ">
                      <%@ include file="../JavaScript/years.jsp"%>
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
                  </span></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td height="18">&nbsp;</td>
            </tr>
            <tr>
              <td height="18"><div id="AttendanceReportTable" style="OVERFLOW: auto;width:100%;height:auto"> </div></td>
            </tr>
          </table></td>
          <td nowrap="nowrap" width="4"><spacer height="1" width="1"
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
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><a href="javascript:window.print()">print</a></td>
  </tr>
  <tr>
    <td><table width="56" align="center">
      <tr>
        <td><input name="Button" type="Button" class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('AttendanceMain.jsp')">
        </td>
      </tr>
    </table></td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
</body>


</html>
