<%@ page import="java.io.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<html>
<head>

<script language="javascript"> 	

    function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].advance
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
			if (document.forms[0].advance.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frmState.action="../SmartLoginAuth";				
				
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
 	function Edit()
 	{		
 	    var count=0;
 	    sel=document.forms[0].advance
 	    for(i=0;i<sel.length;i++)
 	    {
 	       if(sel[i].checked)
 	       count=count+1; 
 	    }
 	    if(count==0)
		{
			if (document.forms[0].advance.checked) { count=1;	}
		}
 	    if(count==0)
 	    {
 	        alert("Select Allowance to Edit");
 	        return false; 
 	    }
 	    
 	    if(count==1)
 	    {
     	    document.frmState.action="AdvanceAction.jsp";
     	    
	    	document.frmState.submit();
	    	return true; }
 	    else
 	    {
 	        alert("Select One Allowance to Edit");
 	        return false; 
 	    }
	}
	
	function mainPage()
	{
	    document.frmState.action="Payrollmain.jsp";
		document.frmState.submit();
		return true;
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
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
.style9 {color: #FFFFFF}
.style10 {font-family: Verdana; font-size: 12px; color: #FFFFFF; }
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   method="get" name='frmState'>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<br>
<br>
<center>
<table width="900" align="center" border="1"  >
	<tr>
		<td colspan="6" width="150" height="32" align="center" valign="middle"
			  class="tablehead">Advance <%
    String fromDate=request.getParameter("fromDate");
    String toDate=request.getParameter("toDate");
    %>
		</td>
	</tr>
	<tr>
		<td width="150" align="left" class="bolddeepblue">Advance Id</td>
		<td width="150" align="center" class="bolddeepblue">Staff Id</td>
		<td width="150" align="center" class="bolddeepblue">Staff Name</td>
		<td width="150" align="center" class="bolddeepblue">Date</td>
		<td width="150" align="center" class="bolddeepblue">Advance
		Amount</td>
		<td width="150" align="center" class="bolddeepblue">Balance
		Amount</td>
	</tr>
	<%
		    ArrayList advanceList=(ArrayList) session.getAttribute("advancelist");
			for(int i=0;i<advanceList.size();i++)
			{
				
				Advance advance= (Advance)advanceList.get(i);	    
		    	
	%>
	<tr class="bolddeepblue">
		<td valign="middle" align="left"><input type="checkbox"
			name="advance" value="<%=advance.getAdv_Id()%>"> <%=advance.getAdv_Id()%></td>
		<td><%=advance.getEmp_Id()%></td>
		<td><%=advance.getEmp_name()%></td>
		<td><%=advance.getOpenDate()%></td>
		<td><%=advance.getAdvAmt()%></td>
		<td><%=advance.getBalAmt()%></td>
	</tr>
	<%	

		   }
			String dis="";
			if(advanceList.size()==7) dis="disabled='disabled'";		 	
	%>
</table>
<input type="hidden" name="filename" value="Advance"> <input
	type="hidden" name="actionS" value="PayAdvanceDelete"> <input
	type="hidden" name="fromDate" value=<%=fromDate%>> <input
	type="hidden" name="toDate" value=<%=toDate%>> <input
	type="hidden" name="msg" value="">

<table BORDER="0" ALIGN="CENTER"  >
	<tr>

		<td width="54" valign="top"><input name="Submit" type="submit"
			class="buttonbold" onclick="return Edit()" value="Edit"></td>
		<td width="54" valign="top"><input name="Submit" type="submit"
			class="buttonbold" onclick="return Delete()" value="Delete"></td>
		<td width="54" valign="top"><input type="button" name="Submit"
			class="buttonbold"  value="Close"   accesskey="c"  onclick="mainPage()"></td>
	</tr>

</table>

<td width="996" height="25">
<% 
	String msg=""+request.getParameter("message");
	if(!msg.equals("null")){
%>
<CENTER>
<table width="50%" border="1" cellspacing="2" cellpadding="2"
	 >
	<tr>
		<td align="center" class="tabledata"><%=msg%></td>
	</tr>
	<% 
   }
	st.close();
	//rs.close();
	 
	
	%>
</table>
</CENTER>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</html>
