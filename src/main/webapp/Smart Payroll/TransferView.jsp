<%@ page import="java.io.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.my.org.erp.SmartPayroll.Travel"%>
<html>
<head>

<script language="javascript"> 	

    function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].training
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
			if (document.forms[0].training.checked) { count=1;}
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
 	    sel=document.forms[0].training
 	   
 	    for(i=0;i<sel.length;i++)
 	    {
 	       if(sel[i].checked)
 	       count=count+1; 
 	    }
 	    if(count==0)
		{
			if (document.forms[0].training.checked) { count=1;	}
		}
 	    if(count==0)
 	    {
 	        alert("Select Allowance to Edit");
 	        return false; 
 	    }
 	    
 	    if(count==1)
 	    {
     	    document.frmState.action="AllowanceAction.jsp";
	    	document.frmState.submit();
	    	return true;
 	    }
 	    else
 	    {
 	        alert("Select One Allowance to Edit");
 	        return false; 
 	    }
	}
	function Add()
 	{		
		document.frmState.action="AllowanceAction.jsp";
		document.frmState.submit();
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
<table width="400" align="center" border="1"  >
	<tr>
		<td colspan="2" width="350" height="32" align="center" valign="middle"
			  class="tablehead">Training</td>
	</tr>
	<tr>
		<td>Program Id</td>
		<td>Staff Id</td>
		<td>Program Name</td>
	</tr>
	<%
		    ArrayList travelingList=(ArrayList) session.getAttribute("travelingList");
			for(int i=0;i<travelingList.size();i++)
			{
				Travel travel= (Travel)travelingList.get(i);	    
		    	
	%>
	<tr class="bolddeepblue">
		<td valign="middle" align="left"><input type="checkbox"
			name="training" value="<%=travel.getTravelId()%>"> <%=travel.getTravelId()%>
		</td>
		<td><%=travel.getEmpId()%></td>
		<td><%=travel.getVisitPlace()%></td>
	</tr>
	<%	

		   }
			String dis="";
			if(travelingList.size()==7) dis="disabled='disabled'";		 	
	%>
</table>
<table BORDER="0" ALIGN="CENTER"  >
	<tr>
		<input type="hidden" name="filename" value="Travel">
		<input type="hidden" name="actionS" value="PaytravelDelete">
		<input type="hidden" name="msg" value="">

		<td width="54" valign="top"><input class="buttonbold"
			type="submit" <%=dis %> onclick="return Edit()" name="action1"
			value="Edit"></td>
		<td width="54" valign="top"><input name="Submit" type="submit"
			class="buttonbold" onclick="return Delete()" value="Delete" <%=dis %>></td>
		<td width="54" valign="top"><input type="button" name="Submit"
			class="buttonbold"  value="Close"   accesskey="c"  onclick="mainPage()"></td>
	</tr>

</table>
</td>
<tr>
	<td width="996" height="25">
	</table>

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
