<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: PAYROLL ::</title>


 
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
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript"
	src="../JavaScript/Attendance/ReportAjax.js"></script>

<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
.style10 {font-family: Verdana; font-size: 12px; font-weight: bold; }
-->
</style>
<%
	String sql = "SELECT INT_PLACEID,CHR_PLACENAME FROM com_m_place ORDER BY CHR_PLACENAME";
	String pldata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	String places="";
	for(int u=0;u<pldata.length;u++)
		places=places+"<option value="+pldata[u][0]+">"+pldata[u][1]+"</option>";
%>
<script language="JavaScript">

	function disable()
	{
		netamount.style.visibility="hidden";
 		netamount1.style.visibility="hidden";
	}	
	
	function enable()
	{
		netamount.style.visibility="Visible";
 		netamount1.style.visibility="Visible";
	}	
	
	function chk()
	{
		//checkNullSelect("vtype","Select Type of Vehicle ","Select")
			 
		if(checkNullSelect("division","Select Division ","Select") )
			insRow();
	}
	var plc ="";
	plc = "<option>";
	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	
	var row =1;
 	var r =1;
	function insRow()
	{
			
		 	enable();
			var x=document.getElementById('myTable').insertRow(row)
			var s0= "from"+r;
			var s1= "to"+r;
			var s2 = "km"+r;
			var s3 ="busfare"+r;
			var s4 = "autofare"+r;
			var s5 = "lunch"+r;
			var s6 = "telephone"+r;
			var s7 = "otherdesc"+r;
			var s8 = "otheramt"+r;
			var s9 = "total"+r;
			var div ="div"+r;
			var vf0 = "onKeyPress=\"doubleValue('"+s2+"','7')\"";
			var vf1 = "onKeyPress=\"doubleValue('"+s3+"','7')\"";
			var vf2 = "onKeyPress=\"doubleValue('"+s4+"','7')\"";
			var vf3 = "onKeyPress=\"doubleValue('"+s5+"','7')\"";
			var vf4 = "onKeyPress=\"doubleValue('"+s6+"','7')\"";
			var vf5 = "onKeyPress=\"doubleValue('"+s8+"','7')\"";
			var vf6 = "onKeyPress=\"doubleValue('"+s9+"','7')\""; 
			x.insertCell(0).innerHTML="<input type='text' size=7  class='formText135' onblur='validfrom(this)'  name='"+s0+"' id ='"+s0+"' />";
			x.insertCell(1).innerHTML="<input type='text' size=7  class='formText135' onblur='validto(this)'   name='"+s1+"' id ='"+s1+"' />";
			x.insertCell(2).innerHTML="<input type='text' size=7 value=0  onblur='calculatekm(this)'  class='formText135'  name='"+s2+"' id ='"+s2+"' " +vf0+" style='text-align:right'/>";
			x.insertCell(3).innerHTML="<div id="+div+"></div>";
			x.insertCell(4).innerHTML="<input type='text' size=7 value=0  onblur='calculatetrain(this)' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf1+" style='text-align:right'/>";
			x.insertCell(5).innerHTML="<input type='text' size=7 value=0  onblur='calculateauto(this)' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+"  style='text-align:right'/>";
			x.insertCell(6).innerHTML="<input type='text' size=7 value=0  onblur='calculatelunch(this)' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf3+"  style='text-align:right'/>";
			x.insertCell(7).innerHTML="<input type='text' size=7 value=0  onblur='calculatetele(this)' class='formText135'  name='"+s6+"' id ='"+s6+"' " +vf4+" style='text-align:right'/>";
			x.insertCell(8).innerHTML="<input type='text' size=7      class='formText135'  name='"+s7+"' id ='"+s7+"'    style='text-align:right'/> ";
			x.insertCell(9).innerHTML="<input type='text' size=7 onblur='calculateother(this)' value=0  class='formText135'  name='"+s8+"' id ='"+s8+"' " +vf5+" style='text-align:right'/>";
			x.insertCell(10).innerHTML="<input type='text' size=7   value=0  class='formText135'  name='"+s9+"' id ='"+s9+"' " +vf6+" style='text-align:right' readonly='readonly'/>";
			x.insertCell(11).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")'>";
			itemArray[idrow] = r	;
			row = row+1;
			r = r+1;
			idrow=idrow+1;
		 	display();
		
	}
	 
 function deleteRow(i,rx)
	{
		document.getElementById('myTable').deleteRow(i);
		row = row-1;
		if(row<=1)
			disable();
		deleteArray[drow] =rx;
		drow = drow+1;
		display();
		//calculatedelete();
		totalassign();
		 
	}
	
	function display()
	{
		var hs="";
		var hs1="";
		var hs2="";
		for(u=0; u<itemArray.length; u++)
			hs = hs+itemArray[u]+",";
		for(u=0; u<deleteArray.length; u++)
			hs1 = hs1+deleteArray[u]+",";
		var Array1 = hs.split(",");
		var Array2 = hs1.split(",");
		for(u=0; u<Array2.length; u++)
		{
			var a1value = Array2[u];
			for(v=0; v<Array1.length; v++)
			{
				if(Array2[u] == Array1[v])
					Array1[v]="";
			}
		}
		hs2="";
		for(v=0; v<Array1.length; v++)
			if(Array1[v]!="")
				hs2 = hs2 +	Array1[v]+",";
		checkArray = hs2.split(",");	
		document.getElementById('param').value=hs2;
		 
		
	}
	
	 function validfrom(qty)
	 {
	 	var qtyposition = (qty.name.replace("from",""));	
  		var quantity = qty.value;;
		if( document.getElementById('from'+qtyposition).value =="")
			alert("Enter Starting Place");
		
	 }
	
	function validto(qty)
	 {
	 	var qtyposition = (qty.name.replace("to",""));	
  		var quantity = qty.value;
		if( document.getElementById('to'+qtyposition).value =="")
			alert("Enter End Place");
		
	 }
	 
	 
	function calculatekm(qty)
	{
  		
		var qtyposition = (qty.name.replace("km",""));	
  		var quantity = qty.value;
  		if(quantity>=1)
		{
			if(checkNull("from"+qtyposition,"Enter Starting Place") && checkNull("from"+qtyposition,"Enter End Place")) 
			{
				var v = parseFloat(quantity)*1.30;
				var tb=document.getElementById('div'+qtyposition);
				tb.innerHTML=Round(v) ; 
				var v1 = parseFloat(document.getElementById('busfare'+qtyposition).value);
				var v2 = parseFloat(document.getElementById('autofare'+qtyposition).value);
				var v3 = parseFloat(document.getElementById('lunch'+qtyposition).value);
				var v4 = parseFloat(document.getElementById('telephone'+qtyposition).value);
				var v5 = parseFloat(document.getElementById('otheramt'+qtyposition).value);
				var tot = v+v1+v2+v3+v4+v5;
				document.getElementById('total'+qtyposition).value = Round(tot);
				totalassign();
			}	
				
		}
		else
		{
			alert("Kilometer Should not be Zero");
			
		}
	}
	
	function calculatetrain(qty)
	{
  		var qtyposition = (qty.name.replace("busfare",""));	
  		var quantity = qty.value;
  		if(quantity>=1)
		{
			
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = Round(v0*1.30);
			var v1 = parseFloat(document.getElementById('busfare'+qtyposition).value);
			var v2 = parseFloat(document.getElementById('autofare'+qtyposition).value);
			var v3 = parseFloat(document.getElementById('lunch'+qtyposition).value);
			var v4 = parseFloat(document.getElementById('telephone'+qtyposition).value);
			var v5 = parseFloat(document.getElementById('otheramt'+qtyposition).value);
			var tot = v+v1+v2+v3+v4+v5;
			document.getElementById('total'+qtyposition).value = Round(tot);
			totalassign();
			
		}
		else
		{
			alert("Train/Bus Fare Should not be Zero");
			
		}
	}
	
	
	function calculateauto(qty)
	{
  		var qtyposition = (qty.name.replace("autofare",""));	
  		var quantity = qty.value;
  		if(quantity>=1)
		{
			
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = Round(v0*1.30);
			var v1 = parseFloat(document.getElementById('busfare'+qtyposition).value);
			var v2 = parseFloat(document.getElementById('autofare'+qtyposition).value);
			var v3 = parseFloat(document.getElementById('lunch'+qtyposition).value);
			var v4 = parseFloat(document.getElementById('telephone'+qtyposition).value);
			var v5 = parseFloat(document.getElementById('otheramt'+qtyposition).value);
			var tot = v+v1+v2+v3+v4+v5;
			document.getElementById('total'+qtyposition).value = Round(tot);
			totalassign();
			
		}
		else
		{
			alert("Auto Fare Fare Should not be Zero");
			
		}
	}
	
	
	function calculatelunch(qty)
	{
  		var qtyposition = (qty.name.replace("lunch",""));	
  		var quantity = qty.value;
  		if(quantity>=1)
		{
			
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = Round(v0*1.30);
			var v1 = parseFloat(document.getElementById('busfare'+qtyposition).value);
			var v2 = parseFloat(document.getElementById('autofare'+qtyposition).value);
			var v3 = parseFloat(document.getElementById('lunch'+qtyposition).value);
			var v4 = parseFloat(document.getElementById('telephone'+qtyposition).value);
			var v5 = parseFloat(document.getElementById('otheramt'+qtyposition).value);
			var tot = v+v1+v2+v3+v4+v5;
			document.getElementById('total'+qtyposition).value = Round(tot);
			totalassign();
			
		}
		else
		{
			alert("Lunch / Dinner Fare Should not be Zero");
			
		}
	}
	
	function calculatetele(qty)
	{
  		var qtyposition = (qty.name.replace("telephone",""));	
  		var quantity = qty.value;
  		if(quantity>=1)
		{
			
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = Round(v0*1.30);
			var v1 = parseFloat(document.getElementById('busfare'+qtyposition).value);
			var v2 = parseFloat(document.getElementById('autofare'+qtyposition).value);
			var v3 = parseFloat(document.getElementById('lunch'+qtyposition).value);
			var v4 = parseFloat(document.getElementById('telephone'+qtyposition).value);
			var v5 = parseFloat(document.getElementById('otheramt'+qtyposition).value);
			var tot = v+v1+v2+v3+v4+v5;
			document.getElementById('total'+qtyposition).value = Round(tot);
			totalassign();
			
		}
		else
		{
			alert("Telephone Charges Should not be Zero");
			
		}
	}
	
	function calculateother(qty)
	{
  		var qtyposition = (qty.name.replace("otheramt",""));	
  		var quantity = qty.value;
  		if(quantity>=1)
		{
			
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = Round(v0*1.30);
			var v1 = parseFloat(document.getElementById('busfare'+qtyposition).value);
			var v2 = parseFloat(document.getElementById('autofare'+qtyposition).value);
			var v3 = parseFloat(document.getElementById('lunch'+qtyposition).value);
			var v4 = parseFloat(document.getElementById('telephone'+qtyposition).value);
			var v5 = parseFloat(document.getElementById('otheramt'+qtyposition).value);
			var tot = v+v1+v2+v3+v4+v5;
			document.getElementById('total'+qtyposition).value = Round(tot);
			totalassign();
			
		}
		else
		{
			alert("Others Amt Should not be Zero");
			
		}
	}
	
	function calculatedelete(qty)
	{
  		var par = document.getElementById('param').value;
		var Array1 = par.split(",");
		var tot=0 ;
		var postion;
		var tvalue;
		var d = Array1.length;
		for(i=0;i<d-1;i++)
		{
			position = Array1[i];
			tvalue=document.getElementById('total'+position).value;
			tot = tot +parseFloat(tvalue);
		}
		document.getElementById('ntotal').value = Round(tot);
		
		
	}
	
	
	function totalassign()
	{
		var par = document.getElementById('param').value;
		var Array1 = par.split(",");
		var tot=0 ;
		var postion;
		var tvalue;
		var d = Array1.length;
		for(i=0;i<d-1;i++)
		{
			position = Array1[i];
			tvalue=document.getElementById('total'+position).value;
			tot = tot +parseFloat(tvalue);
		}
		document.getElementById('ntotal').value = Round(tot);
	}
	
	
	
