<%@ page   language="java" 	import="java.sql.*" errorPage=""%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<%@include file="Redirect.jsp" %>

 

<html>
<head>
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

<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='STA' ")[0][0]%></title>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/staff/Daillycalls.js"></script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %> 
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript">

    function GAdd()
	{ 
		 
		 document.frm.action="DailyCallsAction.jsp";
 	}

	function GEdit()
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
		if(count==1){			
			document.frm.action="DailyCallsEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	 function  SFAUpload(rowid)
	{
		var f ="../Smart Marketing/SFAUpload.jsp?rowid="+rowid;
		newWindow = window.open(f,"subWind",",,height=400,width=600,top=0,left=0");
		newWindow.focus( );
	}
	
 </script>
<body  onpaste="return false;" onLoad="LoadScheduleEntrystaff('0')" >
 
<form  AUTOCOMPLETE = "off"   action="" method="get" name="frm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td><table width="90%" height="200" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign">
	  	
        <tr>
          <td height="31"><div align="center" class="whiteMedium">DAILY CALLS </div></td>
        </tr>
        <tr  >
          <td height="31" align="center" valign="top"  ><table border="0" align="center" cellpadding="2"
					cellspacing="2" class="whiteMedium">
            <tr>
              <td  >Customer </td>
              <td  class="boldEleven"><select name="customer" class="formText135" id="customer" onBlur="LoadScheduleEntrystaff('0')" style="width:175">
                <option value="0">All</option>
                <%
				
 
 
String cdata[][]= CommonFunctions.QueryExecute("SELECT a.INT_CUSTOMERID,b.CHR_NAME ,FIND_A_MKT_CUSTOMER_ADDRESS(a.INT_CUSTOMERID) FROM mkt_m_customerinfo a, mkt_m_customername b  WHERE a.INT_CUSTOMERNAMEID =b.INT_CUSTOMERNAMEID  AND  a.CHR_VERIFY='Y'  ORDER BY b.CHR_NAME");
if(cdata.length>0)
for(int u=0;u<cdata.length;u++)
	out.println("<option value='"+cdata[u][0]+"'>"+cdata[u][1]+" / "+cdata[u][2]+"</option>");
%>
              </select></td>
              <td  >Call Type</td>
              <td  ><span class="boldEleven">
                <select name="calltype" class="formText135" id="calltype"   onBlur="LoadScheduleEntrystaff('0') " style="width:100">
                  <option value="0">All</option>
                  <%
							String ctdata[][]= CommonFunctions.QueryExecute("SELECT INT_CALLTYPEID,CHR_CALLTYPE FROM mkt_k_calltype ORDER BY CHR_CALLTYPE");
							if(ctdata.length>0)
							for(int u=0;u<ctdata.length;u++)
							out.println("<option value='"+ctdata[u][0]+"'>"+ctdata[u][1]+"</option>");
						%>
                </select>
              </span></td>
              <td >Status</td>
              <td ><select name="status" id="status" onChange="LoadScheduleEntrystaff('0')">
                <option value="0">All</option>
                <option value="Y">Closed</option>
                <option value="N">Pending</option>
              </select></td>
              <td >Day</td>
              <td ><select name="day" id="day"  onblur="LoadScheduleEntrystaff('0') ">
                <option value="0">All</option>
                <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
              </select></td>
              <td >Month</td>
              <td  ><select name="month" class="formText135" id="month" onBlur="LoadScheduleEntrystaff('0')">
                <%
java.util.Date dt = new java.util.Date();
int m = dt.getMonth();
%>
                <%@ page import="java.util.Date"%>
                <option value="0">All</option>
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
              </select></td>
              <td  >Year </td>
              <td  ><select name="year" class="formText135" id="year" onBlur="LoadScheduleEntrystaff('0')">
                <%
java.util.Date dts = new java.util.Date();
int ms = dts.getYear();
%>
                <option value="1999" selected="selected">1999</option>
                <%
      for(int i=2000;i<=2050;i++)
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
						var day=d.getDate();
						setOptionValue('day',day);	
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
				//-->
            </script></td>
            </tr>
          </table>
            <table width="100%">  
            <tr>
				  <td width="5%" align="center" ><font color="#FFFFFF">S.No</font></td>
				  <td width="12%" align="center" ><font color="#FFFFFF">CustomerName</font> </td>
				  <td width="13%" align="center"><font color="#FFFFFF">CallType</font></td>
				  <td width="13%" align="center"><font color="#FFFFFF">StartDate</font></td>
				  <td width="13%" align="center" ><font color="#FFFFFF">EndDate </font></td>
			      <td width="10%" align="center" ><font color="#FFFFFF">Status</font></td>
				  <td width="10%" align="center" ><font color="#FFFFFF">Follow Up</font></td>
                  <td width="10%" align="center"><font color="#FFFFFF">Upload</font></td>
              <td width="10%" align="center"><font color="#FFFFFF">Download </font></td>
				
			</tr>
		</table>
		  </td>
        </tr>
         
         
        <tr class="MRow1">
          <td >
		  <div id="GroupTable" style="OVERFLOW:auto;width:100%x;height:300px" class="boldEleven"></div>
		  <br><div id="totalrec"></div> <br></td>
        </tr>
         
	     
      </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
          <tr class="para">
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('0')">All</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('A')">A</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('B')">B</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('C')">C</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('D')">D</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('E')">E</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('F')">F</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('G')">G</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('H')">H</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('I')">I</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('J')">J</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('K')">K</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('L')">L</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('M')">M</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('N')">N</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('O')">O</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('P')">P</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('Q')">Q</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('R')">R</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('S')">S</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('T')">T</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('U')">U</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('V')">V</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('W')">W</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('X')">X</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('Y')">Y</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadScheduleEntrystaff('Z')">Z</a></div></td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><span class="boldEleven">
      <input type="hidden" name="filename" value="ScheduleEntryStaff" />
      <input type="hidden" name="actionS" value="MKTScheduleEntryDelete" />
      </span></td>
    </tr>
	<tr>
		<td><table border="0" align="center" cellpadding="1"
			cellspacing="1">
          <!--DWLayoutTable-->
          <tr>
            <td width="56"  valign="top"><input type="submit" class="ButtonHead"  name="action1" id="Add"  value="Add"   accesskey="s"   onClick="GAdd()" /></td>
            <td  width="56"  valign="top"><input type="submit" class="ButtonHead" name="Edit" id="Edit" value="Edit"  onclick="return GEdit()" /></td>
            
            <td width="56"  ><input type="Button" class="ButtonHead" name="submit"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')" /></td>
          </tr>
      </table></td>
	</tr>
</table>
</form>
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