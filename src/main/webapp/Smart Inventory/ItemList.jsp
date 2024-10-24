<%@ page import="java.io.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 
<title>:: INVENTORY ::</title><script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="Ajax/AJAXFunction.js"> </script>
<script language="javascript">
 function validate()
 {		
		if(checkNullSelect("catId","Select Category","Select"))
			return true;
		else
			return false;
 }
function createRequestObject() 
{
    var tmpXmlHttpObject;
    if (window.XMLHttpRequest) 
    {    
        tmpXmlHttpObject = new XMLHttpRequest();	
    }
    else if (window.ActiveXObject) 
    {    
        tmpXmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP");
    }    
    return tmpXmlHttpObject;
}
var http = createRequestObject();
function makeGetRequest() {
	wordId=document.getElementById("catId").value;		
	
	http.open('get','StockAjax.jsp?catId='+wordId);
	http.onreadystatechange = processResponse;
    http.send(null);
}
function processResponse() 
{ 
    if(http.readyState == 4)
	{
	    var response = http.responseText;
        document.getElementById('description').innerHTML = response;
	}
}

 function mainPage()
	{
	     document.frmState.action="InventoryMain.jsp";
	    // frm.submit();
    }	   
</script>
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
</head>
<body >
<form  AUTOCOMPLETE = "off"   method="post" name='frmState'
	action="../SmartLoginAuth?filename=Stock&actionS=INVstockList">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><%@ include file="indexinv.jsp"%></td>
	</tr>
	<tr>
		<td height="84">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="400" border="1" align="center" cellpadding="1"
			 >
			<tr>
				<td height="25" align="center"  
					class="tableheadInv" colspan="2">Stock</td>
			</tr>
			<tr>
				<td width="194" class="bolddeepblue">Category</td>
				<td width="190"><select name="catId"
					onChange="makeGetRequest()">
					<option value="Select">Select</option>
					<%
					        		ArrayList categoryList=(ArrayList) session.getAttribute("categoryList");
					        		for(int i=0;i<categoryList.size();i++)
					        		{
					        	//com.my.org.erp.SmartInventory.Category cat=(com.my.org.erp.SmartInventory.Category)categoryList.get(i);
					        	//out.println("<option value='"+cat.getCategoryId()+"'>");			
					        	//out.println(cat.getCategoryName()+"</option>");	        	
					        		}
					        		session.removeAttribute("categoryList");
					%>
				</select></td>
			</tr>
			<tr>
				<td class="bolddeepblue">Item</td>
				<td>
				<div id="description"></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table align="center" cellpadding="1" cellspacing="1">
			<tr>
				<td width="56"><input type="submit" class="buttonbold"
					value="Submit" onClick="return validate()"></td>
				<td width="56"><input type="submit" class="buttonbold"
					 value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="159">&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>
</html>
