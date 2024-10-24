<%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>

<html>
 

<title> :: COMMON ::</title>


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

 

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>
<script language="javascript" src="../JavaScript/smartcommon/CityAjax.js"></script>


<script language="javascript">    
	function Delete()
 	{		
		obj = findObj("id"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


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
				document.frm.submit();
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
	
	
 	function  Edit()
 	{		
		obj = findObj("id"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].id;
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
			document.frm.action="CityAction.jsp";
			document.frm.submit();
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}
	function Add()
 	{				
		document.frm.action="CityAction.jsp";
		document.frm.submit();
 	}
 	 
</script>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<form  AUTOCOMPLETE = "off"   method="get" name='frm' >
<body  onpaste="return false;"  >
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>

		<table width="90%" height="408" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<tr>
			  <td height="18" align="center"  class="whiteMedium">CITY INFORMATION 
			  <%
			  String rcountry = ""+request.getParameter("country");
			  String rstate = ""+request.getParameter("state");
			  String rdistrict = ""+request.getParameter("district");
			  if("".equals(rcountry) || "null".equals(rcountry))
			  	rcountry="-1";
			
			  if("".equals(rstate) || "null".equals(rstate))
			  	rstate="0";
				
			  if("".equals(rdistrict) || "null".equals(rdistrict))
			  	rdistrict="0";
					
			  
		 
			  
			  %>			  </td>
		  </tr>
			<tr>
			  <td height="30" align="center"  class="whiteMedium"><table width="90%"  border="0" cellpadding="0" cellspacing="0" class="whiteMedium">
                <tr>
				  <td>COUNTRY</td>
				  <td>
				  <select name="country" class="formText135" id="country"   onChange="LoadSelectState()" >
				  <option value="-1">Select Country</option> 
				  <%
				  String cdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_COUNTRYID,CHR_COUNTRYNAME FROM com_m_country   ORDER BY CHR_COUNTRYNAME");
				  for(int i=0;i<cdata.length;i++)
				  	out.println("<option value='"+cdata[i][0]+"'>"+cdata[i][1]+"</option>");
                  
				  %></select>				  				  </td>
				  <td>&nbsp;</td>
                  <td class="whiteMedium">STATE</td>
                  <td>
				  <select name="state" class="formText135" id="state"   onChange="LoadSelectDistrict()" >
				  	<option value="0">Select State</option> 
			      </select>				                  </td>
                  <td>District</td>
                  <td><select name="district" class="formText135"  id="district" onChange="LoadCity('0')"    >
                      <option value="0">Select</option>
                  </select>
				  <script language="javascript" >
				  		setOptionValue('country','<%=rcountry%>');
						LoadSelectState();
						setOptionValue('state','<%=rstate%>');
						LoadSelectDistrict();
						setOptionValue('district','<%=rdistrict%>');
						LoadCity('0');
						
 
				</script>
				   <select name="city" class="formText135"  id="city" style="visibility:hidden"   >
                    <option value="0">Select</option>
                  </select>				  </td>
                </tr>
              </table>		      </td>
		  </tr>
			<tr>
				<td height="30" align="center"><table width="100%" border="0" align="center" cellpadding="5" cellspacing="0" class="whiteMedium">
                  <tr>
                    <td width="16%"><div align="center">S.No</div></td>
                    <td width="16%"><div align="center">COUNTRY</div></td>
					<td width="16%"><div align="center">STATE   </div></td>
                    <td width="16%"><div align="center">DISTRICT</div></td>
					<td width="16%"><div align="center">CITY / LOCATION</div></td>
					<td width="16%"><div align="center">PINCODE</div></td>
                  </tr>
              </table></td>
			</tr>
			<tr class="MRow1" >
				<td >
				
				<div id="GroupTable" style="OVERFLOW:auto;width:100%;height:300px"></div><br> 	
				<div id="totalrec"  > </div><br>							</td>
			</tr>
			<tr >
			  <td > </td>
		  </tr>
		</table>		</td>
	</tr>

	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
        <tr class="para">
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCity('Z')">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
	  <td><input type="hidden" name="filename"	value="City">
      <input type="hidden" name="actionS"	value="GENCityDelete"></td>
  </tr>
	<tr>
		<td>
		  <div align="center">
            <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_GEN FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_GEN FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_GEN FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('commonmain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
          </div></td>
	</tr>
</table>



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

