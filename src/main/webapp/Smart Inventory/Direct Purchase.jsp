<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
 		
<html>
<head>
<title>:: INVENTORY ::</title>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
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


 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/DirectPurchase.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="DirectPurchaseAdd.jsp";
 	}

	function Edit()
 	{		
		
		obj = findObj("Ponumber"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].Ponumber;
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
			if (document.forms[0].Ponumber.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="DirectPurchaseEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Purchase Order Number");
		    return false;
		}
 	}
	

 	function RDelete()
 	{		
		
		obj = findObj("Ponumber"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


		var count;
		count=0;
		var id="";
		coffee1=document.forms[0].Ponumber;
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
				count=count+1;
				id=i;
			}
		}
		
		if(count==1)
		{
		
				var r=confirm("ARE YOU SURE YOU WANT TO DELETE THE INVOICE  ..."+coffee1[id].value);
				if (r==true)
	  			{
	  				var reason=prompt("Reason for Delete :: ","For e.g - Value has to be change."); 
	  				var email=prompt("Kindly give the email id for sending informations for deleted invoice ","test@test.net"); 
	  				
					if (reason!=null && reason!="")
  					{
	  					var d ="../SmartLoginAuth?saleno="+coffee1[id].value+"&reason="+reason+"&email="+email;
						document.frm.action=d; 
						document.frm.submit();
						return true;	
					}	
	  			}			

		}
		else
		{
		    alert("Select Atleast One Purchase Order Number");
		    return false;
		}		
 	} 	 	
 	function mainPage()
 	{
	      document.frm.action="InventoryMain.jsp";
    } 	
    
</script>

<body    onLoad="loadDirectPurchase('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off" name="frm" method="post"  action="../SmartLoginAuth"  >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td><div align="center">
            <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  RDelete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'InventoryMains.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
          </div></td>
    </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table height="227" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr   >
				<td height="31"   >
				<div align="center" class="whiteMedium">Direct
				Purchase  </div>				</td>
			</tr>
			<tr   >
				<td   >
				<table width="100%" border="0" align="center" cellpadding="2"
					cellspacing="2" class="whiteMedium">
					<tr>
					  <td  >Division</td>
					  <td  ><select name="division"
							class="formText135" id="division" tabindex="1"
							onChange="loadDirectPurchase('0')" style="width:200">
                        <option value='0'>All</option>
                        <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                      </select></td>
					  <td>Cancel</td>
					  <td><select name="cancel" id="cancel"  onBlur="loadDirectPurchase('0') "  >
                        <option value="0">All</option>
                        <option value="N" selected="selected">Live</option>
                        <option value="Y">Cancell</option>
                      </select></td>
					  <td >Tax </td>
					  <td><select name="taxtype" class="formText135" id="taxtype"
							onBlur="loadDirectPurchase('0')" style="width:100">
                          <option value="0" selected="selected">All</option>
                          <option value="S">State</option>
                          <option value="D">Central</option>
                      </select></td>
					  <td  >&nbsp;</td>
					  <td>&nbsp;</td>
				  </tr>
					<tr>
						<td width="37"  >Vendor</td>
						<td width="37"  ><select name="vendor"
							id="vendor" class="formText135"
							onChange="loadDirectPurchase('0')" style="width:200">
							<option value="0">All</option>

							<jsp:include page="LoadVendor.jsp" />
						</select></td>
						
<td>Day</td>
                <td><select name="day" id="day"  onBlur="loadDirectPurchase('0') " style="width:100">
                  <option value="0">All</option>
                  <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                </select></td>
						<td width="74"  >Month </td>
						<td width="89"><select name="month" class="formText135" id="month"
							onBlur="loadDirectPurchase('0')" style="width:100">
							<option value="0">All</option>
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select></td>
						<td width="50"  >Year </td>
						<td width="88"><select name="year" class="formText135" id="year"
							onBlur="loadDirectPurchase('0')" style="width:100">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
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
				</table>				</td>
			</tr>
			 
			<tr class="MRow1">
				<td   valign="top" class="footermenu" height="50">
				 
						<div id="DirectPurchaseTable" style="OVERFLOW:auto;width:100%;height:350px" class="boldEleven">						</div><br> 
						<div align="center" id="totRec"></div><br>				</td>
		  </tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('0')">All</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('A')">A</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('B')">B</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('C')">C</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('D')">D</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('E')">E</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('F')">F</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('G')">G</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('H')">H</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('I')">I</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('J')">J</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('K')">K</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('L')">L</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('M')">M</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('N')">N</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('O')">O</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('P')">P</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('Q')">Q</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('R')">R</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('S')">S</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('T')">T</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('U')">U</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('V')">V</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('W')">W</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('X')">X</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('Y')">Y</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDirectPurchase('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td><input name="filename" type="hidden" value="DirectPurchase" />
	    <input name="actionS" type="hidden" value="INVDirectPurchaseDelete" /></td>
	</tr>
	<tr>
		<td>		  </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
