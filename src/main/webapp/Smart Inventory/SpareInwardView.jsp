<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
 		
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
<script language="javascript" src="../JavaScript/Inventory/SparePurchase.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="SpareInwardAdd.jsp";
 	}

	function Edit()
 	{		
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
			document.frm.action="SpareInwardEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Purchase Order Number");
		    return false;
		}
 	}
	

 	function Delete()
 	{		
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
    function LoadDisable()
	{
	  document.getElementById('btnEdit').disabled = true;
	  document.getElementById('btnDelete').disabled = true;
	  
	} 	
</script>

<body    onLoad="loadSparePurchase('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off" name="frm" method="post"   >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
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
				<div align="center" class="whiteMedium">SPARE INWARD </div>				</td>
			</tr>
			<tr   >
				<td   >
				<table width="100%" border="0" align="center" cellpadding="2"
					cellspacing="2" class="whiteMedium">
					<tr>
						<td width="18"  >Division</td>
						<td width="19"  ><select name="division"
							class="formText135" id="division" tabindex="1"
							onChange="loadSparePurchase('0')">
							<option value='0'>All</option>
							<%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
						</select></td>
						<td width="37"  >Vendor</td>
						<td width="37"  ><select name="vendor"
							id="vendor" class="formText135"
							onChange="loadSparePurchase('0')">
							<option value="0">All</option>

							<jsp:include page="LoadVendor.jsp" />
						</select></td>
						
<td>Day</td>
                <td><select name="day" id="day"  onBlur="loadSparePurchase('0') ">
                  <option value="0">All</option>
                  <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                </select></td>
						<td width="74"  >Month </td>
						<td width="89"><select name="month" class="formText135" id="month"
							onBlur="loadSparePurchase('0')">
							<option value="0">All</option>
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select></td>
						<td width="50"  >Year </td>
						<td width="88"><select name="year" class="formText135" id="year"
							onBlur="loadSparePurchase('0')">
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
			<tr   >
				<td height="31"   >
				<div align="center">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteMedium">
					<tr   >
					  <td  ><div align="center">S.NO</div></td>
						<td  >
						  <div align="center">Purchase No</div></td>
						<td  >
						  <div align="center">Date</div></td>
						<td  >
						  <div align="center">Vendor Name</div></td>
						<td  >
						  <div align="center">Status</div></td>
						<td  ><div align="center">View</div></td>
						<td  >
						  <div align="center">Payment</div></td>
						<td  >
						  <div align="center">Amount</div></td>
					</tr>
				</table>
				</div>				</td>
			</tr>
			<tr class="MRow1">
				<td   valign="top" class="footermenu" height="50">
				 
						<div id="SparePurchaseTable" style="OVERFLOW:auto;width:100%;height:350px" class="boldEleven">						</div><br> 
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
					href="javascript:loadSparePurchase('0')">All</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('A')">A</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('B')">B</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('C')">C</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('D')">D</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('E')">E</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('F')">F</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('G')">G</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('H')">H</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('I')">I</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('J')">J</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('K')">K</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('L')">L</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('M')">M</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('N')">N</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('O')">O</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('P')">P</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('Q')">Q</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('R')">R</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('S')">S</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('T')">T</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('U')">U</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('V')">V</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('W')">W</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('X')">X</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('Y')">Y</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadSparePurchase('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="SparePurchase" />
		<input name="actionS" type="hidden" value="INVSparePurchaseDelete" /></td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="3" cellspacing="3">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action12" id="btnEdit" value="Edit"
					onclick="return Edit()" /></td>


				<%
		  String usertype=""+session.getAttribute("USRTYPE");
		  
		 if("F".equals(usertype) || ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
		  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Submit3" id="btnDelete" value="Cancel"
					onClick="return Delete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='btnDelete'>");
		}
		%>
				<td width="56"><input type="button" class="ButtonHead"
					 value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