function Validate()
  {
  	var v =document.getElementById('ntotal').value;
	if(v<1)
	{
		alert("Atleast we require one Conveyance Claim Amount...");
		return false;
	}
	if(checkNull("ntotal","Invalid net amount") )
		return true;
	else
		return false;
  }
  
  function mainPage()
  {
	    document.a.action="../Smart Attendance/iframeStaffMain.jsp";
		document.a.submit();
		return true;
  }
  </script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="disable()">
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="ifPaySlipView.jsp"
	onSubmit="return Validate()">

<table width="85%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td align="center">
		<p class="tablehead">&nbsp;</p>
		<TABLE class=fontclass1 cellSpacing=1 cellPadding=0 width="100%"
			bgColor=#6f8ec5 border=0>
			<TBODY>
				<TR>
					<TD class=fontclass1_b bgColor=#6f8ec5 colSpan=3><FONT
						class="boldEleven"> <%
								String emp=""+session.getAttribute("EMPID");
								%> <font color=#ffffff>Conveyance Claim for Employee :</font></FONT> <input
						name="perlt" type="hidden" id="perlt" value="1.30"></TD>
				<TR>
					<TD noWrap bgColor=#ffffff colSpan=3>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="13%" class="boldEleven">Claim Date</td>
							<td width="17%" class="boldEleven"><input name="opendate"
								type="text" class="formText135" id="opendate"
								onKeyPress="numericHypenOnly('opendate',10)" size="15"
								maxlength="10" readonly="readonly"> <a
								href="javascript:cal1.popup();"> <img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click here to Pick Up the Date"></a> <script
								language="JavaScript">
