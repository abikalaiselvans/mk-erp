<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<html>
<head>
<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

 <style type="text/css">
@import url("../bootstrap/css/bootstrap.min.css");
@import url("../JavaScript/SmartStyles.css");
</style>
<script src="../bootstrap/js/jquery.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
<meta name="resource-type" content="document" />
<meta http-equiv="Content-Type" content="text/html; charset=" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />

 

<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script type="text/javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/directsales.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="SwapSaleAdd.jsp";
 	}

	function Edit()
 	{		
		obj = findObj("salno"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].salno;
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
			if (document.forms[0].salno.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="SwapSaleSerial.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}
	
	
	function checkboxes()
	  {
	   var inputElems = document.getElementsByTagName("input"),
		count = 0;
	
		for (var i=0; i<inputElems.length; i++) {       
		   if (inputElems[i].type == "checkbox" && inputElems[i].checked == true){
			  count++;
		   }
		}
		 
	 }



function Delete()
{	
	try
	{
		
		obj = findObj("salno"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].salno;
		txt="";
		 
		var id=0;
		var sale=""; 
		 
		for (i=0;i<coffee1.length;i++)
		{
			if (coffee1[i].checked)
			{
				count=count+1;
				id=i;
			}
		}
		
		if(count==0)
		{
			if (document.forms[0].salno.checked) 
			{ 
				count=1;
				sale=document.getElementById('salno').value;
			}
		}
		if(count==1)
		{			
				var r=confirm("ARE YOU SURE YOU WANT TO DELETE THE INVOICE  ..."+coffee1[id].value);
				if (r==true)
				{
					var reason=prompt("Reason for Delete :: ","For e.g - Value has to be change."); 
					var email=prompt("Kindly give the email id for sending informations for deleted invoice ","abikalaiselvan@gmail.com"); 
					if (reason!=null && reason!="")
					{
						var d ="../SmartLoginAuth?saleno="+coffee1[id].value+"&reason="+reason+"&email="+email;
						document.frm.action=d; 
					}	
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
	catch(err)
	{
		alert(err);
		return false;
	}	
} 






		 	
 	function mainPage()
 	{
	      document.frm.action="InventoryMain.jsp";
    } 	
    
	
	
function ResetSerialNumber(query,invoicenumber)
{
		var r=confirm("ARE YOU SURE YOU WANT TO RESET THE SERIAL NUMBER , INVOICE NUMBER IS ..."+invoicenumber);
		if (r==true)
	  	{
			document.frm.action=""+query; 
			document.frm.submit(); 
			
	  	}
}



function invoiceSendMail(query,invoicenumber)
{
		var r=confirm("ARE YOU SURE YOU WANT TO SEND THE INVOICE "+invoicenumber +" TO MAIL ...");
		if (r==true)
	  	{
	  		var subject=prompt("Enter  Subject","Invoice"); 
			var reason=prompt("Enter  Email id","abikalaiselvan@gmail.com"); 
	  		if (subject!=null && subject!="" && reason!=null && reason!="")
  			{
	  			var d =query+"&subject="+subject+"&email="+reason;
	  			document.frm.action=""+d; 
				alert(d);
				document.frm.submit(); 
			}	
	  	}
}

function sendSMS(query)
{
	 	var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
	 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
}
</script>
<!--,loadSwapSales('0')
-->
<body    onLoad="loadSwapSales('0')" >
 
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" id="frm"  >
<table width="100%" border="0" cellpadding="1" cellspacing="1" >
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		</td>
	</tr>
	<tr>
		<td>		</td>
	</tr>
	<tr>
		<td>
		<table width="90%" height="256" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<tr  >
				<td height="22"  >
				<div align="center"><span class="boldThirteen"> DIRECT SALES  </span></div>				</td>
			</tr>
			<tr  >
			  <td height="22"  >
			  <table height="19"   border="0" align="center" cellpadding="3" cellspacing="2">
                <tr>
                  
                  <td class="whiteMedium">Search by invoice/Customer</td>
                  <td class="whiteMedium"><input name="search" type="text" class="formText135" id="search" maxlength="10" onKeyUp="loadSwapSaless(this)" ></td>
                  
                </tr>
              </table></td>
		  </tr>
			<tr  >
				<td height="25"  >
				<table width="100%" border="0" align="center" cellpadding="4"
					cellspacing="4" class="whiteMedium">
					<tr>
					  <td height="19" >Division</td>
					  <td ><select
							name="division" class="formText135" id="division" tabindex="1"
							onChange="loadSwapSales('0')" style="width:150">
                        <option value='0'>All</option>
                        <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                      </select></td>
					  <td>Cancel</td>
					  <td height="30"><select name="cancel" class="formText135" id="cancel"  onBlur="loadSwapSales('0') "  >
                        <option value="0">All</option>
                        <option value="N" selected="selected">Live</option>
                        <option value="Y">Cancell</option>
                      </select></td>
					  <td>Delivery</td>
					  <td><select name="delivery" class="formText135" id="delivery" style="width:50" onBlur="loadSwapSales('0') ">
                        <option value="0">All</option>
                        <option value="Y">Completed</option>
                        <option value="P">Progress</option>
                        <option value="N">Pending</option>
                      </select></td>
					  <td >Tax </td>
					  <td><select name="taxtype" class="formText135" id="taxtype"
							onBlur="loadSwapSales('0')" style="width:100">
                        <option value="A" selected="selected">All</option>
						<option value="S">State</option>
						<option value="C">Central</option>
                      </select></td>
				  </tr>
					<tr>
						<td width="43" height="19" >Customer</td>
						<td width="44" ><select
							name="customer" id="customer" class="formText135"
							onChange="loadSwapSales('0')" style="width:150">
							<option value="0">All</option>

							<jsp:include page="LoadCustomer.jsp" />
						</select></td>
						<td>Day</td>
						<td><select name="day" class="formText135" id="day" style="width:50"  onBlur="loadSwapSales('0') ">
                          <option value="0" selected>All</option>
                          <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                      </select></td>
						<td>Month</td>
                <td><select name="month" class="formText135" id="month"	onBlur="loadSwapSales('0')" style="width:100">
                  <option value="0">All</option>
                  <%@ include file="../JavaScript/Inventory/month.jsp"%>
                </select></td>
						<td width="50" >Year </td>
						<td width="88"><select name="year" class="formText135" id="year"
							onBlur="loadSwapSales('0')" style="width:100">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
						</select>
						 
						 <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						//setOptionValue('day',day);	
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
				//-->
          </script></td>
					</tr>
					<tr>
					  <td height="19" >&nbsp;</td>
					  <td >&nbsp;</td>
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
					  <td >&nbsp;</td>
					  <td>&nbsp;</td>
				  </tr>
				</table>				</td>
			</tr>
			 
			<tr class="MRow1">
				<td height="127" valign="top"  >
				 
						 
						<div id="SwapSalesTable" style="OVERFLOW:auto;width:100%;height:350px" class="boldEleven"></div>
						 <br>						 
				<div align="center" id="totRec"></div>	<br>					 		</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('0')">All</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('A')">A</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('B')">B</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('C')">C</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('D')">D</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('E')">E</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('F')">F</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('G')">G</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('H')">H</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('I')">I</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('J')">J</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('K')">K</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('L')">L</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('M')">M</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('N')">N</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('O')">O</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('P')">P</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('Q')">Q</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('R')">R</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('S')">S</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('T')">T</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('U')">U</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('V')">V</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('W')">W</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('X')">X</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('Y')">Y</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSwapSales('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td height="30"><input name="filename" type="hidden" value="SwapSale" /> <input
			name="actionS" type="hidden" value="INVSwapSaleDelete" /></td>
	</tr>
	<tr>
		<td>
		  <div align="center">
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
				out.println("<input class='ButtonHead' type='submit' onClick='return Delete()' name='Submit' id='Submit' value='Delete'>");
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
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
