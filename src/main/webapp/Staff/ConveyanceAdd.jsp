<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
<%@include file="Redirect.jsp" %>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	$(function() {
		$( "#opendate" ).datepicker({ minDate: -30, maxDate: "+0D",showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true });
	});
	
	 
	$(function() {
		$( "#fromdate" ).datepicker({ 
			changeMonth : true, 
			changeYear : true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true });
	});
	
	
	
	$(function() {
		$( "#todate" ).datepicker({  
			changeMonth : true,  
			changeYear : true, 
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true });
	});
function UploadWindow(query)
{  
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	newWindow = window.open(query,"subWind",styleStr);
	newWindow.focus( );
}
 	
	
</script>
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">

<script language="javascript" >
<%
String dh[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_CONVEYANCECLEAR FROM m_institution WHERE INT_ID=1");
int dd = Integer.parseInt(dh[0][0]);
%>
var d = parseInt("<%=dh[0][0]%>");
var datecollections ="<%=com.my.org.erp.common.CommonFunctions.getLastNoofDay(dd)%>";
var datecollection = datecollections.split(",");

</script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="javascript" src="../JavaScript/Conveyance/conveyance.js"></script>
<%
try
{
%>
<style type="text/css">
<!--
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
.style11 {color: #FFFFFF}
-->
</style>

<script language="JavaScript">
	var petrol 
	<%
	String cdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DOU_PETROL FROM m_institution  WHERE INT_ID=1");
	double price = Double.parseDouble(cdata[0][0]);
	%>
	petrol = "<%=price%>";
	function subformupdate()
	{
		 
		document.frm.action="ConveyanceModify.jsp";
		document.frm.submit();
	}
	function subformlist()
	{
		var fromdate =document.getElementById('fromdate').value;
		var todate = document.getElementById('todate').value;
		document.frm.action="Conveyancelist.jsp?todate="+todate+"&fromdate="+fromdate;
		document.frm.submit();
	}
	
	function buttdisable()
	{
		document.getElementById('buttonitemadd').disabled = false;
	}
	
	function submitdisable()
	{
		document.getElementById('sub1').disabled = true;
	}
	function submitenable()
	{
		document.getElementById('sub1').disabled = false;
		document.getElementById('buttonitemadd').disabled=false;
	}
	 
	
	function calC()
	{
		loadConveyance('opendate','<%=""+session.getAttribute("EMPID")%>');
		var val = document.getElementById('claimdatecheck').value;
		alert(val);
	
	}
	
	function disable()
	{
		//netamountss.style.visibility="hidden";
 		//netamount1.style.visibility="hidden";
		//ppf0.style.visibility="hidden";
	}	
	
	function enable()
	{
		//netamountss.style.visibility="visible";
 		//netamount1.style.visibility="visible";
		//ppf0.style.visibility="Visible";
	}	
	
	function chk()
	{
		//checkNullSelect("vtype","Select Type of Vehicle ","Select")
		var sf = false;
		if(checkNull('opendate',"Select Date"))
			sf = true;
		var df =false;
		var ddf = false;
		var op=	document.getElementById('opendate').value;
		var sp = document.getElementById('serverdate').value;	
		var fg =Datecheck();
		
		if((sf) &&(fg))	
		{
		 	loadConveyance('opendate',"<%=""+session.getAttribute("EMPID")%>");	 
			if(checkNullSelect("division","Select Division ","Select") )
				insRow();
		}		
		
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
		try
		{
				
		 	enable();
			 
			var x=document.getElementById('myTable').insertRow(row)
			var s0= "from"+r;
			var s1= "to"+r;
			var s2 = "km"+r;
			var s3 ="busfare"+r;
			var ss3 ="callid"+r;
			var s4 = "autofare"+r;
			var s5 = "lunch"+r;
			var s6 = "telephone"+r;
			var s7 = "otherdesc"+r;
			var s8 = "otheramt"+r;
			var s9 = "total"+r;
			var div ="div"+r;
					
			var vf0 = " onKeyPress=\" return numeric_only(event,'"+s2+"','8') \" ";
			var vf1 = " onKeyPress=\" return numeric_only(event,'"+s3+"','8') \" ";
			var vff1 =" onKeyPress=\" return numeric_only(event,'"+s3+"','8') \" ";
			var vf2 = " onKeyPress=\" return numeric_only(event,'"+s4+"','8') \" ";
			var vf3 = " onKeyPress=\" return numeric_only(event,'"+s5+"','8') \" ";
			var vf4 = " onKeyPress=\" return numeric_only(event,'"+s6+"','8') \" ";
			var vf5 = " onKeyPress=\" return numeric_only(event,'"+s8+"','8') \" ";
			var vf6 = " onKeyPress=\" return numeric_only(event,'"+s9+"','8') \" "; 
			
			x.insertCell(0).innerHTML="<input type='text' size=7 onKeyUp=\"upperMe(this)\" class='formText135' onblur='validfrom(this)'  name='"+s0+"' id ='"+s0+"' />";
			x.insertCell(1).innerHTML="<input type='text' size=7  onKeyUp=\"upperMe(this)\" class='formText135' onblur='validto(this)'   name='"+s1+"' id ='"+s1+"' />";
			x.insertCell(2).innerHTML="<input type='text' size=7 value=0  onblur='calculatekm(this)'  class='formText135'  name='"+s2+"' id ='"+s2+"' " +vf0+" style='text-align:right'   maxlength='7'  />";
			
			x.insertCell(3).innerHTML="<div id="+div+"></div><input type='text' size=7  class='formText135'  name='"+ss3+"' id ='"+ss3+"' style='text-align:right' onKeyUp=\"upperMe(this)\" maxlength='16' />";
			
			x.insertCell(4).innerHTML="<input type='text' size=7 value=0  onblur='calculatetrain(this)' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf1+" style='text-align:right'   maxlength='7' />";
			x.insertCell(5).innerHTML="<input type='text' size=7 value=0  onblur='calculateauto(this)' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+"  style='text-align:right'   maxlength='7' />";
			x.insertCell(6).innerHTML="<input type='text' size=7 value=0  onblur='calculatelunch(this)' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf3+"  style='text-align:right'   maxlength='7' />";
			
			x.insertCell(7).innerHTML="<input type='text' size=7 value=0  onblur='calculatetele(this)' class='formText135'  name='"+s6+"' id ='"+s6+"' " +vf4+" style='text-align:right   maxlength='7' />";
			
			x.insertCell(8).innerHTML="<input type='text' size=7      class='formText135'  name='"+s7+"' id ='"+s7+"'    style='text-align:right' maxlength='100'/> ";
			x.insertCell(9).innerHTML="<input type='text' size=7 onblur='calculateother(this)' value=0  class='formText135'  name='"+s8+"' id ='"+s8+"' " +vf5+" style='text-align:right'/>";
			x.insertCell(10).innerHTML="<input type='text' size=7   value=0  class='formText135'  name='"+s9+"' id ='"+s9+"' " +vf6+" style='text-align:right' readonly='readonly'/>";
			x.insertCell(11).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")'>";
			document.getElementById(s0).focus();
			
			
			itemArray[idrow] = r	;
			row = row+1;
			idrow=idrow+1;
		 	display();
			
			if(r>1)
			{
				var x1 = document.getElementById('param').value;
				var ctrl = x1.split(",");
				var cctrl = ctrl[ctrl.length -3];
				 
				
				document.getElementById("from"+r).value = document.getElementById("to"+(cctrl)).value;
				document.getElementById(s1).focus();
			}	
			r = r+1;
		}
		catch(err)
		{
			alert(err);
		}		
		
	}
	 

function deleteRow(i,rx)
{
	try
	{
		if(row>1)
			row = row-1;
		
		
		if(row<=1)
		{
			//disable();
			display();
		}
		else
		{
			document.getElementById('myTable').deleteRow(i);
			deleteArray[drow] =rx;
			drow = drow+1;
			display();
			totalassign();
			document.getElementById('buttonitemadd').focus();
		}
	}
	catch(err)
	{
		alert(err);
	}		 
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
		//if( document.getElementById('from'+qtyposition).value =="")
			//alert("Enter Starting Place");
		
	 }
	
	function validto(qty)
	 {
	 	var qtyposition = (qty.name.replace("to",""));	
  		var quantity = qty.value;
		//if( document.getElementById('to'+qtyposition).value =="")
			//alert("Enter End Place");
		
	 }
	 
	 
	function calculatekm(qty)
	{
		try
		{
  		
			var qtyposition = (qty.name.replace("km",""));	
			var quantity = qty.value;
			if(quantity>=1)
			{
				if(checkNull("from"+qtyposition,"Enter Starting Place") && checkNull("from"+qtyposition,"Enter End Place")) 
				{
					var v = parseFloat(quantity)*petrol;
					var tb=document.getElementById('div'+qtyposition);
					var v1 = parseFloat(document.getElementById('busfare'+qtyposition).value);
					var v2 = parseFloat(document.getElementById('autofare'+qtyposition).value);
					var v3 = parseFloat(document.getElementById('lunch'+qtyposition).value);
					var v4 = parseFloat(document.getElementById('telephone'+qtyposition).value);
					var v5 = parseFloat(document.getElementById('otheramt'+qtyposition).value);
					var tot = v+v1+v2+v3+v4+v5;
					document.getElementById('total'+qtyposition).value =  Round(tot);
					totalassign();
				}	
					
			}
			else
			{
				alert("Kilometer Should not be Zero");
			}
		}
		catch(err)
		{
			alert(err.description);
			
		}
	}
	
	function calculatetrain(qty)
	{
  		var qtyposition = (qty.name.replace("busfare",""));	
  		var quantity = qty.value;
  		if(quantity>=1)
		{
			
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = parseFloat(v0*petrol);
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
			//==========================================
			//alert("Train/Bus Fare Should not be Zero");
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = parseFloat(v0*petrol);
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
	
	
	function calculateauto(qty)
	{
  		var qtyposition = (qty.name.replace("autofare",""));	
  		var quantity = qty.value;
  		if(quantity>=1)
		{
			
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = parseFloat(v0*petrol);
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
			//alert("Auto Fare Fare Should not be Zero");
			//===========================================
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = parseFloat(v0*petrol);
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
	
	
	function calculatelunch(qty)
	{
  		var qtyposition = (qty.name.replace("lunch",""));	
  		var quantity = qty.value;
  		if(quantity>=1)
		{
			
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = parseFloat(v0*petrol);
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
			//alert("Lunch / Dinner Fare Should not be Zero");
			//==============================================
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = parseFloat(v0*petrol );
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
	
	function calculatetele(qty)
	{
  		var qtyposition = (qty.name.replace("telephone",""));	
  		var quantity = qty.value;
  		if(quantity>=1)
		{
			
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = parseFloat(v0*petrol);
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
			//alert("Telephone Charges Should not be Zero");
			//============================================
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = parseFloat(v0*petrol);
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
	
	function calculateother(qty)
	{
  		var qtyposition = (qty.name.replace("otheramt",""));	
  		var quantity = qty.value;
  		if(quantity>=1)
		{
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = parseFloat(v0*petrol);
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
			//alert("Others Amt Should not be Zero");
			var v0 = parseFloat(document.getElementById('km'+qtyposition).value);
			var v = (v0*petrol);
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
	
	
	
  
  function mainPage()
  {
	    document.a.action="../Smart Attendance/iframeStaffMain.jsp";
		document.a.submit();
		return true;
  }
  </script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()" >
<table width="95%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td align="center">
		<p class="tablehead">&nbsp;</p>
		<TABLE class=fontclass1 cellSpacing=1 cellPadding=0 width="100%"
			bgColor=#6f8ec5 border=0>
			<TBODY>
				<TR>
					<TD class=fontclass1_b bgColor=#6f8ec5 colSpan=3>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="22%">&nbsp;</td>
							<td width="42%">
							<div align="center"><font class="boldEleven"> <%
								String emp=""+session.getAttribute("EMPID");
								%> <font color=#ffffff>Conveyance Claim for Employee :</font></font> <input
								name="perlt" type="hidden" id="perlt" value="petrol"></div>							</td>
							<td width="22%"><font class="boldEleven"><font
								color=#ffffff>Reporting To</font></font></td>
							<td width="14%"><select id="repto" name="repto"
								class="formText135"    style="width:200"  >
								<option value=0>Select</option>
								<%

								
		   String rptodatas[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_REPTO FROM com_m_staff  WHERE CHR_EMPID='"+emp+"'");
		   String rptodata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("select CHR_EMPID,CHR_STAFFNAME from com_m_staff WHERE CHR_TYPE<>'T'  AND CHR_REP='Y' ");
		   for(int c=0;c<rptodata.length;c++)
		   		out.println("<option value='"+rptodata[c][0]+"'>"+rptodata[c][1]+"</option>");
		   %>
							</select>
						<script language="javascript">
						setOptionValue('repto',"<%=rptodatas[0][0]%>") 
						</script>							</td>
						    <td width="14%"><span class="boldEleven style11">Division :</span></td>
						    <td width="14%"><span class="boldEleven">
						      <select name="division"
								class="formText135" id="division" tabindex="1"  style="width:200" >
                                <option value="Select">Select</option>
                                <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division");
								for(int u=0; u<division.length; u++)
								out.print("<option selected='selected' value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                              </select>
						    </span></td>
						</tr>
					</table>					</TD>
				<TR>
					<TD noWrap bgColor=#ffffff colSpan=3>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
						  <td height="20" class="boldEleven"><img src="../Image/report/upload_red.png" width="48" height="48"><span class="boldgreen"><a   title="Clear Datas" href="javascript:UploadWindow('UploadConveyance.jsp')">Upload</a></span></td>
						  <td class="boldEleven">&nbsp;</td>
						  <td class="boldEleven">                 
					  </tr>       
						  <td class="boldEleven">&nbsp;</td>
						<tr>
							<td width="10%" height="20" class="boldEleven">Claim Date</td>
							<td width="16%" class="boldEleven"><input name="opendate"
								type="text" class="formText135" id="opendate"
								  size="12"
								maxlength="10" readonly>  
		 
		 <%
String date[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("select date(now())");
String dt[] = date[0][0].split("-");
String d = dt[2]+"-"+dt[1]+"-"+dt[0];
%>
		 
		 <script
								language="JavaScript">
<!--
  var cal1=new calendar1(document.forms['frm'].elements['opendate']);
  cal1.year_scroll=true;
  cal1.time_comp=false;
  setCurrentDate('opendate');
//-->


function Datecheck()
{
	var date1 = document.getElementById('opendate').value;
	date1 = escape(date1);
	var fg =false;
	for(  x=0;x<datecollection.length;x++)
		if(escape(datecollection[x]) === date1)
			fg =true;
	
	if(!fg)
	{
		alert("Check your claim date...");
		document.getElementById('opendate').value="<%=d%>";
		return false;
	}
	else
		return true;
			
			
}

	var now = new Date();
	var d = now;
	now.setDate(now.getDate()-15);
	var day=now.getDate();
	if(day<10) day="0"+day;
	var month=now.getMonth() + 1;
	if(month<10) month="0"+month;
	var year=now.getFullYear();
	
function datevalid()
{
	var date1 = document.getElementById('opendate').value;
	var date2 = document.getElementById('serverdate').value;
	var diffdate = checkDateDifferent(date1,date2,15);
	
}	
	
 </script>


<input name="serverdate" id="serverdate"  type="hidden" value="<%=d%>">


<script language="javascript">
	//alert(days_between('opendate', 'serverdate'));
</script>				  </td>
							<td width="73%" class="boldEleven">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="14%" class="boldEleven">For this date</td>
								  <td width="34%" class="boldEleven"><input name=button_upd
										type=button class="wysiwyg" onClick="subformupdate()"
										value=Modify></td>
									<td width="5%" bordercolor="#0000FF" bgcolor="#D4D0C8" class="boldEleven">From</td>
								  <td width="16%" bordercolor="#0000FF" bgcolor="#D4D0C8" class="boldEleven"><input name="fromdate"
										type="text" class="formText135" id="fromdate"
										readonly="readonly" size="12">  </td>
									<td width="3%" bordercolor="#0000FF" bgcolor="#D4D0C8" class="boldEleven">To</td>
								  <td width="17%" bordercolor="#0000FF" bgcolor="#D4D0C8" class="boldEleven"><input name="todate"
										type="text" class="formText135" id="todate"
										readonly="readonly"size="12">   <script
										language="JavaScript">			
 			 	
			setCurrentDate('fromdate');
			setCurrentDate('todate');			
			
 
                          </script></td>
									<td width="1%" bordercolor="#0000FF" bgcolor="#D4D0C8" class="boldEleven">&nbsp;</td>
								  <td width="10%" bordercolor="#0000FF" bgcolor="#D4D0C8" class="boldEleven"><input name=button_upd3
										type=button class="wysiwyg" onClick="subformlist()" value=List></td>
								</tr>
							</table>
							<td width="1%" class="boldEleven">&nbsp;</td>
						</tr>
					</table>					</TD>
				</TR>






				<TR>
					<TD colspan="3" bgColor=#ffffff><!--<div id="divscroll"  style="OVERFLOW:auto;width:780px;height:150px">STAStaffConveyanceAdd-->
					<input name="filename" type="hidden" id="filename"
						value="Conveyance"> <input name="actionS" type="hidden"
						id="actionS" value="STAStaffConveyanceAdd">
					<input name="claimdatecheck" type="hidden" id="claimdatecheck" value="false" >
					<TABLE width="100%" border=0 cellPadding=3 cellSpacing=1
						bgColor=#F0FFFF class=fontclass1 id="myTable">
						<TR>
							<Th bgColor=#ffffff class="boldEleven">From</Th>
							<Th bgColor=#ffffff class="boldEleven">To</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Vehicle
							No of Kms</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Call Number </Th>
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
				  <TD bgColor=#ffffff><div align="left">
                    <input type="button" class="tMLAscreenHead"	onClick="chk()"  value="Add"   accesskey="s"   id="buttonitemadd" name="buttonitemadd" >
                    <input name="param" type="hidden" id="param" value='0,'>
			      </div></TD>
				  <TD class="boldEleven"   bgColor="#ffffff" >&nbsp;</TD>
				  <TD   align=middle bgColor=#ffffff
						class="boldEleven">&nbsp;</TD>
			  </TR>
				<TR id="ppf0">
					<TD width="15%" bgColor=#ffffff>&nbsp;</TD>
					<TD class="boldEleven"   bgColor="#ffffff" >
					<div align="right">Net Amount&nbsp;</div>					</TD>
					<TD width="11%" align=middle bgColor=#ffffff
						class="boldEleven">
					<div align="right"><input name="ntotal" id="ntotal"
						class="formText135" size=15 maxlength=8 readonly
						style='text-align:right'></div>					</TD>
				</TR>
				<TR bgColor=#ffffff>
					<TD align=middle colSpan=3 height=30 >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				      <input name="sub1" id="sub1" type=submit class="tfoot" value=Submit >
			      <input
						name="Button" type="button" class="tfoot"  value="Close"   accesskey="c" 
						onClick="redirect('iframeStaffMain.jsp')"></TD>
				</TR>
			</TBODY>
		</TABLE>
		<p align="center" class="subtitle">
		<%
			String er = ""+request.getParameter("er");
			if(!"null".equals(er))
				out.println(er);
		%>
		</p>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>

<%
}
catch(Exception e)
{
}
%>
</body>
<script language="javascript">
function Validate()
  {
  	var date1 = document.getElementById('opendate').value;
	var date2 = document.getElementById('serverdate').value;
	var ddf =Datecheck();
	var callnos=document.getElementById('param').value;
	var callno = callnos.split(",");
	var v =document.getElementById('ntotal').value;
	if(v<1)
	{
		alert("Atleast we require one Conveyance Claim Amount...");
		return false;
	}
	if( (ddf)
	&& checkNull("opendate","Select Date") 
	&&checkNull("ntotal","Invalid net amount") 
	&&checkNullSelect("repto","Select Reporting head ","0")  )
	{	
			
			for( i=0; i<callno.length-1; i++)
			{
				var s ="callid"+(i+1);
				var chk =document.getElementById(s).value;
				var ck = "Enter Call Number..";
				if(checkNull(s,ck))
				{
					d=1;
				}
				else
				{
					return false;				
				}	
			}	
	
			 
	}
	else
	{
		return false;
	}
  }

</script>
</html>