<!--
  var cal1=new calendar1(document.forms['frm'].elements['opendate']);
  cal1.year_scroll=true;
  cal1.time_comp=false;
  setCurrentDate('opendate');
//-->
                  </script></td>
							<td width="46%" class="boldEleven">For this date <a href="#">Modify</a>
							&nbsp; <a href="#">Delete</a> &nbsp; <a href="#">View Status</a>
							&nbsp; <a href="#">List all</a>&nbsp;</td>
							<td width="9%" class="boldEleven">Division :</td>
							<td width="15%" class="boldEleven"><select name="division"
								class="formText135" id="division" tabindex="1">
								<option value="Select">Select</option>
								<%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division");
								for(int u=0; u<division.length; u++)
								out.print("<option selected='selected' value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
							</select></td>
						</tr>
					</table>
					</TD>
				</TR>






				<TR>
					<TD colspan="3" bgColor=#ffffff><!--<div id="divscroll"  style="OVERFLOW:auto;width:780px;height:150px">-->
					<TABLE width="100%" border=0 cellPadding=3 cellSpacing=1
						bgColor=#F0FFFF class=fontclass1 id="myTable">
						<TR>
							<Th bgColor=#ffffff class="boldEleven">From</Th>
							<Th bgColor=#ffffff class="boldEleven">To</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Vehicle
							No of Kms</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Amount</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Train/Bus
							Fare</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Auto
							Fare</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Lunch /
							Dinner</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Telephone
							Charges</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Others
							Desc</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Others
							Amt</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Total</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">&nbsp;</Th>
						</TR>
						<TR>
							<TD bgColor=#ffffff class="boldEleven"></TD>
							<TD bgColor=#ffffff class="boldEleven"></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"></TD>
							<TD colspan="2" align=middle bgColor=#ffffff class="boldEleven"></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"></TD>
						</TR>
					</TABLE>
					<!--</div>--></TD>
				</TR>
				<TR>
					<TD width="15%" bgColor=#ffffff>
					<div align="left"><input type="button" class="tMLAscreenHead"
						onClick="chk()"  value="Add"   accesskey="s"   id="buttonitemadd" tabindex="8">
					<input name="param" type="hidden" id="param" value='0,'></div>
					</TD>
					<TD bgColor=#ffffff class="boldEleven" id="netamount">
					<div align="right">Net Amount&nbsp;</div>
					</TD>
					<TD width="11%" id="netamount1" align=middle bgColor=#ffffff
						class="boldEleven">
					<div align="right"><input name="ntotal" id="ntotal"
						class="formText135" size=15 maxlength=8 readonly
						style='text-align:right'></div>
					</TD>
				</TR>
				<TR bgColor=#ffffff>
					<TD align=middle colSpan=3 height=30>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT name=sub1 type=submit class="tfoot" value=Submit> <input
						name="Button" type="button" class="tfoot"  value="Close"   accesskey="c" 
						onClick="redirect('../Smart Attendance/iframeStaffMain.jsp')"></TD>
				</TR>
			</TBODY>
		</TABLE>
		<p class="tablehead">&nbsp;</p>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
</body>

</html>
