<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage=""%>
<%
try
{

%>

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
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %> 
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
			document.frm.action="DailyCallsAction.jsp";
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
<body onselectstart="return false" onpaste="return false;" onCopy="return false"      >
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
			cellpadding="0" cellspacing="0"  
			 >
        <tr class="BackGround">
          <td height="31" class="BackGround"><div align="center">DAILY CALLS </div></td>
        </tr>
        <tr class="BackGround">
          <td height="31" class="BackGround"><table width="46%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="boldEleven">
            <tr>
              <td class="bold1"  >Office</td>
              <td class="bold1"  ><%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 String usertype=""+session.getAttribute("USRTYPE"); 
			  %>
                  <select name="Office" class="formText135" id="Office" tabindex="6"    >
                    <%
		if("F".equals(usertype)  || "B".equals(usertype) ) 
				out.print("<option value='0' >All</option>");						
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
                </select></td>
              <td class="bold1">Day</td>
              <td class="bold1"><select name="day" id="day"   >
                  <option value="0">All</option>
                  <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                </select>
              </td>
              <td class="bold1"  >Month :</td>
              <td class="bold1"><select name="month" id="month"   >
                  <%@ include file="../JavaScript/months.jsp"%>
                </select>
              </td>
              <td class="bold1"> Year : </td>
              <td class="bold1"><select name="year" id="year" >
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
              </td>
            </tr>
          </table></td>
        </tr>
        <tr class="BackGround">
          <td height="31" class="BackGround"><table width="100%" border="0" cellspacing="1" cellpadding="1">
              <tr class="BackGround">
                <td width="14%" class="bold1">S.No</td>
                <td width="50%" align="left" class="bold1"><div align="left">Group</div></td>
                <td width="28%" align="left" class="bold1">Creation Date </td>
                <td width="8%" align="left" class="bold1">Active</td>
              </tr>
          </table></td>
        </tr>
         
        <tr>
          <td class="bolddeepblue">
		  <div id="GroupTable" style="OVERFLOW:auto;width:100%x;height:200px" class="boldEleven"></div>
		  <br><div id="totalrec"></div>		  </td>
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
			cellspacing="1"  >
          <tr class="para">
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('0')">All</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('A')">A</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('B')">B</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('C')">C</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('D')">D</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('E')">E</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('F')">F</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('G')">G</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('H')">H</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('I')">I</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('J')">J</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('K')">K</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('L')">L</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('M')">M</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('N')">N</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('O')">O</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('P')">P</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('Q')">Q</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('R')">R</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('S')">S</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('T')">T</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('U')">U</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('V')">V</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('W')">W</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('X')">X</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('Y')">Y</a></div></td>
            <td class="boldEleven"><div align="center"><a
					href="javascript:LoadCustomerGroup('Z')">Z</a></div></td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><span class="boldEleven">
      <input type="hidden" name="filename" value="DailyCallsAction" />
      <input type="hidden" name="actionS" value="MKTDailyCallsActionDelete" />
      </span></td>
    </tr>
	<tr>
		<td><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
          <!--DWLayoutTable-->
          <tr>
            <td width="56" valign="top"><input type="Submit" class="buttonbold13" name="action1" id="Add"  value="Add"   accesskey="s"   onClick="GAdd()" /></td>
            <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Edit" id="Edit" value="Edit"  
					onclick="return GEdit()" /></td>
            <%
	   
	  //if("F".equals(usertype))
	  {
	  %>
            <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Submit" id="Delete" value="Delete"  
					onclick="return RDelete()" /></td>
            <%
		}
		%>
            <td width="56"><input type="Button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('MarketingMain.jsp')" /></td>
          </tr>
        </table></td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
}

%>
