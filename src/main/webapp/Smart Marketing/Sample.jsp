 <%@ page import="java.io.*,java.util.*"  %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
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


<title> :: MARKETING ::</title>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %> 
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript">

    function GAdd()
	{ 
		document.frm.action="ScheduleEntryStaffAction.jsp";
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
			document.frm.action="ScheduleEntryStaffActionEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function RDelete()
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
 
 <script language="javascript" src="../JavaScript/Marketing/ScheduleEntrystaff.js"></script>

<body onselectstart="return false" onpaste="return false;" onCopy="return false"    onLoad="LoadScheduleEntrystaff('0')" >
<%@ include file="index.jsp"%>

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="get" name="frm">
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
	  <td><table width="90%" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
        <tr  >
          <td height="31"  ><div align="center" class="whiteMedium">SCHEDULE </div></td>
        </tr>
        <tr  >
          <td height="31" align="center" valign="top"  ><table width="554" border="0" align="center" cellpadding="2"
					cellspacing="2" class="whiteMedium">
            <tr>
              
              
              <td width="92">Day</td>
              <td width="167"><select name="day" id="day"  onBlur="LoadScheduleEntrystaff('0') " style="width:100">
                  <option value="0">All</option>
                  <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
              </select></td>
              <td width="48" >Month</td>
              <td width="96">
			  <select name="month" class="formText135" id="month" onBlur="LoadScheduleEntrystaff('0')" style="width:100">
			  
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
              <td width="36" >Year </td>
              <td width="63"><select name="year" class="formText135" id="year" onBlur="LoadScheduleEntrystaff('0')" style="width:100">
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
			<td width="75" >Customer </td>
			 <td width="449" class="boldEleven">
              <select name="customer" class="formText135" id="customer" onBlur="LoadScheduleEntrystaff('0')" style="width:200">
<option value="0">All</option>
<%
String cdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_CUSTOMERID,CHR_COMPANYNAME,CHR_CUSTOMERNAME FROM mkt_m_customerinfo ORDER BY CHR_COMPANYNAME");
if(cdata.length>0)
for(int u=0;u<cdata.length;u++)
	out.println("<option value='"+cdata[u][0]+"'>"+cdata[u][1]+" / "+cdata[u][2]+"</option>");
%>
</select> </td>
            </tr>
			
          </table>
		<table width="100%"  >  
		 <tr>
				  <td width="5%" align="center" ><font color="#FFFFFF">S.No</font></td>
				  <td width="13%" align="center" ><font color="#FFFFFF">CustomerName</font> </td>
				  <td width="13%" align="center"><font color="#FFFFFF">CallType</font></td>
				  <td width="13%" align="center"><font color="#FFFFFF">Agenda</font></td>
				  <td width="13%" align="center"><font color="#FFFFFF">StartDate</font></td>
				  <td width="13%" align="center" ><font color="#FFFFFF">EndDate </font></td>
			      <td width="13%" align="center" ><font color="#FFFFFF">Status</font></td>
				  <td width="13%" align="center" ><font color="#FFFFFF">Next</font></td>
				</tr></table>
		  </td>
        </tr>
         
         
        <tr class="MRow1">
          <td  >
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
		<td><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
          <!--DWLayoutTable-->
          <tr>
            <td width="56" valign="top"><input type="submit" class="ButtonHead"  name="action1" id="Add"  value="Add"   accesskey="s"   onClick="GAdd()" /></td>
            <td width="56" valign="top"><input type="submit" class="ButtonHead" name="Edit" id="Edit" value="Edit"  onclick="return GEdit()" /></td>
            
			<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Submit3" id="btnDelete" value="Delete"
					onClick="return RDelete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='btnDelete'>");
		}
		%>
		 
            <td width="56"><input type="Button" class="ButtonHead" name="submit"  value="Close"   accesskey="c"  onClick="redirect('MarketingMain.jsp')" /></td>
          </tr>
        </table></td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
 </body>
</html>
