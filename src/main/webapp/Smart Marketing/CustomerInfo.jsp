<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage=""%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 
<%
try
{
	String usertypes=""+session.getAttribute("USRTYPE");	
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
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %> 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/Marketing/Customerinfo.js"  ></script>

<script language="JavaScript">

    function GAdd()
	{ 
		document.frm.action="CustomerInfoAction.jsp";
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
		if(count==1)
		{			
			document.frm.action="CustomerInfoEdit.jsp";
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
<body onselectstart="return false" onpaste="return false;" onCopy="return false"    onLoad="LoadCustomerinfos('0')"   >
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
		<td> <div align="center">
          <%
			out.println("<table   border='0' align='center' cellpadding='5' cellspacing='1'>");
			out.println("<tr>");
			 
			/*out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_MKT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='GAdd()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");*/
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_MKT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return GEdit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_MKT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  RDelete()' name='Submit' id='Submit' value='Delete'>");
			else	 
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'MarketingMain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
        </div></td>
	</tr>
	 
	<tr>
	  <td> &nbsp;</td>
    </tr>
	 
	<tr>
	  <td><table width="90%" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
        <tr  >
          <td height="31"  ><div align="center">CUSTOMER INFORMATION </div></td>
        </tr>
        <tr  >
          <td height="31" align="center" valign="middle"  ><table width="90%" border="0" align="center" cellpadding="2" cellspacing="2" class="whiteMedium">
              <tr>
                <td>Group</td>
                <td><select name="group" class="formText135" id="group" onChange="LoadCustomerinfos('0')"  style="width:100">
                  <option value="0">All</option>
                  <%
			  String sdata[][] = CommonFunctions.QueryExecute(" SELECT INT_GROUPID,CHR_GROUPNAME FROM  mkt_m_customergroup ORDER BY CHR_GROUPNAME ");
			  for(int u=0;u<sdata.length;u++)
			  	out.println("<option value='"+sdata[u][0]+"'>"+sdata[u][1]+"</option>");
			  %>
                </select></td>
                <td>Division</td>
                <td><select name="division" class="formText135" id="division" tabindex="1"  onChange="LoadCustomerinfos('0')" style="width:100">
                  <option value='0'>All</option>
                  <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,UPPER(CHR_DIVICODE),CHR_DIVISHORTCODE from inv_m_division   WHERE INT_DIVIID >0 ORDER BY CHR_DIVICODE"); 
								String deptname= CommonFunctions.QueryExecute("SELECT FIND_A_DEPARTMENT("+session.getAttribute("DEPARTID")+")")[0][0];
								
								for(int u=0; u<division.length; u++)
									if(deptname.equals(division[u][2]))
										out.print("<option selected='selected' value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
									else
										out.print("<option   value='"+division[u][0]+"'>"+division[u][1]  +"</option>");	
							%>
                </select>
                 
                </td>
                <td>Verified</td>
                <td><select name="verified" id="verified" onChange="LoadCustomerinfos('0')" style="width:100">
                  <option value="0" selected="selected">All</option>
                  <option value="Y">Verified</option>
                  <option value="R">Rejected</option>
                  <option value="N">Pending</option>
                </select></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>Account</td>
                <td><select name="account" class="formText135" id="account" style="width:100"  onChange="LoadCustomerinfos('0')">
                  <option value="0">All</option>
                  <%
				 String adata[][] = CommonFunctions.QueryExecute(" SELECT INT_CUSTOMERNAMEID,CHR_NAME FROM  mkt_m_customername ORDER BY CHR_NAME ");
			  for(int u=0;u<adata.length;u++)
			  		out.println("<option value='"+adata[u][0]+"'>"+adata[u][1]+"</option>");
				%>
                </select></td>
                <td>M.E</td>
                <td>
                <select name="me" class="formText135" id="me" style="width:175"  onBlur="LoadCustomerinfos('0')" >
                  <option value="0">All</option>
                  <%
				  if(!"F".equals(usertypes))
				  {
			  		String datad[][] =CommonFunctions.getReportingEmployeeIdNames(""+session.getAttribute("EMPID"));
					for(int u=0;u<datad.length;u++)
						out.println("<option value='"+datad[u][0]+"'>"+datad[u][1]+" / " +datad[u][0]+"</option>");
				  }
				  else
				  {
					  String datad[][] = CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE CHR_TYPE != 'T' ORDER BY CHR_STAFFNAME");
						for(int u=0;u<datad.length;u++)
							out.println("<option value='"+datad[u][0]+"'>"+datad[u][1]+" / " +datad[u][0]+"</option>");
				  }
			  %>
                </select></td>
                <td>Status</td>
                <td>
                  <select name="status" id="status" onChange="LoadCustomerinfos('0')" style="width:100">
                    <option value="0">All</option>
                    <option value="Y">Active</option>
                    <option value="N">Inactive</option>
                  </select>                </td>
                
                <td>Search</td>
                <td><input name="search" type="text" id="search" maxlength="10" onKeyUp="LoadCustomerinfo(this)"></td>
                </tr>
          </table></td>
        </tr>
        <tr class="MRow1">
          <td class="bolddeepblue"><div id="GroupTable" style="OVERFLOW:auto;width:100%;height:300px" class="boldEleven"></div>
              <br>
            <div id="totalrec"></div></td>
        </tr>
        
	    <tr>        </tr>
      </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
	    <tr class="para">
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('0')">All</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('A')">A</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('B')">B</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('C')">C</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('D')">D</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('E')">E</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('F')">F</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('G')">G</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('H')">H</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('I')">I</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('J')">J</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('K')">K</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('L')">L</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('M')">M</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('N')">N</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('O')">O</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('P')">P</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('Q')">Q</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('R')">R</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('S')">S</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('T')">T</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('U')">U</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('V')">V</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('W')">W</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('X')">X</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('Y')">Y</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('Z')">Z</a></div></td>
	      </tr>
      </table></td>
    </tr>
	<tr>
	  <td><span class="boldEleven">
	    <input type="hidden" name="filename" value="CustomerInfo" />
        <input type="hidden" name="actionS" value="MKTCustomerInfoDelete" />
      </span></td>
    </tr>
	
	<tr>
		<td>&nbsp;</td>
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
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>